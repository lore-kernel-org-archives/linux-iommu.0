From: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 5/8] iommu/vt-d: Items required for kdump
Date: Thu, 24 Apr 2014 18:36:35 -0600
Message-ID: <1398386198-19304-6-git-send-email-bill.sumner@hp.com>
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

Add data declarations and prototypes needed for kdump.

Signed-off-by: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu-private.h | 94 +++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/iommu/intel-iommu-private.h b/drivers/iommu/intel-iommu-private.h
index 480399c..3f20234 100644
--- a/drivers/iommu/intel-iommu-private.h
+++ b/drivers/iommu/intel-iommu-private.h
@@ -361,3 +361,97 @@ static inline void free_pgtable_page(void *vaddr)
 {
 	free_page((unsigned long)vaddr);
 }
+
+#ifdef CONFIG_CRASH_DUMP
+/*
+ * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
+ *
+ * Fixes the crashdump kernel to deal with an active iommu and legacy
+ * DMA from the (old) panicked kernel in a manner similar to how legacy
+ * DMA is handled when no hardware iommu was in use by the old kernel --
+ * allow the legacy DMA to continue into its current buffers.
+ *
+ * In the crashdump kernel, this code:
+ * 1. skips disabling the IOMMU's translating of IO Virtual Addresses (IOVA)
+ * 2. leaves the current translations in-place so that legacy DMA will
+ *    continue to use its current buffers,
+ * 3. allocates to the device drivers in the crashdump kernel
+ *    portions of the iova address ranges that are different
+ *    from the iova address ranges that were being used by the old kernel
+ *    at the time of the panic.
+ *
+ */
+
+struct domain_values_entry {
+	struct list_head link;		/* link entries into a list */
+	struct iova_domain iovad;	/* iova's that belong to this domain */
+	struct dma_pte	*pgd;		/* virtual address */
+	int    did;			/* domain id */
+	int    gaw;			/* max guest address width */
+	int    iommu_superpage;		/* Level of superpages supported:
+					   0 == 4KiB (no superpages), 1 == 2MiB,
+					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
+};
+
+
+
+/* ------------------------------------------------------------------------
+ * Prototypes of interface functions
+ * ------------------------------------------------------------------------
+ */
+
+extern int
+intel_iommu_copy_translation_tables(struct dmar_drhd_unit *drhd,
+	struct root_entry **root_old_p, struct root_entry **root_new_p,
+	int g_num_of_iommus);
+
+extern int
+intel_iommu_get_dids_from_old_kernel(struct intel_iommu *iommu);
+
+extern struct domain_values_entry *
+intel_iommu_did_to_domain_values_entry(int did, struct intel_iommu *iommu);
+
+
+/* ------------------------------------------------------------------------
+ * Utility functions for accessing the iommu Translation Tables
+ * ------------------------------------------------------------------------
+ */
+
+static inline struct context_entry *
+get_context_phys_from_root(struct root_entry *root)
+{
+	return (struct context_entry *)
+		(root_present(root) ? (void *) (root->val & VTD_PAGE_MASK)
+				    : NULL);
+}
+
+static inline int
+context_get_p(struct context_entry *c)    {return((c->lo >> 0) & 0x1); }
+
+static inline int
+context_get_fpdi(struct context_entry *c) {return((c->lo >> 1) & 0x1); }
+
+static inline int
+context_get_t(struct context_entry *c)    {return((c->lo >> 2) & 0x3); }
+
+static inline u64
+context_get_asr(struct context_entry *c)  {return((c->lo >> 12));      }
+
+static inline int
+context_get_aw(struct context_entry *c)   {return((c->hi >> 0) & 0x7); }
+
+static inline int
+context_get_aval(struct context_entry *c) {return((c->hi >> 3) & 0xf); }
+
+static inline int
+context_get_did(struct context_entry *c)  {return((c->hi >> 8) & 0xffff); }
+
+static inline void
+context_put_asr(struct context_entry *c, unsigned long asr)
+{
+	c->lo &= (~VTD_PAGE_MASK);
+	c->lo |= (asr << VTD_PAGE_SHIFT);
+}
+
+#endif	/* CONFIG_CRASH_DUMP */
+
-- 
Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
