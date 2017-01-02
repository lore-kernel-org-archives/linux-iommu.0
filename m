From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v7 RESEND 05/12] iommu/amd: copy old trans table from old
	kernel
Date: Mon,  2 Jan 2017 15:39:51 +0800
Message-ID: <1483342798-6542-6-git-send-email-bhe@redhat.com>
References: <1483342798-6542-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483342798-6542-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Here several things need be done:
- If iommu is pre-enabled in a normal kernel, just disable it and print
  warning.

- If failed to copy dev table of old kernel, continue to proceed as
  it does in normal kernel.

- Disable and Re-enable event/cmd buffer,  install the copied DTE table
  to reg, and detect and enable guest vapic.

- Flush all caches

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 51 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index fddc6e6..93f0ac2 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -37,6 +37,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 
+#include <linux/crash_dump.h>
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
@@ -1482,9 +1483,12 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	iommu->int_enabled = false;
 
 	init_translation_status(iommu);
-
-	if (translation_pre_enabled(iommu))
-		pr_warn("Translation is already enabled - trying to copy translation structures\n");
+	if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
+		iommu_disable(iommu);
+		clear_translation_pre_enabled(iommu);
+		pr_warn("Translation was enabled for IOMMU:%d but we are not in kdump mode\n",
+			iommu->index);
+	}
 
 	ret = init_iommu_from_acpi(iommu, h);
 	if (ret)
@@ -1976,8 +1980,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 }
 
 /*
- * Init the device table to not allow DMA access for devices and
- * suppress all page faults
+ * Init the device table to not allow DMA access for devices
  */
 static void init_device_table_dma(void)
 {
@@ -2118,9 +2121,43 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
+	bool is_pre_enabled = false;
 
-	for_each_iommu(iommu)
-		early_enable_iommu(iommu);
+	for_each_iommu(iommu) {
+		if (translation_pre_enabled(iommu)) {
+			is_pre_enabled = true;
+			break;
+		}
+	}
+
+	if (!is_pre_enabled) {
+		for_each_iommu(iommu)
+			early_enable_iommu(iommu);
+	} else {
+		pr_warn("Translation is already enabled - trying to copy translation structures\n");
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
+				iommu_disable_command_buffer(iommu);
+				iommu_disable_event_buffer(iommu);
+				iommu_enable_command_buffer(iommu);
+				iommu_enable_event_buffer(iommu);
+				iommu_enable_ga(iommu);
+				iommu_set_device_table(iommu);
+				iommu_flush_all_caches(iommu);
+			}
+		}
+	}
 
 #ifdef CONFIG_IRQ_REMAP
 	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
-- 
2.5.5
