# md5sum for macOS

## Installation

```bash
git clone https://github.com/mellowiz/md5sum.git
cd <directory>
sudo chmod a+x md5sum.sh
```

## Usage

### Synopsis

	md5sum [-q] FILE
	md5sum [-v] [-h]

Reads MD5 (128-bits) checksums and filenames in FILE and checks them

	-q	Quiet mode, only prints mismatched hashes

	-h	Displays this help and exits

	-v	Displays version info

## How to generate a valid MD5SUMS file

The default OSX `md5 -r` command [doesn't generate a valid format](http://blog.eexit.net/sh-md5sum-c-like-for-mac-osx/):

	$ md5 -r LICENSE
	95baec3fa8136f631e8b7bad5460d7b6 LICENSE
	# It should output:
	95baec3fa8136f631e8b7bad5460d7b6  LICENSE

In order to fix this, you can extends the `md5` this way:

	$ md5 -r LICENSE | sed 's/ /  /'
	95baec3fa8136f631e8b7bad5460d7b6  LICENSE

If you need to generate a valid `MD5SUMS` format for many files in one command:

```bash
$ find . -not -empty -type f -d 1 | \
xargs -I %s basename %s | xargs -I %s md5 -r %s | sed 's/ /  /'
95baec3fa8136f631e8b7bad5460d7b6  LICENSE
ccbd9f1144351424c0afbc9a9b5df021  md5sum
f9e4c933069ab3c67006dbbd8e9a8840  README.md
```

### Author

  Originally written by Joris Berthelot <admin@eexit.net>
  https://github.com/eexit/md5sum
  Improved by Mel Lowiz <mellowiz@hotmail.com>
  https://github.com/mellowiz/md5sum
