# pfSense Remote Config Backup

[![Flattr Button](https://api.flattr.com/button/flattr-badge-large.png "Flattr This!")]
(https://flattr.com/submit/auto?user_id=echoes&url=https://github.com/echoes-tech/pfsense-remote-config-backup&description=Shell%20scripts%20for%20pfSense%20remote%20config%20backup.&lang=en_GB&category=software "Shell scripts for pfSense remote config backup")

#### Table of Contents

1. [Overview](#overview)
2. [Scripts Description - What the scripts do and why they are useful](#scripts-description)
3. [Setup - The basics of getting started with](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with](#beginning-with)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to these scripts](#development)
7. [Contributors](#contributors)

## Overview

Shell scripts for pfSense remote config backup.

## Scripts Description

These scripts backup [pfSense](https://pfsense.org/) configuration remotely.

## Setup

#### Setup requirements

* A Unix shell
* [Wget](https://www.gnu.org/software/wget/)

#### Beginning with

Copy one of the following script in the folder `/usr/local/bin` with the name `backup-pfsense.sh`.

##### pfSense 2.2.6 and Later

Get the 2.2.6 version [here](https://raw.githubusercontent.com/echoes-tech/pfsense-remote-config-backup/master/backup-pfsense-2.2.6.sh).

##### pfSense 2.0.x through 2.2.5

Get the 2.0 version [here](https://raw.githubusercontent.com/echoes-tech/pfsense-remote-config-backup/master/backup-pfsense-2.0.sh).

## Usage

### Standalone backup 

```shell
sh /usr/local/bin/backup-pfsense.sh pfsense.foo.bar
```

### BackupPC

```shell
$Conf{XferMethod} = 'rsync';
$Conf{DumpPreUserCmd} = 'sh /usr/local/bin/backup-pfsense.sh $host pre';
$Conf{DumpPostUserCmd} = 'sh /usr/local/bin/backup-pfsense.sh $host post';
$Conf{RsyncShareName} = [
  '/var/backups/pfsense'
];
$Conf{RsyncClientCmd} = '$rsyncPath $argList+';
$Conf{RsyncClientRestoreCmd} = '$rsyncPath $argList+';
$Conf{BackupFilesOnly} = {
  '/var/backups/pfsense' => [
    'config-$host*.xml'
  ]
};
```

## Limitations

Tested on Debian.

## Development

[Echoes Technologies](https://echoes.fr) scripts on GitHub are open projects, and community contributions are essential for keeping them great.

[Fork these scripts on GitHub](https://github.com/echoes-tech/pfsense-remote-config-backup/fork)

## Contributors

The list of contributors can be found at: https://github.com/echoes-tech/pfsense-remote-config-backup/graphs/contributors
