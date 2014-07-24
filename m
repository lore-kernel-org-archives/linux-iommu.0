From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 2/3] iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the
	child page table
Date: Thu, 24 Jul 2014 17:27:04 +0200
Message-ID: <1406215625-13982-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When clearing PUD or PMD entries the child page table (if any) is freed
and the PUD or PMD entry is then cleared. This result in a small race
condition window during which a free page table could be accessed by the
IPMMU.

Fix it by clearing and flushing the PUD or PMD entry before freeing the
child page table.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7dc77a6..eb605e5 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -678,30 +678,32 @@ done:
 
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
+		__free_page(table);
+	}
+
 	/* Check whether the PUD is still needed. */
 	pmd = pmd_offset(pud, 0);
 	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
-- 
1.8.5.5
