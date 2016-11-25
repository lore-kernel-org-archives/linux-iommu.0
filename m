From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 03/12] iommu/amd: Define bit fields for DTE particularly
Date: Fri, 25 Nov 2016 13:13:10 +0800
Message-ID: <1480050799-1237-4-git-send-email-bhe@redhat.com>
References: <1480050799-1237-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1480050799-1237-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In amd-vi spec several bits of IO PTE fields and DTE fields are similar
so that both of them can share the same MACRO definition. However
defining their respecitve bit fields can make code more read-able. So
do it in this patch.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |  8 ++++----
 drivers/iommu/amd_iommu_types.h | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 754595e..0b0e50e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1476,9 +1476,9 @@ static int iommu_map_page(struct protection_domain *dom,
 
 	if (count > 1) {
 		__pte = PAGE_SIZE_PTE(phys_addr, page_size);
-		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_P | IOMMU_PTE_FC;
+		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 	} else
-		__pte = phys_addr | IOMMU_PTE_P | IOMMU_PTE_FC;
+		__pte = phys_addr | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 	if (prot & IOMMU_PROT_IR)
 		__pte |= IOMMU_PTE_IR;
@@ -1805,7 +1805,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 
 	pte_root |= (domain->mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
-	pte_root |= IOMMU_PTE_IR | IOMMU_PTE_IW | IOMMU_PTE_P | IOMMU_PTE_TV;
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
 	flags = amd_iommu_dev_table[devid].data[1];
 
@@ -1848,7 +1848,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = IOMMU_PTE_P | IOMMU_PTE_TV;
+	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
 	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 2bbc19d..6a4378f 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -265,7 +265,7 @@
 #define PM_LEVEL_INDEX(x, a)	(((a) >> PM_LEVEL_SHIFT((x))) & 0x1ffULL)
 #define PM_LEVEL_ENC(x)		(((x) << 9) & 0xe00ULL)
 #define PM_LEVEL_PDE(x, a)	((a) | PM_LEVEL_ENC((x)) | \
-				 IOMMU_PTE_P | IOMMU_PTE_IR | IOMMU_PTE_IW)
+				 IOMMU_PTE_PR | IOMMU_PTE_IR | IOMMU_PTE_IW)
 #define PM_PTE_LEVEL(pte)	(((pte) >> 9) & 0x7ULL)
 
 #define PM_MAP_4k		0
@@ -314,13 +314,23 @@
 #define PTE_LEVEL_PAGE_SIZE(level)			\
 	(1ULL << (12 + (9 * (level))))
 
-#define IOMMU_PTE_P  (1ULL << 0)
-#define IOMMU_PTE_TV (1ULL << 1)
+/*
+ * Bit value definition for I/O PTE fields
+ */
+#define IOMMU_PTE_PR (1ULL << 0)
 #define IOMMU_PTE_U  (1ULL << 59)
 #define IOMMU_PTE_FC (1ULL << 60)
 #define IOMMU_PTE_IR (1ULL << 61)
 #define IOMMU_PTE_IW (1ULL << 62)
 
+/*
+ * Bit value definition for DTE fields
+ */
+#define DTE_FLAG_V  (1ULL << 0)
+#define DTE_FLAG_TV (1ULL << 1)
+#define DTE_FLAG_IR (1ULL << 61)
+#define DTE_FLAG_IW (1ULL << 62)
+
 #define DTE_FLAG_IOTLB	(1ULL << 32)
 #define DTE_FLAG_GV	(1ULL << 55)
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
@@ -342,7 +352,7 @@
 #define GCR3_VALID		0x01ULL
 
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
-#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_P)
+#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
 #define IOMMU_PTE_PAGE(pte) (phys_to_virt((pte) & IOMMU_PAGE_MASK))
 #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
 
-- 
2.5.5
