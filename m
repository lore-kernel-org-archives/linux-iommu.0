From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2 1/8] iommu/amd: Modify ivhd_header structure to support
	type 11h and 40h
Date: Tue, 26 Jan 2016 18:14:30 -0500
Message-ID: <1453850077-2539-2-git-send-email-vincent.wan@amd.com>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

This patch modifies the existing struct ivhd_header, which currently
only support IVHD type 0x10, to add new fields from IVHD type 11h and 40h.
It also modifies the pointer calculation to allow support for IVHD type
11h and 40h

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 47 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdff..2ff7000 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -88,7 +88,7 @@
 
 /*
  * structure describing one IOMMU in the ACPI table. Typically followed by one
- * or more ivhd_entrys.
+ * or more ivhd_entrys. This struct supports both IVHD type 10h, 11h and 40h.
  */
 struct ivhd_header {
 	u8 type;
@@ -99,7 +99,11 @@ struct ivhd_header {
 	u64 mmio_phys;
 	u16 pci_seg;
 	u16 info;
-	u32 efr;
+	u32 efr_attr;
+
+	/* Following only valid on IVHD type 11h and 40h */
+	u64 efr_reg_img; /* Exact copy of MMIO_EXT_FEATURES */
+	u64 res;
 } __attribute__((packed));
 
 /*
@@ -399,6 +403,22 @@ static void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
  *
  ****************************************************************************/
 
+static inline u32 get_ivhd_header_size(struct ivhd_header *h)
+{
+	u32 size = 0;
+
+	switch (h->type) {
+	case 0x10:
+		size = 24;
+		break;
+	case 0x11:
+	case 0x40:
+		size = 40;
+		break;
+	}
+	return size;
+}
+
 /*
  * This function calculates the length of a given IVHD entry
  */
@@ -415,8 +435,14 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 {
 	u8 *p = (void *)h, *end = (void *)h;
 	struct ivhd_entry *dev;
+	u32 ivhd_size = get_ivhd_header_size(h);
+
+	if (!ivhd_size) {
+		pr_err("AMD-Vi: Unsupported IVHD type %#x\n", h->type);
+		return -EINVAL;
+	}
 
-	p += sizeof(*h);
+	p += ivhd_size;
 	end += h->length;
 
 	while (p < end) {
@@ -781,6 +807,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
+	u32 ivhd_size;
 	int ret;
 
 
@@ -796,7 +823,13 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	/*
 	 * Done. Now parse the device entries
 	 */
-	p += sizeof(struct ivhd_header);
+	ivhd_size = get_ivhd_header_size(h);
+	if (!ivhd_size) {
+		pr_err("AMD-Vi: Unsupported IVHD type %#x\n", h->type);
+		return -EINVAL;
+	}
+
+	p += ivhd_size;
 	end += h->length;
 
 
@@ -1047,9 +1080,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	iommu->mmio_phys = h->mmio_phys;
 
 	/* Check if IVHD EFR contains proper max banks/counters */
-	if ((h->efr != 0) &&
-	    ((h->efr & (0xF << 13)) != 0) &&
-	    ((h->efr & (0x3F << 17)) != 0)) {
+	if ((h->efr_attr != 0) &&
+	    ((h->efr_attr & (0xF << 13)) != 0) &&
+	    ((h->efr_attr & (0x3F << 17)) != 0)) {
 		iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
 	} else {
 		iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
-- 
1.9.1
