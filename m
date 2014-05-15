From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2 04/10] iommu/ipmmu-vmsa: Define driver-specific page
	directory sizes
Date: Thu, 15 May 2014 12:40:45 +0200
Message-ID: <1400150451-13469-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The PTRS_PER_(PUD|PGD|PMD|PTE) macros evaluate to different values
depending on whether LPAE is enabled. The IPMMU driver uses a long
descriptor format regardless of LPAE, making those macros mismatch the
IPMMU configuration on non-LPAE systems.

Replace the macros by driver-specific versions that always evaluate to
the right value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 313b5b9..b34a4b7b 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -209,6 +209,11 @@ static LIST_HEAD(ipmmu_devices);
 #define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
 #define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
 
+#define IPMMU_PTRS_PER_PTE		512
+#define IPMMU_PTRS_PER_PMD		512
+#define IPMMU_PTRS_PER_PGD		4
+#define IPMMU_PTRS_PER_PUD		1
+
 /* -----------------------------------------------------------------------------
  * Read/Write Access
  */
@@ -327,7 +332,7 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 
 	/* TTBR0 */
 	ipmmu_flush_pgtable(domain->mmu, domain->pgd,
-			    PTRS_PER_PGD * sizeof(*domain->pgd));
+			    IPMMU_PTRS_PER_PGD * sizeof(*domain->pgd));
 	ttbr = __pa(domain->pgd);
 	ipmmu_ctx_write(domain, IMTTLBR0, ttbr);
 	ipmmu_ctx_write(domain, IMTTUBR0, ttbr >> 32);
@@ -469,7 +474,7 @@ static void ipmmu_free_pmds(pud_t *pud)
 	unsigned int i;
 
 	pmd = pmd_base;
-	for (i = 0; i < PTRS_PER_PMD; ++i) {
+	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
 		if (pmd_none(*pmd))
 			continue;
 
@@ -486,7 +491,7 @@ static void ipmmu_free_puds(pgd_t *pgd)
 	unsigned int i;
 
 	pud = pud_base;
-	for (i = 0; i < PTRS_PER_PUD; ++i) {
+	for (i = 0; i < IPMMU_PTRS_PER_PUD; ++i) {
 		if (pud_none(*pud))
 			continue;
 
@@ -509,7 +514,7 @@ static void ipmmu_free_pgtables(struct ipmmu_vmsa_domain *domain)
 	 * tables.
 	 */
 	pgd = pgd_base;
-	for (i = 0; i < PTRS_PER_PGD; ++i) {
+	for (i = 0; i < IPMMU_PTRS_PER_PGD; ++i) {
 		if (pgd_none(*pgd))
 			continue;
 		ipmmu_free_puds(pgd);
@@ -694,7 +699,7 @@ static int ipmmu_domain_init(struct iommu_domain *io_domain)
 
 	spin_lock_init(&domain->lock);
 
-	domain->pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
+	domain->pgd = kzalloc(IPMMU_PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
 	if (!domain->pgd) {
 		kfree(domain);
 		return -ENOMEM;
-- 
1.8.5.5
