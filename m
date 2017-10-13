From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v4.14-rc4
Date: Fri, 13 Oct 2017 17:51:57 +0200
Message-ID: <20171013155153.lo3mqqf46zav4jhg@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7g3poemjknrexsny"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--7g3poemjknrexsny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.14-rc4

for you to fetch changes up to ce76353f169a6471542d999baf3d29b121dce9c0:

  iommu/amd: Finish TLB flush in amd_iommu_unmap() (2017-10-13 17:32:19 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.14-rc4

Three fixes:

	- Keep an important data structure in the Exynos driver around
	  after kernel-init to fix a kernel-oops

	- Keep SWIOTLB enabled when SME is active in the AMD IOMMU
	  driver

	- Add a missing IOTLB sync to the AMD IOMMU driver

----------------------------------------------------------------
Joerg Roedel (1):
      iommu/amd: Finish TLB flush in amd_iommu_unmap()

Marek Szyprowski (1):
      iommu/exynos: Remove initconst attribute to avoid potential kernel oops

Tom Lendacky (1):
      iommu/amd: Do not disable SWIOTLB if SME is active

 drivers/iommu/amd_iommu.c    | 11 +++++++----
 drivers/iommu/exynos-iommu.c |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg

--7g3poemjknrexsny
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZ4OEZAAoJECvwRC2XARrjLlIP/iir6P/L36zQXoTn0M9k4MGJ
YRzlkp+K29v1mzkoT5S3VUPlMpecXOuPVAlCYGrMLC5p0pxp5Jda3u4yhcQwbIBn
2LuXdpNn6nDNQg/AUq/IBQrGhXXMJDoZGDoFT10SA55XQldUJY692rC9jhT/RljK
TFVP5l4FokDVvpFkjBHfZUJaamZASRqgQ/dR7xi69+M9D1mvc16KXD7Q+CDVLM1P
2erIe+vSqYCgz72tLa6B2YN21kWQPDjMeXAIMLQCI0KmnFiW7a+ohJq3i++KwPiv
qWgw/H4Du+T+bPIDvBgX+R1W16y6AqrMNTOVPbcbGjw3vHso6CBLnP0MlLrNGxUG
I6jd6+61kmZE+C03tOv085KnycBYorJM//9OdCiwNlWXKhTZhOrgDkO710qXlQ7Z
0A6Ax2Uie3oEeI1vWxd4pJaTniU50h7CRRsTizU/igeuubCDUKT0ih2WmuO3x0s2
kGZO0ma/idSZGJS9bFDPbr3IK5riXuNY8JeTXgDvSGiuxPWmp8iTCOnQFQkwd2EU
maIw21Z/RbeHta2hKk9EwUTetf3U8USfUklAeHQrXrfg7ukw2jU38TV3q/68JaNb
rch1CrLVCGj82wy7TvtdcFhaYxuN1QRqSX3dUZ6WE/mbVIoV0lUm0EIDpLk1hVXt
73OxFIcwf/UMhJhX1vHX
=GN4P
-----END PGP SIGNATURE-----

--7g3poemjknrexsny--
