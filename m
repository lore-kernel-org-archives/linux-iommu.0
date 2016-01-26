From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch v3 08/12] iommu/amd: set the device table and re-enable
	event/cmd buffer
Date: Tue, 26 Jan 2016 18:29:22 +0800
Message-ID: <1453804166-25646-9-git-send-email-bhe@redhat.com>
References: <1453804166-25646-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453804166-25646-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Here several things need be done:
1) Initialize amd_iommu_dev_table because it was set several times
since kdump kernel reboot. We don't need the set because we will
copy the content from old kernel.
2) Re-enable event/cmd buffer
3) Install the DTE table to reg
4) Flush all caches

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index e5d28ec..26ba00e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1731,16 +1731,30 @@ static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
 static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
-
-	for_each_iommu(iommu) {
-		iommu_disable(iommu);
-		iommu_init_flags(iommu);
-		iommu_set_device_table(iommu);
-		iommu_enable_command_buffer(iommu);
-		iommu_enable_event_buffer(iommu);
-		iommu_set_exclusion_range(iommu);
-		iommu_enable(iommu);
-		iommu_flush_all_caches(iommu);
+	if ( !translation_pre_enabled() ) {
+		for_each_iommu(iommu) {
+			iommu_disable(iommu);
+			iommu_init_flags(iommu);
+			iommu_set_device_table(iommu);
+			iommu_enable_command_buffer(iommu);
+			iommu_enable_event_buffer(iommu);
+			iommu_set_exclusion_range(iommu);
+			iommu_enable(iommu);
+			iommu_flush_all_caches(iommu);
+		}
+	} else {
+		memset(amd_iommu_dev_table, 0, dev_table_size);
+
+		for_each_iommu(iommu) {
+			if (copy_dev_tables(iommu))
+				break;
+			iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
+			iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
+			iommu_enable_command_buffer(iommu);
+			iommu_enable_event_buffer(iommu);
+			iommu_set_device_table(iommu);
+			iommu_flush_all_caches(iommu);
+		}
 	}
 }
 
-- 
2.1.0
