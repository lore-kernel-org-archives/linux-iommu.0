Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51AA18CBF1
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729241856; cv=none; b=sQTN8nmyvRIjZQ6WyjTq9teP/xCPv0ywLpieTK+bcH4vi/ittjYUNHFy5fFCFtogPyr2f6pGy+lyEzIjV0yn404wcM9bAfME1ogtgS4P0ve37tfXZc7zZ+L84LHvvkmVCYHr34HlGW5tk19wOsk4o9jSesdKGrnJjNTuP2xVk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729241856; c=relaxed/simple;
	bh=NDNBZ4MZbiy4V5FwxRLqOWI+bBrqXrIucxSbc/MnqRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l024ElRjRdt5hI5+pIIZZ+cgI0+nVQJ6uPzd5YcLsnNyLfjN+fhmCMZw+HY5YFgo5I5/diIzrGpTi4lb11G+QHeDjR9LcAah6iZG0yIg0oPlUg0flNvG5kegvRsrvyAc4R+MBzukLKge34ohQOk1cEwe6DuwMLzR7Xs90KRpjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ltC26Ip9; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ltC26Ip9"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 084342A20B7;
	Fri, 18 Oct 2024 10:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1729241848;
	bh=NDNBZ4MZbiy4V5FwxRLqOWI+bBrqXrIucxSbc/MnqRY=;
	h=Date:From:To:Cc:Subject:From;
	b=ltC26Ip9idWaE4z4HYPIuqzPhvLnx5itqOVQ3dSqmvoGf4tdlNHzVuzbSlLTk0U8q
	 5gjUuOXE1ASN3vVN0aVtFTGiInw1vSLq4vAQ1l4Wzx4glBzeDl/2MGayuq60Q/36PX
	 Nl1fxO6mQ03lut5Xr3NeqH3g8+TjqKCZje+ziiKol+GIXr+Fn+qpQDl45wqnZMn9Mo
	 xXGDlPwK2X+Wd4vZbBVz4n+p1Uw+Qs/AygF/ES3uiowdHSvqaNbCZxhtDCYweXSkGI
	 ut6Pig4oHkdmyHsmWtfCcL5EEyU4LdOKKnQSOCGe0wzq1q4nCPruc8IDbEruroiltU
	 dk7NBxGT4nSxw==
Date: Fri, 18 Oct 2024 10:57:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.12-rc3
Message-ID: <ZxIi9rUNnv1HOPpr@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HS5WuD6udurEOHJe"
Content-Disposition: inline


--HS5WuD6udurEOHJe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.12-rc3

for you to fetch changes up to 6e02a277f1db24fa039e23783c8921c7b0e5b1b3:

  iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices (2024-10-15 10:17:54 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.12-rc3

Including:

	- ARM-SMMU fixes from Will Deacon:
	  - Clarify warning message when failing to disable the MMU-500
	    prefetcher
	  - Fix undefined behaviour in calculation of L1 stream-table index
	    when 32-bit StreamIDs are implemented
	  - Replace a rogue comma with a semicolon

	- Intel VT-d fix from Lu Baolu:
	  - Fix incorrect pci_for_each_dma_alias() for non-PCI devices

----------------------------------------------------------------
Chen Ni (1):
      iommu/arm-smmu-v3: Convert comma to semicolon

Daniel Mentz (1):
      iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits==32

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into fixes

Lu Baolu (1):
      iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices

Robin Murphy (1):
      iommu/arm-smmu: Clarify MMU-500 CPRE workaround

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c  | 4 ++--
 drivers/iommu/intel/iommu.c                 | 4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg

--HS5WuD6udurEOHJe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmcSIvYACgkQK/BELZcB
GuMC+A//T0JANvaQ8OUZ2bCOry674NcTGldYh84OosAw2xPK2arnyE2+usoj0QTK
HyMtauy3hzb4/2z0hpr2ZE2hguB53eI+Mt4psmyG3uomxVZAhQhEpdTgZ0sqpeYV
tWE01QJc+rJbvumfwDC5yJUwSOP4Y8Gth2DRKY0+/+9AkjaNOMzDG7F4Ytebfg1R
QRaAVsrukykUcg4KEmuAL14Ruz8sHasUJkwln2RfYFQZGfU+0uYX7Xm7gnbE6gER
P4fo2zkWchJeIXHXxqE1Zg+JDrRtkfNZgGBiHmskqF7Ia/FXlxCavh7A33lLM2o0
VXX1mMzcwFa3jgDb4bwMawUs23XlmMWU9G4uVYlJPug7f3jXBSa4ayCGvMzmS3+c
HnDTwz6UkWmo0Xl0SCalXqoszzzGKSgTQIZOltsdwfit811tE5+wqnH8MuUA6k9p
x+XHKmkNaApOo1Zwz/7hxhNWIc+jKbIHhA9ZX9bFdt4z8nkwOKlc/hN7zWZDIdHo
nnt5AzKNExMzoBDjFz7QaDWHqXluO1nRYKIevCaGKibgM+Dxkd7nvOl/fsvHAA8i
LKtGrVOwdnCT3d4AD9gANt+QXJXJmSeZe56bn3hW0WdcXBVXt+lUcy93Sw4AXbe8
1szTeByF7xbzhbO+IiBKi3b3tNLGdDZqYys8+W6Jq7nW0F5fD1g=
=uNjT
-----END PGP SIGNATURE-----

--HS5WuD6udurEOHJe--
