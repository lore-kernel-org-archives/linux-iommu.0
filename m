From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V3 3/5] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Tue, 9 Feb 2016 16:53:53 -0600
Message-ID: <1455058435-8716-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1455058435-8716-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

This patch introduces amd_iommu_get_num_iommus(). Initially, this is
intended to be used by Perf AMD IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c            | 7 ++++++-
 include/linux/perf/perf_event_amd_iommu.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 275c0f5..531b2e1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1030,7 +1030,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
-	iommu->index             = amd_iommus_present++;
+	iommu->index = amd_iommus_present++;
 
 	if (unlikely(iommu->index >= MAX_IOMMUS)) {
 		WARN(1, "AMD-Vi: System has more IOMMUs than supported by this driver\n");
@@ -2244,6 +2244,11 @@ bool amd_iommu_v2_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
+int amd_iommu_get_num_iommus(void)
+{
+	return amd_iommus_present;
+}
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
diff --git a/include/linux/perf/perf_event_amd_iommu.h b/include/linux/perf/perf_event_amd_iommu.h
index 815eabb..cb820c2 100644
--- a/include/linux/perf/perf_event_amd_iommu.h
+++ b/include/linux/perf/perf_event_amd_iommu.h
@@ -25,6 +25,8 @@
 #define PC_MAX_SPEC_CNTRS			16
 
 /* amd_iommu_init.c external support functions */
+extern int amd_iommu_get_num_iommus(void);
+
 extern bool amd_iommu_pc_supported(void);
 
 extern u8 amd_iommu_pc_get_max_banks(void);
-- 
2.5.0
