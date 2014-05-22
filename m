From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 13/16] iommu/fsl: Use iommu_group_get_for_dev() for IOMMU
	groups
Date: Thu, 22 May 2014 17:08:45 -0600
Message-ID: <20140522230845.2856.95844.stgit@bling.home>
References: <20140522230230.2856.40017.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140522230230.2856.40017.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, eddy0596-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Drop custom code and use IOMMU provided grouping support for PCI.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu_domain.c |   66 +--------------------------------------
 1 file changed, 1 insertion(+), 65 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 93072ba..d02d668 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -38,7 +38,6 @@
 #include <sysdev/fsl_pci.h>
 
 #include "fsl_pamu_domain.h"
-#include "pci.h"
 
 /*
  * Global spinlock that needs to be held while
@@ -892,8 +891,6 @@ static int fsl_pamu_get_domain_attr(struct iommu_domain *domain,
 	return ret;
 }
 
-#define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
-
 static struct iommu_group *get_device_iommu_group(struct device *dev)
 {
 	struct iommu_group *group;
@@ -950,74 +947,13 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 	struct pci_controller *pci_ctl;
 	bool pci_endpt_partioning;
 	struct iommu_group *group = NULL;
-	struct pci_dev *bridge, *dma_pdev = NULL;
 
 	pci_ctl = pci_bus_to_host(pdev->bus);
 	pci_endpt_partioning = check_pci_ctl_endpt_part(pci_ctl);
 	/* We can partition PCIe devices so assign device group to the device */
 	if (pci_endpt_partioning) {
-		bridge = pci_find_upstream_pcie_bridge(pdev);
-		if (bridge) {
-			if (pci_is_pcie(bridge))
-				dma_pdev = pci_get_domain_bus_and_slot(
-						pci_domain_nr(pdev->bus),
-						bridge->subordinate->number, 0);
-			if (!dma_pdev)
-				dma_pdev = pci_dev_get(bridge);
-		} else
-			dma_pdev = pci_dev_get(pdev);
-
-		/* Account for quirked devices */
-		swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
-
-		/*
-		 * If it's a multifunction device that does not support our
-		 * required ACS flags, add to the same group as lowest numbered
-		 * function that also does not suport the required ACS flags.
-		 */
-		if (dma_pdev->multifunction &&
-		    !pci_acs_enabled(dma_pdev, REQ_ACS_FLAGS)) {
-			u8 i, slot = PCI_SLOT(dma_pdev->devfn);
-
-			for (i = 0; i < 8; i++) {
-				struct pci_dev *tmp;
-
-				tmp = pci_get_slot(dma_pdev->bus, PCI_DEVFN(slot, i));
-				if (!tmp)
-					continue;
-
-				if (!pci_acs_enabled(tmp, REQ_ACS_FLAGS)) {
-					swap_pci_ref(&dma_pdev, tmp);
-					break;
-				}
-				pci_dev_put(tmp);
-			}
-		}
-
-		/*
-		 * Devices on the root bus go through the iommu.  If that's not us,
-		 * find the next upstream device and test ACS up to the root bus.
-		 * Finding the next device may require skipping virtual buses.
-		 */
-		while (!pci_is_root_bus(dma_pdev->bus)) {
-			struct pci_bus *bus = dma_pdev->bus;
-
-			while (!bus->self) {
-				if (!pci_is_root_bus(bus))
-					bus = bus->parent;
-				else
-					goto root_bus;
-			}
-
-			if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
-				break;
-
-			swap_pci_ref(&dma_pdev, pci_dev_get(bus->self));
-		}
+		group = iommu_group_get_for_dev(&pdev->dev);
 
-root_bus:
-		group = get_device_iommu_group(&dma_pdev->dev);
-		pci_dev_put(dma_pdev);
 		/*
 		 * PCIe controller is not a paritionable entity
 		 * free the controller device iommu_group.
