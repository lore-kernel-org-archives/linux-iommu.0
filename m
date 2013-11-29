From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/3] iommu/arm-smmu: use mutex instead of spinlock for locking
	page tables
Date: Fri, 29 Nov 2013 12:14:33 +0000
Message-ID: <1385727275-19082-2-git-send-email-will.deacon@arm.com>
References: <1385727275-19082-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1385727275-19082-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When creating IO mappings, we lazily allocate our page tables using the
standard, non-atomic allocator functions. This presents us with a
problem, since our page tables are protected with a spinlock.

This patch reworks the smmu_domain lock to use a mutex instead of a
spinlock. iova_to_phys is then reworked so that it only reads the page
tables, and can run in a lockless fashion, leaving the mutex to guard
against concurrent mapping threads.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 62 ++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1abfb5684ab7..6dbcaa4433cd 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -392,7 +392,7 @@ struct arm_smmu_domain {
 	struct arm_smmu_cfg		root_cfg;
 	phys_addr_t			output_mask;
 
-	spinlock_t			lock;
+	struct mutex			lock;
 };
 
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
@@ -900,7 +900,7 @@ static int arm_smmu_domain_init(struct iommu_domain *domain)
 		goto out_free_domain;
 	smmu_domain->root_cfg.pgd = pgd;
 
-	spin_lock_init(&smmu_domain->lock);
+	mutex_init(&smmu_domain->lock);
 	domain->priv = smmu_domain;
 	return 0;
 
@@ -1137,7 +1137,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * Sanity check the domain. We don't currently support domains
 	 * that cross between different SMMU chains.
 	 */
-	spin_lock(&smmu_domain->lock);
+	mutex_lock(&smmu_domain->lock);
 	if (!smmu_domain->leaf_smmu) {
 		/* Now that we have a master, we can finalise the domain */
 		ret = arm_smmu_init_domain_context(domain, dev);
@@ -1152,7 +1152,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			dev_name(device_smmu->dev));
 		goto err_unlock;
 	}
-	spin_unlock(&smmu_domain->lock);
+	mutex_unlock(&smmu_domain->lock);
 
 	/* Looks ok, so add the device to the domain */
 	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
@@ -1162,7 +1162,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return arm_smmu_domain_add_master(smmu_domain, master);
 
 err_unlock:
-	spin_unlock(&smmu_domain->lock);
+	mutex_unlock(&smmu_domain->lock);
 	return ret;
 }
 
@@ -1394,7 +1394,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	if (paddr & ~output_mask)
 		return -ERANGE;
 
-	spin_lock(&smmu_domain->lock);
+	mutex_lock(&smmu_domain->lock);
 	pgd += pgd_index(iova);
 	end = iova + size;
 	do {
@@ -1410,7 +1410,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	} while (pgd++, iova != end);
 
 out_unlock:
-	spin_unlock(&smmu_domain->lock);
+	mutex_unlock(&smmu_domain->lock);
 
 	/* Ensure new page tables are visible to the hardware walker */
 	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
@@ -1449,44 +1449,34 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 					 dma_addr_t iova)
 {
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	pgd_t *pgdp, pgd;
+	pud_t pud;
+	pmd_t pmd;
+	pte_t pte;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	struct arm_smmu_device *smmu = root_cfg->smmu;
 
-	spin_lock(&smmu_domain->lock);
-	pgd = root_cfg->pgd;
-	if (!pgd)
-		goto err_unlock;
+	pgdp = root_cfg->pgd;
+	if (!pgdp)
+		return 0;
 
-	pgd += pgd_index(iova);
-	if (pgd_none_or_clear_bad(pgd))
-		goto err_unlock;
+	pgd = *(pgdp + pgd_index(iova));
+	if (pgd_none(pgd))
+		return 0;
 
-	pud = pud_offset(pgd, iova);
-	if (pud_none_or_clear_bad(pud))
-		goto err_unlock;
+	pud = *pud_offset(&pgd, iova);
+	if (pud_none(pud))
+		return 0;
 
-	pmd = pmd_offset(pud, iova);
-	if (pmd_none_or_clear_bad(pmd))
-		goto err_unlock;
+	pmd = *pmd_offset(&pud, iova);
+	if (pmd_none(pmd))
+		return 0;
 
-	pte = pmd_page_vaddr(*pmd) + pte_index(iova);
+	pte = *(pmd_page_vaddr(pmd) + pte_index(iova));
 	if (pte_none(pte))
-		goto err_unlock;
-
-	spin_unlock(&smmu_domain->lock);
-	return __pfn_to_phys(pte_pfn(*pte)) | (iova & ~PAGE_MASK);
+		return 0;
 
-err_unlock:
-	spin_unlock(&smmu_domain->lock);
-	dev_warn(smmu->dev,
-		 "invalid (corrupt?) page tables detected for iova 0x%llx\n",
-		 (unsigned long long)iova);
-	return -EINVAL;
+	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
 }
 
 static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
-- 
1.8.2.2
