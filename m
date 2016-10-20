From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 2/9] iommu/amd: add several helper function
Date: Thu, 20 Oct 2016 19:37:13 +0800
Message-ID: <1476963440-23039-3-git-send-email-bhe@redhat.com>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1476963440-23039-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Move per iommu enabling code into a wrapper function early_enable_iommu().
This can make later kdump change easier.

And also add iommu_disable_command_buffer and iommu_disable_event_buffer
for later usage.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1628d7e..67f1457 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -625,6 +625,14 @@ static void iommu_enable_command_buffer(struct amd_iommu *iommu)
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
@@ -657,6 +665,14 @@ static void iommu_enable_event_buffer(struct amd_iommu *iommu)
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
@@ -2026,6 +2042,19 @@ static void iommu_enable_ga(struct amd_iommu *iommu)
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
@@ -2034,17 +2063,8 @@ static void early_enable_iommus(void)
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
