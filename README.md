# alacritty-debian

This repository contains the source to build a Debian package for [alacritty](https://github.com/alacritty/alacritty).

## Usage

If you have [Docker](https://www.docker.com/) installed locally, just run the following:

```bash
user@hostname$ ./build.sh
```
By default this will build alacritty v0.7.0 on Debian Buster.

If you want to customize the build at runtime, use the following:

```bash
user@hostname$ ./build.sh -i debian:unstable-slim -v 0.4.3
```
Don't forget to update `debian/changelog` so your package is generated with the correct version.

## Release

To publish a new package version to Github, follow these steps:
  * update the `VERSION` variable in `build.sh`
  * add a new entry in `debian/changelog`
  * create a new tag with the Debian package version

## License

```
Copyright 2020-2021 Martin Simon

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

```

## References

* [ayosec/polybar-debian](https://github.com/ayosec/polybar-debian)
