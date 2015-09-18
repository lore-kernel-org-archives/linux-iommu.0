From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v9 17/18] KVM: Update Posted-Interrupts Descriptor when vCPU
	is blocked
Date: Fri, 18 Sep 2015 22:29:55 +0800
Message-ID: <1442586596-5920-18-git-send-email-feng.wu@intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442586596-5920-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
v9:
- Add description for blocked_vcpu_on_cpu_lock in Documentation/virtual/kvm/locking.txt
- Check !kvm_arch_has_assigned_device(vcpu->kvm) first, then
  !irq_remapping_cap(IRQ_POSTING_CAP)

v8:
- Rename 'pi_pre_block' to 'pre_block'
- Rename 'pi_post_block' to 'post_block'
- Change some comments
- Only add the vCPU to the blocking list when the VM has assigned devices.

 Documentation/virtual/kvm/locking.txt |  12 +++
 arch/x86/include/asm/kvm_host.h       |  13 +++
 arch/x86/kvm/vmx.c                    | 153 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c                    |  53 +++++++++---
 include/linux/kvm_host.h              |   3 +
 virt/kvm/kvm_main.c                   |   3 +
 6 files changed, 227 insertions(+), 10 deletions(-)

diff --git a/Documentation/virtual/kvm/locking.txt b/Documentation/virtual/kvm/locking.txt
index d68af4d..19f94a6 100644
--- a/Documentation/virtual/kvm/locking.txt
+++ b/Documentation/virtual/kvm/locking.txt
@@ -166,3 +166,15 @@ Comment:	The srcu read lock must be held while accessing memslots (e.g.
 		MMIO/PIO address->device structure mapping (kvm->buses).
 		The srcu index can be stored in kvm_vcpu->srcu_idx per vcpu
 		if it is needed by multiple functions.
+
+Name:		blocked_vcpu_on_cpu_lock
+Type:		spinlock_t
+Arch:		x86
+Protects:	blocked_vcpu_on_cpu
+Comment:	This is a per-CPU lock and it is used for VT-d posted-interrupts.
+		When VT-d posted-interrupts is supported and the VM has assigned
+		devices, we put the blocked vCPU on the list blocked_vcpu_on_cpu
+		protected by blocked_vcpu_on_cpu_lock, when VT-d hardware issues
+		wakeup notification event since external interrupts from the
+		assigned devices happens, we will find the vCPU on the list to
+		wakeup.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0ddd353..304fbb5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -552,6 +552,8 @@ struct kvm_vcpu_arch {
 	 */
 	bool write_fault_to_shadow_pgtable;
 
+	bool halted;
+
 	/* set at EPT violation at this point */
 	unsigned long exit_qualification;
 
@@ -864,6 +866,17 @@ struct kvm_x86_ops {
 	/* pmu operations of sub-arch */
 	const struct kvm_pmu_ops *pmu_ops;
 
+	/*
+	 * Architecture specific hooks for vCPU blocking due to
+	 * HLT instruction.
+	 * Returns for .pre_block():
+	 *    - 0 means continue to block the vCPU.
+	 *    - 1 means we cannot block the vCPU since some event
+	 *        happens during this period, such as, 'ON' bit in
+	 *        posted-interrupts descriptor is set.
+	 */
+	int (*pre_block)(struct kvm_vcpu *vcpu);
+	void (*post_block)(struct kvm_vcpu *vcpu);
 	int (*update_pi_irte)(struct kvm *kvm, unsigned int host_irq,
 			      uint32_t guest_irq, bool set);
 };
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 902a67d..9968896 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -879,6 +879,13 @@ static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
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
@@ -2985,6 +2992,8 @@ static int hardware_enable(void)
 		return -EBUSY;
 
 	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
+	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
 
 	/*
 	 * Now we can enable the vmclear operation in kdump
@@ -6121,6 +6130,25 @@ static void update_ple_window_actual_max(void)
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
@@ -6305,6 +6333,8 @@ static __init int hardware_setup(void)
 		kvm_x86_ops->enable_log_dirty_pt_masked = NULL;
 	}
 
+	kvm_set_posted_intr_wakeup_handler(wakeup_handler);
+
 	return alloc_kvm_area();
 
 out8:
@@ -10430,6 +10460,126 @@ static void vmx_enable_log_dirty_pt_masked(struct kvm *kvm,
 }
 
 /*
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
+static int vmx_pre_block(struct kvm_vcpu *vcpu)
+{
+	unsigned long flags;
+	unsigned int dest;
+	struct pi_desc old, new;
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+
+	if (!kvm_arch_has_assigned_device(vcpu->kvm) ||
+		!irq_remapping_cap(IRQ_POSTING_CAP))
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
+static void vmx_post_block(struct kvm_vcpu *vcpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct pi_desc old, new;
+	unsigned int dest;
+	unsigned long flags;
+
+	if (!kvm_arch_has_assigned_device(vcpu->kvm) ||
+		!irq_remapping_cap(IRQ_POSTING_CAP))
+		return;
+
+	do {
+		old.control = new.control = pi_desc->control;
+
+		dest = cpu_physical_id(vcpu->cpu);
+
+		if (x2apic_enabled())
+			new.ndst = dest;
+		else
+			new.ndst = (dest << 8) & 0xFF00;
+
+		/* Allow posting non-urgent interrupts */
+		new.sn = 0;
+
+		/* set 'NV' to 'notification vector' */
+		new.nv = POSTED_INTR_VECTOR;
+	} while (cmpxchg(&pi_desc->control, old.control,
+			new.control) != old.control);
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
+/*
  * vmx_update_pi_irte - set IRTE for Posted-Interrupts
  *
  * @kvm: kvm
@@ -10620,6 +10770,9 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.flush_log_dirty = vmx_flush_log_dirty,
 	.enable_log_dirty_pt_masked = vmx_enable_log_dirty_pt_masked,
 
+	.pre_block = vmx_pre_block,
+	.post_block = vmx_post_block,
+
 	.pmu_ops = &intel_pmu_ops,
 
 	.update_pi_irte = vmx_update_pi_irte,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 58688aa..46f55b2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5869,7 +5869,12 @@ int kvm_vcpu_halt(struct kvm_vcpu *vcpu)
 {
 	++vcpu->stat.halt_exits;
 	if (irqchip_in_kernel(vcpu->kvm)) {
-		vcpu->arch.mp_state = KVM_MP_STATE_HALTED;
+		/* Handle posted-interrupt when vCPU is to be halted */
+		if (!kvm_x86_ops->pre_block ||
+				kvm_x86_ops->pre_block(vcpu) == 0) {
+			vcpu->arch.halted = true;
+			vcpu->arch.mp_state = KVM_MP_STATE_HALTED;
+		}
 		return 1;
 	} else {
 		vcpu->run->exit_reason = KVM_EXIT_HLT;
@@ -6518,6 +6523,20 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_vcpu_reload_apic_access_page(vcpu);
 	}
 
+	/*
+	 * KVM_REQ_EVENT is not set when posted interrupts are set by
+	 * VT-d hardware, so we have to update RVI unconditionally.
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
@@ -6711,10 +6723,31 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 
 	for (;;) {
 		if (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
-		    !vcpu->arch.apf.halted)
+		    !vcpu->arch.apf.halted) {
+			/*
+			 * For some cases, we can get here with
+			 * vcpu->arch.halted being true.
+			 */
+			if (kvm_x86_ops->post_block && vcpu->arch.halted) {
+				kvm_x86_ops->post_block(vcpu);
+				vcpu->arch.halted = false;
+			}
+
 			r = vcpu_enter_guest(vcpu);
-		else
+		} else {
 			r = vcpu_block(kvm, vcpu);
+
+			/*
+			 * post_block() must be called after
+			 * pre_block() which is called in
+			 * kvm_vcpu_halt().
+			 */
+			if (kvm_x86_ops->post_block && vcpu->arch.halted) {
+				kvm_x86_ops->post_block(vcpu);
+				vcpu->arch.halted = false;
+			}
+		}
+
 		if (r <= 0)
 			break;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index feba1fb..bf462e7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -231,6 +231,9 @@ struct kvm_vcpu {
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
