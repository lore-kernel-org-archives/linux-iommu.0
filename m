From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v9 7/8] perf/amd/iommu: Fix sysfs perf attribute groups
Date: Tue, 7 Feb 2017 02:40:35 -0600
Message-ID: <1486456836-17428-8-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

Introduce static amd_iommu_attr_groups to simplify the
sysfs attributes initialization code.

Cc: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/events/amd/iommu.c | 81 ++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index b771914..7bbf405 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -43,14 +43,8 @@ struct perf_amd_iommu {
 	u8 max_counters;
 	u64 cntr_assign_mask;
 	raw_spinlock_t lock;
-	const struct attribute_group *attr_groups[4];
 };
 
-#define format_group	attr_groups[0]
-#define cpumask_group	attr_groups[1]
-#define events_group	attr_groups[2]
-#define null_group	attr_groups[3]
-
 /*---------------------------------------------
  * sysfs format attributes
  *---------------------------------------------*/
@@ -81,6 +75,10 @@ struct perf_amd_iommu {
 /*---------------------------------------------
  * sysfs events attributes
  *---------------------------------------------*/
+static struct attribute_group amd_iommu_events_group = {
+	.name = "events",
+};
+
 struct amd_iommu_event_desc {
 	struct kobj_attribute attr;
 	const char *event;
@@ -384,76 +382,60 @@ static void perf_iommu_del(struct perf_event *event, int flags)
 	perf_event_update_userpage(event);
 }
 
-static __init int _init_events_attrs(struct perf_amd_iommu *perf_iommu)
+static __init int _init_events_attrs(void)
 {
-	struct attribute **attrs;
-	struct attribute_group *attr_group;
 	int i = 0, j;
+	struct attribute **attrs;
 
 	while (amd_iommu_v2_event_descs[i].attr.attr.name)
 		i++;
 
-	attr_group = kzalloc(sizeof(struct attribute *)
-		* (i + 1) + sizeof(*attr_group), GFP_KERNEL);
-	if (!attr_group)
+	attrs = kzalloc(sizeof(struct attribute **) * (i + 1), GFP_KERNEL);
+	if (!attrs)
 		return -ENOMEM;
 
-	attrs = (struct attribute **)(attr_group + 1);
 	for (j = 0; j < i; j++)
 		attrs[j] = &amd_iommu_v2_event_descs[j].attr.attr;
 
-	attr_group->name = "events";
-	attr_group->attrs = attrs;
-	perf_iommu->events_group = attr_group;
-
+	amd_iommu_events_group.attrs = attrs;
 	return 0;
 }
 
 static __init void amd_iommu_pc_exit(void)
 {
-	if (__perf_iommu.events_group != NULL) {
-		kfree(__perf_iommu.events_group);
-		__perf_iommu.events_group = NULL;
-	}
+	kfree(amd_iommu_events_group.attrs);
 }
 
-static __init int _init_perf_amd_iommu(
-	struct perf_amd_iommu *perf_iommu, char *name)
+const struct attribute_group *amd_iommu_attr_groups[] = {
+	&amd_iommu_format_group,
+	&amd_iommu_cpumask_group,
+	&amd_iommu_events_group,
+	NULL,
+};
+
+static __init int
+_init_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, char *name)
 {
 	int ret;
 
 	raw_spin_lock_init(&perf_iommu->lock);
 
-	perf_iommu->format_group = &amd_iommu_format_group;
-
 	/* Init cpumask attributes to only core 0 */
 	cpumask_set_cpu(0, &iommu_cpumask);
-	perf_iommu->cpumask_group = &amd_iommu_cpumask_group;
-
-	ret = _init_events_attrs(perf_iommu);
-	if (ret) {
-		pr_err("Error initializing AMD IOMMU perf events.\n");
-		return ret;
-	}
 
 	perf_iommu->max_banks    = amd_iommu_pc_get_max_banks(0);
 	perf_iommu->max_counters = amd_iommu_pc_get_max_counters(0);
 	if (!perf_iommu->max_banks || !perf_iommu->max_counters)
 		return -EINVAL;
 
-	perf_iommu->null_group = NULL;
-	perf_iommu->pmu.attr_groups = perf_iommu->attr_groups;
-
+	perf_iommu->pmu.attr_groups = amd_iommu_attr_groups;
 	ret = perf_pmu_register(&perf_iommu->pmu, name, -1);
-	if (ret) {
+	if (ret)
 		pr_err("Error initializing AMD IOMMU perf counters.\n");
-		amd_iommu_pc_exit();
-	} else {
+	else
 		pr_info("perf: amd_iommu: Detected. (%d banks, %d counters/bank)\n",
 			amd_iommu_pc_get_max_banks(0),
 			amd_iommu_pc_get_max_counters(0));
-	}
-
 	return ret;
 }
 
@@ -467,24 +449,25 @@ static __init int _init_perf_amd_iommu(
 		.stop		= perf_iommu_stop,
 		.read		= perf_iommu_read,
 	},
-	.max_banks		= 0x00,
-	.max_counters		= 0x00,
-	.cntr_assign_mask	= 0ULL,
-	.format_group		= NULL,
-	.cpumask_group		= NULL,
-	.events_group		= NULL,
-	.null_group		= NULL,
 };
 
 static __init int amd_iommu_pc_init(void)
 {
+	int ret;
+
 	/* Make sure the IOMMU PC resource is available */
 	if (!amd_iommu_pc_supported())
 		return -ENODEV;
 
-	_init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
+	ret = _init_events_attrs();
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = _init_perf_amd_iommu(&__perf_iommu, "amd_iommu");
+	if (ret)
+		amd_iommu_pc_exit();
+
+	return ret;
 }
 
 device_initcall(amd_iommu_pc_init);
-- 
1.8.3.1
