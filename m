Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D1AD5B
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B64153B;
	Tue, 15 Nov 2022 07:27:02 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BF3D3F587;
	Tue, 15 Nov 2022 07:26:55 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 7/9] iommu/io-pgtable-arm: Remove map/unmap
Date: Tue, 15 Nov 2022 15:26:41 +0000
Message-Id: <162e58e83ed42f78c3fbefe78c9b5410dd1dc412.1668100209.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1668100209.git.robin.murphy@arm.com>
References: <cover.1668100209.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all users now calling {map,unmap}_pages, remove the wrappers.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 42 ++++++++++++----------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0ba817e86346..72dcdd468cf3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -360,7 +360,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		max_entries = ARM_LPAE_PTES_PER_TABLE(data) - map_idx_start;
 		num_entries = min_t(int, pgcount, max_entries);
 		ret = arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
-		if (!ret && mapped)
+		if (!ret)
 			*mapped += num_entries * size;
 
 		return ret;
@@ -496,13 +496,6 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
-static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
-			phys_addr_t paddr, size_t size, int iommu_prot, gfp_t gfp)
-{
-	return arm_lpae_map_pages(ops, iova, paddr, size, 1, iommu_prot, gfp,
-				  NULL);
-}
-
 static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 				    arm_lpae_iopte *ptep)
 {
@@ -682,12 +675,6 @@ static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iov
 				data->start_level, ptep);
 }
 
-static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
-			     size_t size, struct iommu_iotlb_gather *gather)
-{
-	return arm_lpae_unmap_pages(ops, iova, size, 1, gather);
-}
-
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 					 unsigned long iova)
 {
@@ -799,9 +786,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->pgd_bits = va_bits - (data->bits_per_level * (levels - 1));
 
 	data->iop.ops = (struct io_pgtable_ops) {
-		.map		= arm_lpae_map,
 		.map_pages	= arm_lpae_map_pages,
-		.unmap		= arm_lpae_unmap,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 	};
@@ -1176,7 +1161,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 	int i, j;
 	unsigned long iova;
-	size_t size;
+	size_t size, mapped;
 	struct io_pgtable_ops *ops;
 
 	selftest_running = true;
@@ -1209,15 +1194,16 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
 			size = 1UL << j;
 
-			if (ops->map(ops, iova, iova, size, IOMMU_READ |
-							    IOMMU_WRITE |
-							    IOMMU_NOEXEC |
-							    IOMMU_CACHE, GFP_KERNEL))
+			if (ops->map_pages(ops, iova, iova, size, 1,
+					   IOMMU_READ | IOMMU_WRITE |
+					   IOMMU_NOEXEC | IOMMU_CACHE,
+					   GFP_KERNEL, &mapped))
 				return __FAIL(ops, i);
 
 			/* Overlapping mappings */
-			if (!ops->map(ops, iova, iova + size, size,
-				      IOMMU_READ | IOMMU_NOEXEC, GFP_KERNEL))
+			if (!ops->map_pages(ops, iova, iova + size, size, 1,
+					    IOMMU_READ | IOMMU_NOEXEC,
+					    GFP_KERNEL, &mapped))
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
@@ -1228,11 +1214,12 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 		/* Partial unmap */
 		size = 1UL << __ffs(cfg->pgsize_bitmap);
-		if (ops->unmap(ops, SZ_1G + size, size, NULL) != size)
+		if (ops->unmap_pages(ops, SZ_1G + size, size, 1, NULL) != size)
 			return __FAIL(ops, i);
 
 		/* Remap of partial unmap */
-		if (ops->map(ops, SZ_1G + size, size, size, IOMMU_READ, GFP_KERNEL))
+		if (ops->map_pages(ops, SZ_1G + size, size, size, 1,
+				   IOMMU_READ, GFP_KERNEL, &mapped))
 			return __FAIL(ops, i);
 
 		if (ops->iova_to_phys(ops, SZ_1G + size + 42) != (size + 42))
@@ -1243,14 +1230,15 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		for_each_set_bit(j, &cfg->pgsize_bitmap, BITS_PER_LONG) {
 			size = 1UL << j;
 
-			if (ops->unmap(ops, iova, size, NULL) != size)
+			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
 				return __FAIL(ops, i);
 
 			/* Remap full block */
-			if (ops->map(ops, iova, iova, size, IOMMU_WRITE, GFP_KERNEL))
+			if (ops->map_pages(ops, iova, iova, size, 1,
+					   IOMMU_WRITE, GFP_KERNEL, &mapped))
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-- 
2.36.1.dirty

