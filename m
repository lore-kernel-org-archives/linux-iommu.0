From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/6] perf/amd/iommu: Modify functions to query max banks and
	counters
Date: Tue, 22 Dec 2015 13:19:13 -0600
Message-ID: <1450811957-1511-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1450811957-1511-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450811957-1511-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, amd_iommu_pc_get_max_[banks|counters]() require devid,
which should not be the case. Also, these don't properly support
multi-IOMMU system.

Current and future AMD systems with IOMMU that support perf counter
would likely contain homogeneous IOMMUs where multiple IOMMUs are
availalbe. So, this patch modifies these function to iterate all IOMMU
to check the max banks and counters reported by the hardware.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/kernel/cpu/perf_event_amd_iommu.c | 17 +++++++----------
 drivers/iommu/amd_iommu_init.c             | 20 ++++++++++++--------
 include/linux/perf/perf_event_amd_iommu.h  |  7 ++-----
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
index 1192f1d..e6d2485 100644
--- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
+++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
@@ -237,14 +237,6 @@ static int perf_iommu_event_init(struct perf_event *event)
 		return -EINVAL;
 	}
 
-	/* integrate with iommu base devid (0000), assume one iommu */
-	perf_iommu->max_banks =
-		amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID);
-	perf_iommu->max_counters =
-		amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID);
-	if ((perf_iommu->max_banks == 0) || (perf_iommu->max_counters == 0))
-		return -EINVAL;
-
 	/* update the hw_perf_event struct with the iommu config data */
 	hwc->config = config;
 	hwc->extra_reg.config = config1;
@@ -455,6 +447,11 @@ static __init int _init_perf_amd_iommu(
 	if (_init_events_attrs(perf_iommu) != 0)
 		pr_err("perf: amd_iommu: Only support raw events.\n");
 
+	perf_iommu->max_banks = amd_iommu_pc_get_max_banks();
+	perf_iommu->max_counters = amd_iommu_pc_get_max_counters();
+	if ((perf_iommu->max_banks == 0) || (perf_iommu->max_counters == 0))
+		return -EINVAL;
+
 	/* Init null attributes */
 	perf_iommu->null_group = NULL;
 	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
@@ -465,8 +462,8 @@ static __init int _init_perf_amd_iommu(
 		amd_iommu_pc_exit();
 	} else {
 		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
-			amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID),
-			amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID));
+			amd_iommu_pc_get_max_banks(),
+			amd_iommu_pc_get_max_counters());
 	}
 
 	return ret;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index b6d684c..275c0f5 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2251,15 +2251,17 @@ EXPORT_SYMBOL(amd_iommu_v2_supported);
  *
  ****************************************************************************/
 
-u8 amd_iommu_pc_get_max_banks(u16 devid)
+u8 amd_iommu_pc_get_max_banks(void)
 {
 	struct amd_iommu *iommu;
 	u8 ret = 0;
 
-	/* locate the iommu governing the devid */
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu)
+	for_each_iommu(iommu) {
+		if (!iommu->max_banks ||
+		    (ret && (iommu->max_banks != ret)))
+			return 0;
 		ret = iommu->max_banks;
+	}
 
 	return ret;
 }
@@ -2271,15 +2273,17 @@ bool amd_iommu_pc_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_pc_supported);
 
-u8 amd_iommu_pc_get_max_counters(u16 devid)
+u8 amd_iommu_pc_get_max_counters(void)
 {
 	struct amd_iommu *iommu;
 	u8 ret = 0;
 
-	/* locate the iommu governing the devid */
-	iommu = amd_iommu_rlookup_table[devid];
-	if (iommu)
+	for_each_iommu(iommu) {
+		if (!iommu->max_counters ||
+		    (ret && (iommu->max_counters != ret)))
+			return 0;
 		ret = iommu->max_counters;
+	}
 
 	return ret;
 }
diff --git a/include/linux/perf/perf_event_amd_iommu.h b/include/linux/perf/perf_event_amd_iommu.h
index 845d173..815eabb 100644
--- a/include/linux/perf/perf_event_amd_iommu.h
+++ b/include/linux/perf/perf_event_amd_iommu.h
@@ -24,15 +24,12 @@
 #define PC_MAX_SPEC_BNKS			64
 #define PC_MAX_SPEC_CNTRS			16
 
-/* iommu pc reg masks*/
-#define IOMMU_BASE_DEVID			0x0000
-
 /* amd_iommu_init.c external support functions */
 extern bool amd_iommu_pc_supported(void);
 
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
+extern u8 amd_iommu_pc_get_max_banks(void);
 
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
+extern u8 amd_iommu_pc_get_max_counters(void);
 
 extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
 			u8 fxn, u64 *value, bool is_write);
-- 
1.9.1
