From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 2/7] iommu/amd: Use dev_printk() when possible
Date: Fri, 08 Feb 2019 16:05:53 -0600
Message-ID: <154966355299.132359.9681240291578714185.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() when possible so the IOMMU messages are more consistent
with other messages related to the device.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/amd_iommu.c      |   25 +++++++++++--------------
 drivers/iommu/amd_iommu_init.c |   20 ++++++++++----------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..fee9c9049d7a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -18,6 +18,7 @@
  */
 
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
@@ -279,10 +280,10 @@ static u16 get_alias(struct device *dev)
 		return pci_alias;
 	}
 
-	pr_info("Using IVRS reported alias %02x:%02x.%d "
-		"for device %s[%04x:%04x], kernel reported alias "
+	pci_info(pdev, "Using IVRS reported alias %02x:%02x.%d "
+		"for device [%04x:%04x], kernel reported alias "
 		"%02x:%02x.%d\n", PCI_BUS_NUM(ivrs_alias), PCI_SLOT(ivrs_alias),
-		PCI_FUNC(ivrs_alias), dev_name(dev), pdev->vendor, pdev->device,
+		PCI_FUNC(ivrs_alias), pdev->vendor, pdev->device,
 		PCI_BUS_NUM(pci_alias), PCI_SLOT(pci_alias),
 		PCI_FUNC(pci_alias));
 
@@ -293,9 +294,8 @@ static u16 get_alias(struct device *dev)
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
 		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
-		pr_info("Added PCI DMA alias %02x.%d for %s\n",
-			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
-			dev_name(dev));
+		pci_info(pdev, "Added PCI DMA alias %02x.%d\n",
+			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias));
 	}
 
 	return ivrs_alias;
@@ -545,7 +545,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 		dev_data = get_dev_data(&pdev->dev);
 
 	if (dev_data && __ratelimit(&dev_data->rs)) {
-		dev_err(&pdev->dev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
+		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
 			domain_id, address, flags);
 	} else if (printk_ratelimit()) {
 		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
@@ -2251,8 +2251,7 @@ static int amd_iommu_add_device(struct device *dev)
 	ret = iommu_init_device(dev);
 	if (ret) {
 		if (ret != -ENOTSUPP)
-			pr_err("Failed to initialize device %s - trying to proceed anyway\n",
-				dev_name(dev));
+			dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 
 		iommu_ignore_device(dev);
 		dev->dma_ops = NULL;
@@ -2605,8 +2604,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	return nelems;
 
 out_unmap:
-	pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
-	       dev_name(dev), npages);
+	dev_err(dev, "IOMMU mapping error in map_sg (io-pages: %d)\n", npages);
 
 	for_each_sg(sglist, s, nelems, i) {
 		int j, pages = iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
@@ -2800,7 +2798,7 @@ static int init_reserved_iova_ranges(void)
 					   IOVA_PFN(r->start),
 					   IOVA_PFN(r->end));
 			if (!val) {
-				pr_err("Reserve pci-resource range failed\n");
+				pci_err(pdev, "Reserve pci-resource range %pR failed\n", r);
 				return -ENOMEM;
 			}
 		}
@@ -3170,8 +3168,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 						 length, prot,
 						 IOMMU_RESV_DIRECT);
 		if (!region) {
-			pr_err("Out of memory allocating dm-regions for %s\n",
-				dev_name(dev));
+			dev_err(dev, "Out of memory allocating dm-regions\n");
 			return;
 		}
 		list_add_tail(&region->list, head);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 66123b911ec8..f773792d77fd 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -18,6 +18,7 @@
  */
 
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
 
 #include <linux/pci.h>
 #include <linux/acpi.h>
@@ -1457,8 +1458,7 @@ static void amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
 	pci_write_config_dword(iommu->dev, 0xf0, 0x90 | (1 << 8));
 
 	pci_write_config_dword(iommu->dev, 0xf4, value | 0x4);
-	pr_info("Applying erratum 746 workaround for IOMMU at %s\n",
-		dev_name(&iommu->dev->dev));
+	pci_info(iommu->dev, "Applying erratum 746 workaround\n");
 
 	/* Clear the enable writing bit */
 	pci_write_config_dword(iommu->dev, 0xf0, 0x90);
@@ -1488,8 +1488,7 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
 	/* Set L2_DEBUG_3[AtsIgnoreIWDis] = 1 */
 	iommu_write_l2(iommu, 0x47, value | BIT(0));
 
-	pr_info("Applying ATS write check workaround for IOMMU at %s\n",
-		dev_name(&iommu->dev->dev));
+	pci_info(iommu->dev, "Applying ATS write check workaround\n");
 }
 
 /*
@@ -1665,6 +1664,7 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
+	struct pci_dev *pdev = iommu->dev;
 	u64 val = 0xabcd, val2 = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
@@ -1676,12 +1676,12 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
 	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
 	    (val != val2)) {
-		pr_err("Unable to write to IOMMU perf counter.\n");
+		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
 		return;
 	}
 
-	pr_info("IOMMU performance counters supported\n");
+	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
 	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
@@ -1840,14 +1840,14 @@ static void print_iommu_info(void)
 	struct amd_iommu *iommu;
 
 	for_each_iommu(iommu) {
+		struct pci_dev *pdev = iommu->dev;
 		int i;
 
-		pr_info("Found IOMMU at %s cap 0x%hx\n",
-			dev_name(&iommu->dev->dev), iommu->cap_ptr);
+		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pr_info("Extended features (%#llx):\n",
-				iommu->features);
+			pci_info(pdev, "Extended features (%#llx):\n",
+				 iommu->features);
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
 				if (iommu_feature(iommu, (1ULL << i)))
 					pr_cont(" %s", feat_str[i]);
