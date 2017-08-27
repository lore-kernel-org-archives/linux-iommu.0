From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux iommu-fixes-v4.13-rc6
Date: Sun, 27 Aug 2017 14:45:32 +0200
Message-ID: <20170827124524.sye7hzriufwwjolu@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6mjxezoq7cigwihk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--6mjxezoq7cigwihk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a7990c647b35415e3dd07a077480a908678947ba:

  iommu/arm-smmu: fix null-pointer dereference in arm_smmu_add_device (2017-08-11 16:56:51 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.13-rc6

for you to fetch changes up to 2926a2aa5c14fb2add75e6584845b1c03022235f:

  iommu: Fix wrong freeing of iommu_device->dev (2017-08-15 13:58:48 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.13-rc6

Another fix, this time in common IOMMU sysfs code

	- In the conversion from the old iommu sysfs-code to the
	  iommu_device_register interface, I missed to update the
	  release path for the struct device associated with an IOMMU.
	  It freed the 'struct device', which was a pointer before, but
	  is now embedded in another struct. Freeing from the middle of
	  allocated memory had all kinds of nasty side effects when an
	  IOMMU was unplugged. Unfortunatly nobody unplugged and IOMMU
	  until now, so this was not discovered earlier.  The fix is to
	  make the 'struct device' a pointer again.

----------------------------------------------------------------
Joerg Roedel (1):
      iommu: Fix wrong freeing of iommu_device->dev

 drivers/iommu/amd_iommu_types.h |  4 +++-
 drivers/iommu/intel-iommu.c     |  4 +++-
 drivers/iommu/iommu-sysfs.c     | 32 ++++++++++++++++++++------------
 include/linux/iommu.h           | 12 +++++++++++-
 4 files changed, 37 insertions(+), 15 deletions(-)

Please pull.

Thanks,

	Joerg

--6mjxezoq7cigwihk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZor7kAAoJECvwRC2XARrjCOEP/2KgSpikUlaY8qwv21i2FM34
oYLEU/kXRKEo9K6sikZN2y2mgo0fORmRV8551tBdRtZMa22OwJE3oSQ105+Y/Gxb
5uU/4NHv/lppb44777JmLcDOORvTWH7sKZLjZ07wd/5vN5JSYbGTewyx2vCGyUML
+iz0DP7hvLaSCj2KP5TRG3AZBrKLcBLfdFQbX1f+wAVFIm4IH5Y0JDsTaBm/egPG
jQuQ8mDh2Mo5L9Xmzm0Tsf9MTmQFJsStwxr3JOyRQJEXhRNXk4nnys9KNkzbd8Mz
6yvxQ/QwP4vHqRIX+H2dRGVpWgEGRv6JAbzHGs8XYoA9amnXalb2FpZBt04txLHI
hn8wgW64dT4BHW27zWSgk3/jlOgS92sYbP/UnZvMyxEbOUjisdVJ5Ro07qYzQFEA
+ph8W6zGCT3SNSI+3c2Ev06A49KJEg9qfkIoDtwy6wnYELiXjLEs4Y86+Ptj1bAj
7czwMaio4mqK3rzXdtsjI9hTUxQDiQbJgOaxWerIHgKfZQf7uJeqKHxSdqbNs+oP
cYi8poYYvx8LNpYhT9q7JcStd32YDUJlX+8Na063PME9PMNB94xE+svFcCDzs3WY
BNGp5QlIu9Vio52eTs+GOg/MFxbHNOdd7X520OxTIQLkDcBMYcOV49nrekvCSoM0
OS+r+0eWvCy+2AiJWWdj
=7tAI
-----END PGP SIGNATURE-----

--6mjxezoq7cigwihk--
