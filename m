From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 03/13] iommu: IOMMU groups for VT-d and AMD-Vi
Date: Fri, 11 May 2012 16:55:48 -0600
Message-ID: <20120511225548.30496.34428.stgit@bling.home>
References: <20120511222148.30496.68571.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120511222148.30496.68571.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add back group support for AMD & Intel.  amd_iommu already tracks
devices and has init and uninit routines to manage groups.
intel-iommu does this on the fly, so we make use of the notifier
support built into iommu groups to create and remove groups.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/amd_iommu.c   |   28 +++++++++++++++++++++++++-
 drivers/iommu/intel-iommu.c |   46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 32c00cd..b7e5ddf 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -256,9 +256,11 @@ static bool check_device(struct device *dev)
 
 static int iommu_init_device(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *dma_pdev, *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
+	struct iommu_group *group;
 	u16 alias;
+	int ret;
 
 	if (dev->archdata.iommu)
 		return 0;
@@ -279,8 +281,30 @@ static int iommu_init_device(struct device *dev)
 			return -ENOTSUPP;
 		}
 		dev_data->alias_data = alias_data;
+
+		dma_pdev = pci_get_bus_and_slot(alias >> 8, alias & 0xff);
+	} else
+		dma_pdev = pdev;
+
+	if (!pdev->is_virtfn && PCI_FUNC(pdev->devfn) && iommu_group_mf &&
+	    pdev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+		dma_pdev = pci_get_slot(pdev->bus,
+					PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
+
+	group = iommu_group_get(&dma_pdev->dev);
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return PTR_ERR(group);
 	}
 
+	ret = iommu_group_add_device(group, dev);
+
+	iommu_group_put(group);
+
+	if (ret)
+		return ret;
+
 	if (pci_iommuv2_capable(pdev)) {
 		struct amd_iommu *iommu;
 
@@ -309,6 +333,8 @@ static void iommu_ignore_device(struct device *dev)
 
 static void iommu_uninit_device(struct device *dev)
 {
+	iommu_group_remove_device(dev);
+
 	/*
 	 * Nothing to do here - we keep dev_data around for unplugged devices
 	 * and reuse it when the device is re-plugged - not doing so would
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d4a0ff7..e63b33b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4087,6 +4087,50 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
+static int intel_iommu_add_device(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *bridge, *dma_pdev = pdev;
+	struct iommu_group *group;
+	int ret;
+
+	if (!device_to_iommu(pci_domain_nr(pdev->bus),
+			     pdev->bus->number, pdev->devfn))
+		return -ENODEV;
+
+	bridge = pci_find_upstream_pcie_bridge(pdev);
+	if (bridge) {
+		if (pci_is_pcie(bridge))
+			dma_pdev = pci_get_domain_bus_and_slot(
+						pci_domain_nr(pdev->bus),
+						bridge->subordinate->number, 0);
+		else
+			dma_pdev = bridge;
+	}
+
+	if (!pdev->is_virtfn && PCI_FUNC(pdev->devfn) && iommu_group_mf &&
+	    pdev->hdr_type == PCI_HEADER_TYPE_NORMAL)
+		dma_pdev = pci_get_slot(pdev->bus,
+					PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
+
+	group = iommu_group_get(&dma_pdev->dev);
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return PTR_ERR(group);
+	}
+
+	ret = iommu_group_add_device(group, dev);
+
+	iommu_group_put(group);
+	return ret;
+}
+
+static void intel_iommu_remove_device(struct device *dev)
+{
+	iommu_group_remove_device(dev);
+}
+
 static struct iommu_ops intel_iommu_ops = {
 	.domain_init	= intel_iommu_domain_init,
 	.domain_destroy = intel_iommu_domain_destroy,
@@ -4096,6 +4140,8 @@ static struct iommu_ops intel_iommu_ops = {
 	.unmap		= intel_iommu_unmap,
 	.iova_to_phys	= intel_iommu_iova_to_phys,
 	.domain_has_cap = intel_iommu_domain_has_cap,
+	.add_device	= intel_iommu_add_device,
+	.remove_device	= intel_iommu_remove_device,
 	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
 };
