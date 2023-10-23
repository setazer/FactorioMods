import json
import pathlib
import shutil
import zipfile


# Folder shenanigans and getting actual name
name = 'factorio_2ish'
src = pathlib.Path(name)
with (src / 'info.json').open('r') as f:
    info = json.load(f)
version = info['version']
target_name = f'{name}_{version}'
out_dir = pathlib.Path('out')
build_dir = out_dir / target_name

# prepare files for zip
shutil.copytree(src, build_dir, dirs_exist_ok=True)

# create zip
zip_name = out_dir / f'{target_name}.zip'
with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for item in build_dir.rglob('*'):
        if not item.is_file():
            continue
        rel_path = item.relative_to(out_dir)
        zipf.write(item, rel_path)

# clean build dir
shutil.rmtree(build_dir, ignore_errors=True)

print('Build complete:', zip_name.absolute().as_uri())

