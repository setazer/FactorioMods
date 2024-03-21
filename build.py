import json
import os
import shutil

import pathlib
import zipfile

from utils import update_2ish, write_forced_info

FACTORIO_PATH = pathlib.Path(os.getenv('APPDATA')) / 'Factorio' / 'mods'


def build_mod(path, out_path, make_forced=False):
    # Folder shenanigans and getting actual name
    name = path.name
    with (path / 'info.json').open('r') as f:
        info = json.load(f)
    version = info['version']

    target_name = f"{name}{'-forced' if make_forced else ''}_{version}"

    build_path = out_path / target_name

    # prepare files for zip
    shutil.copytree(path, build_path, ignore=shutil.ignore_patterns('README.md'), dirs_exist_ok=True)

    if make_forced:
        write_forced_info(build_path / 'info.json')
    # create zip
    zip_name = out_path / f'{target_name}.zip'
    with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for item in build_path.rglob('*'):
            if not item.is_file():
                continue
            rel_path = item.relative_to(out_path)
            zipf.write(item, rel_path)

    # remove build dir
    shutil.rmtree(build_path, ignore_errors=True)
    print('Build complete:', zip_name.absolute().as_uri())


if __name__ == '__main__':
    out_path = pathlib.Path('out')

    # clean out dir
    shutil.rmtree(out_path, ignore_errors=True)
    mods = [mod_path
            for mod_path in pathlib.Path.cwd().iterdir()
            if (mod_path.is_dir()
                and mod_path.name not in ('out', 'media')
                and not mod_path.name.startswith(('.', '__')))]

    # purge old versions
    for mod_path in mods:
        for old_build in FACTORIO_PATH.glob(f'{mod_path.name}*.zip'):
            old_build.unlink()

    # build mods
    for mod_path in mods:
        if mod_path.name == 'factorio-2ish':
            with update_2ish(mod_path):
                build_mod(mod_path, out_path)
                build_mod(mod_path, out_path, make_forced=True)
        else:
            build_mod(mod_path, out_path)

    # install mods
    shutil.copytree(out_path, FACTORIO_PATH, dirs_exist_ok=True)
