Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108513AC3
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 16:43:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE9302F4;
	Thu,  1 Jun 2023 09:44:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B506A3F663;
	Thu,  1 Jun 2023 09:43:37 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: joro@8bytes.org,
	jean-philippe@linaro.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/arm-smmu-v3: Set TTL invalidation hint better
Date: Thu,  1 Jun 2023 17:43:33 +0100
Message-Id: <b409d9a17c52dc0db51faee91d92737bb7975f5b.1685637456.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When io-pgtable unmaps a whole table, rather than waste time walking it
to find the leaf entries to invalidate exactly, it simply expects
.tlb_flush_walk with nominal last-level granularity to invalidate any
leaf entries at higher intermediate levels as well. This works fine with
page-based invalidation, but with range commands we need to be careful
with the TTL hint - unconditionally setting it based on the given level
3 granule means that an invalidation for a level 1 table would strictly
not be required to affect level 2 block entries. It's easy to comply
with the expected behaviour by simply not setting the TTL hint for
non-leaf invalidations, so let's do that.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3fd83fb75722..4763e68cc1ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1892,8 +1892,13 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
 		cmd->tlbi.tg = (tg - 10) / 2;
 
-		/* Determine what level the granule is at */
-		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
+		/*
+		 * Determine what level the granule is at. For non-leaf, io-pgtable
+		 * assumes .tlb_flush_walk can invalidate multiple levels at once,
+		 * so ignore the nominal last-level granule and leave TTL=0.
+		 */
+		if (cmd->tlbi.leaf)
+			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
 		num_pages = size >> tg;
 	}
-- 
2.39.2.101.g768bb238c484.dirty

