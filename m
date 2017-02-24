From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v11 06/10] perf/amd/iommu: Modify functions to query max banks
	and counters
Date: Fri, 24 Feb 2017 02:48:18 -0600
Message-ID: <1487926102-13073-7-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1487926102-13073-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1487926102-13073-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

Currently, amd_iommu_pc_get_max_[banks|counters]() use end-point
device ID to locate an IOMMU and check the reported max banks/counters.
The logic assumes that the IOMMU_BASE_DEVID belongs to the first IOMMU,
and uses it to acquire a reference to the first IOMMU, which does not work
on certain systems. Instead, modify the function to take an IOMMU index,
and use it to query the corresponding AMD IOMMU instance.

Currently, hardcodes the IOMMU index to 0 since the current AMD IOMMU
perf implementation only supports a single IOMMU. A subsequent
patch will add support for multiple IOMMUs, and will use a proper IOMMU index.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c     | 17 +++++++----------
 arch/x86/events/amd/iommu.h     |  9 ++++-----
 drivers/iommu/amd_iommu_init.c  | 34 ++++++++++++++++++++--------------
 drivers/iommu/amd_iommu_proto.h |  2 --
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index d4375da..10f67d3 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -239,14 +239,6 @@ static int perf_iommu_event_init(struct perf_event *event)
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
@@ -448,6 +440,11 @@ static __init int _init_perf_amd_iommu(
 		return ret;
 	}
 
+	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(0);
+	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
+	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
+		return -EINVAL;
+
 	perf_iommu->null_group = NULL;
 	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
 
@@ -457,8 +454,8 @@ static __init int _init_perf_amd_iommu(
 		amd_iommu_pc_exit();
 	} else {
 		pr_info("Detected AMD IOMMU (%d banks, %d counters/bank).\n",
-			amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID),
-			amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID));
+			amd_iommu_pc_get_max_banks(0),
+			amd_iommu_pc_get_max_counters(0));
 	}
 
 	return ret;
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index 5c5c932..b775107 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -24,19 +24,18 @@
 #define PC_MAX_SPEC_BNKS			64
 #define PC_MAX_SPEC_CNTRS			16
 
-/* iommu pc reg masks*/
-#define IOMMU_BASE_DEVID			0x0000
-
 /* amd_iommu_init.c external support functions */
 extern int amd_iommu_get_num_iommus(void);
 
 extern bool amd_iommu_pc_supported(void);
 
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
+extern u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
+extern u8 amd_iommu_pc_get_max_counters(unsigned int idx);
 
 extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
 			u8 fxn, u64 *value, bool is_write);
 
+extern struct amd_iommu *get_amd_iommu(int idx);
+
 #endif /*_PERF_EVENT_AMD_IOMMU_H_*/
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 17d7f44..d5ee17f2 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2715,6 +2715,18 @@ bool amd_iommu_v2_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
+struct amd_iommu *get_amd_iommu(unsigned int idx)
+{
+	unsigned int i = 0;
+	struct amd_iommu *iommu;
+
+	for_each_iommu(iommu)
+		if (i++ == idx)
+			return iommu;
+	return NULL;
+}
+EXPORT_SYMBOL(get_amd_iommu);
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
@@ -2722,17 +2734,14 @@ bool amd_iommu_v2_supported(void)
  *
  ****************************************************************************/
 
-u8 amd_iommu_pc_get_max_banks(u16 devid)
+u8 amd_iommu_pc_get_max_banks(unsigned int idx)
 {
-	struct amd_iommu *iommu;
-	u8 ret = 0;
+	struct amd_iommu *iommu = get_amd_iommu(idx);
 
-	/* locate the iommu governing the devid */
-	iommu = amd_iommu_rlookup_table[devid];
 	if (iommu)
-		ret = iommu->max_banks;
+		return iommu->max_banks;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_max_banks);
 
@@ -2742,17 +2751,14 @@ bool amd_iommu_pc_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_pc_supported);
 
-u8 amd_iommu_pc_get_max_counters(u16 devid)
+u8 amd_iommu_pc_get_max_counters(unsigned int idx)
 {
-	struct amd_iommu *iommu;
-	u8 ret = 0;
+	struct amd_iommu *iommu = get_amd_iommu(idx);
 
-	/* locate the iommu governing the devid */
-	iommu = amd_iommu_rlookup_table[devid];
 	if (iommu)
-		ret = iommu->max_counters;
+		return iommu->max_counters;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(amd_iommu_pc_get_max_counters);
 
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index e8f0710..cd2257e 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -59,8 +59,6 @@ extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 
 /* IOMMU Performance Counter functions */
 extern bool amd_iommu_pc_supported(void);
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
 extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 				    u64 *value, bool is_write);
 
-- 
1.8.3.1
