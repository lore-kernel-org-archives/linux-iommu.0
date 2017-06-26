From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/5] iommu/arm-smmu: add support for unmap a memory range with
	only one tlb sync
Date: Mon, 26 Jun 2017 21:38:49 +0800
Message-ID: <1498484330-10840-5-git-send-email-thunder.leizhen@huawei.com>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1498484330-10840-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

1. remove tlb_sync operation in "unmap"
2. make sure each "unmap" will always be followed by tlb sync operation

The resultant effect is as below:
	unmap memory page-1
	tlb invalidate page-1
	...
	unmap memory page-n
	tlb invalidate page-n
	tlb sync

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/arm-smmu.c           | 10 ++++++++++
 drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b8d069a..74ca6eb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1402,6 +1402,15 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ops->unmap(ops, iova, size);
 }
 
+static void arm_smmu_unmap_tlb_sync(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+
+	if (ops && ops->unmap_tlb_sync)
+		ops->unmap_tlb_sync(ops);
+}
+
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 					      dma_addr_t iova)
 {
@@ -1698,6 +1707,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
+	.unmap_tlb_sync		= arm_smmu_unmap_tlb_sync,
 	.map_sg			= default_iommu_map_sg,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index a55fd38..325c1c6 100644
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
@@ -626,7 +630,6 @@ static int __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
 				/* Also flush any partial walks */
 				io_pgtable_tlb_add_flush(iop, iova, blk_size,
 					ARM_V7S_BLOCK_SIZE(lvl + 1), false);
-				io_pgtable_tlb_sync(iop);
 				ptep = iopte_deref(pte[i], lvl);
 				__arm_v7s_free_table(ptep, lvl + 1, data);
 			} else {
@@ -653,13 +656,15 @@ static int arm_v7s_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 			 size_t size)
 {
 	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	size_t unmapped;
 
-	unmapped = __arm_v7s_unmap(data, iova, size, 1, data->pgd);
-	if (unmapped)
-		io_pgtable_tlb_sync(&data->iop);
+	return __arm_v7s_unmap(data, iova, size, 1, data->pgd);
+}
+
+static void arm_v7s_unmap_tlb_sync(struct io_pgtable_ops *ops)
+{
+	struct arm_v7s_io_pgtable *data = io_pgtable_ops_to_data(ops);
 
-	return unmapped;
+	io_pgtable_tlb_sync(&data->iop);
 }
 
 static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
@@ -724,6 +729,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_v7s_map,
 		.unmap		= arm_v7s_unmap,
+		.unmap_tlb_sync	= arm_v7s_unmap_tlb_sync,
 		.iova_to_phys	= arm_v7s_iova_to_phys,
 	};
 
@@ -822,7 +828,7 @@ static int __init arm_v7s_do_selftests(void)
 		.quirks = IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA,
 		.pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	};
-	unsigned int iova, size, iova_start;
+	unsigned int iova, size, unmapped, iova_start;
 	unsigned int i, loopnr = 0;
 
 	selftest_running = true;
@@ -877,7 +883,9 @@ static int __init arm_v7s_do_selftests(void)
 	size = 1UL << __ffs(cfg.pgsize_bitmap);
 	while (i < loopnr) {
 		iova_start = i * SZ_16M;
-		if (ops->unmap(ops, iova_start + size, size) != size)
+		unmapped = ops->unmap(ops, iova_start + size, size);
+		ops->unmap_tlb_sync(ops);
+		if (unmapped != size)
 			return __FAIL(ops);
 
 		/* Remap of partial unmap */
@@ -896,7 +904,9 @@ static int __init arm_v7s_do_selftests(void)
 	while (i != BITS_PER_LONG) {
 		size = 1UL << i;
 
-		if (ops->unmap(ops, iova, size) != size)
+		unmapped = ops->unmap(ops, iova, size);
+		ops->unmap_tlb_sync(ops);
+		if (unmapped != size)
 			return __FAIL(ops);
 
 		if (ops->iova_to_phys(ops, iova + 42))
-- 
2.5.0
