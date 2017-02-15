From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v10 1/9] perf/amd/iommu: Declare pr_fmt and remove unnecessary
	pr_debug
Date: Wed, 15 Feb 2017 14:56:17 -0600
Message-ID: <1487192185-31272-2-git-send-email-Suravee.Suthikulpanit@amd.com>
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

Declare pr_fmt for perf/amd_iommu and remove unnecessary pr_debug.

Also check return value when _init_events_attrs fails.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index b28200d..44638d0 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -11,6 +11,8 @@
  * published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt)	"perf/amd_iommu: " fmt
+
 #include <linux/perf_event.h>
 #include <linux/init.h>
 #include <linux/cpumask.h>
@@ -298,7 +300,6 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	pr_debug("perf: amd_iommu:perf_iommu_start\n");
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
 
@@ -323,7 +324,6 @@ static void perf_iommu_read(struct perf_event *event)
 	u64 prev_raw_count = 0ULL;
 	u64 delta = 0ULL;
 	struct hw_perf_event *hwc = &event->hw;
-	pr_debug("perf: amd_iommu:perf_iommu_read\n");
 
 	amd_iommu_pc_get_set_reg_val(_GET_DEVID(event),
 				_GET_BANK(event), _GET_CNTR(event),
@@ -349,8 +349,6 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	u64 config;
 
-	pr_debug("perf: amd_iommu:perf_iommu_stop\n");
-
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
@@ -372,7 +370,6 @@ static int perf_iommu_add(struct perf_event *event, int flags)
 	struct perf_amd_iommu *perf_iommu =
 			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
-	pr_debug("perf: amd_iommu:perf_iommu_add\n");
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	/* request an iommu bank/counter */
@@ -393,7 +390,6 @@ static void perf_iommu_del(struct perf_event *event, int flags)
 	struct perf_amd_iommu *perf_iommu =
 			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
-	pr_debug("perf: amd_iommu:perf_iommu_del\n");
 	perf_iommu_stop(event, PERF_EF_UPDATE);
 
 	/* clear the assigned iommu bank/counter */
@@ -444,24 +440,24 @@ static __init int _init_perf_amd_iommu(
 
 	raw_spin_lock_init(&perf_iommu->lock);
 
-	/* Init format attributes */
 	perf_iommu->format_group = &amd_iommu_format_group;
 
 	/* Init cpumask attributes to only core 0 */
 	cpumask_set_cpu(0, &iommu_cpumask);
 	perf_iommu->cpumask_group = &amd_iommu_cpumask_group;
 
-	/* Init events attributes */
-	if (_init_events_attrs(perf_iommu) != 0)
-		pr_err("perf: amd_iommu: Only support raw events.\n");
+	ret = _init_events_attrs(perf_iommu);
+	if (ret) {
+		pr_err("Error initializing AMD IOMMU perf events.\n");
+		return ret;
+	}
 
-	/* Init null attributes */
 	perf_iommu->null_group = NULL;
 	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
 
 	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
 	if (ret) {
-		pr_err("perf: amd_iommu: Failed to initialized.\n");
+		pr_err("Error initializing AMD IOMMU perf counters.\n");
 		amd_iommu_pc_exit();
 	} else {
 		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
-- 
1.8.3.1
