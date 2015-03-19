From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v9 08/10] iommu/vt-d: assign new page table for dma_map
Date: Thu, 19 Mar 2015 13:36:26 +0800
Message-ID: <1426743388-26908-9-git-send-email-zhen-hual@hp.com>
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

When a device driver issues the first dma_map command for a device, we
assign a new and empty page-table, thus removing all mappings from the
old kernel for the device.

Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 54 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 312f06b..6b691d4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -44,6 +44,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <linux/dma-mapping.h>
 
 #include "irq_remapping.h"
 
@@ -3121,14 +3122,30 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 		return NULL;
 	}
 
-	/* make sure context mapping is ok */
-	if (unlikely(!domain_context_mapped(dev))) {
-		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
-		if (ret) {
-			printk(KERN_ERR "Domain context map for %s failed",
-			       dev_name(dev));
-			return NULL;
-		}
+	/* if in kdump kernel, we need to unmap the mapped dma pages,
+	 * detach this device first.
+	 */
+	if (likely(domain_context_mapped(dev))) {
+#ifdef CONFIG_CRASH_DUMP
+		if (is_kdump_kernel()) {
+			unmap_device_dma(domain, dev);
+			domain = get_domain_for_dev(dev,
+				DEFAULT_DOMAIN_ADDRESS_WIDTH);
+			if (!domain) {
+				pr_err("Allocating domain for %s failed",
+				       dev_name(dev));
+				return NULL;
+			}
+		} else
+#endif
+			return domain;
+	}
+
+	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
+	if (ret) {
+		pr_err("Domain context map for %s failed",
+		       dev_name(dev));
+		return NULL;
 	}
 
 	return domain;
@@ -5177,4 +5194,25 @@ static int intel_iommu_load_translation_tables(struct dmar_drhd_unit *drhd)
 	return ret;
 }
 
+static void unmap_device_dma(struct dmar_domain *domain, struct device *dev)
+{
+	struct intel_iommu *iommu;
+	struct context_entry *ce;
+	struct iova *iova;
+	u8 bus, devfn;
+	phys_addr_t phys_addr;
+	dma_addr_t dev_addr;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	ce = device_to_context_entry(iommu, bus, devfn);
+	phys_addr = context_address_root(ce) << VTD_PAGE_SHIFT;
+	dev_addr = phys_to_dma(dev, phys_addr);
+
+	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
+	if (iova)
+		intel_unmap(dev, dev_addr);
+
+	domain_remove_one_dev_info(domain, dev);
+}
+
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.0.0-rc0
