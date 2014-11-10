From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/13] KVM: Update Posted-Interrupts descriptor during VCPU
	scheduling
Date: Mon, 10 Nov 2014 14:26:47 +0800
Message-ID: <1415600812-27773-9-git-send-email-feng.wu@intel.com>
References: <1415600812-27773-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415600812-27773-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Update Posted-Interrupts descriptor according to the
following rules:
- Before VCPU block, set 'NV' to POSTED_INTR_WAKEUP_VECTOR
- After VCPU block, set 'NV' back to POSTED_INTR_VECTOR

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |    5 ++
 arch/x86/kvm/vmx.c              |   83 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |   16 +++++++
 virt/kvm/kvm_main.c             |   11 +++++
 4 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0630161..71cfe3e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -773,6 +773,8 @@ struct kvm_x86_ops {
 
 	void (*sched_in)(struct kvm_vcpu *kvm, int cpu);
 	u64 (*get_pi_desc_addr)(struct kvm_vcpu *vcpu);
+	int (*vcpu_pre_block)(struct kvm_vcpu *vcpu);
+	void (*vcpu_post_block)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_arch_async_pf {
@@ -1095,4 +1097,7 @@ int kvm_pmu_read_pmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
 void kvm_handle_pmu_event(struct kvm_vcpu *vcpu);
 void kvm_deliver_pmi(struct kvm_vcpu *vcpu);
 
+int kvm_arch_vcpu_pre_block(struct kvm_vcpu *vcpu);
+void kvm_arch_vcpu_post_block(struct kvm_vcpu *vcpu);
+
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index f41111f..4c1a966 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9153,6 +9153,86 @@ static void vmx_sched_in(struct kvm_vcpu *vcpu, int cpu)
 		shrink_ple_window(vcpu);
 }
 
+static int vmx_vcpu_pre_block(struct kvm_vcpu *vcpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct pi_desc old;
+	struct pi_desc new;
+
+	if (!irq_post_enabled)
+		return 0;
+
+	memset(&old, 0, sizeof(old));
+	memset(&new, 0, sizeof(new));
+
+	do {
+		old.control = new.control = pi_desc->control;
+
+		/*
+		 * A posted-interrupt happened in the one of the
+		 * following two cases:
+		 * 1. After the latest pir-to-virr sync operation
+		 * in kvm_arch_vcpu_runnable() function
+		 * 2. In this do-while() loop, a posted-interrupt
+		 * occurs.
+		 *
+		 * For either of above cases, we should not block
+		 * the VCPU.
+		 */
+		if (pi_test_on(pi_desc) == 1) {
+			/*
+			 * Need to set this flag, then the inject will
+			 * be synced from PIR to vIRR before VM-ENTRY.
+			 * In fact, for guest IPI case, in function
+			 * vmx_deliver_posted_interrupt(), this flags
+			 * has already been set, but if the interrupt
+			 * is injected by VT-d PI hardware, we need
+			 * to set this.
+			 */
+			kvm_make_request(KVM_REQ_EVENT, vcpu);
+			return 1;
+		}
+
+		pi_clear_sn(&new);
+
+		/* set 'NV' to 'wakeup vector' */
+		new.nv = POSTED_INTR_WAKEUP_VECTOR;
+	} while (cmpxchg(&pi_desc->control, old.control, new.control)
+			!= old.control);
+
+	return 0;
+}
+
+static void vmx_vcpu_post_block(struct kvm_vcpu *vcpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct pi_desc old;
+	struct pi_desc new;
+	unsigned int dest = 0;
+
+	if (!irq_post_enabled)
+		return;
+
+	pi_set_sn(pi_desc);
+
+	do {
+		old.control = new.control = pi_desc->control;
+
+		dest = cpu_physical_id(vcpu->cpu);
+
+		if (x2apic_mode)
+			new.ndst = dest;
+		else
+			new.ndst = (dest << 8) & 0xFF00;
+
+		/* set 'NV' to 'notification vector' */
+		new.nv = POSTED_INTR_VECTOR;
+	} while (cmpxchg(&pi_desc->control, old.control, new.control)
+			!= old.control);
+
+	pi_clear_sn(pi_desc);
+}
+
 static struct kvm_x86_ops vmx_x86_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -9262,6 +9342,9 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.sched_in = vmx_sched_in,
 
 	.get_pi_desc_addr = vmx_get_pi_desc_addr,
+
+	.vcpu_pre_block = vmx_vcpu_pre_block,
+	.vcpu_post_block = vmx_vcpu_post_block,
 };
 
 static int __init vmx_init(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0c19d15..d0c8bb2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7746,6 +7746,22 @@ int kvm_update_pi_irte_common(struct kvm *kvm, struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+int kvm_arch_vcpu_pre_block(struct kvm_vcpu *vcpu)
+{
+	if (kvm_x86_ops->vcpu_pre_block)
+		return kvm_x86_ops->vcpu_pre_block(vcpu);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_arch_vcpu_pre_block);
+
+void kvm_arch_vcpu_post_block(struct kvm_vcpu *vcpu)
+{
+	if (kvm_x86_ops->vcpu_post_block)
+		kvm_x86_ops->vcpu_post_block(vcpu);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_vcpu_post_block);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 25ffac9..1be1a45 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1754,7 +1754,18 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 		if (signal_pending(current))
 			break;
 
+#ifdef CONFIG_X86
+		if (kvm_arch_vcpu_pre_block(vcpu) == 1) {
+			kvm_make_request(KVM_REQ_UNHALT, vcpu);
+			break;
+		}
+#endif
+
 		schedule();
+
+#ifdef CONFIG_X86
+		kvm_arch_vcpu_post_block(vcpu);
+#endif
 	}
 
 	finish_wait(&vcpu->wq, &wait);
-- 
1.7.1
