From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/6] iommu/amd: Add support for non-pci devices
Date: Tue, 5 Jan 2016 05:07:23 -0500
Message-ID: <1451988444-4694-6-git-send-email-vincent.wan@amd.com>
References: <1451988444-4694-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1451988444-4694-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
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
 drivers/iommu/amd_iommu.c | 124 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 106 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 98acb89..1902d01 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -19,6 +19,7 @@
 
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -176,13 +177,56 @@ static struct iommu_dev_data *find_dev_data(u16 devid)
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
+	return -ENODEV;
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
+static inline u16 get_device_id(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return get_pci_device_id(dev);
+	else
+		return get_acpihid_device_id(dev, NULL);
+}
+
 static struct iommu_dev_data *get_dev_data(struct device *dev)
 {
 	return dev->archdata.iommu;
@@ -262,7 +306,7 @@ static bool check_device(struct device *dev)
 		return false;
 
 	/* No PCI device */
-	if (!dev_is_pci(dev))
+	if (!dev_is_pci(dev) && (get_acpihid_device_id(dev, NULL) < 0))
 		return false;
 
 	devid = get_device_id(dev);
@@ -298,7 +342,7 @@ out:
 	iommu_group_put(group);
 }
 
-static int iommu_init_device(struct device *dev)
+static int iommu_init_pci_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
@@ -325,6 +369,32 @@ static int iommu_init_device(struct device *dev)
 	return 0;
 }
 
+static int iommu_init_acpihid_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data;
+
+	if (dev->archdata.iommu)
+		return 0;
+
+	dev_data = find_dev_data(get_device_id(dev));
+	if (!dev_data)
+		return -ENOMEM;
+
+	dev->archdata.iommu = dev_data;
+
+	iommu_device_link(amd_iommu_rlookup_table[dev_data->devid]->iommu_dev,
+			  dev);
+
+	return 0;
+}
+
+static int iommu_init_device(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return iommu_init_pci_device(dev);
+	return iommu_init_acpihid_device(dev);
+}
+
 static void iommu_ignore_device(struct device *dev)
 {
 	u16 devid, alias;
@@ -2066,19 +2136,16 @@ static bool pci_pri_tlp_required(struct pci_dev *pdev)
 	return (status & PCI_PRI_TLP_OFF) ? true : false;
 }
 
-/*
- * If a device is not yet associated with a domain, this function
- * assigns it visible for the hardware
- */
-static int attach_device(struct device *dev,
-			 struct protection_domain *domain)
+static int setup_ats_device(struct device *dev,
+			    struct protection_domain *domain)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct iommu_dev_data *dev_data;
-	unsigned long flags;
-	int ret;
+	struct pci_dev *pdev;
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
 
-	dev_data = get_dev_data(dev);
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
 
 	if (domain->flags & PD_IOMMUV2_MASK) {
 		if (!dev_data->passthrough)
@@ -2098,6 +2165,25 @@ static int attach_device(struct device *dev,
 		dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
 	}
 
+	return 0;
+}
+
+/*
+ * If a device is not yet associated with a domain, this function
+ * assigns it visible for the hardware
+ */
+static int attach_device(struct device *dev,
+			 struct protection_domain *domain)
+{
+	struct iommu_dev_data *dev_data;
+	unsigned long flags;
+	int ret;
+
+	dev_data = get_dev_data(dev);
+	ret = setup_ats_device(dev, domain);
+	if (ret)
+		return ret;
+
 	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
 	ret = __attach_device(dev_data, domain);
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
@@ -2154,10 +2240,12 @@ static void detach_device(struct device *dev)
 	__detach_device(dev_data);
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
-		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats.enabled)
-		pci_disable_ats(to_pci_dev(dev));
+	if (dev_is_pci(dev)) {
+		if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+			pdev_iommuv2_disable(to_pci_dev(dev));
+		else if (dev_data->ats.enabled)
+			pci_disable_ats(to_pci_dev(dev));
+	}
 
 	dev_data->ats.enabled = false;
 }
-- 
1.9.1
