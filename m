From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v12 04/10] iommu/amd: Clean up iommu_pc_get_set_reg()
Date: Wed, 22 Mar 2017 02:02:36 -0500
Message-ID: <1490166162-10002-5-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1490166162-10002-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490166162-10002-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

Clean up coding style and fix a bug in the 64-bit register read
logic since it overwrites the upper 32-bit when reading the lower 32-bit.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6130278..ce65a47 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2763,22 +2763,25 @@ static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
 	if (WARN_ON((fxn > 0x28) || (fxn & 7)))
 		return -ENODEV;
 
-	offset = (u32)(((0x40|bank) << 12) | (cntr << 8) | fxn);
+	offset = (u32)(((0x40 | bank) << 12) | (cntr << 8) | fxn);
 
 	/* Limit the offset to the hw defined mmio region aperture */
-	max_offset_lim = (u32)(((0x40|iommu->max_banks) << 12) |
+	max_offset_lim = (u32)(((0x40 | iommu->max_banks) << 12) |
 				(iommu->max_counters << 8) | 0x28);
 	if ((offset < MMIO_CNTR_REG_OFFSET) ||
 	    (offset > max_offset_lim))
 		return -EINVAL;
 
 	if (is_write) {
-		writel((u32)*value, iommu->mmio_base + offset);
-		writel((*value >> 32), iommu->mmio_base + offset + 4);
+		u64 val = *value & GENMASK_ULL(47, 0);
+
+		writel((u32)val, iommu->mmio_base + offset);
+		writel((val >> 32), iommu->mmio_base + offset + 4);
 	} else {
 		*value = readl(iommu->mmio_base + offset + 4);
 		*value <<= 32;
-		*value = readl(iommu->mmio_base + offset);
+		*value |= readl(iommu->mmio_base + offset);
+		*value &= GENMASK_ULL(47, 0);
 	}
 
 	return 0;
-- 
1.8.3.1
