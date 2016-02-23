From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/amd: Fix boot warning when device 00:00.0 is not iommu
Date: Tue, 23 Feb 2016 13:12:15 +0100
Message-ID: <20160223121215.GA31151@8bytes.org>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160223110406.GA22747@8bytes.org> <56CC422E.7050905@amd.com>
	<56CC44D8.4080604@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56CC44D8.4080604-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 23, 2016 at 06:39:04PM +0700, Suravee Suthikulpanit wrote:
> Actually, my V5 is rebased from tips which has moved several files.
> I think we might need to create a separate patch series to fix this
> issue in older kernels. Which branch should I rebase my changes for
> the older kernel?

The fix is iommu-code only. Based on your patches, I extracted this
smaller patch, which only fixes the issue. Does it look good to you? If
you are okay with it I am going to queue it asap into my iommu/fixes
branch and send it upstream.


	Joerg

>From b91309eedd77374fdecc379942c44f903e2dedff Mon Sep 17 00:00:00 2001
From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 23 Feb 2016 13:03:30 +0100
Subject: [PATCH] iommu/amd: Fix boot warning when device 00:00.0 is not iommu
 covered

The setup code for the performance counters in the AMD IOMMU driver
tests whether the counters can be written. It tests to setup a counter
for device 00:00.0, which fails on systems where this particular device
is not covered by the IOMMU.

Fix this by not relying on device 00:00.0 but only on the IOMMU being
present.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdff..d06a6d9 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -228,6 +228,10 @@ static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
+static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
+				    u8 bank, u8 cntr, u8 fxn,
+				    u64 *value, bool is_write);
+
 static inline void update_last_devid(u16 devid)
 {
 	if (devid > amd_iommu_last_bdf)
@@ -1142,8 +1146,8 @@ static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 	amd_iommu_pc_present = true;
 
 	/* Check if the performance counters can be written to */
-	if ((0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val, true)) ||
-	    (0 != amd_iommu_pc_get_set_reg_val(0, 0, 0, 0, &val2, false)) ||
+	if ((0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val, true)) ||
+	    (0 != iommu_pc_get_set_reg_val(iommu, 0, 0, 0, &val2, false)) ||
 	    (val != val2)) {
 		pr_err("AMD-Vi: Unable to write to IOMMU perf counter.\n");
 		amd_iommu_pc_present = false;
@@ -2283,22 +2287,15 @@ u8 amd_iommu_pc_get_max_counters(u16 devid)
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
 
-int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
+static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
+				    u8 bank, u8 cntr, u8 fxn,
 				    u64 *value, bool is_write)
 {
-	struct amd_iommu *iommu;
 	u32 offset;
 	u32 max_offset_lim;
 
-	/* Make sure the IOMMU PC resource is available */
-	if (!amd_iommu_pc_present)
-		return -ENODEV;
-
-	/* Locate the iommu associated with the device ID */
-	iommu = amd_iommu_rlookup_table[devid];
-
 	/* Check for valid iommu and pc register indexing */
-	if (WARN_ON((iommu == NULL) || (fxn > 0x28) || (fxn & 7)))
+	if (WARN_ON((fxn > 0x28) || (fxn & 7)))
 		return -ENODEV;
 
 	offset = (u32)(((0x40|bank) << 12) | (cntr << 8) | fxn);
@@ -2322,3 +2319,16 @@ int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 	return 0;
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_set_reg_val);
+
+int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
+				    u64 *value, bool is_write)
+{
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+	/* Make sure the IOMMU PC resource is available */
+	if (!amd_iommu_pc_present || iommu == NULL)
+		return -ENODEV;
+
+	return iommu_pc_get_set_reg_val(iommu, bank, cntr, fxn,
+					value, is_write);
+}
-- 
1.8.4.5
