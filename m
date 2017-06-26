From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/5] iommu/arm-smmu-v3: add support for unmap an iova range
	with only one tlb sync
Date: Mon, 26 Jun 2017 21:38:48 +0800
Message-ID: <1498484330-10840-4-git-send-email-thunder.leizhen@huawei.com>
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
 drivers/iommu/arm-smmu-v3.c    | 10 ++++++++++
 drivers/iommu/io-pgtable-arm.c | 30 ++++++++++++++++++++----------
 drivers/iommu/io-pgtable.h     |  1 +
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4481123..328b9d7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1724,6 +1724,15 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
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
 static phys_addr_t
 arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
@@ -1943,6 +1952,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
+	.unmap_tlb_sync		= arm_smmu_unmap_tlb_sync,
 	.map_sg			= default_iommu_map_sg,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 52700fa..8137e62 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -304,6 +304,8 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		WARN_ON(!selftest_running);
 		return -EEXIST;
 	} else if (iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_TABLE) {
+		size_t unmapped;
+
 		/*
 		 * We need to unmap and free the old table before
 		 * overwriting it with a block entry.
@@ -312,7 +314,9 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
 
 		tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
-		if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
+		unmapped = __arm_lpae_unmap(data, iova, sz, lvl, tblp);
+		io_pgtable_tlb_sync(&data->iop);
+		if (WARN_ON(unmapped != sz))
 			return -EINVAL;
 	}
 
@@ -576,7 +580,6 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			/* Also flush any partial walks */
 			io_pgtable_tlb_add_flush(iop, iova, size,
 						ARM_LPAE_GRANULE(data), false);
-			io_pgtable_tlb_sync(iop);
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
 		} else {
@@ -601,16 +604,18 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 			  size_t size)
 {
-	size_t unmapped;
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte *ptep = data->pgd;
 	int lvl = ARM_LPAE_START_LVL(data);
 
-	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);
-	if (unmapped)
-		io_pgtable_tlb_sync(&data->iop);
+	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
+}
+
+static void arm_lpae_unmap_tlb_sync(struct io_pgtable_ops *ops)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 
-	return unmapped;
+	io_pgtable_tlb_sync(&data->iop);
 }
 
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
@@ -723,6 +728,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_lpae_map,
 		.unmap		= arm_lpae_unmap,
+		.unmap_tlb_sync	= arm_lpae_unmap_tlb_sync,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 	};
 
@@ -1019,7 +1025,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 	int i, j;
 	unsigned long iova;
-	size_t size;
+	size_t size, unmapped;
 	struct io_pgtable_ops *ops;
 
 	selftest_running = true;
@@ -1071,7 +1077,9 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 		/* Partial unmap */
 		size = 1UL << __ffs(cfg->pgsize_bitmap);
-		if (ops->unmap(ops, SZ_1G + size, size) != size)
+		unmapped = ops->unmap(ops, SZ_1G + size, size);
+		ops->unmap_tlb_sync(ops);
+		if (unmapped != size)
 			return __FAIL(ops, i);
 
 		/* Remap of partial unmap */
@@ -1087,7 +1095,9 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		while (j != BITS_PER_LONG) {
 			size = 1UL << j;
 
-			if (ops->unmap(ops, iova, size) != size)
+			unmapped = ops->unmap(ops, iova, size);
+			ops->unmap_tlb_sync(ops);
+			if (unmapped != size)
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index 524263a..7b3fc04 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -120,6 +120,7 @@ struct io_pgtable_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	int (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 		     size_t size);
+	void (*unmap_tlb_sync)(struct io_pgtable_ops *ops);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
 };
-- 
2.5.0
