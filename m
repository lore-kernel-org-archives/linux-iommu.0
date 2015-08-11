From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 10/16] KVM: x86: Update IRTE for posted-interrupts
Date: Tue, 11 Aug 2015 14:03:52 +0800
Message-ID: <1439273038-59463-11-git-send-email-feng.wu@intel.com>
References: <1439273038-59463-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1439273038-59463-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds the routine to update IRTE for posted-interrupts
when guest changes the interrupt configuration.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/kvm/x86.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5ef2560..8f09a76 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -63,6 +63,7 @@
 #include <asm/fpu/internal.h> /* Ugh! */
 #include <asm/pvclock.h>
 #include <asm/div64.h>
+#include <asm/irq_remapping.h>
 
 #define MAX_IO_MSRS 256
 #define KVM_MAX_MCE_BANKS 32
@@ -8248,6 +8249,78 @@ bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_arch_has_noncoherent_dma);
 
+/*
+ * kvm_arch_update_pi_irte - set IRTE for Posted-Interrupts
+ *
+ * @kvm: kvm
+ * @host_irq: host irq of the interrupt
+ * @guest_irq: gsi of the interrupt
+ * @set: set or unset PI
+ * returns 0 on success, < 0 on failure
+ */
+int kvm_arch_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+			    uint32_t guest_irq, bool set)
+{
+	struct kvm_kernel_irq_routing_entry *e;
+	struct kvm_irq_routing_table *irq_rt;
+	struct kvm_lapic_irq irq;
+	struct kvm_vcpu *vcpu;
+	struct vcpu_data vcpu_info;
+	int idx, ret = -EINVAL;
+
+	if (!irq_remapping_cap(IRQ_POSTING_CAP))
+		return 0;
+
+	idx = srcu_read_lock(&kvm->irq_srcu);
+	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
+	BUG_ON(guest_irq >= irq_rt->nr_rt_entries);
+
+	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
+		if (e->type != KVM_IRQ_ROUTING_MSI)
+			continue;
+		/*
+		 * VT-d PI cannot support posting multicast/broadcast
+		 * interrupts to a VCPU, we still use interrupt remapping
+		 * for these kind of interrupts.
+		 *
+		 * For lowest-priority interrupts, we only support
+		 * those with single CPU as the destination, e.g. user
+		 * configures the interrupts via /proc/irq or uses
+		 * irqbalance to make the interrupts single-CPU.
+		 *
+		 * We will support full lowest-priority interrupt later.
+		 *
+		 */
+
+		kvm_set_msi_irq(e, &irq);
+		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu))
+			continue;
+
+		vcpu_info.pi_desc_addr = kvm_x86_ops->get_pi_desc_addr(vcpu);
+		vcpu_info.vector = irq.vector;
+
+		if (set)
+			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
+		else {
+			/* suppress notification event before unposting */
+			kvm_x86_ops->pi_set_sn(vcpu);
+			ret = irq_set_vcpu_affinity(host_irq, NULL);
+			kvm_x86_ops->pi_clear_sn(vcpu);
+		}
+
+		if (ret < 0) {
+			printk(KERN_INFO "%s: failed to update PI IRTE\n",
+					__func__);
+			goto out;
+		}
+	}
+
+	ret = 0;
+out:
+	srcu_read_unlock(&kvm->irq_srcu, idx);
+	return ret;
+}
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
-- 
2.1.0
