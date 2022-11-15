Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B82BA40
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E1C91570;
	Tue, 15 Nov 2022 07:27:03 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4394F3F587;
	Tue, 15 Nov 2022 07:26:56 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 8/9] iommu/io-pgtable-arm-v7s: Remove map/unmap
Date: Tue, 15 Nov 2022 15:26:42 +0000
Message-Id: <98481dd7e3576b74149ce2de8f217338ee1dd490.1668100209.git.robin.murphy@arm.com>
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
 drivers/iommu/io-pgtable-arm-v7s.c | 41 +++++++++++-------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index ba3115fd0f86..75f244a3e12d 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -564,8 +564,7 @@ static int arm_v7s_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 
 		iova += pgsize;
 		paddr += pgsize;
-		if (mapped)
-			*mapped += pgsize;
+		*mapped += pgsize;
 	}
 	/*
 	 * Synchronise all PTE updates for the new mapping before there's
@@ -576,12 +575,6 @@ static int arm_v7s_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return ret;
 }
 
-static int arm_v7s_map(struct io_pgtable_ops *ops, unsigned long iova,
-		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
-{
-	return arm_v7s_map_pages(ops, iova, paddr, size, 1, prot, gfp, NULL);
-}
-
 static void arm_v7s_free_pgtable(struct io_pgtable *iop)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_to_data(iop);
@@ -764,12 +757,6 @@ static size_t arm_v7s_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova
 	return unmapped;
 }
 
-static size_t arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
-			    size_t size, struct iommu_iotlb_gather *gather)
-{
-	return arm_v7s_unmap_pages(ops, iova, size, 1, gather);
-}
-
 static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
 					unsigned long iova)
 {
@@ -842,9 +829,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 		goto out_free_data;
 
 	data->iop.ops = (struct io_pgtable_ops) {
-		.map		= arm_v7s_map,
 		.map_pages	= arm_v7s_map_pages,
-		.unmap		= arm_v7s_unmap,
 		.unmap_pages	= arm_v7s_unmap_pages,
 		.iova_to_phys	= arm_v7s_iova_to_phys,
 	};
@@ -954,6 +939,7 @@ static int __init arm_v7s_do_selftests(void)
 	};
 	unsigned int iova, size, iova_start;
 	unsigned int i, loopnr = 0;
+	size_t mapped;
 
 	selftest_running = true;
 
@@ -984,15 +970,16 @@ static int __init arm_v7s_do_selftests(void)
 	iova = 0;
 	for_each_set_bit(i, &cfg.pgsize_bitmap, BITS_PER_LONG) {
 		size = 1UL << i;
-		if (ops->map(ops, iova, iova, size, IOMMU_READ |
-						    IOMMU_WRITE |
-						    IOMMU_NOEXEC |
-						    IOMMU_CACHE, GFP_KERNEL))
+		if (ops->map_pages(ops, iova, iova, size, 1,
+				   IOMMU_READ | IOMMU_WRITE |
+				   IOMMU_NOEXEC | IOMMU_CACHE,
+				   GFP_KERNEL, &mapped))
 			return __FAIL(ops);
 
 		/* Overlapping mappings */
-		if (!ops->map(ops, iova, iova + size, size,
-			      IOMMU_READ | IOMMU_NOEXEC, GFP_KERNEL))
+		if (!ops->map_pages(ops, iova, iova + size, size, 1,
+				    IOMMU_READ | IOMMU_NOEXEC, GFP_KERNEL,
+				    &mapped))
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
@@ -1007,11 +994,12 @@ static int __init arm_v7s_do_selftests(void)
 	size = 1UL << __ffs(cfg.pgsize_bitmap);
 	while (i < loopnr) {
 		iova_start = i * SZ_16M;
-		if (ops->unmap(ops, iova_start + size, size, NULL) != size)
+		if (ops->unmap_pages(ops, iova_start + size, size, 1, NULL) != size)
 			return __FAIL(ops);
 
 		/* Remap of partial unmap */
-		if (ops->map(ops, iova_start + size, size, size, IOMMU_READ, GFP_KERNEL))
+		if (ops->map_pages(ops, iova_start + size, size, size, 1,
+				   IOMMU_READ, GFP_KERNEL, &mapped))
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova_start + size + 42)
@@ -1025,14 +1013,15 @@ static int __init arm_v7s_do_selftests(void)
 	for_each_set_bit(i, &cfg.pgsize_bitmap, BITS_PER_LONG) {
 		size = 1UL << i;
 
-		if (ops->unmap(ops, iova, size, NULL) != size)
+		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42))
 			return __FAIL(ops);
 
 		/* Remap full block */
-		if (ops->map(ops, iova, iova, size, IOMMU_WRITE, GFP_KERNEL))
+		if (ops->map_pages(ops, iova, iova, size, 1, IOMMU_WRITE,
+				   GFP_KERNEL, &mapped))
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-- 
2.36.1.dirty

