From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] intel-iommu: Basic isolation group provider support
Date: Mon, 12 Mar 2012 16:33:02 -0600
Message-ID: <20120312223302.30321.91922.stgit@bling.home>
References: <20120312220109.30321.83419.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120312220109.30321.83419.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/intel-iommu.c |   70 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c9c6053..2e5a709 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -42,6 +42,7 @@
 #include <linux/dmi.h>
 #include <linux/pci-ats.h>
 #include <linux/memblock.h>
+#include <linux/isolation.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -3597,6 +3598,73 @@ static struct notifier_block device_nb = {
 	.notifier_call = device_notifier,
 };
 
+static int isolation_notifier(struct notifier_block *nb,
+			      unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (iommu_no_mapping(dev) ||
+	    !device_to_iommu(pci_domain_nr(pdev->bus),
+			     pdev->bus->number, pdev->devfn))
+		return NOTIFY_DONE;
+
+
+	if (action == ISOLATION_NOTIFY_ADD_DEVICE) {
+		struct device *dma_dev = NULL;
+		struct pci_dev *bridge = pci_find_upstream_pcie_bridge(pdev);
+		struct isolation_group *group;
+
+		if (bridge) {
+			if (pci_is_pcie(bridge)) {
+				struct pci_dev *dma_pdev;
+				dma_pdev = pci_get_domain_bus_and_slot(
+					pci_domain_nr(pdev->bus),
+					bridge->subordinate->number, 0);
+				dma_dev = &dma_pdev->dev;
+			}
+
+			if (!dma_dev)
+				dma_dev = &bridge->dev;
+		} else
+			dma_dev = dev;
+
+		group = to_isolation_group(dma_dev);
+
+		if (!group) {
+			group = isolation_create_group();
+			if (IS_ERR(group))
+				return NOTIFY_BAD;
+
+			isolation_group_set_iommu_ops(group, &intel_iommu_ops);
+
+			if (dma_dev != dev)
+				isolation_group_add_dev(group, dma_dev);
+		}
+
+		if (isolation_group_add_dev(group, dev))
+			return NOTIFY_BAD;
+
+		return NOTIFY_STOP;
+
+	} else if (action == ISOLATION_NOTIFY_DEL_DEVICE) {
+		struct isolation_group *group = to_isolation_group(dev);
+
+		if (isolation_group_del_dev(dev))
+			return NOTIFY_BAD;
+
+		isolation_free_group(group);
+
+		return NOTIFY_STOP;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block isolation_nb = {
+	.notifier_call = isolation_notifier,
+};
+
 int __init intel_iommu_init(void)
 {
 	int ret = 0;
@@ -3663,6 +3731,8 @@ int __init intel_iommu_init(void)
 
 	bus_register_notifier(&pci_bus_type, &device_nb);
 
+	isolation_register_notifier(&pci_bus_type, &isolation_nb);
+
 	intel_iommu_enabled = 1;
 
 	return 0;
