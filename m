From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] intel-iommu: Fix ACS path checking
Date: Sat, 04 Aug 2012 12:08:55 -0600
Message-ID: <20120804180852.6144.71902.stgit@bling.home>
References: <20120804180155.6144.83332.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120804180155.6144.83332.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dsahern-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

SR-IOV can create buses without a bridge.  There may be other cases
where this happens as well.  In these cases skip to the parent bus
and continue testing devices there.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/intel-iommu.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 7469b53..bae1357 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4124,8 +4124,13 @@ static int intel_iommu_add_device(struct device *dev)
 	} else
 		dma_pdev = pci_dev_get(pdev);
 
+	/* Account for quirked devices */
 	swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
 
+	/*
+	 * If it's a multifunction device that does not support our
+	 * required ACS flags, add to the same group as function 0.
+	 */
 	if (dma_pdev->multifunction &&
 	    !pci_acs_enabled(dma_pdev, REQ_ACS_FLAGS))
 		swap_pci_ref(&dma_pdev,
@@ -4133,14 +4138,28 @@ static int intel_iommu_add_device(struct device *dev)
 					  PCI_DEVFN(PCI_SLOT(dma_pdev->devfn),
 					  0)));
 
+	/*
+	 * Devices on the root bus go through the iommu.  If that's not us,
+	 * find the next upstream device and test ACS up to the root bus.
+	 * Finding the next device may require skipping virtual buses.
+	 */
 	while (!pci_is_root_bus(dma_pdev->bus)) {
-		if (pci_acs_path_enabled(dma_pdev->bus->self,
-					 NULL, REQ_ACS_FLAGS))
+		struct pci_bus *bus = dma_pdev->bus;
+
+		while (!bus->self) {
+			if (!pci_is_root_bus(bus))
+				bus = bus->parent;
+			else
+				goto root_bus;
+		}
+
+		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
 			break;
 
-		swap_pci_ref(&dma_pdev, pci_dev_get(dma_pdev->bus->self));
+		swap_pci_ref(&dma_pdev, pci_dev_get(bus->self));
 	}
 
+root_bus:
 	group = iommu_group_get(&dma_pdev->dev);
 	pci_dev_put(dma_pdev);
 	if (!group) {
