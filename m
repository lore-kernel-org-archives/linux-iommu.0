From: Feng Wu <feng.wu@intel.com>
Subject: [v10 04/10] iommu, x86: Implement irq_set_vcpu_affinity for intel_ir_chip
Date: Tue,  9 Jun 2015 13:20:31 +0800
Message-ID: <1433827237-3382-5-git-send-email-feng.wu@intel.com>
References: <1433827237-3382-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433827237-3382-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org, tglx@linutronix.de
Cc: jiang.liu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Interrupt chip callback to set the VCPU affinity for posted interrupts.

[ tglx: Use the helper function to copy from the remap irte instead of
        open coding it. Massage the comment as well ]

Signed-off-by: Feng Wu <feng.wu@intel.com>
Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
Acked-by: David Woodhouse <David.Woodhouse@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/irq_remapping.h |  5 +++++
 drivers/iommu/intel_irq_remapping.c  | 37 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 8b432dd..e479fbd 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -57,6 +57,11 @@ static inline struct irq_domain *arch_get_ir_parent_domain(void)
 	return x86_vector_domain;
 }
 
+struct vcpu_data {
+	u64 pi_desc_addr;	/* Physical address of PI Descriptor */
+	u32 vector;		/* Guest vector of the interrupt */
+};
+
 #else  /* CONFIG_IRQ_REMAP */
 
 static inline void set_irq_remapping_broken(void) { }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 8fad71c..a643eec 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1013,10 +1013,47 @@ static void intel_ir_compose_msi_msg(struct irq_data *irq_data,
 	*msg = ir_data->msi_entry;
 }
 
+static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
+{
+	struct intel_ir_data *ir_data = data->chip_data;
+	struct vcpu_data *vcpu_pi_info = info;
+
+	/* stop posting interrupts, back to remapping mode */
+	if (!vcpu_pi_info) {
+		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
+	} else {
+		struct irte irte_pi;
+
+		/*
+		 * We are not caching the posted interrupt entry. We
+		 * copy the data from the remapped entry and modify
+		 * the fields which are relevant for posted mode. The
+		 * cached remapped entry is used for switching back to
+		 * remapped mode.
+		 */
+		memset(&irte_pi, 0, sizeof(irte_pi));
+		dmar_copy_shared_irte(&irte_pi, &ir_data->irte_entry);
+
+		/* Update the posted mode fields */
+		irte_pi.p_pst = 1;
+		irte_pi.p_urgent = 0;
+		irte_pi.p_vector = vcpu_pi_info->vector;
+		irte_pi.pda_l = (vcpu_pi_info->pi_desc_addr >>
+				(32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
+		irte_pi.pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
+				~(-1UL << PDA_HIGH_BIT);
+
+		modify_irte(&ir_data->irq_2_iommu, &irte_pi);
+	}
+
+	return 0;
+}
+
 static struct irq_chip intel_ir_chip = {
 	.irq_ack = ir_ack_apic_edge,
 	.irq_set_affinity = intel_ir_set_affinity,
 	.irq_compose_msi_msg = intel_ir_compose_msi_msg,
+	.irq_set_vcpu_affinity = intel_ir_set_vcpu_affinity,
 };
 
 static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
-- 
2.1.0
