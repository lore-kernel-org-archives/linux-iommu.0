Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979943;
	b=j7I3PuGeAJe9uh9KlfqQ1vLJ7AIo2+05dNQ36R59z1Axu+nMuxG3nWbbzaNkPfp2nOmf
	 Utk/Icvl3XbHxfh+MmJAO224UrvH5T1k9zQo1cQgbfeDovbuirJWo23Vwn9E2c2CRtdDR
	 obJ0cvZHYwWquOKqe25hewr2Ae0EyL3bwdP4R4PWlQCTWtTqmKDVbb0Bs2VTp8852HafM
	 s3UhjpVgsQDjZB1E1NwkDuf5vFXwkFITlXw1uO+PV0tc8Lv4+KEPz6WASsSEdouw01XzW
	 DR6hfAjH30CBpGH+e3R11sjTIHPod5GUmDiY2wkVl2PNQnjdqqTHrvFEJYJkCfQQkfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979943;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=f1Vggd/CSfV+sAUe31A7z9uDKw+GeX3Dxz7Go8iocug=;
	b=UVG4fOYCA2BXgBbniXnEPCOCs7y73atGzafnRJQke5Z5YEBF32D9v9X/Ly/+SY6zGt68
	 MIjkQhXbWhZh/Sw0p4C4lMRVx4wLzKZaKdFoo9mwLDyb5YNkQWj492ZHtXZyxiB3LD+kW
	 o7FtNSVCK3Qdaj3AMyiBSbvtk35hOokkl8Pl6GVCaQ+QUdgAKhZXrWNjlqVt63C5lCUGL
	 pj/+fRXhnOlARFcfUKJGNIGqOPQndXYyp0e0KQ3QJAUkGmAOizlt5MzVjtHxl305lTvUk
	 LvcLvz+JPdfQWyglGOktOlIsWN13GOZoQREOL6WghOjqfEgEWOeVxk6rTH9oXb8Kesw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958D606A32F
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 15:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3958D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00c8b813848b737b26.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:c8b8:1384:8b73:7b26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A59682436CE;
	Fri,  6 Nov 2026 16:45:34 +0100 (CET)
Date: Fri, 6 Nov 2026 16:45:33 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Fixes for Linux v7.4-rc1
Message-ID: <au32DJVMbP6j5_gq@8bytes.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-fixes-v7.4-rc1

for you to fetch changes up to 2cf4be57b301ed2d7af82e70cff5dfd96894d8de:

  iommu/amd: Fix NULL pointer dereference for GPUs without upstream bridge (2026-11-06 13:22:44 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v7.4-rc1

Including:

  - AMD IOMMU:
    - Move PerfOpt management into the IOMMU domain attachment paths, enabling
      it automatically for supported integrated GPUs in identity mode and
      clearing it before switching to translated or blocked domains.

    - Fix a boot panic in the GPU identity-mapping quirk when a GPU has no
      upstream PCI bridge.

    - Clear the IOMMU SNP enable flag when RMP table initialization fails,
      preventing subsequent initialization from assuming SNP setup succeeded.

    - Check IVRS subtable types before parsing memory definitions, avoiding
      bogus PCI segments caused by misinterpreting IVHD entries under QEMU.

    - Remove an obsolete warning on device release that incorrectly fires for
      devices required to remain attached to an identity domain.

----------------------------------------------------------------
Akshay Jindal (1):
      iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions

Dheeraj Kumar Srivastava (1):
      iommu/amd: Clear amd_iommu_snp_en if snp_rmptable_init() fails

Jean-Christophe Guillain (1):
      iommu/amd: Fix NULL pointer dereference for GPUs without upstream bridge

Kevin Mitchell (1):
      iommu/amd: remove obsolete domain pointer warning on release

Mario Limonciello (AMD) (1):
      iommu/amd: Enable PerfOpt automatically for integrated GPUs

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
 drivers/iommu/amd/amd_iommu.h              |   3 +-
 drivers/iommu/amd/amd_iommu_types.h        |   6 +-
 drivers/iommu/amd/init.c                   | 106 ++++++-----
 drivers/iommu/amd/iommu.c                  | 273 +++++------------------------
 include/linux/amd-iommu.h                  |  11 --
 8 files changed, 115 insertions(+), 347 deletions(-)

Please pull.

Thanks,

	Joerg
