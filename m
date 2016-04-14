From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V4 2/4] iommu/vt-d: use zero-sized array in DMAR related ACPI
	structures
Date: Thu, 14 Apr 2016 14:55:08 +0000
Message-ID: <1460645710-22656-3-git-send-email-richard.weiyang@gmail.com>
References: <1460645710-22656-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1460645710-22656-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

1. DMAR table has variable number of remapping entries
2. DMAR hardware unit has variable number of device scope
3. DMAR device scope has variable number of pci path
4. DMAR reserved memory has variable number device scope
5. DMAR ATS capability reporting structure has variable number device scope

In current implementation, we use (head + 1) to access these variable
number elements, which may not be obvious for audience. Zero-sized array is
usually used for this purpose.

This patch adds zero-sized array for variable elements in DMAR ACPI
structures, which tries to make the code more audience friendly.

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c        |   22 ++++++++++------------
 drivers/iommu/intel-iommu.c |    8 ++++----
 include/acpi/actbl2.h       |   33 +++++++++++++++++++--------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 80199b3..6bff602 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -225,7 +225,6 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 	int i, level;
 	struct device *tmp, *dev = &info->dev->dev;
 	struct acpi_dmar_device_scope *scope;
-	struct acpi_dmar_pci_path *path;
 
 	if (segment != info->seg)
 		return 0;
@@ -236,9 +235,8 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 		    scope->entry_type != ACPI_DMAR_SCOPE_TYPE_BRIDGE)
 			continue;
 
-		path = (struct acpi_dmar_pci_path *)(scope + 1);
-		level = (scope->length - sizeof(*scope)) / sizeof(*path);
-		if (!dmar_match_pci_path(info, scope->bus, path, level))
+		level = (scope->length - sizeof(*scope)) / sizeof(*scope->path);
+		if (!dmar_match_pci_path(info, scope->bus, scope->path, level))
 			continue;
 
 		if ((scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT) ^
@@ -393,7 +391,7 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	dmaru->reg_base_addr = drhd->address;
 	dmaru->segment = drhd->segment;
 	dmaru->include_all = drhd->flags & 0x1; /* BIT0: INCLUDE_ALL */
-	dmaru->devices = dmar_alloc_dev_scope((void *)(drhd + 1),
+	dmaru->devices = dmar_alloc_dev_scope(drhd->dev_scope,
 					      ((void *)drhd) + drhd->header.length,
 					      &dmaru->devices_cnt);
 	if (dmaru->devices_cnt && dmaru->devices == NULL) {
@@ -579,7 +577,7 @@ static int dmar_walk_remapping_entries(struct acpi_dmar_header *start,
 static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
 				       struct dmar_res_callback *cb)
 {
-	return dmar_walk_remapping_entries((void *)(dmar + 1),
+	return dmar_walk_remapping_entries(dmar->remapping_entries,
 			dmar->header.length - sizeof(*dmar), cb);
 }
 
@@ -685,12 +683,11 @@ static void __init dmar_acpi_insert_dev_scope(u8 device_number,
 	struct acpi_dmar_device_scope *scope;
 	struct device *tmp;
 	int i;
-	struct acpi_dmar_pci_path *path;
 
 	for_each_drhd_unit(dmaru) {
 		drhd = dmaru->drhd;
 
-		for (scope = (void *)(drhd + 1);
+		for (scope = drhd->dev_scope;
 		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
 		     scope = ((void *)scope) + scope->length) {
 			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
@@ -698,15 +695,16 @@ static void __init dmar_acpi_insert_dev_scope(u8 device_number,
 			if (scope->enumeration_id != device_number)
 				continue;
 
-			path = (void *)(scope + 1);
 			pr_info("ACPI device \"%s\" under DMAR at %llx as %02x:%02x.%d\n",
 				dev_name(&adev->dev), dmaru->reg_base_addr,
-				scope->bus, path->device, path->function);
+				scope->bus, scope->path->device,
+				scope->path->function);
 			for_each_dev_scope(dmaru->devices, dmaru->devices_cnt, i, tmp)
 				if (tmp == NULL) {
 					dmaru->devices[i].bus = scope->bus;
-					dmaru->devices[i].devfn = PCI_DEVFN(path->device,
-									    path->function);
+					dmaru->devices[i].devfn =
+					  PCI_DEVFN(scope->path->device,
+						    scope->path->function);
 					rcu_assign_pointer(dmaru->devices[i].dev,
 							   get_device(&adev->dev));
 					return;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ab03f79..e3061d3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4071,7 +4071,7 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
 	rmrru->base_address = rmrr->base_address;
 	rmrru->end_address = rmrr->end_address;
-	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
+	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr->dev_scope),
 				((void *)rmrr) + rmrr->header.length,
 				&rmrru->devices_cnt);
 	if (rmrru->devices_cnt && rmrru->devices == NULL) {
@@ -4127,7 +4127,7 @@ int dmar_parse_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 	memcpy(atsru->atsr, hdr, hdr->length);
 	atsru->include_all = atsr->flags & 0x1;
 	if (!atsru->include_all) {
-		atsru->devices = dmar_alloc_dev_scope((void *)(atsr + 1),
+		atsru->devices = dmar_alloc_dev_scope((void *)(atsr->dev_scope),
 				(void *)atsr + atsr->header.length,
 				&atsru->devices_cnt);
 		if (atsru->devices_cnt && atsru->devices == NULL) {
@@ -4361,7 +4361,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 		rmrr = container_of(rmrru->hdr,
 				    struct acpi_dmar_reserved_memory, header);
 		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
-			ret = dmar_insert_dev_scope(info, (void *)(rmrr + 1),
+			ret = dmar_insert_dev_scope(info, (void *)(rmrr->dev_scope),
 				((void *)rmrr) + rmrr->header.length,
 				rmrr->segment, rmrru->devices,
 				rmrru->devices_cnt);
@@ -4379,7 +4379,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 
 		atsr = atsru->atsr;
 		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
-			ret = dmar_insert_dev_scope(info, (void *)(atsr + 1),
+			ret = dmar_insert_dev_scope(info, (void *)(atsr->dev_scope),
 					(void *)atsr + atsr->header.length,
 					atsr->segment, atsru->devices,
 					atsru->devices_cnt);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 6e28f54..e03df1d 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -403,17 +403,6 @@ struct acpi_table_dbgp {
  *
  ******************************************************************************/
 
-struct acpi_table_dmar {
-	struct acpi_table_header header;	/* Common ACPI table header */
-	u8 width;		/* Host Address Width */
-	u8 flags;
-	u8 reserved[10];
-};
-
-/* Masks for Flags field above */
-
-#define ACPI_DMAR_INTR_REMAP        (1)
-
 /* DMAR subtable header */
 
 struct acpi_dmar_header {
@@ -434,12 +423,18 @@ enum acpi_dmar_type {
 
 /* DMAR Device Scope structure */
 
+struct acpi_dmar_pci_path {
+	u8 device;
+	u8 function;
+};
+
 struct acpi_dmar_device_scope {
 	u8 entry_type;
 	u8 length;
 	u16 reserved;
 	u8 enumeration_id;
 	u8 bus;
+	struct acpi_dmar_pci_path path[0];
 };
 
 /* Values for entry_type in struct acpi_dmar_device_scope - device types */
@@ -454,11 +449,18 @@ enum acpi_dmar_scope_type {
 	ACPI_DMAR_SCOPE_TYPE_RESERVED = 6	/* 6 and greater are reserved */
 };
 
-struct acpi_dmar_pci_path {
-	u8 device;
-	u8 function;
+struct acpi_table_dmar {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u8 width;		/* Host Address Width */
+	u8 flags;
+	u8 reserved[10];
+	struct acpi_dmar_header remapping_entries[0];
 };
 
+/* Masks for Flags field above */
+
+#define ACPI_DMAR_INTR_REMAP        (1)
+
 /*
  * DMAR Subtables, correspond to Type in struct acpi_dmar_header
  */
@@ -471,6 +473,7 @@ struct acpi_dmar_hardware_unit {
 	u8 reserved;
 	u16 segment;
 	u64 address;		/* Register Base Address */
+	struct acpi_dmar_device_scope dev_scope[0];
 };
 
 /* Masks for Flags field above */
@@ -485,6 +488,7 @@ struct acpi_dmar_reserved_memory {
 	u16 segment;
 	u64 base_address;	/* 4K aligned base address */
 	u64 end_address;	/* 4K aligned limit address */
+	struct acpi_dmar_device_scope dev_scope[0];
 };
 
 /* Masks for Flags field above */
@@ -498,6 +502,7 @@ struct acpi_dmar_atsr {
 	u8 flags;
 	u8 reserved;
 	u16 segment;
+	struct acpi_dmar_device_scope dev_scope[0];
 };
 
 /* Masks for Flags field above */
-- 
1.7.9.5
