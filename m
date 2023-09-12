Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6333168CB
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:18:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26FD4C15;
	Tue, 12 Sep 2023 09:19:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 914A93F738;
	Tue, 12 Sep 2023 09:18:48 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	m.szyprowski@samsung.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: [PATCH 0/8] iommu: Clean up map/unmap ops
Date: Tue, 12 Sep 2023 17:18:36 +0100
Message-Id: <cover.1694525662.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Time to repay a little more from the technical debt pile and actually
finalise another of our half-finished API evolutions, since it turned
out that by now this was dead simple. So much so in fact that I'm in
two minds whether to squash all the driver patches into one or not, as
they're so very mechanical.

Note that the sun50i patch is just a placeholder to make a consistent
series for now, as I'm anticipating a "proper" implementation from
Jernej.

Thanks,
Robin.


Robin Murphy (8):
  iommu/exynos: Update to {map,unmap}_pages
  iommu/omap: Update to {map,unmap}_pages
  iommu/rockchip: Update to {map,unmap}_pages
  iommu/sun50i: Update to {map,unmap}_pages
  iommu/tegra-gart: Update to {map,unmap}_pages
  iommu/tegra-smmu: Update to {map,unmap}_pages
  iommu: Retire map/unmap ops
  iommu: Improve map/unmap sanity checks

 drivers/iommu/exynos-iommu.c   | 10 +++---
 drivers/iommu/iommu.c          | 66 +++++++++-------------------------
 drivers/iommu/omap-iommu.c     | 11 +++---
 drivers/iommu/rockchip-iommu.c | 11 +++---
 drivers/iommu/sun50i-iommu.c   | 10 +++---
 drivers/iommu/tegra-gart.c     | 12 ++++---
 drivers/iommu/tegra-smmu.c     | 12 ++++---
 include/linux/iommu.h          |  6 ----
 8 files changed, 58 insertions(+), 80 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

