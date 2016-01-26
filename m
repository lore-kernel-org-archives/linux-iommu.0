From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2 6/8] iommu/amd: Add iommu support for ACPI HID devices
Date: Tue, 26 Jan 2016 18:14:35 -0500
Message-ID: <1453850077-2539-7-git-send-email-vincent.wan@amd.com>
References: <1453850077-2539-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453850077-2539-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

Current IOMMU driver make assumption that the downstream devices are PCI.
With the newly added ACPI-HID IVHD device entry support, this is no
longer true. This patch is to add dev type check and to distinguish the
pci and acpihid device code path.

Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 69 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 10d6623..4857d66 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -19,6 +19,7 @@
 
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -215,13 +216,60 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
 	return dev_data;
 }
 
-static inline u16 get_device_id(struct device *dev)
+static inline int match_hid_uid(struct device *dev,
+				struct acpihid_map_entry *entry)
+{
+	const char *hid, *uid;
+
+	hid = acpi_device_hid(ACPI_COMPANION(dev));
+	uid = acpi_device_uid(ACPI_COMPANION(dev));
+
+	if (!hid || !(*hid))
+		return -ENODEV;
+
+	if (!uid || !(*uid))
+		return strcmp(hid, entry->hid);
+
+	if (!(*entry->uid))
+		return strcmp(hid, entry->hid);
+
+	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
+}
+
+static inline u16 get_pci_device_id(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	return PCI_DEVID(pdev->bus->number, pdev->devfn);
 }
 
+static inline int get_acpihid_device_id(struct device *dev,
+					struct acpihid_map_entry **entry)
+{
+	struct acpihid_map_entry *p;
+
+	list_for_each_entry(p, &acpihid_map, list) {
+		if (!match_hid_uid(dev, p)) {
+			if (entry)
+				*entry = p;
+			return p->devid;
+		}
+	}
+	return -EINVAL;
+}
+
+static inline int get_device_id(struct device *dev)
+{
+	int devid;
+
+	if (dev_is_pci(dev))
+		devid = get_pci_device_id(dev);
+	else
+		devid = get_acpihid_device_id(dev, NULL);
+
+	return devid;
+}
+
 static struct iommu_dev_data *get_dev_data(struct device *dev)
 {
 	return dev->archdata.iommu;
@@ -302,10 +350,6 @@ static bool check_device(struct device *dev)
 	if (!dev || !dev->dma_mask)
 		return false;
 
-	/* No PCI device */
-	if (!dev_is_pci(dev))
-		return false;
-
 	devid = get_device_id(dev);
 	if (IS_ERR_VALUE(devid))
 		return false;
@@ -343,7 +387,6 @@ out:
 
 static int iommu_init_device(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
 	int devid;
 
@@ -358,10 +401,10 @@ static int iommu_init_device(struct device *dev)
 	if (!dev_data)
 		return -ENOMEM;
 
-	if (pci_iommuv2_capable(pdev)) {
+	if (dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
 		struct amd_iommu *iommu;
 
-		iommu              = amd_iommu_rlookup_table[dev_data->devid];
+		iommu = amd_iommu_rlookup_table[dev_data->devid];
 		dev_data->iommu_v2 = iommu->is_iommu_v2;
 	}
 
@@ -2235,13 +2278,17 @@ static bool pci_pri_tlp_required(struct pci_dev *pdev)
 static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *pdev;
 	struct iommu_dev_data *dev_data;
 	unsigned long flags;
 	int ret;
 
 	dev_data = get_dev_data(dev);
 
+	if (!dev_is_pci(dev))
+		goto skip_ats_check;
+
+	pdev = to_pci_dev(dev);
 	if (domain->flags & PD_IOMMUV2_MASK) {
 		if (!dev_data->passthrough)
 			return -EINVAL;
@@ -2260,6 +2307,7 @@ static int attach_device(struct device *dev,
 		dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
 	}
 
+skip_ats_check:
 	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	ret = __attach_device(dev_data, domain);
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
@@ -2316,6 +2364,9 @@ static void detach_device(struct device *dev)
 	__detach_device(dev_data);
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
+	if (!dev_is_pci(dev))
+		return;
+
 	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats.enabled)
-- 
1.9.1
