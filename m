From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: =?y?q?=5BRFC=5D=5BPATCH=200/2=5D=20debugfs=3A=20Allow=20debugfs=5Fcreate=5Fdir=28=29=20to=20take=20data=20from=20caller?=
Date: Wed, 8 Aug 2012 09:24:31 +0300
Message-ID: <1344407073-12030-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The commit c3b1a35 "debugfs: make sure that debugfs_create_file() gets
used only for regulars" doesn't allow to use debugfs_create_file() for
creating directory, and the current debugfs_create_dir() cannot take
the private data from caller. There are some cases that we want to pass=
 some
client data to dir, especially when dir is nested deeply. We can work
around to pass all necessary data with some invented data structure to
the end files, but if directory itself had private data, we could
avoid to introduce new structures just to pass data to end files.

=46or example, tegra iommu(smmu) case, debugfs structure could be as
below.

sys/
=E2=94=94=E2=94=80=E2=94=80 kernel
    =E2=94=94=E2=94=80=E2=94=80 debug
        =E2=94=9C=E2=94=80=E2=94=80 smmu.0
        =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mc
        =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=
=94=80 ptc
        =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=
=94=80 tlb
        =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 mc0
        =E2=94=82=C2=A0=C2=A0     =E2=94=9C=E2=94=80=E2=94=80 ptc
        =E2=94=82=C2=A0=C2=A0     =E2=94=94=E2=94=80=E2=94=80 tlb
        =E2=94=94=E2=94=80=E2=94=80 smmu.1
            =E2=94=9C=E2=94=80=E2=94=80 mc
            =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ptc
            =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 tlb
            =E2=94=9C=E2=94=80=E2=94=80 mc0
            =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 ptc
            =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 tlb
            =E2=94=94=E2=94=80=E2=94=80 mc1
                =E2=94=9C=E2=94=80=E2=94=80 ptc
                =E2=94=94=E2=94=80=E2=94=80 tlb

The end files, {ptc,tlb} depend on which mc? to belong to, and
which smmu.? to belong to. The parent data can be accessed from those
end files if necessary.

  dent =3D d_find_alias(s->private);
  cache =3D (int)dent->d_inode->i_private;
  mc =3D (int)dent->d_parent->d_inode->i_private;
  smmu =3D dent->d_parent->d_parent->d_inode->i_private;

The original tegra smmu debugfs patch is:
  http://lists.linuxfoundation.org/pipermail/iommu/2012-August/004507.h=
tml

Hiroshi Doyu (2):
  debugfs: Allow debugfs_create_dir() to take data
  iommu/tegra: smmu: Use __debugfs_create_dir

 drivers/iommu/tegra-smmu.c |    4 +---
 fs/debugfs/inode.c         |    7 ++++---
 include/linux/debugfs.h    |    9 ++++++++-
 3 files changed, 13 insertions(+), 7 deletions(-)

--
1.7.5.4
