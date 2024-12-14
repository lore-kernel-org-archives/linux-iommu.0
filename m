Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3095317BA0
	for <iommu@lists.linux.dev>; Sat, 14 Dec 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734168410; cv=none; b=ldZSOhZCykPthLB7c8DnJ2t6YbWNHqDCBXMew2YdRUp1BbfEQKqmfVNUYQQEQ6FsX2jZJuBrWh2BJq9AW4EEBaBJX1V1iRRfPwurd0usip+v4BNEOu9OoWsZ4+cbwDnmUG9mvBax4K3cb43WHg1JchuL12WnM6mwC+pXE10p8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734168410; c=relaxed/simple;
	bh=24duFGQsUHUz/c9cbzKXf4wUPmJtnfoKbPFnWsOy8A4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tgrx6IwNH5t0arlYe2Raswu3Vn2F+evlgpnwokLHgwKGHkF/5lRVMH96wUELwTcgqvuSlR4ElmOD4q7iESvXrkTgknOcdIAWj2eUBpKTXsSxWgX+Vdtq3MdAsAw7vrWBk68WQf9/Ykmq5ZR9iIgJ81rudotvz2O0wxSuGW7GO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Qr2LCYfm; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Qr2LCYfm"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D653A2C0894;
	Sat, 14 Dec 2024 10:26:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734168405;
	bh=24duFGQsUHUz/c9cbzKXf4wUPmJtnfoKbPFnWsOy8A4=;
	h=Date:From:To:Cc:Subject:From;
	b=Qr2LCYfm9+4VBBUi3/6Y/wSjH5ZjijIU1sz4EDGYs33Fx4Ls169fv7ZN8AXV7cy//
	 VbfbNmATwe5m+hRLoq28ExYISZ8aACc9652GuAUA28g1hp+OJG/yZfBXe/rjRU7tze
	 gG1tmeR+cq9d6TQhoBcPWfOOWWMmv65UgPJOGzRDuM1IPAXFeSERM/p8PhVPSa99SK
	 iRimP/m13rDWOiuXn8k4f9IIEQHjLItphqVL4mCTgnuMBbNmsRlVQRq+/61/9S2KJR
	 DydZrRDpPTCI6E/GQHm9Joi/6f787L4TrhngYBjGz6VUoHO8bUt7u//q0z1kKL3VGb
	 Yh9zvv/dc4DLA==
Date: Sat, 14 Dec 2024 10:26:44 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v6.13-rc2
Message-ID: <Z11PVKcR4-rJhQZD@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eZGzT04Sj4+mxdaD"
Content-Disposition: inline


--eZGzT04Sj4+mxdaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v6.13-rc2

for you to fetch changes up to dda2b8c3c6ccc50deae65cc75f246577348e2ec5:

  iommu/vt-d: Avoid draining PRQ in sva mm release path (2024-12-13 15:54:27 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v6.13-rc2

Including:

	- Per-domain device-list locking fixes for the AMD IOMMU
	  driver.

	- Fix incorrect use of smp_processor_id() in the NVidia-specific part
	  of the ARM-SMMU-v3 driver.

	- Intel IOMMU driver fixes:
	  - Remove cache tags before disabling ATS.
	  - Avoid draining PRQ in sva mm release path.
	  - Fix qi_batch NULL pointer with nested parent domain.

----------------------------------------------------------------
Jason Gunthorpe (2):
      iommu/amd: Put list_add/del(dev_data) back under the domain->lock
      iommu/amd: Add lockdep asserts for domain->dev_list

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into fixes

Lu Baolu (2):
      iommu/vt-d: Remove cache tags before disabling ATS
      iommu/vt-d: Avoid draining PRQ in sva mm release path

Luis Claudio R. Goncalves (1):
      iommu/tegra241-cmdqv: do not use smp_processor_id in preemptible context

Yi Liu (1):
      iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain

 drivers/iommu/amd/iommu.c                      | 10 +++++++-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |  2 +-
 drivers/iommu/intel/cache.c                    | 34 ++++++++++++++++++++------
 drivers/iommu/intel/iommu.c                    |  4 ++-
 drivers/iommu/intel/pasid.c                    |  3 ++-
 5 files changed, 42 insertions(+), 11 deletions(-)

Please pull.

Thanks,

	Joerg

--eZGzT04Sj4+mxdaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmddT1QACgkQK/BELZcB
GuNcxg/+KD2dQaNPMe55V2BOLbhvxhuTS6n5UhavvkKEcwkxVbSjva8Jj+ry01T5
1G/fJlT5/0OSrNkI5SvqTj47nIDflHCRvdYMfGPnyU8SyGBiF037DEUv7r6zaM4m
dl1QTm/3hwGJ/HoECWpb72WYm0ZtfO92SZ9Z8P6b0bLSS0QlgJFLP+AEP800rUbn
EB/jhkLC6sdLhcyeGVoVrefaVlUSa0Nt//sk0nUxDzSAzbgrJNDtAL5gfylLD+wu
LhC4i9Pwr+gmPo5ILT/i0Oacg34aj3Lq+YSndab5gg4F/Yh40RyZp2KTOpyw1QUP
l2YN0C4nUAHxR04ZlPOVSfzK4+4usQ6Xr37RFMtB5F6q/2jF7Abmyaoh8V0pBnJ8
mE420HBLm6zu/6IgnV2j6gS8bowL56gaAzWKcTGH2pHHO4NegROmkZaNdhgRNuL0
9IgJXmLDtZK0qDyS2ig2aXJsGKuzK6N3+BRJRFyXyKG+SUJXfXO2HPKgcxXxqrlA
pg9w7sv9/1XqNbuS/NMhvjdfVDC578fZjWJOPT/ztdOu3QbdInLirlrB1Qxh1DP1
Cbm97owcspXS0CP3muRFFz++TyLslPUaAIml8m3Kf0j0Pr/RnbxW5n7r5QOUBG5f
wYoCXC0ZW/gRwqsCZTZG0ny0HmLeuwIPa0t0QswcycmYVi07wI4=
=HDwi
-----END PGP SIGNATURE-----

--eZGzT04Sj4+mxdaD--
