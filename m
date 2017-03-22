From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v12 09/10] perf/amd/iommu: Introduce amd_iommu-specific struct
	in struct hw_perf_event
Date: Wed, 22 Mar 2017 02:02:41 -0500
Message-ID: <1490166162-10002-10-git-send-email-Suravee.Suthikulpanit@amd.com>
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

Current AMD IOMMU Perf PMU inappropriately uses hardware struct
inside the union inside the struct hw_perf_event, mainly the use of
extra_reg.

Instead, introduce amd_iommu-specific struct with required
parameters to be programmed onto the IOMMU performance counter
control register.

Also update the pasid field from 16 to 20 bits.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 102 +++++++++++++++++++-------------------------
 include/linux/perf_event.h  |   7 +++
 2 files changed, 52 insertions(+), 57 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 7ac8138..915a20c 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -23,17 +23,16 @@
 
 #define COUNTER_SHIFT		16
 
-#define _GET_BANK(ev)       ((u8)(ev->hw.extra_reg.reg >> 8))
-#define _GET_CNTR(ev)       ((u8)(ev->hw.extra_reg.reg))
-
-/* iommu pmu config masks */
-#define _GET_CSOURCE(ev)    ((ev->hw.config & 0xFFULL))
-#define _GET_DEVID(ev)      ((ev->hw.config >> 8)  & 0xFFFFULL)
-#define _GET_PASID(ev)      ((ev->hw.config >> 24) & 0xFFFFULL)
-#define _GET_DOMID(ev)      ((ev->hw.config >> 40) & 0xFFFFULL)
-#define _GET_DEVID_MASK(ev) ((ev->hw.extra_reg.config)  & 0xFFFFULL)
-#define _GET_PASID_MASK(ev) ((ev->hw.extra_reg.config >> 16) & 0xFFFFULL)
-#define _GET_DOMID_MASK(ev) ((ev->hw.extra_reg.config >> 32) & 0xFFFFULL)
+/* iommu pmu conf masks */
+#define GET_CSOURCE(x)     (x->conf & 0xFFULL)
+#define GET_DEVID(x)       ((x->conf >> 8)  & 0xFFFFULL)
+#define GET_DOMID(x)       ((x->conf >> 24) & 0xFFFFULL)
+#define GET_PASID(x)       ((x->conf >> 40) & 0xFFFFFULL)
+
+/* iommu pmu conf1 masks */
+#define GET_DEVID_MASK(x)  (x->conf1  & 0xFFFFULL)
+#define GET_DOMID_MASK(x)  ((x->conf1 >> 16) & 0xFFFFULL)
+#define GET_PASID_MASK(x)  ((x->conf1 >> 32) & 0xFFFFFULL)
 
 static struct perf_amd_iommu __perf_iommu;
 
@@ -50,11 +49,11 @@ struct perf_amd_iommu {
  *---------------------------------------------*/
 PMU_FORMAT_ATTR(csource,    "config:0-7");
 PMU_FORMAT_ATTR(devid,      "config:8-23");
-PMU_FORMAT_ATTR(pasid,      "config:24-39");
-PMU_FORMAT_ATTR(domid,      "config:40-55");
+PMU_FORMAT_ATTR(domid,      "config:24-39");
+PMU_FORMAT_ATTR(pasid,      "config:40-59");
 PMU_FORMAT_ATTR(devid_mask, "config1:0-15");
-PMU_FORMAT_ATTR(pasid_mask, "config1:16-31");
-PMU_FORMAT_ATTR(domid_mask, "config1:32-47");
+PMU_FORMAT_ATTR(domid_mask, "config1:16-31");
+PMU_FORMAT_ATTR(pasid_mask, "config1:32-51");
 
 static struct attribute *iommu_format_attrs[] = {
 	&format_attr_csource.attr,
@@ -150,10 +149,13 @@ static ssize_t _iommu_cpumask_show(struct device *dev,
 
 /*---------------------------------------------*/
 
-static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
+static int get_next_avail_iommu_bnk_cntr(struct perf_event *event)
 {
 	unsigned long flags;
-	int shift, bank, cntr, retval;
+	u32 shift, bank, cntr;
+	int retval;
+	struct perf_amd_iommu *perf_iommu =
+			container_of(event->pmu, struct perf_amd_iommu, pmu);
 	int max_banks = perf_iommu->max_banks;
 	int max_cntrs = perf_iommu->max_counters;
 
@@ -166,7 +168,9 @@ static int get_next_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu)
 				continue;
 			} else {
 				perf_iommu->cntr_assign_mask |= BIT_ULL(shift);
-				retval = ((bank & 0xFF) << 8) | (cntr & 0xFF);
+				event->hw.iommu_bank = bank;
+				event->hw.iommu_cntr = cntr;
+				retval = 0;
 				goto out;
 			}
 		}
@@ -202,8 +206,6 @@ static int clear_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu,
 static int perf_iommu_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct perf_amd_iommu *perf_iommu;
-	u64 config, config1;
 
 	/* test the event attr type check for PMU enumeration */
 	if (event->attr.type != event->pmu->type)
@@ -225,21 +227,9 @@ static int perf_iommu_event_init(struct perf_event *event)
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
+	hwc->conf  = event->attr.config;
+	hwc->conf1 = event->attr.config1;
 
 	return 0;
 }
@@ -247,26 +237,28 @@ static int perf_iommu_event_init(struct perf_event *event)
 static void perf_iommu_enable_event(struct perf_event *ev)
 {
 	struct amd_iommu *iommu = get_amd_iommu(0);
-	u8 csource = _GET_CSOURCE(ev);
-	u16 devid = _GET_DEVID(ev);
-	u8 bank = _GET_BANK(ev);
-	u8 cntr = _GET_CNTR(ev);
+	struct hw_perf_event *hwc = &ev->hw;
+	u8 bank = hwc->iommu_bank;
+	u8 cntr = hwc->iommu_cntr;
 	u64 reg = 0ULL;
 
-	reg = csource;
+	reg = GET_CSOURCE(hwc);
 	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_COUNTER_SRC_REG, &reg);
 
-	reg = devid | (_GET_DEVID_MASK(ev) << 32);
+	reg = GET_DEVID_MASK(hwc);
+	reg = GET_DEVID(hwc) | (reg << 32);
 	if (reg)
 		reg |= BIT(31);
 	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_DEVID_MATCH_REG, &reg);
 
-	reg = _GET_PASID(ev) | (_GET_PASID_MASK(ev) << 32);
+	reg = GET_PASID_MASK(hwc);
+	reg = GET_PASID(hwc) | (reg << 32);
 	if (reg)
 		reg |= BIT(31);
 	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_PASID_MATCH_REG, &reg);
 
-	reg = _GET_DOMID(ev) | (_GET_DOMID_MASK(ev) << 32);
+	reg = GET_DOMID_MASK(hwc);
+	reg = GET_DOMID(hwc) | (reg << 32);
 	if (reg)
 		reg |= BIT(31);
 	amd_iommu_pc_set_reg(iommu, bank, cntr, IOMMU_PC_DOMID_MATCH_REG, &reg);
@@ -275,16 +267,16 @@ static void perf_iommu_enable_event(struct perf_event *ev)
 static void perf_iommu_disable_event(struct perf_event *event)
 {
 	struct amd_iommu *iommu = get_amd_iommu(0);
+	struct hw_perf_event *hwc = &event->hw;
 	u64 reg = 0ULL;
 
-	amd_iommu_pc_set_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
+	amd_iommu_pc_set_reg(iommu, hwc->iommu_bank, hwc->iommu_cntr,
 			     IOMMU_PC_COUNTER_SRC_REG, &reg);
 }
 
 static void perf_iommu_start(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	struct amd_iommu *iommu = get_amd_iommu(0);
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -293,8 +285,10 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	if (flags & PERF_EF_RELOAD) {
-		u64 prev_raw_count =  local64_read(&hwc->prev_count);
-		amd_iommu_pc_set_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
+		u64 prev_raw_count = local64_read(&hwc->prev_count);
+		struct amd_iommu *iommu = get_amd_iommu(0);
+
+		amd_iommu_pc_set_reg(iommu, hwc->iommu_bank, hwc->iommu_cntr,
 				     IOMMU_PC_COUNTER_REG, &prev_raw_count);
 	}
 
@@ -309,7 +303,7 @@ static void perf_iommu_read(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	struct amd_iommu *iommu = get_amd_iommu(0);
 
-	if (amd_iommu_pc_get_reg(iommu, _GET_BANK(event), _GET_CNTR(event),
+	if (amd_iommu_pc_get_reg(iommu, hwc->iommu_bank, hwc->iommu_cntr,
 				 IOMMU_PC_COUNTER_REG, &count))
 		return;
 
@@ -329,7 +323,6 @@ static void perf_iommu_read(struct perf_event *event)
 static void perf_iommu_stop(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
-	u64 config;
 
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
@@ -341,7 +334,6 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
-	config = hwc->config;
 	perf_iommu_read(event);
 	hwc->state |= PERF_HES_UPTODATE;
 }
@@ -349,16 +341,12 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 static int perf_iommu_add(struct perf_event *event, int flags)
 {
 	int retval;
-	struct perf_amd_iommu *perf_iommu =
-			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	/* request an iommu bank/counter */
-	retval = get_next_avail_iommu_bnk_cntr(perf_iommu);
-	if (retval != -ENOSPC)
-		event->hw.extra_reg.reg = (u16)retval;
-	else
+	retval = get_next_avail_iommu_bnk_cntr(event);
+	if (retval)
 		return retval;
 
 	if (flags & PERF_EF_START)
@@ -369,6 +357,7 @@ static int perf_iommu_add(struct perf_event *event, int flags)
 
 static void perf_iommu_del(struct perf_event *event, int flags)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	struct perf_amd_iommu *perf_iommu =
 			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
@@ -376,8 +365,7 @@ static void perf_iommu_del(struct perf_event *event, int flags)
 
 	/* clear the assigned iommu bank/counter */
 	clear_avail_iommu_bnk_cntr(perf_iommu,
-				     _GET_BANK(event),
-				     _GET_CNTR(event));
+				   hwc->iommu_bank, hwc->iommu_cntr);
 
 	perf_event_update_userpage(event);
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 000fdb2..14c0767 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -165,6 +165,13 @@ struct hw_perf_event {
 			struct list_head		bp_list;
 		};
 #endif
+		struct { /* amd_iommu */
+			u8	iommu_bank;
+			u8	iommu_cntr;
+			u16	padding;
+			u64	conf;
+			u64	conf1;
+		};
 	};
 	/*
 	 * If the event is a per task event, this will point to the task in
-- 
1.8.3.1
