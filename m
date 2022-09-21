Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177A13211
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 12:19:07 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id ADBC624131B;
	Wed, 21 Sep 2022 14:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1663762746;
	bh=hZ+WGEjggQCri78fagmsYANy5ntZstnG04jkIRuh9Xk=;
	h=Date:From:To:Cc:Subject:From;
	b=KIGa4ncKuSILKD26U7g01VcKvxcOlg1IMCn7ThE7N3sngz9RcF5z1rtQGc1XQnLZn
	 E3B5iEjI9ewbtl2nqpGpo3mkbIoHenQnkMS7twCu81Zvf+L8F4TQB0f9iymCRftRs3
	 m7OqhdDQ9JRkxHAIAkDAFLVHOntHdyxiPD3WN5CNBc2iByF2zuBDp9opnyjRZHU/Uw
	 BvoqBtD6/x7ADrOPgncG0M066Bo1BvrUzofB43RbYZnTtBLUYCKWEDYE+ag4rm0O9b
	 d1+IFsGGmoljeNGm9KfLwQvyn4jEHSEajj4QZQJN04zBI9vmJPshhXlgOlXUXaQpnA
	 j1dgg41aBtqPg==
Date: Wed, 21 Sep 2022 14:19:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.0-rc6
Message-ID: <YysBOff9ZGM/EfQh@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l/vVzbqds+DTlzV7"
Content-Disposition: inline


--l/vVzbqds+DTlzV7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc6

for you to fetch changes up to 154897807050c1161cb2660e502fc0470d46b986:

  iommu/vt-d: Check correct capability for sagaw determination (2022-09-21 10:22:54 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.0-rc6

Including:

	- Two fixes for Intel VT-d:

	  - Check the right capability bit for 5-level page table support.

	  - Revert a previous fix which caused a regression with Thunderbolt
	    devices.

----------------------------------------------------------------
Lu Baolu (1):
      Revert "iommu/vt-d: Fix possible recursive locking in intel_iommu_init()"

Yi Liu (1):
      iommu/vt-d: Check correct capability for sagaw determination

 drivers/iommu/intel/dmar.c  |  7 -------
 drivers/iommu/intel/iommu.c | 29 ++++++++++++++++++++++++++---
 include/linux/dmar.h        |  4 +---
 3 files changed, 27 insertions(+), 13 deletions(-)

Please pull.

Thanks,

	Joerg

--l/vVzbqds+DTlzV7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmMrATkACgkQK/BELZcB
GuOE0Q/9Gc1bFSEAY+dTpLKR3xX8cxepYcCjhssMGbQ/YXniVmVZOIR+eu6EUAHV
Am0FQ5wSsbpvXlLu0bFjnbzNTuRW8dFBTgI+NJTWikh2KoDscF15K9YZ8JQYx6Ut
bxI9ksqSVlfXmcOGzhJ+Ugj0nEgIPo1Ja1oTpQmMFLClxdx9aAyp60/KdpMPB7BP
Duw/pJxu/Ofj6fVI18JSek0g1SmtbnklRWeHzLAVsoDrCd93Q7kuSfbdMharqXdF
xfRWj+GYtZWUzQdBmQiJh7NOo5h7TJbdUJFFYo3+NXHax2IMR513/TDcxHcJeXrf
+YSjFayeKhftwbdAN2Gc5q0tqhc1rxkkBXzFB/RjyBIk3BVgVFxTMux9OME4lhPX
kjUuuqLPDyb5HEODejr7oOS/1kXFYqRQyoiFs0X2va3BDpumVU8kO8Fu5KvvtaXp
+mJwriF8eWAxrjPUXiEviC92mY+jJNBoPL9ig3+OsUBzueFbBjgrsraLQk7fSjpD
MmDTMLVV9SKTQAVWh0Zcuj/LsSVBDmEsqawUqvhc0GJgDqwq2QXMoZSVz1OSgTa0
JHyF3NyCXjj85X/cbR6EScHUI9yfRKjd2d1fpKjm5AaEPIQV899p1GmeoIs+a55g
tWpbXFNQz7kVaJLKJyIn/pr+bnstWAhlpOViI8RZeh88g8j0sv8=
=VN65
-----END PGP SIGNATURE-----

--l/vVzbqds+DTlzV7--
