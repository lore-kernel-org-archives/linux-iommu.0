From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 3/3] iommu/arm-smmu: add support for unmap a memory range with only one tlb sync
Date: Tue, 12 Sep 2017 21:00:38 +0800
Message-ID: <1505221238-9428-4-git-send-email-thunder.leizhen@huawei.com>
References: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>, Jinyue Li <lijinyue@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: iommu@lists.linux-foundation.org

This patch is base on: 
(add02cfdc9bc2 "iommu: Introduce Interface for IOMMU TLB Flushing")

Because iotlb_sync is moved out of ".unmap = arm_smmu_unmap", some interval
".unmap" calls should explicitly followed by a iotlb_sync operation.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu.c           | 10 ++++++++++
 drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3bdb799..bb57d67 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1259,6 +1259,15 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ops->unmap(ops, iova, size);
 }
 
+static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+
+	if (ops && ops->iotlb_sync)
+		ops->iotlb_sync(ops);
+}
+
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 					      dma_addr_t iova)
 {
@@ -1561,6 +1570,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
+	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.map_sg			= default_iommu_map_sg,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index d665d0d..457ad29 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -370,6 +370,8 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 
 	for (i = 0; i < num_entries; i++)
 		if (ARM_V7S_PTE_IS_TABLE(ptep[i], lvl)) {
+			size_t unmapped;
+
 			/*
 			 * We need to unmap and free the old table before
 			 * overwriting it with a block entry.
@@ -378,8 +380,10 @@ static int arm_v7s_init_pte(struct arm_v7s_io_pgtable *data,
 			size_t sz = ARM_V7S_BLOCK_SIZE(lvl);
 
 			tblp = ptep - ARM_V7S_LVL_IDX(iova, lvl);
-			if (WARN_ON(__arm_v7s_unmap(data, iova + i * sz,
-						    sz, lvl, tblp) != sz))
+			unmapped = __arm_v7s_unmap(data, iova + i * sz,
+						    sz, lvl, tblp);
+			io_pgtable_tlb_sync(&data->iop);
+			if (WARN_ON(unmapped != sz))
 				return -EINVAL;
 		} else if (ptep[i]) {
 			/* We require an unmap first */
@@ -633,7 +637,6 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 				/* Also flush any partial walks */
 				io_pgtable_tlb_add_flush(iop, iova, blk_size,
 					ARM_V7S_BLOCK_SIZE(lvl + 1), false);
-				io_pgtable_tlb_sync(iop);
 				ptep = iopte_deref(pte[i], lvl);
 				__arm_v7s_free_table(ptep, lvl + 1, data);
 			} else {
@@ -660,16 +663,18 @@ static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 			 size_t size)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	size_t unmapped;
 
 	if (WARN_ON(upper_32_bits(iova)))
 		return 0;
 
-	unmapped = __arm_v7s_unmap(data, iova, size, 1, data->pgd);
-	if (unmapped)
-		io_pgtable_tlb_sync(&data->iop);
+	return __arm_v7s_unmap(data, iova, size, 1, data->pgd);
+}
+
+static void arm_v7s_iotlb_sync(struct io_pgtable_ops *ops)
+{
+	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
 
-	return unmapped;
+	io_pgtable_tlb_sync(&data->iop);
 }
 
 static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
@@ -734,6 +739,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_v7s_map,
 		.unmap		= arm_v7s_unmap,
+		.iotlb_sync	= arm_v7s_iotlb_sync,
 		.iova_to_phys	= arm_v7s_iova_to_phys,
 	};
 
@@ -832,7 +838,7 @@ static int __init arm_v7s_do_selftests(void)
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA,
 		.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	};
-	unsigned int iova, size, iova_start;
+	unsigned int iova, size, unmapped, iova_start;
 	unsigned int i, loopnr = 0;
 
 	selftest_running = true;
@@ -887,7 +893,9 @@ static int __init arm_v7s_do_selftests(void)
 	size = 1UL << __ffs(cfg.pgsize_bitmap);
 	while (i < loopnr) {
 		iova_start = i * SZ_16M;
-		if (ops->unmap(ops, iova_start + size, size) != size)
+		unmapped = ops->unmap(ops, iova_start + size, size);
+		ops->iotlb_sync(ops);
+		if (unmapped != size)
 			return __FAIL(ops);
 
 		/* Remap of partial unmap */
@@ -906,7 +914,9 @@ static int __init arm_v7s_do_selftests(void)
 	while (i != BITS_PER_LONG) {
 		size = 1UL << i;
 
-		if (ops->unmap(ops, iova, size) != size)
+		unmapped = ops->unmap(ops, iova, size);
+		ops->iotlb_sync(ops);
+		if (unmapped != size)
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42))
-- 
2.5.0
