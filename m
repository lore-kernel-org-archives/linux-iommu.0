From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 10/15] iommu/intel: Use pci_find_dma_isolation_root() for
	IOMMU groups
Date: Sat, 10 May 2014 09:03:24 -0600
Message-ID: <20140510150324.2997.69374.stgit@bling.home>
References: <20140510145619.2997.429.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140510145619.2997.429.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Drop custom code that attempts to do the exact same thing and use
PCI provided isolation root support.  Existing IOMMU group laytout
should not change.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   71 +++++--------------------------------------
 1 file changed, 8 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f256ffc..f0e50f1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -44,7 +44,6 @@
 #include <asm/iommu.h>
 
 #include "irq_remapping.h"
-#include "pci.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
@@ -4359,12 +4358,9 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 	return 0;
 }
 
-#define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
-
 static int intel_iommu_add_device(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *bridge, *dma_pdev = NULL;
+	struct pci_dev *pdev;
 	struct iommu_group *group;
 	int ret;
 	u8 bus, devfn;
@@ -4372,68 +4368,16 @@ static int intel_iommu_add_device(struct device *dev)
 	if (!device_to_iommu(dev, &bus, &devfn))
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
-
-	/* Account for quirked devices */
-	swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
-
-	/*
-	 * If it's a multifunction device that does not support our
-	 * required ACS flags, add to the same group as lowest numbered
-	 * function that also does not suport the required ACS flags.
-	 */
-	if (dma_pdev->multifunction &&
-	    !pci_acs_enabled(dma_pdev, REQ_ACS_FLAGS)) {
-		u8 i, slot = PCI_SLOT(dma_pdev->devfn);
-
-		for (i = 0; i < 8; i++) {
-			struct pci_dev *tmp;
-
-			tmp = pci_get_slot(dma_pdev->bus, PCI_DEVFN(slot, i));
-			if (!tmp)
-				continue;
-
-			if (!pci_acs_enabled(tmp, REQ_ACS_FLAGS)) {
-				swap_pci_ref(&dma_pdev, tmp);
-				break;
-			}
-			pci_dev_put(tmp);
-		}
+	group = iommu_group_get(dev);
+	if (group) {
+		iommu_group_put(group);
+		return 0;
 	}
 
-	/*
-	 * Devices on the root bus go through the iommu.  If that's not us,
-	 * find the next upstream device and test ACS up to the root bus.
-	 * Finding the next device may require skipping virtual buses.
-	 */
-	while (!pci_is_root_bus(dma_pdev->bus)) {
-		struct pci_bus *bus = dma_pdev->bus;
+	pdev = pci_find_dma_isolation_root(to_pci_dev(dev));
 
-		while (!bus->self) {
-			if (!pci_is_root_bus(bus))
-				bus = bus->parent;
-			else
-				goto root_bus;
-		}
+	group = iommu_group_get(&pdev->dev);
 
-		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
-			break;
-
-		swap_pci_ref(&dma_pdev, pci_dev_get(bus->self));
-	}
-
-root_bus:
-	group = iommu_group_get(&dma_pdev->dev);
-	pci_dev_put(dma_pdev);
 	if (!group) {
 		group = iommu_group_alloc();
 		if (IS_ERR(group))
@@ -4443,6 +4387,7 @@ root_bus:
 	ret = iommu_group_add_device(group, dev);
 
 	iommu_group_put(group);
+
 	return ret;
 }
 
