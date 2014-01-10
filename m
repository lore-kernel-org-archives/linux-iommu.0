From: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCHv3 2/6] Crashdump-Accepting-Active-IOMMU-Utility-functions
Date: Fri, 10 Jan 2014 15:07:28 -0700
Message-ID: <1389391652-52422-3-git-send-email-bill.sumner@hp.com>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389391652-52422-1-git-send-email-bill.sumner-VXdhtT5mjnY@public.gmane.org>
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

---------.---------.---------.---------.---------.---------.---------.
Most of the code for Crashdump Accepting Active IOMMU is contained
in a large section at the end of intel-iommu.c -- beginning here.

This patch contains small utility functions used to access the
bit fields of the context entry, plus one to copy from a physically-
addressed area of memory (primarily pages from the panicked kernel)
into a virtually-addressed area within the crashdump kernel.

v1->v2:
Updated patch description

v2->v3:
No change

Signed-off-by: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 17c4537..4172a2b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4455,3 +4455,77 @@ static void __init check_tylersburg_isoch(void)
 	printk(KERN_WARNING "DMAR: Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
+#ifdef CONFIG_CRASH_DUMP
+
+/* ========================================================================
+ * Utility functions for accessing the iommu Translation Tables
+ * ------------------------------------------------------------------------
+ */
+static inline struct context_entry *
+get_context_phys_from_root(struct root_entry *root)
+{
+	return (struct context_entry *)
+		(root_present(root) ? (void *) (root->val & VTD_PAGE_MASK)
+				    : NULL);
+}
+
+static int
+context_get_p(struct context_entry *c)    {return((c->lo >> 0) & 0x1); }
+
+static int
+context_get_fpdi(struct context_entry *c) {return((c->lo >> 1) & 0x1); }
+
+static int
+context_get_t(struct context_entry *c)    {return((c->lo >> 2) & 0x3); }
+
+static u64
+context_get_asr(struct context_entry *c)  {return((c->lo >> 12));      }
+
+static int
+context_get_aw(struct context_entry *c)   {return((c->hi >> 0) & 0x7); }
+
+static int
+context_get_aval(struct context_entry *c) {return((c->hi >> 3) & 0xf); }
+
+static int
+context_get_did(struct context_entry *c)  {return((c->hi >> 8) & 0xffff); }
+
+static void context_put_asr(struct context_entry *c, unsigned long asr)
+{
+	c->lo &= (~VTD_PAGE_MASK);
+	c->lo |= (asr << VTD_PAGE_SHIFT);
+}
+
+
+/*
+ * Copy memory from a physically-addressed area into a virtually-addressed area
+ */
+static int oldcopy(void *to, void *from, int size)
+{
+	size_t ret = 0;			/* Length copied */
+	unsigned long pfn;		/* Page Frame Number */
+	char *buf = to;			/* Adr(Output buffer) */
+	size_t csize = (size_t)size;	/* Num(bytes to copy) */
+	unsigned long offset;		/* Lower 12 bits of from */
+	int userbuf = 0;		/* to is in kernel space */
+
+	if (pr_dbg.enter_oldcopy)
+		pr_debug("ENTER %s to=%16.16llx, from = %16.16llx, size = %d\n",
+			__func__,
+			(unsigned long long) to,
+			(unsigned long long) from, size);
+
+	if (intel_iommu_translation_tables_are_mapped)
+		memcpy(to, phys_to_virt((phys_addr_t)from), csize);
+	else {
+		pfn = ((unsigned long) from) >> VTD_PAGE_SHIFT;
+		offset = ((unsigned long) from) & (~VTD_PAGE_MASK);
+		ret = copy_oldmem_page(pfn, buf, csize, offset, userbuf);
+	}
+
+	if (pr_dbg.leave_oldcopy)
+		pr_debug("LEAVE %s ret=%d\n", __func__, (int) ret);
+
+	return (int) ret;
+}
+#endif /* CONFIG_CRASH_DUMP */
-- 
Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
