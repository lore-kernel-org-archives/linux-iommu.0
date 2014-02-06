From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/5] iommu/arm-smmu: really fix page table locking
Date: Thu,  6 Feb 2014 18:09:30 +0000
Message-ID: <1391710173-4343-3-git-send-email-will.deacon@arm.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Commit a44a9791e778 ("iommu/arm-smmu: use mutex instead of spinlock for
locking page tables") replaced the page table spinlock with a mutex, to
allow blocking allocations to satisfy lazy mapping requests.

Unfortunately, it turns out that IOMMU mappings are created from atomic
context (e.g. spinlock held during a dma_map), so this change doesn't
really help us in practice.

This patch is a partial revert of the offending commit, bringing back
the original spinlock but replacing our page table allocations for any
levels below the pgd (which is allocated during domain init) with
GFP_ATOMIC instead of GFP_KERNEL.

Cc: <stable@vger.kernel.org>
Reported-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9f210de6537e..6eb54ae97470 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -393,7 +393,7 @@ struct arm_smmu_domain {
 	struct arm_smmu_cfg		root_cfg;
 	phys_addr_t			output_mask;
 
-	struct mutex			lock;
+	spinlock_t			lock;
 };
 
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
@@ -901,7 +901,7 @@ static int arm_smmu_domain_init(struct iommu_domain *domain)
 		goto out_free_domain;
 	smmu_domain->root_cfg.pgd = pgd;
 
-	mutex_init(&smmu_domain->lock);
+	spin_lock_init(&smmu_domain->lock);
 	domain->priv = smmu_domain;
 	return 0;
 
@@ -1138,7 +1138,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * Sanity check the domain. We don't currently support domains
 	 * that cross between different SMMU chains.
 	 */
-	mutex_lock(&smmu_domain->lock);
+	spin_lock(&smmu_domain->lock);
 	if (!smmu_domain->leaf_smmu) {
 		/* Now that we have a master, we can finalise the domain */
 		ret = arm_smmu_init_domain_context(domain, dev);
@@ -1153,7 +1153,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			dev_name(device_smmu->dev));
 		goto err_unlock;
 	}
-	mutex_unlock(&smmu_domain->lock);
+	spin_unlock(&smmu_domain->lock);
 
 	/* Looks ok, so add the device to the domain */
 	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
@@ -1163,7 +1163,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return arm_smmu_domain_add_master(smmu_domain, master);
 
 err_unlock:
-	mutex_unlock(&smmu_domain->lock);
+	spin_unlock(&smmu_domain->lock);
 	return ret;
 }
 
@@ -1210,7 +1210,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 
 	if (pmd_none(*pmd)) {
 		/* Allocate a new set of tables */
-		pgtable_t table = alloc_page(PGALLOC_GFP);
+		pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
 		if (!table)
 			return -ENOMEM;
 
@@ -1317,7 +1317,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	if (pud_none(*pud)) {
-		pmd = pmd_alloc_one(NULL, addr);
+		pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
 		if (!pmd)
 			return -ENOMEM;
 
@@ -1349,7 +1349,7 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 
 #ifndef __PAGETABLE_PUD_FOLDED
 	if (pgd_none(*pgd)) {
-		pud = pud_alloc_one(NULL, addr);
+		pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
 		if (!pud)
 			return -ENOMEM;
 
@@ -1403,7 +1403,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	if (paddr & ~output_mask)
 		return -ERANGE;
 
-	mutex_lock(&smmu_domain->lock);
+	spin_lock(&smmu_domain->lock);
 	pgd += pgd_index(iova);
 	end = iova + size;
 	do {
@@ -1419,7 +1419,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	} while (pgd++, iova != end);
 
 out_unlock:
-	mutex_unlock(&smmu_domain->lock);
+	spin_unlock(&smmu_domain->lock);
 
 	/* Ensure new page tables are visible to the hardware walker */
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
-- 
1.8.2.2
