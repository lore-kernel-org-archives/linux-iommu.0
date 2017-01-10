From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v7 4/7] perf/amd/iommu: Declare pr_fmt and remove unnecessary
	pr_debug
Date: Mon, 9 Jan 2017 21:33:44 -0600
Message-ID: <1484019227-11473-5-git-send-email-Suravee.Suthikulpanit@amd.com>
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

This patch declare pr_fmt for perf/amd_iommu and remove unnecessary
pr_debug.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 9744dc8..9bff41d 100644
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
@@ -288,7 +290,6 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 	u64 val;
 	struct hw_perf_event *hwc = &event->hw;
 
-	pr_debug("perf: amd_iommu:perf_iommu_start\n");
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
 
@@ -312,7 +313,6 @@ static void perf_iommu_read(struct perf_event *event)
 	u64 cnt, prev;
 	s64 delta;
 	struct hw_perf_event *hwc = &event->hw;
-	pr_debug("perf: amd_iommu:perf_iommu_read\n");
 
 	if (amd_iommu_pc_get_counter(0, _GET_BANK(event), _GET_CNTR(event), &cnt))
 		return;
@@ -339,8 +339,6 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	u64 config;
 
-	pr_debug("perf: amd_iommu:perf_iommu_stop\n");
-
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
@@ -362,7 +360,6 @@ static int perf_iommu_add(struct perf_event *event, int flags)
 	struct perf_amd_iommu *perf_iommu =
 			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
-	pr_debug("perf: amd_iommu:perf_iommu_add\n");
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	/* request an iommu bank/counter */
@@ -383,7 +380,6 @@ static void perf_iommu_del(struct perf_event *event, int flags)
 	struct perf_amd_iommu *perf_iommu =
 			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
-	pr_debug("perf: amd_iommu:perf_iommu_del\n");
 	perf_iommu_stop(event, PERF_EF_UPDATE);
 
 	/* clear the assigned iommu bank/counter */
@@ -443,7 +439,7 @@ static __init int _init_perf_amd_iommu(
 
 	/* Init events attributes */
 	if (_init_events_attrs(perf_iommu) != 0)
-		pr_err("perf: amd_iommu: Only support raw events.\n");
+		pr_err("Only support raw events.\n");
 
 	perf_iommu->max_banks = amd_iommu_pc_get_max_banks(0);
 	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
@@ -456,7 +452,7 @@ static __init int _init_perf_amd_iommu(
 
 	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
 	if (ret) {
-		pr_err("perf: amd_iommu: Failed to initialized.\n");
+		pr_err("Error initializing AMD IOMMU perf counters.\n");
 		amd_iommu_pc_exit();
 	} else {
 		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
-- 
1.8.3.1
