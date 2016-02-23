From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V5 10/10] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Tue, 23 Feb 2016 08:12:44 -0600
Message-ID: <1456236764-1569-11-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1456236764-1569-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1456236764-1569-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
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
 arch/x86/events/amd/iommu.c | 115 ++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 53 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 35a7b18..0ebadc6 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -35,10 +35,13 @@
 #define _GET_PASID_MASK(ev) ((ev->hw.extra_reg.config >> 16) & 0xFFFFULL)
 #define _GET_DOMID_MASK(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFULL)
 
-static struct perf_iommu __perf_iommu;
+#define PERF_AMD_IOMMU_NAME_SZ 16
 
 struct perf_iommu {
+	struct list_head list;
 	struct pmu pmu;
+	int idx;
+	char name[PERF_AMD_IOMMU_NAME_SZ];
 	u8 max_banks;
 	u8 max_counters;
 	u64 cntr_assign_mask;
@@ -46,6 +49,8 @@ struct perf_iommu {
 	const struct attribute_group *attr_groups[4];
 };
 
+LIST_HEAD(perf_amd_iommu_list);
+
 #define format_group	attr_groups[0]
 #define cpumask_group	attr_groups[1]
 #define events_group	attr_groups[2]
@@ -196,8 +201,7 @@ static int clear_avail_iommu_bnk_cntr(struct perf_iommu *pi, u8 bank, u8 cntr)
 static int perf_iommu_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_iommu *pi;
-	u64 config, config1;
+	struct perf_iommu *pi = container_of(event->pmu, struct perf_iommu, pmu);
 
 	/* test the event attr type check for PMU enumeration */
 	if (event->attr.type != event->pmu->type)
@@ -219,27 +223,17 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	pi = &__perf_iommu;
-
-	if (event->pmu != &pi->pmu)
-		return -ENOENT;
-
-	if (pi) {
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
@@ -247,33 +241,34 @@ static void perf_iommu_enable_event(struct perf_event *ev)
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
 
@@ -293,7 +288,7 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 
 	val = local64_read(&hwc->prev_count);
 
-	amd_iommu_pc_set_counter(0, _GET_BANK(event), _GET_CNTR(event), &val);
+	amd_iommu_pc_set_counter(hwc->idx, _GET_BANK(event), _GET_CNTR(event), &val);
 enable:
 	perf_iommu_enable_event(event);
 	perf_event_update_userpage(event);
@@ -306,7 +301,7 @@ static void perf_iommu_read(struct perf_event *event)
 	s64 delta;
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (amd_iommu_pc_get_counter(0, _GET_BANK(event), _GET_CNTR(event), &cnt))
+	if (amd_iommu_pc_get_counter(hwc->idx, _GET_BANK(event), _GET_CNTR(event), &cnt))
 		return;
 
 	/* IOMMU pc counter register is only 48 bits */
@@ -405,13 +400,19 @@ static __init int _init_events_attrs(struct perf_iommu *pi)
 
 static __init void amd_iommu_pc_exit(void)
 {
-	if (__perf_iommu.events_group != NULL) {
-		kfree(__perf_iommu.events_group);
-		__perf_iommu.events_group = NULL;
+	struct perf_iommu *pi, *next;
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
 
-static __init int _init_perf_amd_iommu(struct perf_iommu *pi, char *name)
+static __init int init_one_perf_amd_iommu(struct perf_iommu *pi, int idx)
 {
 	int ret;
 
@@ -428,53 +429,61 @@ static __init int _init_perf_amd_iommu(struct perf_iommu *pi, char *name)
 	if (_init_events_attrs(pi) != 0)
 		pr_err("Only support raw events.\n");
 
-	pi->max_banks = amd_iommu_pc_get_max_banks(0);
-	pi->max_counters = amd_iommu_pc_get_max_counters(0);
+	snprintf(pi->name, PERF_AMD_IOMMU_NAME_SZ, "amd_iommu_%u", idx);
+	pi->idx = idx;
+	pi->max_banks = amd_iommu_pc_get_max_banks(idx);
+	pi->max_counters = amd_iommu_pc_get_max_counters(idx);
 	if (!pi->max_banks || !pi->max_counters)
 		return -EINVAL;
 
 	/* Init null attributes */
 	pi->null_group = NULL;
+
+	/* Setting up PMU */
+	pi->pmu.event_init = perf_iommu_event_init,
+	pi->pmu.add = perf_iommu_add,
+	pi->pmu.del = perf_iommu_del,
+	pi->pmu.start = perf_iommu_start,
+	pi->pmu.stop = perf_iommu_stop,
+	pi->pmu.read = perf_iommu_read,
 	pi->pmu.attr_groups = pi->attr_groups;
 
-	ret = perf_pmu_register(&pi->pmu, name, -1);
+	ret = perf_pmu_register(&pi->pmu, pi->name, -1);
 	if (ret) {
 		pr_err("Error initializing AMD IOMMU perf counters.\n");
 		amd_iommu_pc_exit();
 	} else {
-		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
-			amd_iommu_pc_get_max_banks(0),
-			amd_iommu_pc_get_max_counters(0));
+		pr_info("Detected %s, w/ %d banks, %d counters/bank\n",
+			pi->name,
+			amd_iommu_pc_get_max_banks(idx),
+			amd_iommu_pc_get_max_counters(idx));
+
+		list_add_tail(&pi->list, &perf_amd_iommu_list);
 	}
 
 	return ret;
 }
 
-static struct perf_iommu __perf_iommu = {
-	.pmu = {
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
+	int i;
+
 	/* Make sure the IOMMU PC resource is available */
 	if (!amd_iommu_pc_supported())
 		return -ENODEV;
 
-	_init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
+	for (i = 0 ; i < amd_iommu_get_num_iommus(); i++) {
+		int ret;
+		struct perf_iommu *pi;
+
+		pi = kzalloc(sizeof(struct perf_iommu), GFP_KERNEL);
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
1.9.1
