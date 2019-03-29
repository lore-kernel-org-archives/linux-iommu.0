From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v5.1-rc3
Date: Fri, 29 Mar 2019 17:26:42 +0100
Message-ID: <20190329162636.GA29901@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.1-rc3

for you to fetch changes up to 8aafaaf2212192012f5bae305bb31cdf7681d777:

  iommu/amd: Reserve exclusion range in iova-domain (2019-03-29 17:12:57 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.1-rc3

Including:

	- Fix a bug in the AMD IOMMU driver not handling exclusion ranges
	  correctly. In fact the driver did not reserve these ranges for
	  IOVA allocations, so that dma-handles could be allocated in an
	  exclusion range, leading to data corruption. Exclusion ranges
	  have not been used by any firmware up to now, so this issue
	  remained undiscovered for quite some time.

	- Fix wrong warning messages that the IOMMU core code prints
	  when it tries to allocate the default domain for an iommu
	  group and the driver does not support any of the default
	  domain types (like Intel VT-d).

----------------------------------------------------------------
Joerg Roedel (2):
      iommu: Don't print warning when IOMMU driver only supports unmanaged domains
      iommu/amd: Reserve exclusion range in iova-domain

 drivers/iommu/amd_iommu.c       | 9 ++++++---
 drivers/iommu/amd_iommu_init.c  | 7 ++++---
 drivers/iommu/amd_iommu_types.h | 2 ++
 drivers/iommu/iommu.c           | 8 +++++---
 4 files changed, 17 insertions(+), 9 deletions(-)

Please pull.

Thanks,

	Joerg

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlyeRzwACgkQK/BELZcB
GuM71g/8DR8/HcnbEjWjYEEeSRRreyOO+oKku8wW7khaK8+rQ3jjn9qQ/pVYaImv
wZmuF4GDO51r+xZzjOxavKEYYHTrc3jvaK8JNcmVJzZKyOopm/F9Foy/sBrKgMXd
JttxqISIM1zAE0G5Nvx+jyx4PIp5qyy8w+S9L1srooRHCi6WYaIDajIbx1sYhLtb
cLUqk1whM24kBQFEAETidizoCczGGzmp7hKuTUMVIKyOyFETYcRUleITToVY18sY
Spv/S2QzI/rx49Kb2D+AlEMy3RyIFO26eltOk8ecyCWf3TVgrwjLFc3pmv22Bq6u
yoqSrpXcFilK2ZMef9ZWC8phtI5J3tSY9uAJAJdjCDx8tlkug2kD+IxrDXTYddrF
1fSfpHogXLirVKvVTgaCCnNMKRZGA+UM5lLjDoMbhsKzNh22sAxslbYP/3GQVHPK
TiKtRZGYKlHSIzn3yFbak7I8Kz8R6m+mOLPAf4WwCfFphINEX1K2ybYumVE9/MgS
4Z+pVn28EcXnbDvCxJXoZdveSPo3dmEJAiEsWv2AFt4Rp4iifxo0/2NxP3NymBlD
mM10O+SjHhLML6+jtQH6x8arJEvO9rdQtbtlvlJDVtlgH/ps5l8OS+FUSu14X7I9
U1ViaI+lA68CsooAEohpDFC+66AyaboOoiaNzuy7hO2y3isOyKE=
=ABZo
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
