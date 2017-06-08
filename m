From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 8/8] iommu/arm-smmu-v3: Remove io-pgtable spinlock
Date: Thu,  8 Jun 2017 12:52:07 +0100
Message-ID: <8e8e747566e6e11dd16ddc7af092d992ef9ee7d5.1496921366.git.robin.murphy@arm.com>
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

As for SMMUv2, take advantage of io-pgtable's newfound tolerance for
concurrency. Unfortunately in this case the command queue lock remains a
point of serialisation for the unmap path, but there may be a little
more we can do to ameliorate that in future.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b9c4cf4ccca2..291da5f918d5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -645,7 +645,6 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
-	spinlock_t			pgtbl_lock;
 
 	enum arm_smmu_domain_stage	stage;
 	union {
@@ -1406,7 +1405,6 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	}
 
 	mutex_init(&smmu_domain->init_mutex);
-	spin_lock_init(&smmu_domain->pgtbl_lock);
 	return &smmu_domain->domain;
 }
 
@@ -1678,44 +1676,29 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int prot)
 {
-	int ret;
-	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
 	if (!ops)
 		return -ENODEV;
 
-	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
-	ret = ops->map(ops, iova, paddr, size, prot);
-	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
-	return ret;
+	return ops->map(ops, iova, paddr, size, prot);
 }
 
 static size_t
 arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
-	size_t ret;
-	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
 	if (!ops)
 		return 0;
 
-	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
-	ret = ops->unmap(ops, iova, size);
-	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
-	return ret;
+	return ops->unmap(ops, iova, size);
 }
 
 static phys_addr_t
 arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
-	phys_addr_t ret;
-	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		return iova;
@@ -1723,11 +1706,7 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	if (!ops)
 		return 0;
 
-	spin_lock_irqsave(&smmu_domain->pgtbl_lock, flags);
-	ret = ops->iova_to_phys(ops, iova);
-	spin_unlock_irqrestore(&smmu_domain->pgtbl_lock, flags);
-
-	return ret;
+	return ops->iova_to_phys(ops, iova);
 }
 
 static struct platform_driver arm_smmu_driver;
-- 
2.12.2.dirty
