
import json
import os
import pathlib
import shutil
import zipfile


factorio_path = pathlib.Path(os.getenv('APPDATA')) / 'Factorio' / 'mods'

# Folder shenanigans and getting actual name
name = 'factorio-2ish'
src = pathlib.Path(name)
with (src / 'info.json').open('r') as f:
    info = json.load(f)
version = info['version']
target_name = f'{name}_{version}'
out_path = pathlib.Path('out')
build_path = out_path / target_name

# prepare files for zip
shutil.copytree(src, build_path, dirs_exist_ok=True)

# create zip
zip_name = out_path / f'{target_name}.zip'
with zipfile.ZipFile(zip_name, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for item in build_path.rglob('*'):
        if not item.is_file():
            continue
        rel_path = item.relative_to(out_path)
        zipf.write(item, rel_path)

# clean build dir
shutil.rmtree(build_path, ignore_errors=True)

print('Build complete:', zip_name.absolute().as_uri())

for old_build in factorio_path.glob(f'{name}*.zip'):
    old_build.unlink()
shutil.copyfile(zip_name, factorio_path / zip_name.name)

