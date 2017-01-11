From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 2/7] perf/amd/iommu: Modify functions to query max
	banks and counters
Date: Wed, 11 Jan 2017 16:14:32 +0700
Message-ID: <97fc3f5b-acb4-1858-fd8f-5f06397e703d@amd.com>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1484019227-11473-3-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170110144340.GT17255@8bytes.org>
	<862635a0-a4fc-066e-0a45-e8626a02775c@amd.com>
	<1EEB747F-DD67-4BEC-9B07-F449520B3666@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1EEB747F-DD67-4BEC-9B07-F449520B3666-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Boris Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, amd_iommu_pc_get_max_[banks|counters]() use end-point
device ID to locate an IOMMU and check the reported max banks/counters.
The logic assumes that the IOMMU_BASE_DEVID belongs to the first IOMMU,
and uses it to acquire a reference to the first IOMMU, which does not work
on certain systems. Instead, we modify the function to take IOMMU index,
and use it to query the corresponded AMD IOMMU instance.

Note that we currently hard-code the IOMMU index to 0, since the current
AMD IOMMU perf implementation only supports single IOMMU. Subsequent patch
will add support for multi-IOMMU, and will use proper IOMMU index.

This patch also removes unnecessary function declaration in
amd_iommu_proto.h.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---

NOTE: This contains the fix in get_amd_iommu() as suggested by Joerg.

  arch/x86/events/amd/iommu.c     | 17 +++++++----------
  arch/x86/events/amd/iommu.h     |  7 ++-----
  drivers/iommu/amd_iommu_init.c  | 36 ++++++++++++++++++++++--------------
  drivers/iommu/amd_iommu_proto.h |  2 --
  4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index f387baf..cf94f48 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
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
@@ -456,6 +448,11 @@ static __init int _init_perf_amd_iommu(
  	if (_init_events_attrs(perf_iommu) != 0)
  		pr_err("perf: amd_iommu: Only support raw events.\n");

+	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
+	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
+	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
+		return -EINVAL;
+
  	/* Init null attributes */
  	perf_iommu->null_group = NULL;
  	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
@@ -466,8 +463,8 @@ static __init int _init_perf_amd_iommu(
  		amd_iommu_pc_exit();
  	} else {
  		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
-			amd_iommu_pc_get_max_banks(IOMMU_BASE_DEVID),
-			amd_iommu_pc_get_max_counters(IOMMU_BASE_DEVID));
+			amd_iommu_pc_get_max_banks(0),
+			amd_iommu_pc_get_max_counters(0));
  	}

  	return ret;
diff --git a/arch/x86/events/amd/iommu.h b/arch/x86/events/amd/iommu.h
index 845d173..432d867 100644
--- a/arch/x86/events/amd/iommu.h
+++ b/arch/x86/events/amd/iommu.h
@@ -24,15 +24,12 @@
  #define PC_MAX_SPEC_BNKS			64
  #define PC_MAX_SPEC_CNTRS			16

-/* iommu pc reg masks*/
-#define IOMMU_BASE_DEVID			0x0000
-
  /* amd_iommu_init.c external support functions */
  extern bool amd_iommu_pc_supported(void);

-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
+extern u8 amd_iommu_pc_get_max_banks(uint idx);

-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
+extern u8 amd_iommu_pc_get_max_counters(uint idx);

  extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr,
  			u8 fxn, u64 *value, bool is_write);
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 157e934..1a13c34 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2706,6 +2706,20 @@ bool amd_iommu_v2_supported(void)
  }
  EXPORT_SYMBOL(amd_iommu_v2_supported);

+static struct amd_iommu *get_amd_iommu(uint idx)
+{
+	uint i = 0;
+	struct amd_iommu *iommu, *ret = NULL;
+
+	for_each_iommu(iommu) {
+		if (i++ == idx) {
+			ret = iommu;
+			break;
+		}
+	}
+	return ret;
+}
+
  /****************************************************************************
   *
   * IOMMU EFR Performance Counter support functionality. This code allows
@@ -2713,17 +2727,14 @@ bool amd_iommu_v2_supported(void)
   *
   ****************************************************************************/

-u8 amd_iommu_pc_get_max_banks(u16 devid)
+u8 amd_iommu_pc_get_max_banks(uint idx)
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

@@ -2733,17 +2744,14 @@ bool amd_iommu_pc_supported(void)
  }
  EXPORT_SYMBOL(amd_iommu_pc_supported);

-u8 amd_iommu_pc_get_max_counters(u16 devid)
+u8 amd_iommu_pc_get_max_counters(uint idx)
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
index 7eb60c1..60f2eef 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -58,8 +58,6 @@ extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,

  /* IOMMU Performance Counter functions */
  extern bool amd_iommu_pc_supported(void);
-extern u8 amd_iommu_pc_get_max_banks(u16 devid);
-extern u8 amd_iommu_pc_get_max_counters(u16 devid);
  extern int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
  				    u64 *value, bool is_write);

-- 
1.8.3.1
