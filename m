From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 02/13] iommu/amd: add several helper functions
Date: Fri, 21 Jul 2017 16:59:00 +0800
Message-ID: <1500627551-12930-3-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jroedel-l3A5Bk7waGM@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Move single iommu enabling codes into a wrapper function early_enable_iommu().
This can make later kdump change easier.

And also add iommu_disable_command_buffer and iommu_disable_event_buffer
for later usage.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index e39857ce6481..4ca6e3257d92 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -634,6 +634,14 @@ static void iommu_enable_command_buffer(struct amd_iommu *iommu)
 	amd_iommu_reset_cmd_buffer(iommu);
 }
 
+/*
+ * This function disables the command buffer
+ */
+static void iommu_disable_command_buffer(struct amd_iommu *iommu)
+{
+	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
+}
+
 static void __init free_command_buffer(struct amd_iommu *iommu)
 {
 	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
@@ -666,6 +674,14 @@ static void iommu_enable_event_buffer(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
 }
 
+/*
+ * This function disables the command buffer
+ */
+static void iommu_disable_event_buffer(struct amd_iommu *iommu)
+{
+	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
+}
+
 static void __init free_event_buffer(struct amd_iommu *iommu)
 {
 	free_pages((unsigned long)iommu->evt_buf, get_order(EVT_BUFFER_SIZE));
@@ -2046,6 +2062,19 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
 #endif
 }
 
+static void early_enable_iommu(struct amd_iommu *iommu)
+{
+	iommu_disable(iommu);
+	iommu_init_flags(iommu);
+	iommu_set_device_table(iommu);
+	iommu_enable_command_buffer(iommu);
+	iommu_enable_event_buffer(iommu);
+	iommu_set_exclusion_range(iommu);
+	iommu_enable_ga(iommu);
+	iommu_enable(iommu);
+	iommu_flush_all_caches(iommu);
+}
+
 /*
  * This function finally enables all IOMMUs found in the system after
  * they have been initialized
@@ -2054,17 +2083,8 @@ static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu) {
-		iommu_disable(iommu);
-		iommu_init_flags(iommu);
-		iommu_set_device_table(iommu);
-		iommu_enable_command_buffer(iommu);
-		iommu_enable_event_buffer(iommu);
-		iommu_set_exclusion_range(iommu);
-		iommu_enable_ga(iommu);
-		iommu_enable(iommu);
-		iommu_flush_all_caches(iommu);
-	}
+	for_each_iommu(iommu)
+		early_enable_iommu(iommu);
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-- 
2.5.5
