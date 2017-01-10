From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v7 7/7] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Mon, 9 Jan 2017 21:33:47 -0600
Message-ID: <1484019227-11473-8-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484019227-11473-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

This patch adds multi-IOMMU support for perf by exposing
an AMD IOMMU PMU for each IOMMU found in the system via:

  /sys/device/amd_iommu_x     /* where x is the IOMMU index. */

This allows users to specify different events to be programed
onto performance counters of each IOMMU.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 119 ++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 55 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 2403c78..5fd97b5 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -35,10 +35,13 @@
 #define _GET_PASID_MASK(ev) ((ev->hw.extra_reg.config >> 16) & 0xFFFFULL)
 #define _GET_DOMID_MASK(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFULL)
 
-static struct perf_amd_iommu __perf_iommu;
+#define PERF_AMD_IOMMU_NAME_SZ 16
 
 struct perf_amd_iommu {
+	struct list_head list;
 	struct pmu pmu;
+	uint idx;
+	char name[PERF_AMD_IOMMU_NAME_SZ];
 	u8 max_banks;
 	u8 max_counters;
 	u64 cntr_assign_mask;
@@ -46,6 +49,8 @@ struct perf_amd_iommu {
 	const struct attribute_group *attr_groups[4];
 };
 
+LIST_HEAD(perf_amd_iommu_list);
+
 #define format_group	attr_groups[0]
 #define cpumask_group	attr_groups[1]
 #define events_group	attr_groups[2]
@@ -204,8 +209,7 @@ static int clear_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu,
 static int perf_iommu_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_amd_iommu *perf_iommu;
-	u64 config, config1;
+	struct perf_amd_iommu *pi = container_of(event->pmu, struct perf_amd_iommu, pmu);
 
 	/* test the event attr type check for PMU enumeration */
 	if (event->attr.type != event->pmu->type)
@@ -227,27 +231,17 @@ static int perf_iommu_event_init(struct perf_event *event)
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
+	hwc->idx = pi->idx;
+	hwc->config = event->attr.config;
+	hwc->extra_reg.config = event->attr.config1;
 
 	return 0;
 }
 
 static void perf_iommu_enable_event(struct perf_event *ev)
 {
+	struct hw_perf_event *hwc = &ev->hw;
 	u8 csource = _GET_CSOURCE(ev);
 	u16 devid = _GET_DEVID(ev);
 	u8 bank = _GET_BANK(ev);
@@ -255,33 +249,34 @@ static void perf_iommu_enable_event(struct perf_event *ev)
 	u64 reg = 0ULL;
 
 	reg = csource;
-	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+	amd_iommu_pc_set_reg(hwc->idx, devid, bank, cntr,
 			     IOMMU_PC_COUNTER_SRC_REG, &reg);
 
 	reg = devid | (_GET_DEVID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+	amd_iommu_pc_set_reg(hwc->idx, devid, bank, cntr,
 			     IOMMU_PC_DEVID_MATCH_REG, &reg);
 
 	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+	amd_iommu_pc_set_reg(hwc->idx, devid, bank, cntr,
 			     IOMMU_PC_PASID_MATCH_REG, &reg);
 
 	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
 	if (reg)
 		reg |= BIT(31);
-	amd_iommu_pc_set_reg(0, devid, bank, cntr,
+	amd_iommu_pc_set_reg(hwc->idx, devid, bank, cntr,
 			     IOMMU_PC_DOMID_MATCH_REG, &reg);
 }
 
 static void perf_iommu_disable_event(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	u64 reg = 0ULL;
 
-	amd_iommu_pc_set_reg(0, _GET_DEVID(event), _GET_BANK(event),
+	amd_iommu_pc_set_reg(hwc->idx, _GET_DEVID(event), _GET_BANK(event),
 			     _GET_CNTR(event), IOMMU_PC_COUNTER_SRC_REG, &reg);
 }
 
@@ -301,7 +296,7 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 
 	val = local64_read(&hwc->prev_count);
 
-	amd_iommu_pc_set_counter(0, _GET_BANK(event), _GET_CNTR(event), &val);
+	amd_iommu_pc_set_counter(hwc->idx, _GET_BANK(event), _GET_CNTR(event), &val);
 enable:
 	perf_iommu_enable_event(event);
 	perf_event_update_userpage(event);
@@ -314,7 +309,7 @@ static void perf_iommu_read(struct perf_event *event)
 	s64 delta;
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (amd_iommu_pc_get_counter(0, _GET_BANK(event), _GET_CNTR(event), &cnt))
+	if (amd_iommu_pc_get_counter(hwc->idx, _GET_BANK(event), _GET_CNTR(event), &cnt))
 		return;
 
 	/* IOMMU pc counter register is only 48 bits */
@@ -417,14 +412,20 @@ static __init int _init_events_attrs(struct perf_amd_iommu *perf_iommu)
 
 static __init void amd_iommu_pc_exit(void)
 {
-	if (__perf_iommu.events_group != NULL) {
-		kfree(__perf_iommu.events_group);
-		__perf_iommu.events_group = NULL;
+	struct perf_amd_iommu *pi, *next;
+
+	list_for_each_entry_safe(pi, next, &perf_amd_iommu_list, list) {
+		list_del(&pi->list);
+
+		kfree(pi->events_group);
+		pi->events_group = NULL;
+
+		kfree(pi);
 	}
 }
 
-static __init int _init_perf_amd_iommu(
-	struct perf_amd_iommu *perf_iommu, char *name)
+static __init int
+init_one_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, uint idx)
 {
 	int ret;
 
@@ -441,54 +442,62 @@ static __init int _init_perf_amd_iommu(
 	if (_init_events_attrs(perf_iommu) != 0)
 		pr_err("Only support raw events.\n");
 
-	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
-	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
+	snprintf(perf_iommu->name, PERF_AMD_IOMMU_NAME_SZ, "amd_iommu_%u", idx);
+	perf_iommu->idx = idx;
+	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(idx);
+	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(idx);
 	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
 		return -EINVAL;
 
 	/* Init null attributes */
 	perf_iommu->null_group = NULL;
+
+	/* Setting up PMU */
+	perf_iommu->pmu.event_init = perf_iommu_event_init,
+	perf_iommu->pmu.add = perf_iommu_add,
+	perf_iommu->pmu.del = perf_iommu_del,
+	perf_iommu->pmu.start = perf_iommu_start,
+	perf_iommu->pmu.stop = perf_iommu_stop,
+	perf_iommu->pmu.read = perf_iommu_read,
+	perf_iommu->pmu.task_ctx_nr = perf_invalid_context;
 	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
 
-	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
+	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
 	if (ret) {
 		pr_err("Error initializing AMD IOMMU perf counters.\n");
 		amd_iommu_pc_exit();
 	} else {
-		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
-			amd_iommu_pc_get_max_banks(0),
-			amd_iommu_pc_get_max_counters(0));
+		pr_info("Detected %s, w/ %d banks, %d counters/bank\n",
+			perf_iommu->name,
+			amd_iommu_pc_get_max_banks(idx),
+			amd_iommu_pc_get_max_counters(idx));
+
+		list_add_tail(&perf_iommu->list, &perf_amd_iommu_list);
 	}
 
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
-	.max_banks		= 0x00,
-	.max_counters		= 0x00,
-	.cntr_assign_mask	= 0ULL,
-	.format_group		= NULL,
-	.cpumask_group		= NULL,
-	.events_group		= NULL,
-	.null_group		= NULL,
-};
-
 static __init int amd_iommu_pc_init(void)
 {
+	uint i;
+
 	/* Make sure the IOMMU PC resource is available */
 	if (!amd_iommu_pc_supported())
 		return -ENODEV;
 
-	_init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
+	for (i = 0 ; i < amd_iommu_get_num_iommus(); i++) {
+		int ret;
+		struct perf_amd_iommu *pi;
+
+		pi = kzalloc(sizeof(struct perf_amd_iommu), GFP_KERNEL);
+		if (!pi)
+			return -ENOMEM;
+
+		ret = init_one_perf_amd_iommu(pi, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
1.8.3.1
