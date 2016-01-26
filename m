From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2 2/8] iommu/amd: Use the most comprehensive IVHD type that
	the driver can support
Date: Tue, 26 Jan 2016 18:14:31 -0500
Message-ID: <1453850077-2539-3-git-send-email-vincent.wan@amd.com>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

The IVRS in more recent AMD system usually contains multiple
IVHD block types (e.g. 0x10, 0x11, and 0x40) for each IOMMU.
The newer IVHD types provide more information (e.g. new features
specified in the IOMMU spec), while maintain compatibility with
the older IVHD type.

Having multiple IVHD type allows older IOMMU drivers to still function
(e.g. using the older IVHD type 0x10) while the newer IOMMU driver can use
the newer IVHD types (e.g. 0x11 and 0x40). Therefore, the IOMMU driver
should only make use of the newest IVHD type that it can support.

This patch adds new logic to determine the highest level of IVHD type
it can support, and use it throughout the to initialize the driver.
This requires adding another pass to the IVRS parsing to determine
appropriate IVHD type (see function get_highest_supported_ivhd_type())
before parsing the contents.

[Vincent: fix the build error of IVHD_DEV_ACPI_HID flag not found]

Signed-off-by: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 107 ++++++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 2ff7000..146f3ee 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -44,7 +44,7 @@
  */
 #define IVRS_HEADER_LENGTH 48
 
-#define ACPI_IVHD_TYPE                  0x10
+#define ACPI_IVHD_TYPE_MAX_SUPPORTED	0x40
 #define ACPI_IVMD_TYPE_ALL              0x20
 #define ACPI_IVMD_TYPE                  0x21
 #define ACPI_IVMD_TYPE_RANGE            0x22
@@ -58,6 +58,7 @@
 #define IVHD_DEV_EXT_SELECT             0x46
 #define IVHD_DEV_EXT_SELECT_RANGE       0x47
 #define IVHD_DEV_SPECIAL		0x48
+#define IVHD_DEV_ACPI_HID		0xf0
 
 #define IVHD_SPECIAL_IOAPIC		1
 #define IVHD_SPECIAL_HPET		2
@@ -137,6 +138,7 @@ bool amd_iommu_irq_remap __read_mostly;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
+static int amd_iommu_target_ivhd_type;
 
 u16 amd_iommu_last_bdf;			/* largest PCI device id we have
 					   to handle */
@@ -424,7 +426,15 @@ static inline u32 get_ivhd_header_size(struct ivhd_header *h)
  */
 static inline int ivhd_entry_length(u8 *ivhd)
 {
-	return 0x04 << (*ivhd >> 6);
+	u32 type = ((struct ivhd_entry *)ivhd)->type;
+
+	if (type < 0x80) {
+		return 0x04 << (*ivhd >> 6);
+	} else if (type == IVHD_DEV_ACPI_HID) {
+		/* For ACPI_HID, offset 21 is uid len */
+		return *((u8 *)ivhd + 21) + 22;
+	}
+	return 0;
 }
 
 /*
@@ -470,6 +480,22 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 	return 0;
 }
 
+static int __init check_ivrs_checksum(struct acpi_table_header *table)
+{
+	int i;
+	u8 checksum = 0, *p = (u8 *)table;
+
+	for (i = 0; i < table->length; ++i)
+		checksum += p[i];
+	if (checksum != 0) {
+		/* ACPI table corrupt */
+		pr_err(FW_BUG "AMD-Vi: IVRS invalid checksum\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 /*
  * Iterate over all IVHD entries in the ACPI table and find the highest device
  * id which we need to handle. This is the first of three functions which parse
@@ -477,31 +503,19 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
  */
 static int __init find_last_devid_acpi(struct acpi_table_header *table)
 {
-	int i;
-	u8 checksum = 0, *p = (u8 *)table, *end = (u8 *)table;
+	u8 *p = (u8 *)table, *end = (u8 *)table;
 	struct ivhd_header *h;
 
-	/*
-	 * Validate checksum here so we don't need to do it when
-	 * we actually parse the table
-	 */
-	for (i = 0; i < table->length; ++i)
-		checksum += p[i];
-	if (checksum != 0)
-		/* ACPI table corrupt */
-		return -ENODEV;
-
 	p += IVRS_HEADER_LENGTH;
 
 	end += table->length;
 	while (p < end) {
 		h = (struct ivhd_header *)p;
-		switch (h->type) {
-		case ACPI_IVHD_TYPE:
-			find_last_devid_from_ivhd(h);
-			break;
-		default:
-			break;
+		if (h->type == amd_iommu_target_ivhd_type) {
+			int ret = find_last_devid_from_ivhd(h);
+
+			if (ret)
+				return ret;
 		}
 		p += h->length;
 	}
@@ -1118,6 +1132,32 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	return 0;
 }
 
+/**
+ * get_highest_supported_ivhd_type - Look up the appropriate IVHD type
+ * @ivrs          Pointer to the IVRS header
+ *
+ * This function search through all IVDB of the maximum supported IVHD
+ */
+static u8 get_highest_supported_ivhd_type(struct acpi_table_header *ivrs)
+{
+	u8 *base = (u8 *)ivrs;
+	struct ivhd_header *ivhd = (struct ivhd_header *)
+					(base + IVRS_HEADER_LENGTH);
+	u8 last_type = ivhd->type;
+	u16 devid = ivhd->devid;
+
+	while (((u8 *)ivhd - base < ivrs->length) &&
+	       (ivhd->type <= ACPI_IVHD_TYPE_MAX_SUPPORTED)) {
+		u8 *p = (u8 *) ivhd;
+
+		if (ivhd->devid == devid)
+			last_type = ivhd->type;
+		ivhd = (struct ivhd_header *)(p + ivhd->length);
+	}
+
+	return last_type;
+}
+
 /*
  * Iterates over all IOMMU entries in the ACPI table, allocates the
  * IOMMU structure and initializes it with init_iommu_one()
@@ -1134,8 +1174,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 
 	while (p < end) {
 		h = (struct ivhd_header *)p;
-		switch (*p) {
-		case ACPI_IVHD_TYPE:
+		if (*p == amd_iommu_target_ivhd_type) {
 
 			DUMP_printk("device: %02x:%02x.%01x cap: %04x "
 				    "seg: %d flags: %01x info %04x\n",
@@ -1152,9 +1191,6 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 			ret = init_iommu_one(iommu, h);
 			if (ret)
 				return ret;
-			break;
-		default:
-			break;
 		}
 		p += h->length;
 
@@ -1818,18 +1854,20 @@ static void __init free_dma_resources(void)
  * remapping setup code.
  *
  * This function basically parses the ACPI table for AMD IOMMU (IVRS)
- * three times:
+ * four times:
  *
- *	1 pass) Find the highest PCI device id the driver has to handle.
+ *	1 pass) Discover the most comprehensive IVHD type to use.
+ *
+ *	2 pass) Find the highest PCI device id the driver has to handle.
  *		Upon this information the size of the data structures is
  *		determined that needs to be allocated.
  *
- *	2 pass) Initialize the data structures just allocated with the
+ *	3 pass) Initialize the data structures just allocated with the
  *		information in the ACPI table about available AMD IOMMUs
  *		in the system. It also maps the PCI devices in the
  *		system to specific IOMMUs
  *
- *	3 pass) After the basic data structures are allocated and
+ *	4 pass) After the basic data structures are allocated and
  *		initialized we update them with information about memory
  *		remapping requirements parsed out of the ACPI table in
  *		this last pass.
@@ -1857,6 +1895,17 @@ static int __init early_amd_iommu_init(void)
 	}
 
 	/*
+	 * Validate checksum here so we don't need to do it when
+	 * we actually parse the table
+	 */
+	ret = check_ivrs_checksum(ivrs_base);
+	if (ret)
+		return ret;
+
+	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
+	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
+
+	/*
 	 * First parse ACPI tables to find the largest Bus/Dev/Func
 	 * we need to handle. Upon this information the shared data
 	 * structures for the IOMMUs in the system will be allocated
-- 
1.9.1
