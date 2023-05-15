Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B08BF6
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 12:49:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 387E42F4;
	Mon, 15 May 2023 05:50:22 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3669E3F67D;
	Mon, 15 May 2023 05:49:36 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	will@kernel.org,
	jgg@nvidia.com,
	digetx@gmail.com,
	thierry.reding@gmail.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH 0/4] iommu: tegra-gart cleanups
Date: Mon, 15 May 2023 13:49:28 +0100
Message-Id: <cover.1684154219.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

For the sake of discussion, here's my irrational pet project to bring
the tegra-gart driver right up to date as an example of a
properly-implemented IOMMU driver for a non-isolated address space. Part
of that irrationality is that I don't even own any hardware which uses
this driver, so it's only build-tested :)

Thanks,
Robin.


Robin Murphy (4):
  iommu/tegra-gart: Add default identity domain support
  iommu/tegra-gart: Improve domain support
  iommu/tegra-gart: Generalise domain support
  iommu: Clean up force_aperture confusion

 drivers/iommu/dma-iommu.c    |  19 ++--
 drivers/iommu/mtk_iommu_v1.c |   4 +
 drivers/iommu/sprd-iommu.c   |   1 +
 drivers/iommu/tegra-gart.c   | 162 +++++++++++++++++++----------------
 4 files changed, 99 insertions(+), 87 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

