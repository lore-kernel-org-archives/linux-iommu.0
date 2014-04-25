From: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 2/8] iommu/vt-d: Consolidate lines for a new private header
Date: Thu, 24 Apr 2014 18:36:32 -0600
Message-ID: <1398386198-19304-3-git-send-email-bill.sumner@hp.com>
References: <1398386198-19304-1-git-send-email-bill.sumner@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398386198-19304-1-git-send-email-bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, bill.sumner-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

 In intel-iommu.c, move downward the few lines near the
 front that should not move to an intel-iommu-private.h
 file (mostly data-item definitions.) Also move upward
 a couple of inline functions that allocate and free pages.
 This leaves at the front of the file a consolidated block
 of the lines that would move to an intel-iommu-private.h file.

Signed-off-by: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 74 +++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f80b4bb..49fdac5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -163,17 +163,6 @@ static inline unsigned long virt_to_dma_pfn(void *p)
 	return page_to_dma_pfn(virt_to_page(p));
 }
 
-/* global iommu list, set NULL for ignored DMAR units */
-static struct intel_iommu **g_iommus;
-
-static void __init check_tylersburg_isoch(void);
-static int rwbf_quirk;
-
-/*
- * set to 1 to panic kernel if can't successfully enable VT-d
- * (used when kernel is launched w/ TXT)
- */
-static int force_on;
 
 /*
  * 0: Present
@@ -312,15 +301,6 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
-/*
- * This domain is a statically identity mapping domain.
- *	1. This domain creats a static 1:1 mapping to all usable memory.
- *	2. It maps to each iommu if successful.
- *	3. Each iommu mapps to this domain if successful.
- */
-static struct dmar_domain *si_domain;
-static int hw_pass_through = 1;
-
 /* devices under the same p2p bridge are owned in one domain */
 #define DOMAIN_FLAG_P2P_MULTIPLE_DEVICES (1 << 0)
 
@@ -394,12 +374,50 @@ struct dmar_atsr_unit {
 	u8 include_all:1;		/* include all ports */
 };
 
+static inline void *alloc_pgtable_page(int node)
+{
+	struct page *page;
+	void *vaddr = NULL;
+
+	page = alloc_pages_node(node, GFP_ATOMIC | __GFP_ZERO, 0);
+	if (page)
+		vaddr = page_address(page);
+	return vaddr;
+}
+
+static inline void free_pgtable_page(void *vaddr)
+{
+	free_page((unsigned long)vaddr);
+}
+
 static LIST_HEAD(dmar_atsr_units);
 static LIST_HEAD(dmar_rmrr_units);
 
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
+
+static void __init check_tylersburg_isoch(void);
+
+/* global iommu list, set NULL for ignored DMAR units */
+static struct intel_iommu **g_iommus;
+static int rwbf_quirk;
+
+/*
+ * set to 1 to panic kernel if can't successfully enable VT-d
+ * (used when kernel is launched w/ TXT)
+ */
+static int force_on;
+
+/*
+ * This domain is a statically identity mapping domain.
+ *	1. This domain creats a static 1:1 mapping to all usable memory.
+ *	2. It maps to each iommu if successful.
+ *	3. Each iommu mapps to this domain if successful.
+ */
+static struct dmar_domain *si_domain;
+static int hw_pass_through = 1;
+
 static void flush_unmaps_timeout(unsigned long data);
 
 static DEFINE_TIMER(unmap_timer,  flush_unmaps_timeout, 0, 0);
@@ -494,22 +512,6 @@ static struct kmem_cache *iommu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 static struct kmem_cache *iommu_iova_cache;
 
-static inline void *alloc_pgtable_page(int node)
-{
-	struct page *page;
-	void *vaddr = NULL;
-
-	page = alloc_pages_node(node, GFP_ATOMIC | __GFP_ZERO, 0);
-	if (page)
-		vaddr = page_address(page);
-	return vaddr;
-}
-
-static inline void free_pgtable_page(void *vaddr)
-{
-	free_page((unsigned long)vaddr);
-}
-
 static inline void *alloc_domain_mem(void)
 {
 	return kmem_cache_alloc(iommu_domain_cache, GFP_ATOMIC);
-- 
Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
