From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v9 03/10] iommu/vt-d: Function to get old context entry
Date: Thu, 19 Mar 2015 13:36:21 +0800
Message-ID: <1426743388-26908-4-git-send-email-zhen-hual@hp.com>
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

Interface for when a new domain in the crashdump kernel needs some
values from the panicked kernel's context entries.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 577d5de..f7dbe70 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -369,6 +369,10 @@ static inline int first_pte_in_page(struct dma_pte *pte)
  *
  */
 
+static struct context_entry *device_to_existing_context_entry(
+				struct intel_iommu *iommu,
+				u8 bus, u8 devfn);
+
 
 #endif /* CONFIG_CRASH_DUMP */
 
@@ -4796,3 +4800,26 @@ static void __init check_tylersburg_isoch(void)
 	printk(KERN_WARNING "DMAR: Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
+
+#ifdef CONFIG_CRASH_DUMP
+
+static struct context_entry *device_to_existing_context_entry(
+				struct intel_iommu *iommu,
+				u8 bus, u8 devfn)
+{
+	struct root_entry *root;
+	struct context_entry *context;
+	struct context_entry *ret;
+	unsigned long flags;
+
+	ret = NULL;
+	spin_lock_irqsave(&iommu->lock, flags);
+	root = &iommu->root_entry[bus];
+	context = get_context_addr_from_root(root);
+	if (context && context_present(context+devfn))
+		ret = &context[devfn];
+	spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+#endif /* CONFIG_CRASH_DUMP */
-- 
2.0.0-rc0
