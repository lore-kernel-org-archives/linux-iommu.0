From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v4 5/9] iommu/amd: Define bit fields for DTE particularly
Date: Wed, 25 May 2016 14:28:51 +0800
Message-ID: <1464157735-8865-6-git-send-email-bhe@redhat.com>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1464157735-8865-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vincent.wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In amd-vi spec several bits of IO PTE fields and DTE fields are similar
so that both of them can share the same MACRO definition. However
defining their respecitve bit fields can make code more read-able. So
do it in this patch.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 10 +++++-----
 drivers/iommu/amd_iommu_types.h | 19 +++++++++++++++----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index cc636e6..1c916cc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1401,9 +1401,9 @@ static int iommu_map_page(struct protection_domain *dom,
 
 	if (count > 1) {
 		__pte = PAGE_SIZE_PTE(phys_addr, page_size);
-		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_P | IOMMU_PTE_FC;
+		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 	} else
-		__pte = phys_addr | IOMMU_PTE_P | IOMMU_PTE_FC;
+		__pte = phys_addr | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 	if (prot & IOMMU_PROT_IR)
 		__pte |= IOMMU_PTE_IR;
@@ -2048,7 +2048,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 
 	pte_root |= (domain->mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
-	pte_root |= IOMMU_PTE_IR | IOMMU_PTE_IW | IOMMU_PTE_P | IOMMU_PTE_TV;
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
 	flags = amd_iommu_dev_table[devid].data[1];
 
@@ -2091,7 +2091,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
 static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = IOMMU_PTE_P | IOMMU_PTE_TV;
+	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
 	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
@@ -2533,7 +2533,7 @@ static dma_addr_t dma_ops_domain_map(struct dma_ops_domain *dom,
 	if (!pte)
 		return DMA_ERROR_CODE;
 
-	__pte = paddr | IOMMU_PTE_P | IOMMU_PTE_FC;
+	__pte = paddr | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 	if (direction == DMA_TO_DEVICE)
 		__pte |= IOMMU_PTE_IR;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 01783cc..7796edf 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -239,7 +239,7 @@
 #define PM_LEVEL_INDEX(x, a)	(((a) >> PM_LEVEL_SHIFT((x))) & 0x1ffULL)
 #define PM_LEVEL_ENC(x)		(((x) << 9) & 0xe00ULL)
 #define PM_LEVEL_PDE(x, a)	((a) | PM_LEVEL_ENC((x)) | \
-				 IOMMU_PTE_P | IOMMU_PTE_IR | IOMMU_PTE_IW)
+				 IOMMU_PTE_PR | IOMMU_PTE_IR | IOMMU_PTE_IW)
 #define PM_PTE_LEVEL(pte)	(((pte) >> 9) & 0x7ULL)
 
 #define PM_MAP_4k		0
@@ -288,13 +288,24 @@
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
 
+
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
@@ -316,7 +327,7 @@
 #define GCR3_VALID		0x01ULL
 
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
-#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_P)
+#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
 #define IOMMU_PTE_PAGE(pte) (phys_to_virt((pte) & IOMMU_PAGE_MASK))
 #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
 
-- 
2.5.5
