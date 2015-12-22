From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] iommu/amd: Introduce amd_iommu_get_num_iommus()
Date: Tue, 22 Dec 2015 13:19:14 -0600
Message-ID: <1450811957-1511-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1450811957-1511-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450811957-1511-1-git-send-email-Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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

This patch introduces amd_iommu_get_num_iommus(). Initially, this is
intended to be used by Perf AMD IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c            | 16 ++++++++++++++++
 include/linux/perf/perf_event_amd_iommu.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 275c0f5..9c62613 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2244,6 +2244,22 @@ bool amd_iommu_v2_supported(void)
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
+static int amd_iommu_cnt;
+
+int amd_iommu_get_num_iommus(void)
+{
+	struct amd_iommu *iommu;
+
+	if (amd_iommu_cnt)
+		return amd_iommu_cnt;
+
+	for_each_iommu(iommu)
+		amd_iommu_cnt++;
+
+	return amd_iommu_cnt;
+}
+EXPORT_SYMBOL(amd_iommu_get_num_iommus);
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
1.9.1
