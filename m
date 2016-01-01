From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 4/6] perf/amd/iommu: Introduce data structure for tracking
	prev count.
Date: Fri, 1 Jan 2016 12:13:38 -0600
Message-ID: <1451672020-2150-5-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1451672020-2150-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1451672020-2150-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

To enable AMD IOMMU PMU to support multiple IOMMUs, this patch introduces
a new data structure, perf_amd_iommu.prev_cnts, to track previous counts
of IOMMU performance counters in multi-IOMMU environment.

Also, this patch allocates perf_iommu_cnts for internal use
when manages counters.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/kernel/cpu/perf_event_amd_iommu.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_amd_iommu.c b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
index e6d2485..99fcd10 100644
--- a/arch/x86/kernel/cpu/perf_event_amd_iommu.c
+++ b/arch/x86/kernel/cpu/perf_event_amd_iommu.c
@@ -42,6 +42,7 @@ struct perf_amd_iommu {
 	u64 cntr_assign_mask;
 	raw_spinlock_t lock;
 	const struct attribute_group *attr_groups[4];
+	local64_t *prev_cnts;
 };
 
 #define format_group	attr_groups[0]
@@ -126,6 +127,8 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
 	{ /* end: all zeroes */ },
 };
 
+static u64 *perf_iommu_cnts;
+
 /*---------------------------------------------
  * sysfs cpumask attributes
  *---------------------------------------------*/
@@ -423,10 +426,14 @@ static __init int _init_events_attrs(struct perf_amd_iommu *perf_iommu)
 
 static __init void amd_iommu_pc_exit(void)
 {
-	if (__perf_iommu.events_group != NULL) {
-		kfree(__perf_iommu.events_group);
-		__perf_iommu.events_group = NULL;
-	}
+	kfree(__perf_iommu.events_group);
+	__perf_iommu.events_group = NULL;
+
+	kfree(__perf_iommu.prev_cnts);
+	__perf_iommu.prev_cnts = NULL;
+
+	kfree(perf_iommu_cnts);
+	perf_iommu_cnts = NULL;
 }
 
 static __init int _init_perf_amd_iommu(
@@ -456,6 +463,17 @@ static __init int _init_perf_amd_iommu(
 	perf_iommu->null_group = NULL;
 	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
 
+	perf_iommu->prev_cnts = kzalloc(sizeof(*perf_iommu->prev_cnts) *
+		(amd_iommu_get_num_iommus() * perf_iommu->max_banks *
+		perf_iommu->max_counters), GFP_KERNEL);
+	if (!perf_iommu->prev_cnts)
+		return -ENOMEM;
+
+	perf_iommu_cnts = kzalloc(sizeof(*perf_iommu_cnts) *
+				  amd_iommu_get_num_iommus(), GFP_KERNEL);
+	if (!perf_iommu_cnts)
+		return -ENOMEM;
+
 	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
 	if (ret) {
 		pr_err("perf: amd_iommu: Failed to initialized.\n");
-- 
1.9.1
