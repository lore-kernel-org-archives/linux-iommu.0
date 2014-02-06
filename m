From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/5] iommu/arm-smmu: fix table flushing during initial
	allocations
Date: Thu,  6 Feb 2014 18:09:31 +0000
Message-ID: <1391710173-4343-4-git-send-email-will.deacon@arm.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391710173-4343-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we populate page tables as we traverse them ("iommu/arm-smmu:
fix pud/pmd entry fill sequence"), we need to ensure that we flush out
our zeroed tables after initial allocation, to prevent speculative TLB
fills using bogus data.

This patch adds additional calls to arm_smmu_flush_pgtable during
initial table allocation, and moves the dsb required by coherent table
walkers into the helper.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 51 +++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6eb54ae97470..509f01f054d9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -79,7 +79,6 @@
 
 #define ARM_SMMU_PTE_CONT_SIZE		(PAGE_SIZE * ARM_SMMU_PTE_CONT_ENTRIES)
 #define ARM_SMMU_PTE_CONT_MASK		(~(ARM_SMMU_PTE_CONT_SIZE - 1))
-#define ARM_SMMU_PTE_HWTABLE_SIZE	(PTRS_PER_PTE * sizeof(pte_t))
 
 /* Stage-1 PTE */
 #define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
@@ -632,6 +631,28 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
+				   size_t size)
+{
+	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
+
+
+	/* Ensure new page tables are visible to the hardware walker */
+	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
+		dsb();
+	} else {
+		/*
+		 * If the SMMU can't walk tables in the CPU caches, treat them
+		 * like non-coherent DMA since we need to flush the new entries
+		 * all the way out to memory. There's no possibility of
+		 * recursion here as the SMMU table walker will not be wired
+		 * through another SMMU.
+		 */
+		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
+				DMA_TO_DEVICE);
+	}
+}
+
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 {
 	u32 reg;
@@ -715,6 +736,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	}
 
 	/* TTBR0 */
+	arm_smmu_flush_pgtable(smmu, root_cfg->pgd,
+			       PTRS_PER_PGD * sizeof(pgd_t));
 	reg = __pa(root_cfg->pgd);
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
 	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
@@ -1177,23 +1200,6 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 		arm_smmu_domain_remove_master(smmu_domain, master);
 }
 
-static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
-				   size_t size)
-{
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
-
-	/*
-	 * If the SMMU can't walk tables in the CPU caches, treat them
-	 * like non-coherent DMA since we need to flush the new entries
-	 * all the way out to memory. There's no possibility of recursion
-	 * here as the SMMU table walker will not be wired through another
-	 * SMMU.
-	 */
-	if (!(smmu->features & ARM_SMMU_FEAT_COHERENT_WALK))
-		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
-			     DMA_TO_DEVICE);
-}
-
 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
 					     unsigned long end)
 {
@@ -1214,8 +1220,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 		if (!table)
 			return -ENOMEM;
 
-		arm_smmu_flush_pgtable(smmu, page_address(table),
-				       ARM_SMMU_PTE_HWTABLE_SIZE);
+		arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
 		if (!pgtable_page_ctor(table)) {
 			__free_page(table);
 			return -ENOMEM;
@@ -1321,6 +1326,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 		if (!pmd)
 			return -ENOMEM;
 
+		arm_smmu_flush_pgtable(smmu, pmd, PAGE_SIZE);
 		pud_populate(NULL, pud, pmd);
 		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
 
@@ -1353,6 +1359,7 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 		if (!pud)
 			return -ENOMEM;
 
+		arm_smmu_flush_pgtable(smmu, pud, PAGE_SIZE);
 		pgd_populate(NULL, pgd, pud);
 		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
 
@@ -1421,10 +1428,6 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 out_unlock:
 	spin_unlock(&smmu_domain->lock);
 
-	/* Ensure new page tables are visible to the hardware walker */
-	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
-		dsb();
-
 	return ret;
 }
 
-- 
1.8.2.2
