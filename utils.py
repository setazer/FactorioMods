import datetime
import json
import pathlib
from contextlib import contextmanager

import bs4
import requests
from dateutil.relativedelta import relativedelta, FR

FACTORIO_CHANGELOG_DATE_FORMAT = "%d. %m. %Y"
MESSAGE_SPLITTER = "\n    - "
NEW_CHANGELOG_ENTRY = """---------------------------------------------------------------------------------------------------
Version: %version%
Date: %date%
  Changes:
    - 
"""


def _get_current_blog_number() -> int:
    page = requests.get('https://factorio.com/blog/')
    soup = bs4.BeautifulSoup(page.text, features='lxml')
    latest_blog_entry = soup.select_one('div.blog-card-text')
    return int(latest_blog_entry.a['href'].rpartition('-')[-1])


def get_blog_number() -> int:
    try:
        with open('blog.ver', encoding='utf-8') as f:
            last_check, blog_number = f.read().strip().split(' ')
    except FileNotFoundError:
        last_check, blog_number = None, None

    if blog_number:
        last_check = datetime.date.fromisoformat(last_check)
        fffs_incremented = (datetime.date.today() - last_check).days // 7
        new_blog_number = int(blog_number) + fffs_incremented
    else:
        new_blog_number = _get_current_blog_number()
    new_check = datetime.date.today() + relativedelta(weekday=FR(-1))  # closest friday
    with open('blog.ver', 'w', encoding='utf-8') as f:
        f.write(f"{new_check.isoformat()} {new_blog_number}")
    return new_blog_number


def update_changelog(changelog_path, version, date):
    with open(changelog_path, "r", encoding='utf-8') as f:
        changelog = f.read()
        if version in changelog:
            return
        changelog = changelog.replace(f'%version%', version).replace(f'%date%', date)
    with open(changelog_path, "w", encoding='utf-8') as f:
        f.write(changelog)
    yield
    with open(changelog_path, 'w', encoding='utf-8') as f:
        f.write(NEW_CHANGELOG_ENTRY)
        f.write(changelog)


def write_forced_info(info_path):
    with open(info_path, encoding='utf-8') as f:
        info = json.load(f)
        reqs = info['dependencies']
    info['dependencies'] = [dep.replace('? ', '') for dep in reqs]
    info['name'] += '-forced'
    info['title'] += ' Force Full Install'
    with open(info_path, 'w', encoding='utf-8') as f:
        json.dump(info, f, indent=4)


@contextmanager
def update_2ish(path: pathlib.Path):
    changelog_path = path / 'changelog.txt'
    info_path = path / 'info.json'
    cur_blog = get_blog_number()
    with open(info_path, encoding='utf-8') as f:
        info = json.load(f)
        cur_version = info['version']
    _, blog, version = cur_version.split('.')
    if int(blog) == cur_blog:
        new_version = f"0.{blog}.{int(version)+1}"
    else:
        new_version = f"0.{cur_blog}.1"
    with open(info_path, 'w', encoding='utf-8') as f:
        info['version'] = new_version
        json.dump(info, f, indent=4)
    yield from update_changelog(changelog_path,
                                version=new_version,
                                date=datetime.date.today().strftime(FACTORIO_CHANGELOG_DATE_FORMAT))
