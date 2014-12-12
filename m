From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 13/26] KVM: Define a new interface kvm_find_dest_vcpu() for VT-d
	PI
Date: Fri, 12 Dec 2014 23:14:47 +0800
Message-ID: <1418397300-10870-14-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch defines a new interface kvm_find_dest_vcpu for
VT-d PI, which can returns the destination vCPU of the
interrupt for guests.

Since VT-d PI cannot handle broadcast/multicast interrupt,
Here we only handle Fixed and Lowest priority interrupts.

The current method of handling guest lowest priority interrtups
is to use a counter 'apic_arb_prio' for each vCPU, we choose the
vCPU with smallest 'apic_arb_prio' and then increase it by 1.
However, for VT-d PI, we cannot re-use this, since we no longer
have control to 'apic_arb_prio' with posted interrupt direct
delivery by Hardware.

Here, we introduce a similar way with 'apic_arb_prio' to handle
guest lowest priority interrtups when VT-d PI is used. Here is the
ideas:
- Each vCPU has a counter 'round_robin_counter'.
- When guests sets an interrupts to lowest priority, we choose
the vCPU with smallest 'round_robin_counter' as the destination,
then increase it.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |  4 ++++
 virt/kvm/irq_comm.c             | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6ed0c30..7a41808 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -358,6 +358,7 @@ struct kvm_vcpu_arch {
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	unsigned long apic_attention;
 	int32_t apic_arb_prio;
+	int32_t round_robin_counter;
 	int mp_state;
 	u64 ia32_misc_enable_msr;
 	bool tpr_access_reporting;
@@ -1093,4 +1094,7 @@ int kvm_pmu_read_pmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 void kvm_handle_pmu_event(struct kvm_vcpu *vcpu);
 void kvm_deliver_pmi(struct kvm_vcpu *vcpu);
 
+bool kvm_find_dest_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
+			struct kvm_vcpu **dest_vcpu);
+
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/virt/kvm/irq_comm.c b/virt/kvm/irq_comm.c
index 963b899..f3c5d69 100644
--- a/virt/kvm/irq_comm.c
+++ b/virt/kvm/irq_comm.c
@@ -317,6 +317,47 @@ out:
 	return r;
 }
 
+int kvm_compare_rr_counter(struct kvm_vcpu *vcpu1, struct kvm_vcpu *vcpu2)
+{
+	return vcpu1->arch.round_robin_counter -
+			vcpu2->arch.round_robin_counter;
+}
+
+bool kvm_find_dest_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
+				struct kvm_vcpu **dest_vcpu)
+{
+	int i, r = 0;
+	struct kvm_vcpu *vcpu, *dest = NULL;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!kvm_apic_present(vcpu))
+			continue;
+
+		if (!kvm_apic_match_dest(vcpu, NULL, irq->shorthand,
+					irq->dest_id, irq->dest_mode))
+			continue;
+
+		if (!kvm_is_dm_lowest_prio(irq)) {
+			r++;
+			*dest_vcpu = vcpu;
+		} else if (kvm_lapic_enabled(vcpu)) {
+			if (!dest)
+				dest = vcpu;
+			else if (kvm_compare_rr_counter(vcpu, dest) < 0)
+				dest = vcpu;
+		}
+	}
+
+	if (dest) {
+		dest->arch.round_robin_counter++;
+		*dest_vcpu = dest;
+		return true;
+	} else if (r == 1)
+		return true;
+
+	return false;
+}
+
 #define IOAPIC_ROUTING_ENTRY(irq) \
 	{ .gsi = irq, .type = KVM_IRQ_ROUTING_IRQCHIP,	\
 	  .u.irqchip = { .irqchip = KVM_IRQCHIP_IOAPIC, .pin = (irq) } }
-- 
1.9.1
