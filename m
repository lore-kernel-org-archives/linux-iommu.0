From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 07/13] KVM: x86: Update IRTE for posted-interrupts
Date: Wed, 16 Sep 2015 16:50:03 +0800
Message-ID: <1442393409-2623-8-git-send-email-feng.wu@intel.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442393409-2623-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
v8:
- Move 'kvm_arch_update_pi_irte' to vmx.c as a callback
- Only update the PI irte when VM has assigned devices
- Add a trace point for VT-d posted-interrupts when we update
  or disable it for a specific irq.

 arch/x86/include/asm/kvm_host.h |  3 ++
 arch/x86/kvm/trace.h            | 33 ++++++++++++++++
 arch/x86/kvm/vmx.c              | 83 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  2 +
 4 files changed, 121 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index daa6126..8c44286 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -862,6 +862,9 @@ struct kvm_x86_ops {
 					   gfn_t offset, unsigned long mask);
 	/* pmu operations of sub-arch */
 	const struct kvm_pmu_ops *pmu_ops;
+
+	int (*update_pi_irte)(struct kvm *kvm, unsigned int host_irq,
+			      uint32_t guest_irq, bool set);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index 4eae7c3..539a9e4 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -974,6 +974,39 @@ TRACE_EVENT(kvm_enter_smm,
 		  __entry->smbase)
 );
 
+/*
+ * Tracepoint for VT-d posted-interrupts.
+ */
+TRACE_EVENT(kvm_pi_irte_update,
+	TP_PROTO(unsigned int vcpu_id, unsigned int gsi,
+		 unsigned int gvec, u64 pi_desc_addr, bool set),
+	TP_ARGS(vcpu_id, gsi, gvec, pi_desc_addr, set),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	vcpu_id		)
+		__field(	unsigned int,	gsi		)
+		__field(	unsigned int,	gvec		)
+		__field(	u64,		pi_desc_addr	)
+		__field(	bool,		set		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id	= vcpu_id;
+		__entry->gsi		= gsi;
+		__entry->gvec		= gvec;
+		__entry->pi_desc_addr	= pi_desc_addr;
+		__entry->set		= set;
+	),
+
+	TP_printk("VT-d PI is %s for this irq, vcpu %u, gsi: 0x%x, "
+		  "gvec: 0x%x, pi_desc_addr: 0x%llx",
+		  __entry->set ? "enabled and being updated" : "disabled",
+		  __entry->vcpu_id,
+		  __entry->gsi,
+		  __entry->gvec,
+		  __entry->pi_desc_addr)
+);
+
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 316f9bf..5a25651 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -45,6 +45,7 @@
 #include <asm/debugreg.h>
 #include <asm/kexec.h>
 #include <asm/apic.h>
+#include <asm/irq_remapping.h>
 
 #include "trace.h"
 #include "pmu.h"
@@ -605,6 +606,11 @@ static inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
 	return container_of(vcpu, struct vcpu_vmx, vcpu);
 }
 
+struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
+{
+	return &(to_vmx(vcpu)->pi_desc);
+}
+
 #define VMCS12_OFFSET(x) offsetof(struct vmcs12, x)
 #define FIELD(number, name)	[number] = VMCS12_OFFSET(name)
 #define FIELD64(number, name)	[number] = VMCS12_OFFSET(name), \
@@ -10344,6 +10350,81 @@ static void vmx_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_mmu_clear_dirty_pt_masked(kvm, memslot, offset, mask);
 }
 
+/*
+ * vmx_update_pi_irte - set IRTE for Posted-Interrupts
+ *
+ * @kvm: kvm
+ * @host_irq: host irq of the interrupt
+ * @guest_irq: gsi of the interrupt
+ * @set: set or unset PI
+ * returns 0 on success, < 0 on failure
+ */
+int vmx_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+		       uint32_t guest_irq, bool set)
+{
+	struct kvm_kernel_irq_routing_entry *e;
+	struct kvm_irq_routing_table *irq_rt;
+	struct kvm_lapic_irq irq;
+	struct kvm_vcpu *vcpu;
+	struct vcpu_data vcpu_info;
+	int idx, ret = -EINVAL;
+
+	if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
+		(!kvm_arch_has_assigned_device(kvm)))
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
+		 * interrupts to a vCPU, we still use interrupt remapping
+		 * for these kind of interrupts.
+		 *
+		 * For lowest-priority interrupts, we only support
+		 * those with single CPU as the destination, e.g. user
+		 * configures the interrupts via /proc/irq or uses
+		 * irqbalance to make the interrupts single-CPU.
+		 *
+		 * We will support full lowest-priority interrupt later.
+		 */
+
+		kvm_set_msi_irq(e, &irq);
+		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu))
+			continue;
+
+		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
+		vcpu_info.vector = irq.vector;
+
+		trace_kvm_pi_irte_update(vcpu->vcpu_id, e->gsi,
+				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
+
+		if (set)
+			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
+		else {
+			/* suppress notification event before unposting */
+			pi_set_sn(vcpu_to_pi_desc(vcpu));
+			ret = irq_set_vcpu_affinity(host_irq, NULL);
+			pi_clear_sn(vcpu_to_pi_desc(vcpu));
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
 static struct kvm_x86_ops vmx_x86_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -10461,6 +10542,8 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.enable_log_dirty_pt_masked = vmx_enable_log_dirty_pt_masked,
 
 	.pmu_ops = &intel_pmu_ops,
+
+	.update_pi_irte = vmx_update_pi_irte,
 };
 
 static int __init vmx_init(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5ef2560..9dcd501 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -63,6 +63,7 @@
 #include <asm/fpu/internal.h> /* Ugh! */
 #include <asm/pvclock.h>
 #include <asm/div64.h>
+#include <asm/irq_remapping.h>
 
 #define MAX_IO_MSRS 256
 #define KVM_MAX_MCE_BANKS 32
@@ -8263,3 +8264,4 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_nested_intercepts);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_write_tsc_offset);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ple_window);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pml_full);
+EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pi_irte_update);
-- 
2.1.0
