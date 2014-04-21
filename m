From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 3/9] iommu/ipmmu-vmsa: Define driver-specific page directory sizes
Date: Mon, 21 Apr 2014 16:13:03 +0200
Message-ID: <1398089589-9181-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

The PTRS_PER_(PGD|PMD|PTE) macros evaluate to different values depending
on whether LPAE is enabled. The IPMMU driver uses a long descriptor
format regardless of LPAE, making those macros mismatch the IPMMU
configuration on non-LPAE systems.

Replace the macros by driver-specific versions that always evaluate to
the right value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1ae97d8..7c8c21e 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -210,6 +210,10 @@ static LIST_HEAD(ipmmu_devices);
 #define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
 #define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
 
+#define IPMMU_PTRS_PER_PTE		512
+#define IPMMU_PTRS_PER_PMD		512
+#define IPMMU_PTRS_PER_PGD		4
+
 /* -----------------------------------------------------------------------------
  * Read/Write Access
  */
@@ -328,7 +332,7 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 
 	/* TTBR0 */
 	ipmmu_flush_pgtable(domain->mmu, domain->pgd,
-			    PTRS_PER_PGD * sizeof(*domain->pgd));
+			    IPMMU_PTRS_PER_PGD * sizeof(*domain->pgd));
 	ttbr = __pa(domain->pgd);
 	ipmmu_ctx_write(domain, IMTTLBR0, ttbr);
 	ipmmu_ctx_write(domain, IMTTUBR0, ttbr >> 32);
@@ -470,7 +474,7 @@ static void ipmmu_free_pmds(pud_t *pud)
 	unsigned int i;
 
 	pmd = pmd_base;
-	for (i = 0; i < PTRS_PER_PMD; ++i) {
+	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
 		if (pmd_none(*pmd))
 			continue;
 
@@ -487,7 +491,7 @@ static void ipmmu_free_puds(pgd_t *pgd)
 	unsigned int i;
 
 	pud = pud_base;
-	for (i = 0; i < PTRS_PER_PUD; ++i) {
+	for (i = 0; i < IPMMU_PTRS_PER_PUD; ++i) {
 		if (pud_none(*pud))
 			continue;
 
@@ -510,7 +514,7 @@ static void ipmmu_free_pgtables(struct ipmmu_vmsa_domain *domain)
 	 * tables.
 	 */
 	pgd = pgd_base;
-	for (i = 0; i < PTRS_PER_PGD; ++i) {
+	for (i = 0; i < IPMMU_PTRS_PER_PGD; ++i) {
 		if (pgd_none(*pgd))
 			continue;
 		ipmmu_free_puds(pgd);
@@ -695,7 +699,7 @@ static int ipmmu_domain_init(struct iommu_domain *io_domain)
 
 	spin_lock_init(&domain->lock);
 
-	domain->pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	domain->pgd = kzalloc(IPMMU_PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
 	if (!domain->pgd) {
 		kfree(domain);
 		return -ENOMEM;
-- 
1.8.3.2

