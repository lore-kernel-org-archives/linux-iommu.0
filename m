From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 5/8] iommu/amd: copy old trans table from old kernel
Date: Thu, 15 Sep 2016 23:03:23 +0800
Message-ID: <1473951806-25511-6-git-send-email-bhe@redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1473951806-25511-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

Here several things need be done:
1) If iommu is pre-enabled in a normal kernel, just disable it and print
   warning.
2) If failed to copy dev table of old kernel, continue to proceed as
   it does in normal kernel.
3) Re-enable event/cmd buffer and install the new DTE table to reg.
4) Flush all caches

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 44 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index ce49641..47a8fc9 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -34,7 +34,7 @@
 #include <asm/iommu_table.h>
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
-
+#include <linux/crash_dump.h>
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
@@ -1344,6 +1344,12 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	iommu->int_enabled = false;
 
 	init_translation_status(iommu);
+	if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
+		iommu_disable(iommu);
+		clear_translation_pre_enabled(iommu);
+		pr_warn("Translation was enabled for IOMMU:%d but we are not in kdump mode\n",
+			iommu->index);
+	}
 
 	if (translation_pre_enabled(iommu))
 		pr_warn("Translation is already enabled - trying to copy translation structures\n");
@@ -1946,9 +1952,41 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
+	bool is_pre_enabled=false;
 
-	for_each_iommu(iommu)
-		early_enable_iommu(iommu);
+	for_each_iommu(iommu) {
+		if ( translation_pre_enabled(iommu) ) {
+			is_pre_enabled = true;
+			break;
+		}
+	}
+
+	if ( !is_pre_enabled) {
+		for_each_iommu(iommu)
+			early_enable_iommu(iommu);
+	} else {
+		if (copy_dev_tables()) {
+			pr_err("Failed to copy DEV table from previous kernel.\n");
+			/*
+			 * If failed to copy dev tables from old kernel, continue to proceed
+			 * as it does in normal kernel.
+			 */
+			for_each_iommu(iommu) {
+				clear_translation_pre_enabled(iommu);
+				early_enable_iommu(iommu);
+			}
+		} else {
+			pr_info("Copied DEV table from previous kernel.\n");
+			for_each_iommu(iommu) {
+				iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
+		                iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
+		                iommu_enable_command_buffer(iommu);
+		                iommu_enable_event_buffer(iommu);
+		                iommu_set_device_table(iommu);
+		                iommu_flush_all_caches(iommu);
+			}
+		}
+	}
 }
 
 static void enable_iommus_v2(void)
-- 
2.5.5
