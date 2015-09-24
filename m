From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/10] iommu/amd: Detect pre enabled translation
Date: Thu, 24 Sep 2015 14:37:30 +0800
Message-ID: <1443076656-31776-5-git-send-email-bhe@redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443076656-31776-1-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add functions to check whether translation is already enabled in IOMMU.
Maybe it need be checked per IOMMU. Currently for debugging I didn't do
like that.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_proto.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 5845918..1fc369e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -229,6 +229,27 @@ static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
+static u8 g_pre_enabled;
+
+bool translation_pre_enabled(void)
+{
+        return !!g_pre_enabled;
+}
+
+void clear_translation_pre_enabled(void)
+{
+        g_pre_enabled = 0;
+}
+
+static void init_translation_status(struct amd_iommu *iommu)
+{
+        u32 ctrl;
+
+        ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+        if (ctrl & (1<<CONTROL_IOMMU_EN))
+                g_pre_enabled = 1;
+}
+
 static inline void update_last_devid(u16 devid)
 {
 	if (devid > amd_iommu_last_bdf)
@@ -1142,6 +1163,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	iommu->int_enabled = false;
 
+	init_translation_status(iommu);
+
+	if (translation_pre_enabled())
+		pr_warn("Translation is already enabled - trying to copy translation structures\n");
+
 	ret = init_iommu_from_acpi(iommu, h);
 	if (ret)
 		return ret;
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 0bd9eb3..743e209 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -98,4 +98,8 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
 	return !!(iommu->features & f);
 }
 
+/* kdump checking  */
+extern bool translation_pre_enabled(void);
+extern void clear_translation_pre_enabled(void);
+
 #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
-- 
2.4.0
