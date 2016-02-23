From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V5 08/10] perf/amd/iommu: Rename struct perf_amd_iommu to
	perf_iommu
Date: Tue, 23 Feb 2016 08:12:42 -0600
Message-ID: <1456236764-1569-9-git-send-email-Suravee.Suthikulpanit@amd.com>
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

This patch shortens the struct name perf_amd_iommu to perf_iommu since
the old name is too long. The new name should be sufficient since
the structure is only used within this file. We also clean up variable
name for this structure in various functions.

Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 82 +++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index d5e4d39..35a7b18 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -35,9 +35,9 @@
 #define _GET_PASID_MASK(ev) ((ev->hw.extra_reg.config >> 16) & 0xFFFFULL)
 #define _GET_DOMID_MASK(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFULL)
 
-static struct perf_amd_iommu __perf_iommu;
+static struct perf_iommu __perf_iommu;
 
-struct perf_amd_iommu {
+struct perf_iommu {
 	struct pmu pmu;
 	u8 max_banks;
 	u8 max_counters;
@@ -147,49 +147,48 @@ static struct attribute_group amd_iommu_cpumask_group = {
 
 /*---------------------------------------------*/
 
-static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
+static int get_next_avail_iommu_bnk_cntr(struct perf_iommu *pi)
 {
 	unsigned long flags;
 	int bank, cntr, retval = -ENOSPC;
 
-	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+	raw_spin_lock_irqsave(&pi->lock, flags);
 
-	for (bank = 0; bank < perf_iommu->max_banks; bank++) {
-		for (cntr = 0; cntr < perf_iommu->max_counters; cntr++) {
-			int shift = (perf_iommu->max_counters * bank) + cntr;
+	for (bank = 0; bank < pi->max_banks; bank++) {
+		for (cntr = 0; cntr < pi->max_counters; cntr++) {
+			int shift = (pi->max_counters * bank) + cntr;
 
-			if (perf_iommu->cntr_assign_mask & (1ULL << shift)) {
+			if (pi->cntr_assign_mask & (1ULL << shift)) {
 				continue;
 			} else {
-				perf_iommu->cntr_assign_mask |= (1ULL << shift);
+				pi->cntr_assign_mask |= (1ULL << shift);
 				retval = ((u16)((u16)bank << 8) | (u8)(cntr));
 				goto out;
 			}
 		}
 	}
 out:
-	raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+	raw_spin_unlock_irqrestore(&pi->lock, flags);
 	return retval;
 }
 
-static int clear_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu,
-					u8 bank, u8 cntr)
+static int clear_avail_iommu_bnk_cntr(struct perf_iommu *pi, u8 bank, u8 cntr)
 {
 	unsigned long flags;
 	int max_banks, max_cntrs;
 	int shift = 0;
 
-	max_banks = perf_iommu->max_banks;
-	max_cntrs = perf_iommu->max_counters;
+	max_banks = pi->max_banks;
+	max_cntrs = pi->max_counters;
 
 	if ((bank > max_banks) || (cntr > max_cntrs))
 		return -EINVAL;
 
 	shift = bank + cntr + (bank*3);
 
-	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
-	perf_iommu->cntr_assign_mask &= ~(1ULL<<shift);
-	raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+	raw_spin_lock_irqsave(&pi->lock, flags);
+	pi->cntr_assign_mask &= ~(1ULL<<shift);
+	raw_spin_unlock_irqrestore(&pi->lock, flags);
 
 	return 0;
 }
@@ -197,7 +196,7 @@ static int clear_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu,
 static int perf_iommu_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_amd_iommu *perf_iommu;
+	struct perf_iommu *pi;
 	u64 config, config1;
 
 	/* test the event attr type check for PMU enumeration */
@@ -220,12 +219,12 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	perf_iommu = &__perf_iommu;
+	pi = &__perf_iommu;
 
-	if (event->pmu != &perf_iommu->pmu)
+	if (event->pmu != &pi->pmu)
 		return -ENOENT;
 
-	if (perf_iommu) {
+	if (pi) {
 		config = event->attr.config;
 		config1 = event->attr.config1;
 	} else {
@@ -350,13 +349,12 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 static int perf_iommu_add(struct perf_event *event, int flags)
 {
 	int retval;
-	struct perf_amd_iommu *perf_iommu =
-			container_of(event->pmu, struct perf_amd_iommu, pmu);
+	struct perf_iommu *pi = container_of(event->pmu, struct perf_iommu, pmu);
 
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	/* request an iommu bank/counter */
-	retval = get_next_avail_iommu_bnk_cntr(perf_iommu);
+	retval = get_next_avail_iommu_bnk_cntr(pi);
 	if (retval != -ENOSPC)
 		event->hw.extra_reg.reg = (u16)retval;
 	else
@@ -370,20 +368,17 @@ static int perf_iommu_add(struct perf_event *event, int flags)
 
 static void perf_iommu_del(struct perf_event *event, int flags)
 {
-	struct perf_amd_iommu *perf_iommu =
-			container_of(event->pmu, struct perf_amd_iommu, pmu);
+	struct perf_iommu *pi = container_of(event->pmu, struct perf_iommu, pmu);
 
 	perf_iommu_stop(event, PERF_EF_UPDATE);
 
 	/* clear the assigned iommu bank/counter */
-	clear_avail_iommu_bnk_cntr(perf_iommu,
-				     _GET_BANK(event),
-				     _GET_CNTR(event));
+	clear_avail_iommu_bnk_cntr(pi, _GET_BANK(event), _GET_CNTR(event));
 
 	perf_event_update_userpage(event);
 }
 
-static __init int _init_events_attrs(struct perf_amd_iommu *perf_iommu)
+static __init int _init_events_attrs(struct perf_iommu *pi)
 {
 	struct attribute **attrs;
 	struct attribute_group *attr_group;
@@ -403,7 +398,7 @@ static __init int _init_events_attrs(struct perf_amd_iommu *perf_iommu)
 
 	attr_group->name = "events";
 	attr_group->attrs = attrs;
-	perf_iommu->events_group = attr_group;
+	pi->events_group = attr_group;
 
 	return 0;
 }
@@ -416,34 +411,33 @@ static __init void amd_iommu_pc_exit(void)
 	}
 }
 
-static __init int _init_perf_amd_iommu(
-	struct perf_amd_iommu *perf_iommu, char *name)
+static __init int _init_perf_amd_iommu(struct perf_iommu *pi, char *name)
 {
 	int ret;
 
-	raw_spin_lock_init(&perf_iommu->lock);
+	raw_spin_lock_init(&pi->lock);
 
 	/* Init format attributes */
-	perf_iommu->format_group = &amd_iommu_format_group;
+	pi->format_group = &amd_iommu_format_group;
 
 	/* Init cpumask attributes to only core 0 */
 	cpumask_set_cpu(0, &iommu_cpumask);
-	perf_iommu->cpumask_group = &amd_iommu_cpumask_group;
+	pi->cpumask_group = &amd_iommu_cpumask_group;
 
 	/* Init events attributes */
-	if (_init_events_attrs(perf_iommu) != 0)
+	if (_init_events_attrs(pi) != 0)
 		pr_err("Only support raw events.\n");
 
-	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
-	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
-	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
+	pi->max_banks = amd_iommu_pc_get_max_banks(0);
+	pi->max_counters = amd_iommu_pc_get_max_counters(0);
+	if (!pi->max_banks || !pi->max_counters)
 		return -EINVAL;
 
 	/* Init null attributes */
-	perf_iommu->null_group = NULL;
-	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
+	pi->null_group = NULL;
+	pi->pmu.attr_groups = pi->attr_groups;
 
-	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
+	ret = perf_pmu_register(&pi->pmu, name, -1);
 	if (ret) {
 		pr_err("Error initializing AMD IOMMU perf counters.\n");
 		amd_iommu_pc_exit();
@@ -456,7 +450,7 @@ static __init int _init_perf_amd_iommu(
 	return ret;
 }
 
-static struct perf_amd_iommu __perf_iommu = {
+static struct perf_iommu __perf_iommu = {
 	.pmu = {
 		.event_init	= perf_iommu_event_init,
 		.add		= perf_iommu_add,
-- 
1.9.1
