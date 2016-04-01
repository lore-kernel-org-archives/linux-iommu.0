From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V3 1/9] iommu/amd: Adding Extended Feature Register check for
	PC support
Date: Fri, 1 Apr 2016 09:05:57 -0400
Message-ID: <1459515965-2865-2-git-send-email-vincent.wan@amd.com>
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

The IVHD header type 11h and 40h introduce the PCSup bit in
the EFR Register Image bit fileds. This should be used to
determine the IOMMU performance support instead of relying
on the PNCounters and PNBanks.

Note also that the PNCouters and PNBanks bits in the IOMMU
attributes field of IVHD headers type 11h are incorrectly
programmed on some systems.

So, we should not rely on it to determine the performance
counter/banks size. Instead, these values should be read
from the MMIO Offset 0030h IOMMU Extended Feature Register.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index bf4959f..dff1e01 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -99,7 +99,11 @@ struct ivhd_header {
 	u64 mmio_phys;
 	u16 pci_seg;
 	u16 info;
-	u32 efr;
+	u32 efr_attr;
+
+	/* Following only valid on IVHD type 11h and 40h */
+	u64 efr_reg; /* Exact copy of MMIO_EXT_FEATURES */
+	u64 res;
 } __attribute__((packed));
 
 /*
@@ -1078,13 +1082,25 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	iommu->pci_seg = h->pci_seg;
 	iommu->mmio_phys = h->mmio_phys;
 
-	/* Check if IVHD EFR contains proper max banks/counters */
-	if ((h->efr != 0) &&
-	    ((h->efr & (0xF << 13)) != 0) &&
-	    ((h->efr & (0x3F << 17)) != 0)) {
-		iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
-	} else {
-		iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
+	switch (h->type) {
+	case 0x10:
+		/* Check if IVHD EFR contains proper max banks/counters */
+		if ((h->efr_attr != 0) &&
+		    ((h->efr_attr & (0xF << 13)) != 0) &&
+		    ((h->efr_attr & (0x3F << 17)) != 0))
+			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
+		else
+			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
+		break;
+	case 0x11:
+	case 0x40:
+		if (h->efr_reg & (1 << 9))
+			iommu->mmio_phys_end = MMIO_REG_END_OFFSET;
+		else
+			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	iommu->mmio_base = iommu_map_mmio_space(iommu->mmio_phys,
-- 
1.9.1
