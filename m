From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v9 8/8] perf/amd/iommu: Enable support for multiple IOMMUs
Date: Wed, 15 Feb 2017 11:28:57 +0100
Message-ID: <20170215102857.cyn25jzsv3q7qchq@pd.tnic>
References: <1486456836-17428-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<1486456836-17428-9-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20170208193340.x7lka54ismqqy7nw@pd.tnic>
	<483deec0-412f-bc34-de30-ce6ffcce3d4b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <483deec0-412f-bc34-de30-ce6ffcce3d4b-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 15, 2017 at 02:13:29PM +0700, Suravee Suthikulpanit wrote:
> > So you can define a static struct pmu in the driver and do struct
> > assignment directly instead of writing them one-by-one.
> 
> I believe this is the same suggestion you have made in V8.

Here's what I mean:

---
diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index d9313d20a715..ac11d0755707 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -416,6 +416,17 @@ const struct attribute_group *amd_iommu_attr_groups[] = {
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
 init_one_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, unsigned int idx)
 {
@@ -431,14 +442,7 @@ init_one_perf_amd_iommu(struct perf_amd_iommu *perf_iommu, unsigned int idx)
 
 	snprintf(perf_iommu->name, PERF_AMD_IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
 
-	perf_iommu->pmu.event_init  = perf_iommu_event_init;
-	perf_iommu->pmu.add         = perf_iommu_add;
-	perf_iommu->pmu.del         = perf_iommu_del;
-	perf_iommu->pmu.start       = perf_iommu_start;
-	perf_iommu->pmu.stop        = perf_iommu_stop;
-	perf_iommu->pmu.read        = perf_iommu_read;
-	perf_iommu->pmu.task_ctx_nr = perf_invalid_context;
-	perf_iommu->pmu.attr_groups = amd_iommu_attr_groups;
+	perf_iommu->pmu = iommu_pmu;
 
 	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
 	if (ret)

> The initialized ones should be functioning independently (as separate PMUs).
> So, it should be alright to just leave them. I'll add the warning message
> as you suggested.

Yes, you need at least a warning message so that people know why some of
the IOMMUs are missing.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
