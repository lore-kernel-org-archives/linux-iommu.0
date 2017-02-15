From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v10 9/9] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Wed, 15 Feb 2017 14:56:25 -0600
Message-ID: <1487192185-31272-10-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1487192185-31272-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1487192185-31272-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

Add multi-IOMMU support for perf by exposing an AMD IOMMU PMU
for each IOMMU found in the system via:

  /bus/event_source/devices/amd_iommu_x

where x is the IOMMU index. This allows users to specify
different events to be programmed onto performance counters
of each IOMMU.

Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 129 ++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 7bbf405..cc1d2eb 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -35,16 +35,21 @@
 #define _GET_PASID_MASK(ev) ((ev->hw.extra_reg.config >> 16) & 0xFFFFULL)
 #define _GET_DOMID_MASK(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFULL)
 
-static struct perf_amd_iommu __perf_iommu;
+#define PERF_AMD_IOMMU_NAME_SIZE	16
 
 struct perf_amd_iommu {
+	struct list_head list;
 	struct pmu pmu;
+	struct amd_iommu *iommu;
+	char name[PERF_AMD_IOMMU_NAME_SIZE];
 	u8 max_banks;
 	u8 max_counters;
 	u64 cntr_assign_mask;
 	raw_spinlock_t lock;
 };
 
+static LIST_HEAD(perf_amd_iommu_list);
+
 /*---------------------------------------------
  * sysfs format attributes
  *---------------------------------------------*/
@@ -202,8 +207,6 @@ static int clear_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu,
 static int perf_iommu_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_amd_iommu *perf_iommu;
-	u64 config, config1;
 
 	/* test the event attr type check for PMU enumeration */
 	if (event->attr.type != event->pmu->type)
@@ -225,28 +228,21 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	perf_iommu = &__perf_iommu;
-
-	if (event->pmu != &perf_iommu->pmu)
-		return -ENOENT;
-
-	if (perf_iommu) {
-		config = event->attr.config;
-		config1 = event->attr.config1;
-	} else {
-		return -EINVAL;
-	}
-
 	/* update the hw_perf_event struct with the iommu config data */
-	hwc->config = config;
-	hwc->extra_reg.config = config1;
+	hwc->config           = event->attr.config;
+	hwc->extra_reg.config = event->attr.config1;
 
 	return 0;
 }
 
+static inline struct amd_iommu *perf_event_2_iommu(struct perf_event *ev)
+{
+	return (container_of(ev->pmu, struct perf_amd_iommu, pmu))->iommu;
+}
+
 static void perf_iommu_enable_event(struct perf_event *ev)
 {
-	struct amd_iommu *iommu = get_amd_iommu(0);
+	struct amd_iommu *iommu = perf_event_2_iommu(ev);
 	u8 csource = _GET_CSOURCE(ev);
 	u16 devid = _GET_DEVID(ev);
 	u8 bank = _GET_BANK(ev);
@@ -274,7 +270,7 @@ static void perf_iommu_enable_event(struct perf_event *ev)
 
 static void perf_iommu_disable_event(struct perf_event *event)
 {
-	struct amd_iommu *iommu = get_amd_iommu(0);
+	struct amd_iommu *iommu = perf_event_2_iommu(event);
 	u64 reg = 0ULL;
 
 	amd_iommu_pc_set_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
@@ -284,7 +280,7 @@ static void perf_iommu_disable_event(struct perf_event *event)
 static void perf_iommu_start(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct amd_iommu *iommu = get_amd_iommu(0);
+	struct amd_iommu *iommu = perf_event_2_iommu(event);
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -307,7 +303,7 @@ static void perf_iommu_read(struct perf_event *event)
 {
 	u64 count, prev, delta;
 	struct hw_perf_event *hwc = &event->hw;
-	struct amd_iommu *iommu = get_amd_iommu(0);
+	struct amd_iommu *iommu = perf_event_2_iommu(event);
 
 	if (amd_iommu_pc_get_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
 				 IOMMU_PC_COUNTER_REG, &count))
@@ -401,11 +397,6 @@ static __init int _init_events_attrs(void)
 	return 0;
 }
 
-static __init void amd_iommu_pc_exit(void)
-{
-	kfree(amd_iommu_events_group.attrs);
-}
-
 const struct attribute_group *amd_iommu_attr_groups[] = {
 	&amd_iommu_format_group,
 	&amd_iommu_cpumask_group,
@@ -413,47 +404,56 @@ static __init void amd_iommu_pc_exit(void)
 	NULL,
 };
 
+static struct pmu iommu_pmu = {
+	.event_init	= perf_iommu_event_init,
+	.add		= perf_iommu_add,
+	.del		= perf_iommu_del,
+	.start		= perf_iommu_start,
+	.stop		= perf_iommu_stop,
+	.read		= perf_iommu_read,
+	.task_ctx_nr	= perf_invalid_context,
+	.attr_groups	= amd_iommu_attr_groups,
+};
+
 static __init int
-_init_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, char *name)
+init_one_iommu(unsigned int idx)
 {
 	int ret;
+	struct perf_amd_iommu *perf_iommu;
 
-	raw_spin_lock_init(&perf_iommu->lock);
+	perf_iommu = kzalloc(sizeof(struct perf_amd_iommu), GFP_KERNEL);
+	if (!perf_iommu)
+		return -ENOMEM;
 
-	/* Init cpumask attributes to only core 0 */
-	cpumask_set_cpu(0, &iommu_cpumask);
+	raw_spin_lock_init(&perf_iommu->lock);
 
-	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(0);
-	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
-	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
+	perf_iommu->pmu          = iommu_pmu;
+	perf_iommu->iommu        = get_amd_iommu(idx);
+	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(idx);
+	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(idx);
+	if (!perf_iommu->iommu || !perf_iommu->max_banks ||
+	    !perf_iommu->max_counters) {
+		kfree(perf_iommu);
 		return -EINVAL;
+	}
 
-	perf_iommu->pmu.attr_groups = amd_iommu_attr_groups;
-	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
-	if (ret)
-		pr_err("Error initializing AMD IOMMU perf counters.\n");
-	else
-		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
-			amd_iommu_pc_get_max_banks(0),
-			amd_iommu_pc_get_max_counters(0));
+	snprintf(perf_iommu->name, PERF_AMD_IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
+	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
+	if (!ret) {
+		pr_info("Detected AMD IOMMU #%d (%d banks, %d counters/bank)\n",
+			idx, perf_iommu->max_banks, perf_iommu->max_counters);
+		list_add_tail(&perf_iommu->list, &perf_amd_iommu_list);
+	} else {
+		pr_warn("Error initializing IOMMU %d.\n", idx);
+		kfree(perf_iommu);
+	}
 	return ret;
 }
 
-static struct perf_amd_iommu __perf_iommu = {
-	.pmu = {
-		.task_ctx_nr    = perf_invalid_context,
-		.event_init	= perf_iommu_event_init,
-		.add		= perf_iommu_add,
-		.del		= perf_iommu_del,
-		.start		= perf_iommu_start,
-		.stop		= perf_iommu_stop,
-		.read		= perf_iommu_read,
-	},
-};
-
 static __init int amd_iommu_pc_init(void)
 {
 	int ret;
+	unsigned int i, cnt = 0;
 
 	/* Make sure the IOMMU PC resource is available */
 	if (!amd_iommu_pc_supported())
@@ -463,11 +463,26 @@ static __init int amd_iommu_pc_init(void)
 	if (ret)
 		return ret;
 
-	ret = _init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
-	if (ret)
-		amd_iommu_pc_exit();
+	/*
+	 * An IOMMU PMU is specific to each IOMMU, and can
+	 * function independently. So, we go through all IOMMUs
+	 * and ignore the one that fails initialization unless
+	 * all IOMMU are failing.
+	 */
+	for (i = 0; i < amd_iommu_get_num_iommus(); i++) {
+		ret = init_one_iommu(i);
+		if (!ret)
+			cnt++;
+	}
 
-	return ret;
+	if (!cnt) {
+		kfree(amd_iommu_events_group.attrs);
+		return -ENODEV;
+	}
+
+	/* Init cpumask attributes to only core 0 */
+	cpumask_set_cpu(0, &iommu_cpumask);
+	return 0;
 }
 
 device_initcall(amd_iommu_pc_init);
-- 
1.8.3.1
