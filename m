Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C5AD5B
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A929F13D5;
	Tue, 15 Nov 2022 07:26:54 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D8B33F587;
	Tue, 15 Nov 2022 07:26:47 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 0/9] iommu: {map,unmap}_pages cleanup
Date: Tue, 15 Nov 2022 15:26:34 +0000
Message-Id: <cover.1668100209.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here's a couple more strands of cleanup along a common theme. With the
original pgsize_bitmap trick for multi-page mappings long gone from
Intel and now getting cleaned up from s390 as well, the first two
patches here convert the remaining instances of that to the proper new
multi-page interfaces. The rest then convert the remaining users of the
io-pgtable API, so we can clean up the old interfaces entirely at that
level.

Cheers,
Robin.


Robin Murphy (9):
  iommu/mediatek-v1: Update to {map,unmap}_pages
  iommu/sprd: Update to {map,unmap}_pages
  iommu/mediatek: Update to {map,unmap}_pages
  iommu/msm: Update to {map,unmap}_pages
  iommu/ipmmu-vmsa: Update to {map,unmap}_pages
  iommu/qcom: Update to {map,unmap}_pages
  iommu/io-pgtable-arm: Remove map/unmap
  iommu/io-pgtable-arm-v7s: Remove map/unmap
  iommu/io-pgtable: Remove map/unmap

 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 14 +++++----
 drivers/iommu/io-pgtable-arm-v7s.c      | 41 +++++++++---------------
 drivers/iommu/io-pgtable-arm.c          | 42 +++++++++----------------
 drivers/iommu/ipmmu-vmsa.c              | 18 +++++------
 drivers/iommu/msm_iommu.c               | 18 ++++++-----
 drivers/iommu/mtk_iommu.c               | 15 ++++-----
 drivers/iommu/mtk_iommu_v1.c            | 30 +++++++++---------
 drivers/iommu/sprd-iommu.c              | 25 ++++++++-------
 include/linux/io-pgtable.h              |  6 ----
 9 files changed, 94 insertions(+), 115 deletions(-)

-- 
2.36.1.dirty

