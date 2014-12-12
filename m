From: Feng Wu <feng.wu@intel.com>
Subject: [v3 02/26] iommu: Add new member capability to struct irq_remap_ops
Date: Fri, 12 Dec 2014 23:14:36 +0800
Message-ID: <1418397300-10870-3-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, pbonzini@redhat.com, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com
Cc: eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds a new member capability to struct irq_remap_ops,
this new function ops can be used to check whether some
features are supported, such as VT-d Posted-Interrupts.

Signed-off-by: Feng Wu <feng.wu@intel.com>
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/include/asm/irq_remapping.h | 4 ++++
 drivers/iommu/irq_remapping.h        | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 6ba2431..f67ae08 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -31,6 +31,10 @@ struct irq_alloc_info;
 
 #ifdef CONFIG_IRQ_REMAP
 
+enum irq_remap_cap {
+	IRQ_POSTING_CAP = 0,
+};
+
 extern void setup_irq_remapping_ops(void);
 extern int irq_remapping_supported(void);
 extern void set_irq_remapping_broken(void);
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 4bd791d..2d991b2 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -28,6 +28,7 @@ struct irq_data;
 struct msi_msg;
 struct irq_domain;
 struct irq_alloc_info;
+enum irq_remap_cap;
 
 extern int disable_irq_remap;
 extern int irq_remap_broken;
@@ -39,6 +40,9 @@ struct irq_remap_ops {
 	/* Check whether Interrupt Remapping is supported */
 	int (*supported)(void);
 
+	/* Check some capability is supported */
+	bool (*capability)(enum irq_remap_cap);
+
 	/* Initializes hardware and makes it ready for remapping interrupts */
 	int  (*prepare)(void);
 
-- 
1.9.1
