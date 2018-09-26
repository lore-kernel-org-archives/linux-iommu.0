From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.19-rc5
Date: Wed, 26 Sep 2018 11:36:49 +0200
Message-ID: <20180926093643.o67rf7q56fvfcrpt@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uywm56sl3lc6eur7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--uywm56sl3lc6eur7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

The following changes since commit 6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84:

  Linux 4.19-rc5 (2018-09-23 19:15:18 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.19-rc5

for you to fetch changes up to 5ebb1bc2d63d90dd204169e21fd7a0b4bb8c776e:

  iommu/amd: Return devid as alias for ACPI HID devices (2018-09-26 09:41:11 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.19-rc5

Three fixes queued up:

	- Warning fix for Rockchip IOMMU where there were IRQ handlers
	  for offlined hardware.

	- Fix for Intel VT-d because recent changes caused boot failures
	  on some machines because it tried to allocate to much
	  contiguous memory.

	- Fix for AMD IOMMU to handle eMMC devices correctly that appear
	  as ACPI HID devices.

----------------------------------------------------------------
Arindam Nath (1):
      iommu/amd: Return devid as alias for ACPI HID devices

Heiko Stuebner (1):
      iommu/rockchip: Free irqs in shutdown handler

Lu Baolu (1):
      iommu/vt-d: Handle memory shortage on pasid table allocation

 drivers/iommu/amd_iommu.c      | 6 ++++++
 drivers/iommu/intel-iommu.c    | 6 +++---
 drivers/iommu/intel-pasid.h    | 2 +-
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--uywm56sl3lc6eur7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJbq1MrAAoJECvwRC2XARrj8fIQALkXq/q5tpPoQ0UGuHotzsmj
fNcMbQjNmQSejG5d7P0dEiGm0hCTz1B9+g2p2obRcKCPXtsSdUqzBvZabBsjOulg
OhHNjUTU8f4GmZSzI1spnATv+9SejsaPZ1tiESTZ/GIOt4CcTqBLaPhjsrC/Mq+3
EV0wL3saPoDj/AhLSZiBDrR+1uCzdnz67f4NAvk9KdLJkzSTbUACfkOoOr0j1zDs
rNUKUuB2/eSIq1m56po2Je+IEkCK9goCi1udHA0zDVtPUhvqL/b9IhSJAWrnTT+x
m0f9zxBah6zFYY3KXARAXAK+nnBv2tHIeBw7/0OC6AHCIOiU++ILrKBFQovqmXU2
0nr68mBykBpWJF4/1Izgq8KPBo3JH3LN0SS4tDvras+Yuv6+239Lvyup8v30+0r0
DV86iklqcEAceRSo9fdylPFXg28V/HLQ2qreDvw70gZDNyAuqC+3JLbvW3nqEo/a
cO/cbhD1pcgqSMtHA/gUJE5/hqam3uth1DGTbnoK+Dgydyul/OA9kHp3LiqLwqug
zQSaUqLUi7z5gHqLXYLFByA0juaJAhFa0OVHqxLMKH+mCeHiTPHdZ3ZjLoVxszey
zdzmw64yQv7vDRD9n370yDlvdFI0DFdbjZU4VM5+XwnFLYqmvs9dcHHTuyqt35cp
PgFyZr8wwDQwVQEIOATs
=OzWo
-----END PGP SIGNATURE-----

--uywm56sl3lc6eur7--
