From: Feng Wu <feng.wu@intel.com>
Subject: [v5 1/9] iommu: Add new member capability to struct irq_remap_ops
Date: Wed, 20 May 2015 13:15:29 +0800
Message-ID: <1432098937-19527-2-git-send-email-feng.wu@intel.com>
References: <1432098937-19527-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432098937-19527-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: tglx@linutronix.de, jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds a new member capability to struct irq_remap_ops,
this new function ops can be used to check whether some
features are supported, such as VT-d Posted-Interrupts.

Signed-off-by: Feng Wu <feng.wu@intel.com>
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/x86/include/asm/irq_remapping.h | 4 ++++
 drivers/iommu/irq_remapping.h        | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 78974fb..0953723 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -31,6 +31,10 @@ struct irq_alloc_info;
 
 #ifdef CONFIG_IRQ_REMAP
 
+enum irq_remap_cap {
+	IRQ_POSTING_CAP = 0,
+};
+
 extern void set_irq_remapping_broken(void);
 extern int irq_remapping_prepare(void);
 extern int irq_remapping_enable(void);
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 91d5a11..b6ca30d 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -35,6 +35,9 @@ extern int no_x2apic_optout;
 extern int irq_remapping_enabled;
 
 struct irq_remap_ops {
+	/* The supported capabilities */
+	int capability;
+
 	/* Initializes hardware and makes it ready for remapping interrupts */
 	int  (*prepare)(void);
 
-- 
2.1.0
