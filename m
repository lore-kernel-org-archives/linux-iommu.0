From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/7] amd_iommu: Make use of DMA quirks and ACS checks in IOMMU
	groups
Date: Tue, 29 May 2012 23:10:34 -0600
Message-ID: <20120530051034.1543.46304.stgit@bling.home>
References: <20120530045150.1543.73660.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120530045150.1543.73660.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Work around broken devices and adhere to ACS support when determining
IOMMU grouping.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/amd_iommu.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c0385b3..9b2e2c9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -254,6 +254,8 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
+#define PCI_ACS_ENABLED	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
+
 static int iommu_init_device(struct device *dev)
 {
 	struct pci_dev *dma_pdev, *pdev = to_pci_dev(dev);
@@ -291,6 +293,22 @@ static int iommu_init_device(struct device *dev)
 		dma_pdev = pci_get_slot(pdev->bus,
 					PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
 
+	dma_pdev = pci_dma_source(dma_pdev);
+
+	if (dma_pdev->multifunction &&
+	    !pci_acs_enabled(dma_pdev, PCI_ACS_ENABLED))
+		dma_pdev = pci_get_slot(dma_pdev->bus,
+					PCI_DEVFN(PCI_SLOT(dma_pdev->devfn),
+					0));
+
+	while (!pci_is_root_bus(dma_pdev->bus)) {
+		if (pci_acs_path_enabled(dma_pdev->bus->self,
+					 NULL, PCI_ACS_ENABLED))
+			break;
+
+		dma_pdev = dma_pdev->bus->self;
+	}
+
 	group = iommu_group_get(&dma_pdev->dev);
 	if (!group) {
 		group = iommu_group_alloc();
