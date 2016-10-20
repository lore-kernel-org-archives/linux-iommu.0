From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 1/9] iommu/amd: Detect pre enabled translation
Date: Thu, 20 Oct 2016 19:37:12 +0800
Message-ID: <1476963440-23039-2-git-send-email-bhe@redhat.com>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476963440-23039-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, Vincent.Wan@amd.com, dyoung@redhat.com, xlpang@redhat.com, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Add functions to check whether translation is already enabled in IOMMU.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu_init.c  | 25 +++++++++++++++++++++++++
 drivers/iommu/amd_iommu_proto.h |  1 +
 drivers/iommu/amd_iommu_types.h |  4 ++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 157e934..1628d7e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -251,6 +251,26 @@ static int amd_iommu_enable_interrupts(void);
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
+	iommu->flags &= ~AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
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
@@ -1389,6 +1409,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 
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
index 7eb60c1..9560183 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -93,4 +93,5 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 f)
 	return !!(iommu->features & f);
 }
 
+extern bool translation_pre_enabled(struct amd_iommu *iommu);
 #endif /* _ASM_X86_AMD_IOMMU_PROTO_H  */
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 0d91785..2bbc19d 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -416,6 +416,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
 
 
+
 /*
  * This struct is used to pass information about
  * incoming PPR faults around.
@@ -434,6 +435,8 @@ struct iommu_domain;
 struct irq_domain;
 struct amd_irte_ops;
 
+#define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -566,6 +569,7 @@ struct amd_iommu {
 	struct amd_irte_ops *irte_ops;
 #endif
 
+	u32 flags;
 	volatile u64 __aligned(8) cmd_sem;
 };
 
-- 
2.5.5
