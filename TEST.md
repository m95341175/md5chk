```
$ ./md5sum.sh
SYNOPSIS
  md5sum.sh [-q] FILE
  md5sum.sh [-v] [-h]

$ ./md5sum.sh -v
md5sum.sh -- v2.01 -- 2017-10-19

$ ./md5sum.sh -h
md5sum.sh -- v2.01

SYNOPSIS
  md5sum.sh [-q] FILE
  md5sum.sh [-v] [-h]

DESCRIPTION
  Reads MD5 (128-bits) checksums and filenames in FILE and checks them

  -q  Quiet mode, only prints mismatched hashes

  -h  Displays this help and exits

  -v  Displays version info

AUTHOR
  Originally written by Joris Berthelot <admin@eexit.net>
  https://github.com/eexit/md5sum
  Improved by Mel Lowiz
  https://github.com/mellowiz/md5sum

COPYRIGHT
        Copyright (c) 2017, Mel Lowiz <mellowiz@hotmail.com>
                 2011-2015, Joris Berthelot <admin@eexit.net>

$ ./md5sum.sh hashes.test
[  OK  ] test/a.txt
[  OK  ] test/b.txt
[FAILED] test/c.txt: MD5 sum incorrect
[  !!  ] test/d.txt: File is missing
```
