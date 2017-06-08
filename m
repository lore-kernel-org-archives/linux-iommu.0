From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 7/8] iommu/arm-smmu: Remove io-pgtable spinlock
Date: Thu,  8 Jun 2017 12:52:06 +0100
Message-ID: <b4b616f52091d8e870e52e72484d80374aad67b7.1496921366.git.robin.murphy@arm.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1496921366.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, joro@8bytes.org
Cc: salil.mehta@huawei.com, sunil.goutham@cavium.com, iommu@lists.linux-foundation.org, ray.jui@broadcom.com, linux-arm-kernel@lists.infradead.org, linu.cherian@cavium.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

With the io-pgtable code now robust against (valid) races, we no longer
need to serialise all operations with a lock. This might make broken
callers who issue concurrent operations on overlapping addresses go even
more wrong than before, but hey, they already had little hope of useful
or deterministic results.

We do however still have to keep a lock around to serialise the ATS1*
translation ops, as parallel iova_to_phys() calls could lead to
unpredictable hardware behaviour otherwise.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1f42f339a284..b8d069a2b31d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -425,10 +425,10 @@ enum arm_smmu_domain_stage {
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
-	spinlock_t			pgtbl_lock;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
 	struct mutex			init_mutex; /* Protects smmu pointer */
+	spinlock_t			cb_lock; /* Serialises ATS1* ops */
 	struct iommu_domain		domain;
 };
 
@@ -1105,7 +1105,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	}
 
 	mutex_init(&smmu_domain->init_mutex);
-	spin_lock_init(&smmu_domain->pgtbl_lock);
+	spin_lock_init(&smmu_domain->cb_lock);
 
 	return &smmu_domain->domain;
 }
@@ -1383,35 +1383,23 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
-	int ret;
-	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
 	if (!ops)
 		return -ENODEV;
 
-	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
-	ret = ops->map(ops, iova, paddr, size, prot);
-	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
-	return ret;
+	return ops->map(ops, iova, paddr, size, prot);
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			     size_t size)
 {
-	size_t ret;
-	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
 	if (!ops)
 		return 0;
 
-	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
-	ret = ops->unmap(ops, iova, size);
-	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
-	return ret;
+	return ops->unmap(ops, iova, size);
 }
 
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
@@ -1425,10 +1413,11 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	void __iomem *cb_base;
 	u32 tmp;
 	u64 phys;
-	unsigned long va;
+	unsigned long va, flags;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
 	if (smmu->version == ARM_SMMU_V2)
@@ -1438,6 +1427,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
 				      !(tmp & ATSR_ACTIVE), 5, 50)) {
+		spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 		dev_err(dev,
 			"iova to phys timed out on %pad. Falling back to software table walk.\n",
 			&iova);
@@ -1445,6 +1435,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	}
 
 	phys = readq_relaxed(cb_base + ARM_SMMU_CB_PAR);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 	if (phys & CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
 		dev_err(dev, "PAR = 0x%llx\n", phys);
@@ -1457,10 +1448,8 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 					dma_addr_t iova)
 {
-	phys_addr_t ret;
-	unsigned long flags;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return iova;
@@ -1468,17 +1457,11 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	if (!ops)
 		return 0;
 
-	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
 	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_TRANS_OPS &&
-			smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		ret = arm_smmu_iova_to_phys_hard(domain, iova);
-	} else {
-		ret = ops->iova_to_phys(ops, iova);
-	}
+			smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
+		return arm_smmu_iova_to_phys_hard(domain, iova);
 
-	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
-
-	return ret;
+	return ops->iova_to_phys(ops, iova);
 }
 
 static bool arm_smmu_capable(enum iommu_cap cap)
-- 
2.12.2.dirty
