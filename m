From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 02/10] iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page table
Date: Mon, 15 Dec 2014 02:13:41 +0200
Message-ID: <1418602429-11276-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

When clearing PUD or PMD entries the child page table (if any) is freed
and the PUD or PMD entry is then cleared. This result in a small race
condition window during which a free page table could be accessed by the
IPMMU.

Fix it by clearing and flushing the PUD or PMD entry before freeing the
child page table.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index f7036adb5634..fcb603d8b041 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -678,30 +678,33 @@ done:
 
 static void ipmmu_clear_pud(struct ipmmu_vmsa_device *mmu, pud_t *pud)
 {
-	/* Free the page table. */
 	pgtable_t table = pud_pgtable(*pud);
-	__free_page(table);
 
 	/* Clear the PUD. */
 	*pud = __pud(0);
 	ipmmu_flush_pgtable(mmu, pud, sizeof(*pud));
+
+	/* Free the page table. */
+	__free_page(table);
 }
 
 static void ipmmu_clear_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
 			    pmd_t *pmd)
 {
+	pmd_t pmdval = *pmd;
 	unsigned int i;
 
-	/* Free the page table. */
-	if (pmd_table(*pmd)) {
-		pgtable_t table = pmd_pgtable(*pmd);
-		__free_page(table);
-	}
-
 	/* Clear the PMD. */
 	*pmd = __pmd(0);
 	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
 
+	/* Free the page table. */
+	if (pmd_table(pmdval)) {
+		pgtable_t table = pmd_pgtable(pmdval);
+
+		__free_page(table);
+	}
+
 	/* Check whether the PUD is still needed. */
 	pmd = pmd_offset(pud, 0);
 	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
-- 
2.0.4

