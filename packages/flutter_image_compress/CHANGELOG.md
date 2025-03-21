## 3.0.0

- Update 3.0.0 with support Swift and Swift Package Manager

## 2.4.0

 - **FEAT**: remove pica from web ([#324](https://github.com/fluttercandies/flutter_image_compress/issues/324)). ([b56ce0fa](https://github.com/fluttercandies/flutter_image_compress/commit/b56ce0fa4763bf8084c26ea8e435e37e06997ba8))

## 2.3.0

 - **FEAT**: Update plugin structure for OpenHarmony ([#301](https://github.com/fluttercandies/flutter_image_compress/issues/301)). ([5e999c43](https://github.com/fluttercandies/flutter_image_compress/commit/5e999c431c5dcff880b8c217e40fa7d027ca0bdc))

## 2.2.0

 - **FEAT**: support openharmony ([#290](https://github.com/fluttercandies/flutter_image_compress/issues/290)). ([e9f10b28](https://github.com/fluttercandies/flutter_image_compress/commit/e9f10b28e089539fe7319d7bc1779b9a2c209fc4))
 - **DOCS**: The first version for OpenHarmony. ([5fcab8da](https://github.com/fluttercandies/flutter_image_compress/commit/5fcab8dac6277b36b7169962474e5af3cf88724b))

## 2.1.0

 - **FEAT**: support macOS ([#264](https://github.com/fluttercandies/flutter_image_compress/issues/264)). ([06ab91ed](https://github.com/fluttercandies/flutter_image_compress/commit/06ab91ed470ea2c838daeb6c654ad06dadc99f1d))
 - **DOCS**: Update README ([#266](https://github.com/fluttercandies/flutter_image_compress/issues/266)). ([235643ab](https://github.com/fluttercandies/flutter_image_compress/commit/235643ab0be9c9a39083031d9ab9de06a74241f3))
 - **DOCS**: Update README. ([1e232a10](https://github.com/fluttercandies/flutter_image_compress/commit/1e232a10c84743ab3c35e1bffda5730801506891))
 - **DOCS**: Update changelog. ([c847f5d5](https://github.com/fluttercandies/flutter_image_compress/commit/c847f5d5d03d4e727b1a83dd33e54d8d93787749))

## 2.0.4

 - **DOCS**: Update changelog. ([c847f5d5](https://github.com/fluttercandies/flutter_image_compress/commit/c847f5d5d03d4e727b1a83dd33e54d8d93787749))

## 2.0.3

- Bump dependencies version.
- Change sdk constraint to `>=2.12.0 <4.0.0`.

## 2.0.2

- Config default_plugin for web in pubspec.yaml.

## 2.0.1

- Include web support.

## 2.0.0

- Migrate platform interface

**Breaking** Change:

- The result `File` to `XFile` of [cross_file](https://pub.dev/packages/cross_file)

See the [migration guide](https://github.com/fluttercandies/flutter_image_compress/blob/main/migrate.md) for more details.

## 1.1.3

- Fix converting from WebP causes app crash on iOS. (#222).

## 1.1.2

- Fix crashes on iOS with nil data. (#220)
- Adapt Flutter 3.3.

## 1.1.1

- Merge effective PRs that improve the plugin from various aspects, including:
  #192, #207, #208, #210, #214. Thanks to these contributors.
- Repo cleanup.

## 1.1.0

- Add SDWebImage dependency for iOS. (#182)
- Repo cleanup.

## 1.0.0

Modify the constraint version of flutter to 2.0.0

## 1.0.0-nullsafety

Migrate null-safety version.

## 0.7.0

- Fix memory leaked for android.
- Support android v2 plugin.

**Breaking Change**:

- Replace `List<int>` to `Uint8List`.

## 0.6.8

- Update `Validate` code.

## 0.6.7

Use the async GCD in iOS.

## 0.6.6

- [#116](https://github.com/fluttercandies/flutter_image_compress/pull/116)
- [#124](https://github.com/fluttercandies/flutter_image_compress/pull/124)

## 0.6.5+1

Fix:

- Web format error
- Import header error for iOS.

## 0.6.5

New feature

- Support webp on iOS.

## 0.6.4

New feature:

- Add Params inSampleSize for methods.
- Heif and webp Partially supported.

## 0.6.3

Fix:

- Android: When the register of the calling plugin is not in the main process or there is no Activity.

## 0.6.2

Optimization:

- Reduce the speed required for ios to add dependencies by copying the `SYPictureMetadata` source code into the project.

## 0.6.1

Fix:

- autoCorrectionAngle switches image width and height.

New feature:

- Keep exif (no have orientation), use `keepExif`

## 0.6.0

**BREAKING CHANGE** :

- remove method `getImageInfo`.

For the time being, the follow-dev branch is no longer used, but only the master branch is needed to unify the pub version number.

New Feature:

- It is now supported to set the compression target to png format.

## 0.5.2

Fix:

- [#49](https://github.com/fluttercandies/flutter_image_compress/issues/49): A problem of reading Exif information.

## 0.5.1

Change `reportError` with flutter stable version.

**Breaking Change:**
The autoCorrectionAngle parameter causes a number of situations to behave differently than `0.4.0`. See readme for details.

## 0.5.0

(don't use)

**Breaking Change:**
Because `FlutterError.reportError` method's param `context` type changed.
So this library will add the constraints of flutter SDK so that users before 1.5.9 will not use version 0.5.0 incorrectly.

## 0.4.0

Some code has been added to ensure that parameters that do not pass in native do not trigger crash.

## 0.3.1

Fix:

- Android close file output stream.

## 0.3.0

Fix:

- optimize compress scale.

## 0.2.4

Updated Kotlin version

**Breaking change**. Migrate from the deprecated original Android Support
Library to AndroidX. This shouldn't result in any functional changes, but it
requires any Android apps using this plugin to [also
migrate](https://developer.android.com/jetpack/androidx/migrate) if they're
using the original support library.

## 0.2.3

change iOS return type

## 0.2.2

add some dart doc

## 0.2.1

update readme

## 0.2.0

The version number is updated so that people who can use the higher version of gradle can use it. see pr #8

if android run error, you must update your kotlin's version to 1.2.71+

## 0.1.4

add optional params rotate

fix bug

update example

## 0.1.3

fix the ios `flutter.h` bug

## 0.1.1

update readme

## 0.1.0

first version
