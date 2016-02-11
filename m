From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V4 6/6] perf/amd/iommu: Clean up print messages pr_debug
Date: Thu, 11 Feb 2016 16:15:27 +0700
Message-ID: <1455182127-17551-7-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>

This patch declares pr_fmt for perf/amd_iommu, removes unnecessary
pr_debug, and clean up error messages.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 947ae8a..3e00925 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -11,6 +11,8 @@
  * published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt)	"perf/amd_iommu: " fmt
+
 #include <linux/perf_event.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
@@ -305,7 +307,6 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 							 struct perf_amd_iommu,
 							 pmu);
 
-	pr_debug("perf: amd_iommu:perf_iommu_start\n");
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
 
@@ -381,8 +382,6 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	u64 config;
 
-	pr_debug("perf: amd_iommu:perf_iommu_stop\n");
-
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
@@ -404,7 +403,6 @@ static int perf_iommu_add(struct perf_event *event, int flags)
 	struct perf_amd_iommu *perf_iommu =
 			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
-	pr_debug("perf: amd_iommu:perf_iommu_add\n");
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	/* request an iommu bank/counter */
@@ -425,7 +423,6 @@ static void perf_iommu_del(struct perf_event *event, int flags)
 	struct perf_amd_iommu *perf_iommu =
 			container_of(event->pmu, struct perf_amd_iommu, pmu);
 
-	pr_debug("perf: amd_iommu:perf_iommu_del\n");
 	perf_iommu_stop(event, PERF_EF_UPDATE);
 
 	/* clear the assigned iommu bank/counter */
@@ -489,7 +486,7 @@ static __init int _init_perf_amd_iommu(
 
 	/* Init events attributes */
 	if (_init_events_attrs(perf_iommu) != 0)
-		pr_err("perf: amd_iommu: Only support raw events.\n");
+		pr_err("Only support raw events.\n");
 
 	perf_iommu->max_banks = amd_iommu_pc_get_max_banks();
 	perf_iommu->max_counters = amd_iommu_pc_get_max_counters();
@@ -514,10 +511,10 @@ static __init int _init_perf_amd_iommu(
 
 	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
 	if (ret) {
-		pr_err("perf: amd_iommu: Failed to initialized.\n");
+		pr_err("Error initializing AMD IOMMU perf counters.\n");
 		amd_iommu_pc_exit();
 	} else {
-		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
+		pr_info("Detected. (%d banks, %d counters/bank)\n",
 			amd_iommu_pc_get_max_banks(),
 			amd_iommu_pc_get_max_counters());
 	}
-- 
2.5.0
