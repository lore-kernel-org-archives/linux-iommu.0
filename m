From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v9 02/10] iommu/vt-d: Items required for kdump
Date: Thu, 19 Mar 2015 13:36:20 +0800
Message-ID: <1426743388-26908-3-git-send-email-zhen-hual@hp.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add context entry functions needed for kdump.

Bill Sumner:
    Original version;

Li, Zhenhua:
    Changed the name of new functions, make them consistent with current
    context get/set functions.
    Remove the structure dve which is not used in new version.

Signed-off-by: Bill Sumner <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 76674a1..577d5de 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -40,6 +40,7 @@
 #include <linux/pci-ats.h>
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
+#include <linux/crash_dump.h>
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -211,6 +212,12 @@ get_context_addr_from_root(struct root_entry *root)
 		NULL);
 }
 
+static inline unsigned long
+get_context_phys_from_root(struct root_entry *root)
+{
+	return  root_present(root) ? (root->val & VTD_PAGE_MASK) : 0;
+}
+
 /*
  * low 64 bits:
  * 0: present
@@ -231,6 +238,32 @@ static inline bool context_present(struct context_entry *context)
 {
 	return (context->lo & 1);
 }
+
+static inline int context_fault_enable(struct context_entry *c)
+{
+	return((c->lo >> 1) & 0x1);
+}
+
+static inline int context_translation_type(struct context_entry *c)
+{
+	return((c->lo >> 2) & 0x3);
+}
+
+static inline u64 context_address_root(struct context_entry *c)
+{
+	return((c->lo >> VTD_PAGE_SHIFT));
+}
+
+static inline int context_address_width(struct context_entry *c)
+{
+	return((c->hi >> 0) & 0x7);
+}
+
+static inline int context_domain_id(struct context_entry *c)
+{
+	return((c->hi >> 8) & 0xffff);
+}
+
 static inline void context_set_present(struct context_entry *context)
 {
 	context->lo |= 1;
@@ -316,6 +349,29 @@ static inline int first_pte_in_page(struct dma_pte *pte)
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
 
+
+#ifdef CONFIG_CRASH_DUMP
+
+/*
+ * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
+ *
+ * Fixes the crashdump kernel to deal with an active iommu and legacy
+ * DMA from the (old) panicked kernel in a manner similar to how legacy
+ * DMA is handled when no hardware iommu was in use by the old kernel --
+ * allow the legacy DMA to continue into its current buffers.
+ *
+ * In the crashdump kernel, this code:
+ * 1. skips disabling the IOMMU's translating.
+ * 2. Do not re-enable IOMMU's translating.
+ * 3. In kdump kernel, use the old root entry table.
+ * 4. Allocate pages for new context entry, copy data from old context entries
+ *    in the old kernel to the new ones.
+ *
+ */
+
+
+#endif /* CONFIG_CRASH_DUMP */
+
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
-- 
2.0.0-rc0
