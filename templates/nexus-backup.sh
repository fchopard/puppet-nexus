#!/bin/bash

rsync -auv --delete-delay --include-from /var/lib/nexus/nexus-backup-includes.list /var/lib/nexus/sonatype-work/nexus/ /mnt/isa/backup/nexus/