From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v5 1/8] iommu/amd: Detect pre enabled translation
Date: Thu, 15 Sep 2016 23:03:19 +0800
Message-ID: <1473951806-25511-2-git-send-email-bhe@redhat.com>
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

Add functions to check whether translation is already enabled in IOMMU.

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 25 +++++++++++++++++++++++++
 drivers/iommu/amd_iommu_proto.h |  1 +
 drivers/iommu/amd_iommu_types.h |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 59741ea..9bf1a04 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -247,6 +247,26 @@ static int amd_iommu_enable_interrupts(void);
 static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(void);
 
+
+bool translation_pre_enabled(struct amd_iommu *iommu)
+{
+	return (iommu->flags & AMD_IOMMU_FLAG_TRANS_PRE_ENABLED);
+}
+
+static void clear_translation_pre_enabled(struct amd_iommu *iommu)
+{
+        iommu->flags &= ~AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
+}
+
+static void init_translation_status(struct amd_iommu *iommu)
+{
+	u32 ctrl;
+
+	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	if (ctrl & (1<<CONTROL_IOMMU_EN))
+		iommu->flags |= AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
+}
+
 static int iommu_pc_get_set_reg_val(struct amd_iommu *iommu,
 				    u8 bank, u8 cntr, u8 fxn,
 				    u64 *value, bool is_write);
@@ -1283,6 +1303,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
 	iommu->int_enabled = false;
 
+	init_translation_status(iommu);
+
+	if (translation_pre_enabled(iommu))
+		pr_warn("Translation is already enabled - trying to copy translation structures\n");
+
 	ret = init_iommu_from_acpi(iommu, h);
 	if (ret)
 		return ret;
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 0bd9eb3..f066e01 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -98,4 +98,5 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
 	return !!(iommu->features & f);
 }
 
+extern bool translation_pre_enabled(struct amd_iommu *iommu);
 #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index caf5e38..7781953 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -384,6 +384,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
 
 
+
 /*
  * This struct is used to pass information about
  * incoming PPR faults around.
@@ -401,6 +402,8 @@ struct amd_iommu_fault {
 struct iommu_domain;
 struct irq_domain;
 
+#define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -524,6 +527,7 @@ struct amd_iommu {
 	struct irq_domain *ir_domain;
 	struct irq_domain *msi_domain;
 #endif
+	u32 flags;
 };
 
 #define ACPIHID_UID_LEN 256
-- 
2.5.5
