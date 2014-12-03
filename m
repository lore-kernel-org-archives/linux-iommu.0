From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v2 04/25] iommu,
	x86: Implement irq_set_vcpu_affinity for intel_ir_chip
Date: Wed,  3 Dec 2014 15:39:33 +0800
Message-ID: <1417592394-24343-5-git-send-email-feng.wu@intel.com>
References: <1417592394-24343-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417592394-24343-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement irq_set_vcpu_affinity for intel_ir_chip.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 arch/x86/include/asm/irq_remapping.h |    5 +++++
 drivers/iommu/intel_irq_remapping.c  |   27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index f67ae08..f87ac70 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -60,6 +60,11 @@ static inline struct irq_domain *arch_get_ir_parent_domain(void)
 	return x86_vector_domain;
 }
 
+struct vcpu_data {
+	u64 pi_desc_addr;	/* Physical address of PI Descriptor */
+	u32 vector;		/* Guest vector of the interrupt */
+};
+
 #else  /* CONFIG_IRQ_REMAP */
 
 static inline void setup_irq_remapping_ops(void) { }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f6da3b2..749cb93 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1010,10 +1010,37 @@ static void intel_ir_compose_msi_msg(struct irq_data *irq_data,
 	*msg = ir_data->msi_entry;
 }
 
+static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
+{
+	struct intel_ir_data *ir_data = data->chip_data;
+	struct irte *irte = &ir_data->irte_entry;
+	struct irte_pi *irte_pi = (struct irte_pi *)irte;
+	struct vcpu_data *vcpu_pi_info = (struct vcpu_data *)vcpu_info;
+
+	irte_pi->urg = 0;
+	irte_pi->vector = vcpu_pi_info->vector;
+	irte_pi->pda_l = (vcpu_pi_info->pi_desc_addr >> (32 - PDA_LOW_BIT)) &
+			 ~(-1UL << PDA_LOW_BIT);
+	irte_pi->pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
+			 ~(-1UL << PDA_HIGH_BIT);
+
+	irte_pi->__reserved_1 = 0;
+	irte_pi->__reserved_2 = 0;
+	irte_pi->__reserved_3 = 0;
+	irte_pi->__reserved_4 = 0;
+
+	irte_pi->pst = 1;
+
+	modify_irte(&ir_data->irq_2_iommu, irte);
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
1.7.1
