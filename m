From: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v11 08/10] iommu/vt-d: assign new page table for dma_map
Date: Mon, 11 May 2015 17:52:52 +0800
Message-ID: <1431337974-545-9-git-send-email-zhen-hual@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual-VXdhtT5mjnY@public.gmane.org>
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
 drivers/iommu/intel-iommu.c | 58 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 91545bf..3cc1027 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -396,6 +396,9 @@ static int copy_root_entry_table(struct intel_iommu *iommu);
 
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
 
+static void unmap_device_dma(struct dmar_domain *domain,
+				struct device *dev,
+				struct intel_iommu *iommu);
 static void iommu_check_pre_te_status(struct intel_iommu *iommu);
 static u8 g_translation_pre_enabled;
 
@@ -3115,6 +3118,7 @@ static struct iova *intel_alloc_iova(struct device *dev,
 static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
 	int ret;
 
 	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
@@ -3124,14 +3128,30 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
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
+		iommu = domain_get_iommu(domain);
+		if (iommu->pre_enabled_trans) {
+			unmap_device_dma(domain, dev, iommu);
+
+			domain = get_domain_for_dev(dev,
+				DEFAULT_DOMAIN_ADDRESS_WIDTH);
+			if (!domain) {
+				pr_err("Allocating domain for %s failed",
+				       dev_name(dev));
+				return NULL;
+			}
+		} else
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
@@ -5168,6 +5188,28 @@ static int intel_iommu_load_translation_tables(struct intel_iommu *iommu)
 	return ret;
 }
 
+static void unmap_device_dma(struct dmar_domain *domain,
+				struct device *dev,
+				struct intel_iommu *iommu)
+{
+	struct context_entry *ce;
+	struct iova *iova;
+	phys_addr_t phys_addr;
+	dma_addr_t dev_addr;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+	ce = iommu_context_addr(iommu, pdev->bus->number, pdev->devfn, 1);
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
 static void iommu_check_pre_te_status(struct intel_iommu *iommu)
 {
 	u32 sts;
-- 
2.0.0-rc0
