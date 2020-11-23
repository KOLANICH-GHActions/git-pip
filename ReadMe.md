pip-git GitHub Action [![`Unlicense`d work](https://raw.githubusercontent.com/unlicense/unlicense.org/master/static/favicon.png)](https://unlicense.org/)
=====================

Builds and installs python packages by their git repos URIs.

The URIs must be enumerated in a text file `./.ci/pythonPackagesToInstallFromGit.txt`. The file name can be changed using `packagesURIsFile` input variable

Clones using `--depth=50`, then builds either with [`setuptools`](https://github.com/pypa/setuptools), or with [`build`](https://github.com/pypa/build).
