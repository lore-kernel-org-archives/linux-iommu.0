From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V3 2/9] iommu/amd: Modify ivhd_header structure to support
	type 11h and 40h
Date: Fri, 1 Apr 2016 09:05:58 -0400
Message-ID: <1459515965-2865-3-git-send-email-vincent.wan@amd.com>
References: <1459515965-2865-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1459515965-2865-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>

This patch modifies the existing struct ivhd_header,
which currently only support IVHD type 0x10, to add
new fields from IVHD type 11h and 40h.

It also modifies the pointer calculation to allow
support for IVHD type 11h and 40h

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index dff1e01..22e078b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -398,6 +398,22 @@ static void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
 	release_mem_region(iommu->mmio_phys, iommu->mmio_phys_end);
 }
 
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
 /****************************************************************************
  *
  * The functions below belong to the first pass of AMD IOMMU ACPI table
@@ -424,7 +440,14 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 	u8 *p = (void *)h, *end = (void *)h;
 	struct ivhd_entry *dev;
 
-	p += sizeof(*h);
+	u32 ivhd_size = get_ivhd_header_size(h);
+
+	if (!ivhd_size) {
+		pr_err("AMD-Vi: Unsupported IVHD type %#x\n", h->type);
+		return -EINVAL;
+	}
+
+	p += ivhd_size;
 	end += h->length;
 
 	while (p < end) {
@@ -789,6 +812,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
+	u32 ivhd_size;
 	int ret;
 
 
@@ -804,7 +828,14 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
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
+
 	end += h->length;
 
 
-- 
1.9.1
