Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6C817
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815619; cv=none; b=FIKHAvHuzd1LB3SuCMVUEo6snwEfo0kkEDg2T63Yw0tvRFvVpKfcgka65dYxfWEYDws16lcBO6jYtzP3XEliGB7MuX25IEoZHjd2HqMj7A2enKZyElT8LcoO8ylYnPW8w4eUPNZ6RjJx40b4apznkN6CVQt16vtYG9MLvNxtRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815619; c=relaxed/simple;
	bh=Meqxexe0wX8cbrgeZspjqsBowKJlSlFfz9G1TT+7xUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q16998XtS4j25euMX3sjcNgKQNW8B2ZbwrObsZ2aHe00ryCgPVRII6djUltlWPCS7r9hsJDblup8AgKPBRGHKiP76pjWUeEug+1iiMEGfgKum3w2ZhrTjjMVQ4GmLCXReheIrk5E8hXI1PHnHxBub76wuux/43h243/szPOPwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=vdvKNJbX; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="vdvKNJbX"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 369122A5D8A;
	Fri, 16 Aug 2024 15:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1723815610;
	bh=Meqxexe0wX8cbrgeZspjqsBowKJlSlFfz9G1TT+7xUo=;
	h=Date:From:To:Cc:Subject:From;
	b=vdvKNJbXUPvM5YknDBvW+YuAXgdijCfmzjFxHp4ajI+KbHJ7wTa2mGhM9Z20RPh1h
	 UrpVHD2eDMXE30awJuPSLM9hptNEDk1DVMBArgTR9wQf7ptTIFn/A77sI+ZnJvib+b
	 mTCSz0qCw4EjQQtzAYOvODMPBOFeb7vqDsptJ9PafddxXNjL6j1FYWrBZEvUSiiQL7
	 K+pdQbxcVieFQOlHHHulBBuud3mplXwcg+k7nQSDcG9FancaxrXzysE9yOjvDlPljt
	 ixNd+W3CEf7dr/nX4GtXdko+00/VKwBxAJgJPZW6UYT/+sVNjN984ncHWlGBx/6nsn
	 ft3q9v8aMOMeg==
Date: Fri, 16 Aug 2024 15:40:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.11-rc1
Message-ID: <Zr9WubNFJyVjE1R0@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TjlZnCe6OcuoWwCx"
Content-Disposition: inline


--TjlZnCe6OcuoWwCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.11-rc3

for you to fetch changes up to 92567a5f92bc947fb7aa4351979db1b7b71a554c:

  iommu: Remove unused declaration iommu_sva_unbind_gpasid() (2024-08-13 10:53:45 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.11-rc3

Including:

	- Bring back a lost return statement in io-page-fault code

	- Remove an unused function declaration

----------------------------------------------------------------
Barak Biber (1):
      iommu: Restore lost return in iommu_report_device_fault()

Yue Haibing (1):
      iommu: Remove unused declaration iommu_sva_unbind_gpasid()

 drivers/iommu/io-pgfault.c | 1 +
 include/linux/iommu.h      | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg

--TjlZnCe6OcuoWwCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAma/VrgACgkQK/BELZcB
GuNfXQ//fECTqYiasEBEGtAaj8bb0uqJUKLlIsKEIHUKQHkJe9OUk1wkahNFygS0
bVNK9z9R1k0HIOXJrmWdKrNS/cBEimFqZOoJkCXBX0X24I8Bu1FP8LkYXmSY+JcY
wr1iy2vwrPHaxbdyZd+xbi5HQLZORJE1immYKOlA+paPkb6/Kaenpk9L4o2xiTdJ
kOREOVLnkB1J/cR/c19EGCWIN9Y7vabdC3J2pOtaLEKoe1E3WimqszmyHAalu4AB
gLOvSR2BGOGm69V+9+lTj/mWoKeYjaov7ehl7l/Mj2tS5rYiP/ooZOUafjZp2QXU
FvoC+UZHGF7MQV1JNP07SVmCRLt77rsN/JnjZL233dAykSNcp0hAQ34dQrjoBDgL
qBtSzC5uS459lOASyaPXZ7ARe7ojO3vMkLJgFEpThq7lmLKqM6p6ZNLxSvpq/lPs
6K2VI0k3foUdsxRl+sOlfQzhDiQpY0Djfr5iV+dWJeNGn6vfb7SEIti7w6YTVTND
HkrOPkyPJLCcaWRPIDbVEjHHq5C+MWXyy8VdU/Hh9ZV/CKpmYXpmYfgkz1rFbfcV
uhicMAmHCWE6um1UmD2WoSKKDAACsKcsWHZYaV0fal4xbatBplFdydVrmHRfEJq5
/Wz3xEaDeBLXFxaGJ3BffWe2Ul6dfoQMZNjIdb93fi57EHzZIPU=
=qpkg
-----END PGP SIGNATURE-----

--TjlZnCe6OcuoWwCx--
