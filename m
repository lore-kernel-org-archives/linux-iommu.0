From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.14-rc1
Date: Fri, 22 Sep 2017 14:07:06 +0200
Message-ID: <20170922120658.2z6nnds35vsak6we@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7vl2ng346uok3dun"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--7vl2ng346uok3dun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.14-rc1

for you to fetch changes up to c0d05cde2a685cd6486390c62be684ce456d84d6:

  iommu/of: Remove PCI host bridge node check (2017-09-22 12:05:43 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.14-rc1

Including:

	- Two Kconfig fixes to fix dependencies that cause compile
	  failures when they are not fulfilled.

	- Section mismatch fix for Intel VT-d

	- A fix for PCI topology detection in ARM device-tree code

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu/vt-d: Fix harmless section mismatch warning

Geert Uytterhoeven (1):
      iommu/qcom: Depend on HAS_DMA to fix compile error

Guenter Roeck (1):
      iommu: Add missing dependencies

Robin Murphy (1):
      iommu/of: Remove PCI host bridge node check

 drivers/iommu/Kconfig    | 5 +++--
 drivers/iommu/dmar.c     | 2 +-
 drivers/iommu/of_iommu.c | 5 +----
 3 files changed, 5 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg

--7vl2ng346uok3dun
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZxPziAAoJECvwRC2XARrjsZgQAIeYMfHA4wAiB9k686DOV9yB
davw58m+EgNSBMmrltVXKGdR77uoA4FFcGkWa023KrkEsvZ0o10wbN4jkF63MbzM
JhR1pgkrDSSlSHfjW1O1XMyo/orgQcdDEWmJoPv0MQIJM+B8QwofPmLiWQ669h9Q
UIf0CHZFaNog0xJLdd6YeZ7clKLm7RHeRoSYc9K62sSFmf9uhUOxhicm3YlmnSnm
dsPlhd6Z9LKCLSTg1bUAoai9ZHL2AhS/clAiF0p4ySaiQAzUluxIa1/QPSW1wIF/
NnKxxIE3qDlFLb4r1kxCmXERBY2XGAXUqIeJgObB+smlAOD/Vusyph8gTnGFfmfI
SxUh3M9ZKV15AYWnNLGfKzkdp//LgaGG1gRV9552Rw8FiTDOd7TTECmdbbNsa/Hr
UCn7mM+rd6llx+VWXxfHOHvRehp/sgG3FHjn91TtxdAyJGYT/fR6DKQBTdCMaFeW
LGk8XLVl9COeGEL7L6G/zFrbnLk+F71s9oWwJkFy84RmbPqQmUFiSpzTw8hpr2kJ
rj0c9FhhrWhGNWiskFnJVWioz9RUidvN9LP8tgGcLC+lnY4AU59unwqI4t++9dWW
I8w/bUaanASHl7qxGGvpSg7wJA+qydn+DTv3cjFPgthYFyrr0sBqfn96XXLHPC4L
YvhWysAb6KaYX/js+XRb
=VhQj
-----END PGP SIGNATURE-----

--7vl2ng346uok3dun--
