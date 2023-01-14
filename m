Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF958498
	for <iommu@lists.linux.dev>; Sat, 14 Jan 2023 16:27:54 +0000 (UTC)
Received: from 8bytes.org (p200300c277327f0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7732:7f00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D8DCC262023;
	Sat, 14 Jan 2023 17:27:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673713666;
	bh=vULKOkbp9CZBwY7oIAXxQR1kopxTS17Ty9VeKoVt+Vg=;
	h=Date:From:To:Cc:Subject:From;
	b=A3EHKNmXqEbms4/YLd8gYwVLxMaWLUnTdsLbjMmR1KtPbtSQCwuw2iEHN7XOQ3xnP
	 7z20tvMF2LJwjP4IBVvPmcTilRXJBuFfOUPEu7eHzw1xzwAwW6o6TLb5PWepiiMbXs
	 ovCU5xcOR0+ptv+juSxWDgQhBB7dDjLOhqf/uQS6gsBJ40lHwmok7+V3bn624r9jVR
	 YRcXBJOzAXCEnXWE9qIyAkBAnrJ86Q22ig5mWcf2vGTpkJBf88+yq7CAfvOP/WIH/X
	 wlTDlBSll8ZAOKA7GdWObbauNYWkeTUGknGSyHNes84SE//PGHVucMj4Zg1Y1UetMb
	 b+M3uso+4XFlg==
Date: Sat, 14 Jan 2023 17:27:45 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.2-rc3
Message-ID: <Y8LYARivqaRbWWja@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jOjp5fKZ3QeU4oJL"
Content-Disposition: inline


--jOjp5fKZ3QeU4oJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.2-rc3

for you to fetch changes up to 142e821f68cf5da79ce722cb9c1323afae30e185:

  iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe() (2023-01-13 13:46:32 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.2-rc3

Including:

	- Core: Fix an iommu-group refcount leak

	- Fix overflow issue in IOVA alloc path

	- ARM-SMMU fixes from Will:

	  - Fix VFIO regression on NXP SoCs by reporting IOMMU_CAP_CACHE_COHERENCY

	  - Fix SMMU shutdown paths to avoid device unregistration race

	- Error handling fix for Mediatek IOMMU driver

----------------------------------------------------------------
Christophe JAILLET (1):
      iommu/mediatek-v1: Fix an error handling path in mtk_iommu_v1_probe()

Miaoqian Lin (1):
      iommu: Fix refcount leak in iommu_device_claim_dma_owner

Robin Murphy (1):
      iommu/arm-smmu: Report IOMMU_CAP_CACHE_COHERENCY even betterer

Vladimir Oltean (2):
      iommu/arm-smmu: Don't unregister on shutdown
      iommu/arm-smmu-v3: Don't unregister on shutdown

Yunfei Wang (1):
      iommu/iova: Fix alloc iova overflows issue

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 32 ++++++++++++++++++++---------
 drivers/iommu/iommu.c                       |  8 +++++---
 drivers/iommu/iova.c                        |  4 ++--
 drivers/iommu/mtk_iommu_v1.c                |  4 +++-
 5 files changed, 35 insertions(+), 17 deletions(-)

Please pull.

Thanks,

	Joerg

--jOjp5fKZ3QeU4oJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmPC2AEACgkQK/BELZcB
GuOhnBAArnqzlOLtYDzYKAC7B2/X3bIMD0LtchDIg5+TG0I860XFvCPOStV5Mmgv
B4bHAFF7upNUfCyrPGfM1bk0dSHfrk5rtW9FV40xgZpliLdCHcYW8sAYCO24HhYw
4LOvzEYlB9jiEOZUuAOXmTdN24wvKRJIYEX5psMYVhm5pz+yqWvgYLvI2TMjRtVD
FiBQwcIgkBipxx7zoLspg2oX2rVCMyG8gMNHuPdOEuR4u8VggBI+nZWBXRqsVxha
eTgAKSs4Xgo5PBtXmKbOeJSsQ0FZmkiOZqhXQzOSq2AApQIb/Nfv55rgUtn4V7Ku
iRF9fO2JsGNHceybeBUs55wvw86qYAUYc/AMENgXr6/qn4fxLIrBtPHR5iiifbyF
aGwWxkWeFgxlBA4XG1mHuPKOtHEkNzE3VIY/Itkf6+ccjrfpQrfFRG0sN1+eb1m6
sXVBROvbL+ShbeXApkbbmxMFu4SPdInTj7lkHN27zICIfDSJPgJ3C9p05wkyTXfy
UdCd1RFm+7XWm5kaIzSm7p7wGd3x7vi9CC1hWTKYgFftTjhjrggUwXegS1wXv2EM
OdLuk+njlD7Eot8xtGAspS3pmnkggb5r2ZKWrVDJK1ROjGzWYL8T6H2wIopjGJwc
hbm2KxINwFqTJoVvGl2n7e0o7JHmQstexJdtk+d4SQu0YS2UIOA=
=tqwf
-----END PGP SIGNATURE-----

--jOjp5fKZ3QeU4oJL--
