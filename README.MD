# shellutils

Some shell sripts I wrote, to solve problems I had.


## course-content-list.sh

Create a .ods file with filenames as lines, from each sufolder contents.

### Usage

```bash
cd to_course_folder
course-content-list.sh
```

Will create a file named as the current_folder.ods.

## github-mkrepo.sh

Create a repository on Github.

### Usage

```bash
github-mkrepo.sh GITHUB_USERNAME REPOSITORY_NAME
```

GITHUB_USERNAME is the Github login.
REPOSITORY_NAME is the name of the repository to be created.

## jre-mkplayer.sh
Generate a htm file with the Spotify player for the JRE episode passed on command run

### Usage

```bash
jre-mkplayer.sh EpIsoDe1d
```

## myip.sh

Fetch your valid IP address from web services. Store it on a file.

### Usage

```bash
myip.sh
```

## mkv2ac3.sh

MKV Extractor. From a mkv file:
- Converts audio track to ac3;
- Copy only one subtitle track;
- Copy only one video track;
- Copies to a mounted pen drive.

### Usage

```bash
mkv2ac3.sh
```

## mount-pen.sh

Yes, I'm lazy. This one simply mounts /dev/sdb1 to /mnt/pen

### Usage

```bash
mount-pen.sh
```

## video-info.sh

Extract info from a video file (mkv, avi) into columns.

```bash
video-info.sh
```

