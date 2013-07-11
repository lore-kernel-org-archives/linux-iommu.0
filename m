From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH v2 2/2] iommu/intel: Make use of PCIe requester ID
	interface
Date: Thu, 11 Jul 2013 15:03:34 -0600
Message-ID: <20130711210334.1701.99104.stgit@bling.home>
References: <20130711204439.1701.90503.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130711204439.1701.90503.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This eliminates uses of pci_find_upstream_pcie_bridge() and
incorporates DMA quirks into dma_ops path.

Suggested-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c         |  164 ++++++++++++++---------------------
 drivers/iommu/intel_irq_remapping.c |    2 
 2 files changed, 65 insertions(+), 101 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b4f0e28..51488cb 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1675,80 +1675,59 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 	return 0;
 }
 
-static int
-domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
-			int translation)
+struct context_mapping_info {
+	struct dmar_domain *domain;
+	int translation;
+};
+
+static int context_mapping(struct pci_dev *dev, u16 requester_id, void *data)
 {
-	int ret;
-	struct pci_dev *tmp, *parent;
+	struct context_mapping_info *info = data;
+	u8 bus = requester_id >> 8;
+	u8 devfn = requester_id & 0xFF;
 
-	ret = domain_context_mapping_one(domain, pci_domain_nr(pdev->bus),
-					 pdev->bus->number, pdev->devfn,
-					 translation);
-	if (ret)
-		return ret;
+	return domain_context_mapping_one(info->domain, pci_domain_nr(dev->bus),
+					  bus, devfn, info->translation);
+}
 
-	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (!tmp)
-		return 0;
-	/* Secondary interface's bus number and devfn 0 */
-	parent = pdev->bus->self;
-	while (parent != tmp) {
-		ret = domain_context_mapping_one(domain,
-						 pci_domain_nr(parent->bus),
-						 parent->bus->number,
-						 parent->devfn, translation);
-		if (ret)
-			return ret;
-		parent = parent->bus->self;
-	}
-	if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
-		return domain_context_mapping_one(domain,
-					pci_domain_nr(tmp->subordinate),
-					tmp->subordinate->number, 0,
-					translation);
-	else /* this is a legacy PCI bridge */
-		return domain_context_mapping_one(domain,
-						  pci_domain_nr(tmp->bus),
-						  tmp->bus->number,
-						  tmp->devfn,
-						  translation);
+static int domain_context_mapping(struct dmar_domain *domain,
+				  struct pci_dev *pdev, int translation)
+{
+	struct context_mapping_info info = {
+		.domain = domain,
+		.translation = translation,
+	};
+
+	return pcie_for_each_requester(pdev, NULL, context_mapping, &info);
+}
+
+static int is_context_mapped(struct pci_dev *dev, u16 requester_id, void *data)
+{
+	struct intel_iommu *iommu = data;
+	u8 bus = requester_id >> 8;
+	u8 devfn = requester_id & 0xFF;
+
+	if (!device_context_mapped(iommu, bus, devfn))
+		return 1; /* stop */
+
+	return 0;
 }
 
 static int domain_context_mapped(struct pci_dev *pdev)
 {
-	int ret;
-	struct pci_dev *tmp, *parent;
 	struct intel_iommu *iommu;
+	int ret;
 
-	iommu = device_to_iommu(pci_domain_nr(pdev->bus), pdev->bus->number,
-				pdev->devfn);
+	iommu = device_to_iommu(pci_domain_nr(pdev->bus),
+				pdev->bus->number, pdev->devfn);
 	if (!iommu)
 		return -ENODEV;
 
-	ret = device_context_mapped(iommu, pdev->bus->number, pdev->devfn);
-	if (!ret)
-		return ret;
-	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (!tmp)
+	ret = pcie_for_each_requester(pdev, NULL, is_context_mapped, iommu);
+	if (ret < 0)
 		return ret;
-	/* Secondary interface's bus number and devfn 0 */
-	parent = pdev->bus->self;
-	while (parent != tmp) {
-		ret = device_context_mapped(iommu, parent->bus->number,
-					    parent->devfn);
-		if (!ret)
-			return ret;
-		parent = parent->bus->self;
-	}
-	if (pci_is_pcie(tmp))
-		return device_context_mapped(iommu, tmp->subordinate->number,
-					     0);
-	else
-		return device_context_mapped(iommu, tmp->bus->number,
-					     tmp->devfn);
+
+	return (ret == 0);
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
@@ -1975,6 +1954,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 	struct dmar_drhd_unit *drhd;
 	struct device_domain_info *info, *tmp;
 	struct pci_dev *dev_tmp;
+	u16 requester_id;
 	unsigned long flags;
 	int bus = 0, devfn = 0;
 	int segment;
@@ -1986,15 +1966,11 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 	segment = pci_domain_nr(pdev->bus);
 
-	dev_tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (dev_tmp) {
-		if (pci_is_pcie(dev_tmp)) {
-			bus = dev_tmp->subordinate->number;
-			devfn = 0;
-		} else {
-			bus = dev_tmp->bus->number;
-			devfn = dev_tmp->devfn;
-		}
+	dev_tmp = pci_get_visible_pcie_requester(pdev, NULL, &requester_id);
+	if (dev_tmp && dev_tmp != pdev) {
+		bus = requester_id >> 8;
+		devfn = requester_id & 0xFF;
+
 		spin_lock_irqsave(&device_domain_lock, flags);
 		list_for_each_entry(info, &device_domain_list, global) {
 			if (info->segment == segment &&
@@ -3749,31 +3725,24 @@ int __init intel_iommu_init(void)
 	return 0;
 }
 
+static int detach_requester(struct pci_dev *dev, u16 requester_id, void *data)
+{
+	struct intel_iommu *iommu = data;
+	u8 bus = requester_id >> 8;
+	u8 devfn = requester_id & 0xFF;
+
+	iommu_detach_dev(iommu, bus, devfn);
+	return 0;
+}
+
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 					   struct pci_dev *pdev)
 {
-	struct pci_dev *tmp, *parent;
-
 	if (!iommu || !pdev)
 		return;
 
-	/* dependent device detach */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	/* Secondary interface's bus number and devfn 0 */
-	if (tmp) {
-		parent = pdev->bus->self;
-		while (parent != tmp) {
-			iommu_detach_dev(iommu, parent->bus->number,
-					 parent->devfn);
-			parent = parent->bus->self;
-		}
-		if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
-			iommu_detach_dev(iommu,
-				tmp->subordinate->number, 0);
-		else /* this is a legacy PCI bridge */
-			iommu_detach_dev(iommu, tmp->bus->number,
-					 tmp->devfn);
-	}
+	/* XXX What if there's something else using his path? */
+	pcie_for_each_requester(pdev, NULL, detach_requester, iommu);
 }
 
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
@@ -4158,7 +4127,7 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 static int intel_iommu_add_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *bridge, *dma_pdev = NULL;
+	struct pci_dev *dma_pdev = NULL;
 	struct iommu_group *group;
 	int ret;
 
@@ -4166,16 +4135,11 @@ static int intel_iommu_add_device(struct device *dev)
 			     pdev->bus->number, pdev->devfn))
 		return -ENODEV;
 
-	bridge = pci_find_upstream_pcie_bridge(pdev);
-	if (bridge) {
-		if (pci_is_pcie(bridge))
-			dma_pdev = pci_get_domain_bus_and_slot(
-						pci_domain_nr(pdev->bus),
-						bridge->subordinate->number, 0);
-		if (!dma_pdev)
-			dma_pdev = pci_dev_get(bridge);
-	} else
-		dma_pdev = pci_dev_get(pdev);
+	dma_pdev = pci_get_visible_pcie_requester(pdev, NULL, NULL);
+	if (!dma_pdev)
+		return -EINVAL;
+
+	dma_pdev = pci_dev_get(dma_pdev);
 
 	/* Account for quirked devices */
 	swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 5b19b2d..31214fe 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -385,7 +385,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 		return 0;
 	}
 
-	bridge = pci_find_upstream_pcie_bridge(dev);
+	bridge = pci_get_visible_pcie_requester(dev, NULL, NULL);
 	if (bridge) {
 		if (pci_is_pcie(bridge))/* this is a PCIe-to-PCI/PCIX bridge */
 			set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
