From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 05/33] iommu/vt-d: Add ACPI devices into dmaru->devices[] array
Date: Fri, 21 Mar 2014 17:18:46 +0000
Message-ID: <1395422354-19762-6-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 34d271e..382f63d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -612,6 +612,79 @@ out:
 	return dmaru;
 }
 
+static void __init dmar_acpi_insert_dev_scope(u8 device_number,
+					      struct acpi_device *adev)
+{
+	struct dmar_drhd_unit *dmaru;
+	struct acpi_dmar_hardware_unit *drhd;
+	struct acpi_dmar_device_scope *scope;
+	struct device *tmp;
+	int i;
+	struct acpi_dmar_pci_path *path;
+
+	for_each_drhd_unit(dmaru) {
+		drhd = container_of(dmaru->hdr,
+				    struct acpi_dmar_hardware_unit,
+				    header);
+
+		for (scope = (void *)(drhd + 1);
+		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
+		     scope = ((void *)scope) + scope->length) {
+			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_ACPI)
+				continue;
+			if (scope->enumeration_id != device_number)
+				continue;
+
+			path = (void *)(scope + 1);
+			pr_info("ACPI device \"%s\" under DMAR at %llx as %02x:%02x.%d\n",
+				dev_name(&adev->dev), dmaru->reg_base_addr,
+				scope->bus, path->device, path->function);
+			for_each_dev_scope(dmaru->devices, dmaru->devices_cnt, i, tmp)
+				if (tmp == NULL) {
+					dmaru->devices[i].bus = scope->bus;
+					dmaru->devices[i].devfn = PCI_DEVFN(path->device,
+									    path->function);
+					rcu_assign_pointer(dmaru->devices[i].dev,
+							   get_device(&adev->dev));
+					return;
+				}
+			BUG_ON(i >= dmaru->devices_cnt);
+		}
+	}
+	pr_warn("No IOMMU scope found for ANDD enumeration ID %d (%s)\n",
+		device_number, dev_name(&adev->dev));
+}
+
+static int __init dmar_acpi_dev_scope_init(void)
+{
+	struct acpi_dmar_andd *andd = (void *)dmar_tbl + sizeof(struct acpi_table_dmar);
+
+	while (((unsigned long)andd) <
+	       ((unsigned long)dmar_tbl) + dmar_tbl->length) {
+		if (andd->header.type == ACPI_DMAR_TYPE_ANDD) {
+			acpi_handle h;
+			struct acpi_device *adev;
+
+			if (!ACPI_SUCCESS(acpi_get_handle(ACPI_ROOT_OBJECT,
+							  andd->object_name,
+							  &h))) {
+				pr_err("Failed to find handle for ACPI object %s\n",
+				       andd->object_name);
+				continue;
+			}
+			acpi_bus_get_device(h, &adev);
+			if (!adev) {
+				pr_err("Failed to get device for ACPI object %s\n",
+				       andd->object_name);
+				continue;
+			}
+			dmar_acpi_insert_dev_scope(andd->device_number, adev);
+		}
+		andd = ((void *)andd) + andd->header.length;
+	}
+	return 0;
+}
+
 int __init dmar_dev_scope_init(void)
 {
 	struct pci_dev *dev = NULL;
@@ -620,6 +693,8 @@ int __init dmar_dev_scope_init(void)
 	if (dmar_dev_scope_status != 1)
 		return dmar_dev_scope_status;
 
+	dmar_acpi_dev_scope_init();
+
 	if (list_empty(&dmar_drhd_units)) {
 		dmar_dev_scope_status = -ENODEV;
 	} else {
-- 
1.8.5.3
