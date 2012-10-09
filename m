From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 2/5] amd_iommu: Split IOMMU Group topology walk
Date: Mon, 08 Oct 2012 22:49:41 -0600
Message-ID: <20121009044941.16302.16171.stgit@bling.home>
References: <20121009044057.16302.44577.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121009044057.16302.44577.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg.Roedel-5C7GfCeVMHo@public.gmane.org, florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/amd_iommu.c |   58 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b65b377..6edbd0e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -276,32 +276,9 @@ static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
 
 #define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
 
-static int init_iommu_group(struct device *dev)
+static struct pci_dev *get_isolation_root(struct pci_dev *pdev)
 {
-	struct iommu_dev_data *dev_data;
-	struct iommu_group *group;
-	struct pci_dev *dma_pdev = NULL;
-	int ret;
-
-	group = iommu_group_get(dev);
-	if (group) {
-		iommu_group_put(group);
-		return 0;
-	}
-
-	dev_data = find_dev_data(get_device_id(dev));
-	if (!dev_data)
-		return -ENOMEM;
-
-	if (dev_data->alias_data) {
-		u16 alias;
-
-		alias = amd_iommu_alias_table[dev_data->devid];
-		dma_pdev = pci_get_bus_and_slot(alias >> 8, alias & 0xff);
-	}
-
-	if (!dma_pdev)
-		dma_pdev = pci_dev_get(to_pci_dev(dev));
+	struct pci_dev *dma_pdev = pdev;
 
 	/* Account for quirked devices */
 	swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
@@ -339,6 +316,37 @@ static int init_iommu_group(struct device *dev)
 	}
 
 root_bus:
+	return dma_pdev;
+}
+
+static int init_iommu_group(struct device *dev)
+{
+	struct iommu_dev_data *dev_data;
+	struct iommu_group *group;
+	struct pci_dev *dma_pdev = NULL;
+	int ret;
+
+	group = iommu_group_get(dev);
+	if (group) {
+		iommu_group_put(group);
+		return 0;
+	}
+
+	dev_data = find_dev_data(get_device_id(dev));
+	if (!dev_data)
+		return -ENOMEM;
+
+	if (dev_data->alias_data) {
+		u16 alias;
+
+		alias = amd_iommu_alias_table[dev_data->devid];
+		dma_pdev = pci_get_bus_and_slot(alias >> 8, alias & 0xff);
+	}
+
+	if (!dma_pdev)
+		dma_pdev = pci_dev_get(to_pci_dev(dev));
+
+	dma_pdev = get_isolation_root(dma_pdev);
 	group = iommu_group_get(&dma_pdev->dev);
 	pci_dev_put(dma_pdev);
 	if (!group) {
