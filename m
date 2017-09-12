From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/3] iommu/arm-smmu-v3: add support for unmap an iova range with only one tlb sync
Date: Tue, 12 Sep 2017 21:00:37 +0800
Message-ID: <1505221238-9428-3-git-send-email-thunder.leizhen@huawei.com>
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
 drivers/iommu/arm-smmu-v3.c    | 10 ++++++++++
 drivers/iommu/io-pgtable-arm.c | 30 ++++++++++++++++++++----------
 drivers/iommu/io-pgtable.h     |  1 +
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ef42c4b..e92828e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1772,6 +1772,15 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
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
 static phys_addr_t
 arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
@@ -1991,6 +2000,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.attach_dev		= arm_smmu_attach_dev,
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
+	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.map_sg			= default_iommu_map_sg,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e8018a3..805efc9 100644
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
 
@@ -584,7 +588,6 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			/* Also flush any partial walks */
 			io_pgtable_tlb_add_flush(iop, iova, size,
 						ARM_LPAE_GRANULE(data), false);
-			io_pgtable_tlb_sync(iop);
 			ptep = iopte_deref(pte, data);
 			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
 		} else {
@@ -609,7 +612,6 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 			  size_t size)
 {
-	size_t unmapped;
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte *ptep = data->pgd;
 	int lvl = ARM_LPAE_START_LVL(data);
@@ -617,11 +619,14 @@ static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
 		return 0;
 
-	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);
-	if (unmapped)
-		io_pgtable_tlb_sync(&data->iop);
+	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
+}
+
+static void arm_lpae_iotlb_sync(struct io_pgtable_ops *ops)
+{
+	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 
-	return unmapped;
+	io_pgtable_tlb_sync(&data->iop);
 }
 
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
@@ -734,6 +739,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map		= arm_lpae_map,
 		.unmap		= arm_lpae_unmap,
+		.iotlb_sync	= arm_lpae_iotlb_sync,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
 	};
 
@@ -1030,7 +1036,7 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 	int i, j;
 	unsigned long iova;
-	size_t size;
+	size_t size, unmapped;
 	struct io_pgtable_ops *ops;
 
 	selftest_running = true;
@@ -1082,7 +1088,9 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 
 		/* Partial unmap */
 		size = 1UL << __ffs(cfg->pgsize_bitmap);
-		if (ops->unmap(ops, SZ_1G + size, size) != size)
+		unmapped = ops->unmap(ops, SZ_1G + size, size);
+		ops->iotlb_sync(ops);
+		if (unmapped != size)
 			return __FAIL(ops, i);
 
 		/* Remap of partial unmap */
@@ -1098,7 +1106,9 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		while (j != BITS_PER_LONG) {
 			size = 1UL << j;
 
-			if (ops->unmap(ops, iova, size) != size)
+			unmapped = ops->unmap(ops, iova, size);
+			ops->iotlb_sync(ops);
+			if (unmapped != size)
 				return __FAIL(ops, i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
index a3e6670..3a72e08 100644
--- a/drivers/iommu/io-pgtable.h
+++ b/drivers/iommu/io-pgtable.h
@@ -120,6 +120,7 @@ struct io_pgtable_ops {
 		   phys_addr_t paddr, size_t size, int prot);
 	int (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 		     size_t size);
+	void (*iotlb_sync)(struct io_pgtable_ops *ops);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
 };
-- 
2.5.0
