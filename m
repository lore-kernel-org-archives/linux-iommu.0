From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v9 06/13] iommu/amd: copy old trans table from old kernel
Date: Tue,  1 Aug 2017 19:37:22 +0800
Message-ID: <1501587449-9817-7-git-send-email-bhe@redhat.com>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501587449-9817-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Here several things need be done:
- If iommu is pre-enabled in a normal kernel, just disable it and print
  warning.

- If any one of IOMMUs is not pre-enabled in kdump kernel, just continue
  as it does in normal kernel.

- If failed to copy dev table of old kernel, continue to proceed as
  it does in normal kernel.

- Only if all IOMMUs are pre-enabled and copy dev table is done well, free
  the dev table allocated in early_amd_iommu_init() and make amd_iommu_dev_table
  point to the copied one.

- Disable and Re-enable event/cmd buffer,  install the copied DTE table
  to reg, and detect and enable guest vapic.

- Flush all caches

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c | 57 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index ab6794539527..e3d8af9d9636 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -37,6 +37,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 
+#include <linux/crash_dump.h>
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
@@ -1498,9 +1499,12 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
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
@@ -1995,8 +1999,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 }
 
 /*
- * Init the device table to not allow DMA access for devices and
- * suppress all page faults
+ * Init the device table to not allow DMA access for devices
  */
 static void init_device_table_dma(void)
 {
@@ -2137,9 +2140,49 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
+	bool is_pre_disabled = false;
 
-	for_each_iommu(iommu)
-		early_enable_iommu(iommu);
+	for_each_iommu(iommu) {
+		if (!translation_pre_enabled(iommu)) {
+			is_pre_disabled = true;
+			break;
+		}
+	}
+
+	if (is_pre_disabled) {
+		for_each_iommu(iommu)
+			early_enable_iommu(iommu);
+	} else {
+		pr_warn("Translation is already enabled - trying to copy translation structures\n");
+		if (copy_device_table()) {
+			pr_err("Failed to copy DEV table from previous kernel.\n");
+			/*
+			 * If failed to copy dev tables from old kernel, continue to proceed
+			 * as it does in normal kernel.
+			 */
+			if(old_dev_tbl_cpy != NULL)
+				free_pages((unsigned long)old_dev_tbl_cpy,
+						get_order(dev_table_size));
+			for_each_iommu(iommu) {
+				clear_translation_pre_enabled(iommu);
+				early_enable_iommu(iommu);
+			}
+		} else {
+			pr_info("Copied DEV table from previous kernel.\n");
+			free_pages((unsigned long)amd_iommu_dev_table,
+					get_order(dev_table_size));
+			amd_iommu_dev_table = old_dev_tbl_cpy;
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
