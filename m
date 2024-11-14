Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D4262A3;
	Thu, 14 Nov 2024 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604695; cv=none; b=Pq0Sn/0S1giPG9+G4DrxN7hxdee4gIRJTchPnCstgOE6JrVDpdOFs/Q2aNV2xg7tPrtLRkSlele58EzITYQDlJBDydluZ/uuxL+UI8zY0tWixA438D5Se9wG+O18IqYPjITbcBDqypdo/qIDWhHVZDHQTOHdvpH1B9sE5Qsgjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604695; c=relaxed/simple;
	bh=LEScVdE1MmRWG9RlagdTE4dJgZgN9CYYoi/c43WPRXw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N9bJpeRy9SQRF21fgdJE26I7h0UYuDkgzKNvZ6+L43UM44HXrQNTzaL+lKDbNuL7uHFKzm84mRaiwQNyhZdcsxJqY2QgRI0nY2cWGtPNSOH1xKoyRcW5PKEHI77uDBg4YhiNusSOOXmvXeB41dSG7cxLvX8HM7vFk80drDEQbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu/9dD9T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu/9dD9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B69DC4CECD;
	Thu, 14 Nov 2024 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731604694;
	bh=LEScVdE1MmRWG9RlagdTE4dJgZgN9CYYoi/c43WPRXw=;
	h=Date:From:To:Cc:Subject:From;
	b=iu/9dD9T8apb8rpUwdvWz0nd1RHmoZ70W8mu51pn7loG9dSffXjV54idqmmpXU/Mw
	 b3fzN2suCvLwEHauAKWP80nPgAlHWcY2Dd0lZZbZ/om5M8inY+pOG++/Ul7hcs7fuL
	 L7guv/mr24X4Ke4RMEJ7+FDtxmzKBLJvxLazjedjeeXLdNuWiSFEDo90oxhkqqGeFr
	 sPAFoOJe25aTnGvls8TM1JiMb5B/9MVEwiaOWimsmVEV5sx0uuasTlw2TGEfnYO+N7
	 q69g/qxzRbpb1S2MRkCD5fnYYPJy8hpMU2ToMuZSTxXD8w8q0CcLHSV+QNT2PlpkLN
	 hKKvxEq+SPiNQ==
Date: Thu, 14 Nov 2024 17:18:09 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: [GIT PULL] iommu/arm-smmu: Updates for 6.13
Message-ID: <20241114171808.GA24017@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Joerg,

Please pull these Arm SMMU updates for 6.13.

The summary is in the tag, but the highlight is definitely the removal
of the complicated block-splitting code from the Arm page-table
implementations. It even means that we have a negative diffstat!

As with 6.12, I've already pushed this lot to the arm/smmu branch in
the iommu tree. Please can you merge that into 'next'?

Cheers,

Will

--->8

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

for you to fetch changes up to a3799717b881aa0f4e722afb70e7b8ba84ae4f36:

  iommu/tegra241-cmdqv: Fix alignment failure at max_n_shift (2024-11-12 15:09:42 +0000)

----------------------------------------------------------------
Arm SMMU updates for 6.13

- SMMUv2:
  * Return -EPROBE_DEFER for client devices probing before their SMMU.
  * Devicetree binding updates for Qualcomm MMU-500 implementations.

- SMMUv3:
  * Minor fixes and cleanup for NVIDIA's virtual command queue driver.

- IO-PGTable:
  * Fix indexing of concatenated PGDs and extend selftest coverage.
  * Remove unused block-splitting support.

----------------------------------------------------------------
Dmitry Baryshkov (1):
      dt-bindings: iommu: arm,smmu: Add Qualcomm SAR2130P compatible

Jason Gunthorpe (3):
      iommu/io-pgtable-arm: Remove split on unmap behavior
      iommu/io-pgtable-arm-v7s: Remove split on unmap behavior
      iommu: Add a kdoc to iommu_unmap()

Mostafa Saleh (2):
      iommu/io-pgtable-arm: Fix stage-2 map/unmap for concatenated tables
      iommu/io-pgtable-arm: Add self test for the last page in the IAS

Nicolin Chen (2):
      iommu/tegra241-cmdqv: Staticize cmdqv_debugfs_dir
      iommu/tegra241-cmdqv: Fix alignment failure at max_n_shift

Pratyush Brahma (1):
      iommu/arm-smmu: Defer probe of clients after smmu device bound

Qingqing Zhou (1):
      dt-bindings: arm-smmu: document QCS615 APPS SMMU

Will Deacon (2):
      iommu/tegra241-cmdqv: Fix unused variable warning
      Merge branch 'for-joerg/arm-smmu/bindings' into arm/smmu

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   5 +
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   7 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  11 ++
 drivers/iommu/io-pgtable-arm-v7s.c                 | 149 +--------------------
 drivers/iommu/io-pgtable-arm.c                     | 114 +++++-----------
 drivers/iommu/iommu.c                              |  14 ++
 6 files changed, 74 insertions(+), 226 deletions(-)
