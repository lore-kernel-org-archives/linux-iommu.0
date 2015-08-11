From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 14/16] KVM: Update Posted-Interrupts Descriptor when vCPU
	is blocked
Date: Tue, 11 Aug 2015 14:03:56 +0800
Message-ID: <1439273038-59463-15-git-send-email-feng.wu@intel.com>
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

This patch updates the Posted-Interrupts Descriptor when vCPU
is blocked.

pre-block:
- Add the vCPU to the blocked per-CPU list
- Set 'NV' to POSTED_INTR_WAKEUP_VECTOR

post-block:
- Remove the vCPU from the per-CPU list

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/vmx.c              | 158 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  42 ++++++++---
 include/linux/kvm_host.h        |   3 +
 virt/kvm/kvm_main.c             |   3 +
 5 files changed, 199 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 22269b4..6bc11fb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -868,6 +868,9 @@ struct kvm_x86_ops {
 
 	void (*pi_clear_sn)(struct kvm_vcpu *vcpu);
 	void (*pi_set_sn)(struct kvm_vcpu *vcpu);
+
+	int (*pi_pre_block)(struct kvm_vcpu *vcpu);
+	void (*pi_post_block)(struct kvm_vcpu *vcpu);
 	/* pmu operations of sub-arch */
 	const struct kvm_pmu_ops *pmu_ops;
 };
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 20472ad..6b50eba 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -888,6 +888,13 @@ static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
 static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
 static DEFINE_PER_CPU(struct desc_ptr, host_gdt);
 
+/*
+ * We maintian a per-CPU linked-list of vCPU, so in wakeup_handler() we
+ * can find which vCPU should be waken up.
+ */
+static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
+static DEFINE_PER_CPU(spinlock_t, blocked_vcpu_on_cpu_lock);
+
 static unsigned long *vmx_io_bitmap_a;
 static unsigned long *vmx_io_bitmap_b;
 static unsigned long *vmx_msr_bitmap_legacy;
@@ -2964,6 +2971,8 @@ static int hardware_enable(void)
 		return -EBUSY;
 
 	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
+	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
 
 	/*
 	 * Now we can enable the vmclear operation in kdump
@@ -6089,6 +6098,25 @@ static void update_ple_window_actual_max(void)
 			                    ple_window_grow, INT_MIN);
 }
 
+/*
+ * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
+ */
+static void wakeup_handler(void)
+{
+	struct kvm_vcpu *vcpu;
+	int cpu = smp_processor_id();
+
+	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
+	list_for_each_entry(vcpu, &per_cpu(blocked_vcpu_on_cpu, cpu),
+			blocked_vcpu_list) {
+		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+
+		if (pi_test_on(pi_desc) == 1)
+			kvm_vcpu_kick(vcpu);
+	}
+	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
+}
+
 static __init int hardware_setup(void)
 {
 	int r = -ENOMEM, i, msr;
@@ -6273,6 +6301,8 @@ static __init int hardware_setup(void)
 		kvm_x86_ops->enable_log_dirty_pt_masked = NULL;
 	}
 
+	kvm_set_posted_intr_wakeup_handler(wakeup_handler);
+
 	return alloc_kvm_area();
 
 out8:
@@ -10397,6 +10427,131 @@ static void vmx_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_mmu_clear_dirty_pt_masked(kvm, memslot, offset, mask);
 }
 
+/*
+ * This routine does the following things for vCPU which is going
+ * to be blocked if VT-d PI is enabled.
+ * - Store the vCPU to the wakeup list, so when interrupts happen
+ *   we can find the right vCPU to wake up.
+ * - Change the Posted-interrupt descriptor as below:
+ *      'NDST' <-- vcpu->pre_pcpu
+ *      'NV' <-- POSTED_INTR_WAKEUP_VECTOR
+ * - If 'ON' is set during this process, which means at least one
+ *   interrupt is posted for this vCPU, we cannot block it, in
+ *   this case, return 1, otherwise, return 0.
+ *
+ */
+static int vmx_pi_pre_block(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+	unsigned int dest;
+	struct pi_desc old, new;
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+
+	if (!irq_remapping_cap(IRQ_POSTING_CAP))
+		return 0;
+
+	vcpu->pre_pcpu = vcpu->cpu;
+	spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
+			  vcpu->pre_pcpu), flags);
+	list_add_tail(&vcpu->blocked_vcpu_list,
+		      &per_cpu(blocked_vcpu_on_cpu,
+		      vcpu->pre_pcpu));
+	spin_unlock_irqrestore(&per_cpu(blocked_vcpu_on_cpu_lock,
+			       vcpu->pre_pcpu), flags);
+
+	do {
+		old.control = new.control = pi_desc->control;
+
+		/*
+		 * We should not block the vCPU if
+		 * an interrupt is posted for it.
+		 */
+		if (pi_test_on(pi_desc) == 1) {
+			spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
+					  vcpu->pre_pcpu), flags);
+			list_del(&vcpu->blocked_vcpu_list);
+			spin_unlock_irqrestore(
+					&per_cpu(blocked_vcpu_on_cpu_lock,
+					vcpu->pre_pcpu), flags);
+			vcpu->pre_pcpu = -1;
+
+			return 1;
+		}
+
+		WARN((pi_desc->sn == 1),
+		     "Warning: SN field of posted-interrupts "
+		     "is set before blocking\n");
+
+		/*
+		 * Since vCPU can be preempted during this process,
+		 * vcpu->cpu could be different with pre_pcpu, we
+		 * need to set pre_pcpu as the destination of wakeup
+		 * notification event, then we can find the right vCPU
+		 * to wakeup in wakeup handler if interrupts happen
+		 * when the vCPU is in blocked state.
+		 */
+		dest = cpu_physical_id(vcpu->pre_pcpu);
+
+		if (x2apic_enabled())
+			new.ndst = dest;
+		else
+			new.ndst = (dest << 8) & 0xFF00;
+
+		/* set 'NV' to 'wakeup vector' */
+		new.nv = POSTED_INTR_WAKEUP_VECTOR;
+	} while (cmpxchg(&pi_desc->control, old.control,
+			new.control) != old.control);
+
+	return 0;
+}
+
+static void vmx_pi_post_block(struct kvm_vcpu *vcpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct pi_desc old, new;
+	unsigned int dest;
+	unsigned long flags;
+
+	if (!irq_remapping_cap(IRQ_POSTING_CAP))
+		return;
+
+	/*
+	 * If the vCPU is not really blocked and vmx_vcpu_load()
+	 * doesn't have chance to run before this point, we should
+	 * set posted-interrupt descriptor back, just like what we
+	 * do in vmx_vcpu_load().
+	 */
+	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR)
+		do {
+			old.control = new.control = pi_desc->control;
+
+			dest = cpu_physical_id(vcpu->cpu);
+
+			if (x2apic_enabled())
+				new.ndst = dest;
+			else
+				new.ndst = (dest << 8) & 0xFF00;
+
+			/* Allow posting non-urgent interrupts */
+			new.sn = 0;
+
+			/* set 'NV' to 'notification vector' */
+			new.nv = POSTED_INTR_VECTOR;
+		} while (cmpxchg(&pi_desc->control, old.control,
+				new.control) != old.control);
+
+	if(vcpu->pre_pcpu != -1) {
+		spin_lock_irqsave(
+			&per_cpu(blocked_vcpu_on_cpu_lock,
+			vcpu->pre_pcpu), flags);
+		list_del(&vcpu->blocked_vcpu_list);
+		spin_unlock_irqrestore(
+			&per_cpu(blocked_vcpu_on_cpu_lock,
+			vcpu->pre_pcpu), flags);
+		vcpu->pre_pcpu = -1;
+	}
+}
+
 static struct kvm_x86_ops vmx_x86_ops = {
 	.cpu_has_kvm_support = cpu_has_kvm_support,
 	.disabled_by_bios = vmx_disabled_by_bios,
@@ -10518,6 +10673,9 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.pi_clear_sn = vmx_pi_clear_sn,
 	.pi_set_sn = vmx_pi_set_sn,
 
+	.pi_pre_block = vmx_pi_pre_block,
+	.pi_post_block = vmx_pi_post_block,
+
 	.pmu_ops = &intel_pmu_ops,
 };
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 74a1d83..953195e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5869,7 +5869,11 @@ int kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 {
 	++vcpu->stat.halt_exits;
 	if (irqchip_in_kernel(vcpu->kvm)) {
-		vcpu->arch.mp_state = KVM_MP_STATE_HALTED;
+		/* Handle posted-interrupt when vCPU is to be halted */
+		if (!kvm_x86_ops->pi_pre_block ||
+		    (kvm_x86_ops->pi_pre_block &&
+		    kvm_x86_ops->pi_pre_block(vcpu) == 0))
+			vcpu->arch.mp_state = KVM_MP_STATE_HALTED;
 		return 1;
 	} else {
 		vcpu->run->exit_reason = KVM_EXIT_HLT;
@@ -6518,6 +6522,21 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_vcpu_reload_apic_access_page(vcpu);
 	}
 
+	/*
+	 * Since posted-interrupts can be set by VT-d HW now, in this
+	 * case, KVM_REQ_EVENT is not set. We move the following
+	 * operations out of the if statement.
+	 */
+	if (kvm_lapic_enabled(vcpu)) {
+		/*
+		 * Update architecture specific hints for APIC
+		 * virtual interrupt delivery.
+		 */
+		if (kvm_x86_ops->hwapic_irr_update)
+			kvm_x86_ops->hwapic_irr_update(vcpu,
+				kvm_lapic_find_highest_irr(vcpu));
+	}
+
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
 		kvm_apic_accept_events(vcpu);
 		if (vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED) {
@@ -6534,13 +6553,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_x86_ops->enable_irq_window(vcpu);
 
 		if (kvm_lapic_enabled(vcpu)) {
-			/*
-			 * Update architecture specific hints for APIC
-			 * virtual interrupt delivery.
-			 */
-			if (kvm_x86_ops->hwapic_irr_update)
-				kvm_x86_ops->hwapic_irr_update(vcpu,
-					kvm_lapic_find_highest_irr(vcpu));
 			update_cr8_intercept(vcpu);
 			kvm_lapic_sync_to_vapic(vcpu);
 		}
@@ -6711,10 +6723,20 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 
 	for (;;) {
 		if (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
-		    !vcpu->arch.apf.halted)
+		    !vcpu->arch.apf.halted) {
 			r = vcpu_enter_guest(vcpu);
-		else
+		} else {
 			r = vcpu_block(kvm, vcpu);
+
+			/*
+			 * pi_post_block() must be called after
+			 * pi_pre_block() which is called in
+			 * kvm_vcpu_halt().
+			 */
+			if (kvm_x86_ops->pi_post_block)
+				kvm_x86_ops->pi_post_block(vcpu);
+		}
+
 		if (r <= 0)
 			break;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f4005dc..6aa69f4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -233,6 +233,9 @@ struct kvm_vcpu {
 	unsigned long requests;
 	unsigned long guest_debug;
 
+	int pre_pcpu;
+	struct list_head blocked_vcpu_list;
+
 	struct mutex mutex;
 	struct kvm_run *run;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b8a444..191c7eb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -220,6 +220,9 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	init_waitqueue_head(&vcpu->wq);
 	kvm_async_pf_vcpu_init(vcpu);
 
+	vcpu->pre_pcpu = -1;
+	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
+
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page) {
 		r = -ENOMEM;
-- 
2.1.0
