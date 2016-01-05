From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 6/6] iommu/amd: Manage iommu_group for non-pci devices
Date: Tue, 5 Jan 2016 05:07:24 -0500
Message-ID: <1451988444-4694-7-git-send-email-vincent.wan@amd.com>
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

This patch creates a new function for finding or creating an IOMMU
group for acpihid(ACPI Hardware ID) device.

The acpihid devices with the same devid will be put into same group and
there will have the same domain id and share the same page table.

Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1902d01..e1083ce 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -232,6 +232,29 @@ static struct iommu_dev_data *get_dev_data(struct device *dev)
 	return dev->archdata.iommu;
 }
 
+/*
+* Find or create an IOMMU group for a acpihid device.
+*/
+static struct iommu_group *acpihid_device_group(struct device *dev)
+{
+	struct acpihid_map_entry *p, *entry = NULL;
+	u16 devid;
+
+	devid = get_acpihid_device_id(dev, &entry);
+	if (devid < 0)
+		return ERR_PTR(devid);
+
+	list_for_each_entry(p, &acpihid_map, list) {
+		if ((devid == p->devid) && p->group)
+			entry->group = p->group;
+	}
+
+	if (!entry->group)
+		entry->group = generic_device_group(dev);
+
+	return entry->group;
+}
+
 static bool pci_iommuv2_capable(struct pci_dev *pdev)
 {
 	static const int caps[] = {
@@ -2311,6 +2334,14 @@ static void amd_iommu_remove_device(struct device *dev)
 	iommu_completion_wait(iommu);
 }
 
+static struct iommu_group *amd_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+
+	return acpihid_device_group(dev);
+}
+
 /*****************************************************************************
  *
  * The next functions belong to the dma_ops mapping/unmapping code.
@@ -3202,7 +3233,7 @@ static const struct iommu_ops amd_iommu_ops = {
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.add_device = amd_iommu_add_device,
 	.remove_device = amd_iommu_remove_device,
-	.device_group = pci_device_group,
+	.device_group = amd_iommu_device_group,
 	.get_dm_regions = amd_iommu_get_dm_regions,
 	.put_dm_regions = amd_iommu_put_dm_regions,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
-- 
1.9.1
