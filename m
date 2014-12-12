From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU is
	blocked
Date: Fri, 12 Dec 2014 23:14:58 +0800
Message-ID: <1418397300-10870-25-git-send-email-feng.wu@intel.com>
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

This patch updates the Posted-Interrupts Descriptor when vCPU
is blocked.

pre-block:
- Add the vCPU to the blocked per-CPU list
- Clear 'SN'
- Set 'NV' to POSTED_INTR_WAKEUP_VECTOR

post-block:
- Remove the vCPU from the per-CPU list

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/vmx.c              | 96 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              | 22 +++++++---
 include/linux/kvm_host.h        |  4 ++
 virt/kvm/kvm_main.c             |  6 +++
 5 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 13e3e40..32c110a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -101,6 +101,8 @@ static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
 
 #define ASYNC_PF_PER_VCPU 64
 
+extern void (*wakeup_handler_callback)(void);
+
 enum kvm_reg {
 	VCPU_REGS_RAX = 0,
 	VCPU_REGS_RCX = 1,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bf2e6cd..a1c83a2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -832,6 +832,13 @@ static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
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
@@ -1921,6 +1928,7 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 		struct pi_desc old, new;
 		unsigned int dest;
+		unsigned long flags;
 
 		memset(&old, 0, sizeof(old));
 		memset(&new, 0, sizeof(new));
@@ -1942,6 +1950,20 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 			new.nv = POSTED_INTR_VECTOR;
 		} while (cmpxchg(&pi_desc->control, old.control,
 				new.control) != old.control);
+
+		/*
+		 * Delete the vCPU from the related wakeup queue
+		 * if we are resuming from blocked state
+		 */
+		if (vcpu->blocked) {
+			vcpu->blocked = false;
+			spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
+				vcpu->wakeup_cpu), flags);
+			list_del(&vcpu->blocked_vcpu_list);
+			spin_unlock_irqrestore(&per_cpu(blocked_vcpu_on_cpu_lock,
+				vcpu->wakeup_cpu), flags);
+			vcpu->wakeup_cpu = -1;
+		}
 	}
 }
 
@@ -1950,6 +1972,9 @@ static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
 		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 		struct pi_desc old, new;
+		unsigned long flags;
+		int cpu;
+		struct cpumask cpu_others_mask;
 
 		memset(&old, 0, sizeof(old));
 		memset(&new, 0, sizeof(new));
@@ -1961,6 +1986,54 @@ static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 				pi_set_sn(&new);
 			} while (cmpxchg(&pi_desc->control, old.control,
 					new.control) != old.control);
+		} else if (vcpu->blocked) {
+			/*
+			 * The vcpu is blocked on the wait queue.
+			 * Store the blocked vCPU on the list of the
+			 * vcpu->wakeup_cpu, which is the destination
+			 * of the wake-up notification event.
+			 */
+			vcpu->wakeup_cpu = vcpu->cpu;
+			spin_lock_irqsave(&per_cpu(blocked_vcpu_on_cpu_lock,
+					  vcpu->wakeup_cpu), flags);
+			list_add_tail(&vcpu->blocked_vcpu_list,
+				      &per_cpu(blocked_vcpu_on_cpu,
+				      vcpu->wakeup_cpu));
+			spin_unlock_irqrestore(
+					&per_cpu(blocked_vcpu_on_cpu_lock,
+					vcpu->wakeup_cpu), flags);
+
+			do {
+				old.control = new.control = pi_desc->control;
+
+				/*
+				 * We should not block the vCPU if
+				 * an interrupt is posted for it.
+				 */
+				if (pi_test_on(pi_desc) == 1) {
+					/*
+					 * We need schedule the wakeup worker
+					 * on a different cpu other than
+					 * vcpu->cpu, because in some case,
+					 * schedule_work() will call
+					 * try_to_wake_up() which needs acquire
+					 * the rq lock. This can cause deadlock.
+					 */
+					cpumask_copy(&cpu_others_mask,
+						     cpu_online_mask);
+					cpu_clear(vcpu->cpu, cpu_others_mask);
+					cpu = any_online_cpu(cpu_others_mask);
+
+					schedule_work_on(cpu,
+							 &vcpu->wakeup_worker);
+				}
+
+				pi_clear_sn(&new);
+
+				/* set 'NV' to 'wakeup vector' */
+				new.nv = POSTED_INTR_WAKEUP_VECTOR;
+			} while (cmpxchg(&pi_desc->control, old.control,
+				new.control) != old.control);
 		}
 	}
 
@@ -2842,6 +2915,8 @@ static int hardware_enable(void)
 		return -EBUSY;
 
 	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
+	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
 
 	/*
 	 * Now we can enable the vmclear operation in kdump
@@ -9315,6 +9390,25 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.pi_set_sn = vmx_pi_set_sn,
 };
 
+/*
+ * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
+ */
+void wakeup_handler(void)
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
 static int __init vmx_init(void)
 {
 	int r, i, msr;
@@ -9429,6 +9523,8 @@ static int __init vmx_init(void)
 
 	update_ple_window_actual_max();
 
+	wakeup_handler_callback = wakeup_handler;
+
 	return 0;
 
 out7:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0033df3..1551a46 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6152,6 +6152,21 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
@@ -6168,13 +6183,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3d7242c..d981d16 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -239,6 +239,9 @@ struct kvm_vcpu {
 	unsigned long requests;
 	unsigned long guest_debug;
 
+	int wakeup_cpu;
+	struct list_head blocked_vcpu_list;
+
 	struct mutex mutex;
 	struct kvm_run *run;
 
@@ -282,6 +285,7 @@ struct kvm_vcpu {
 	} spin_loop;
 #endif
 	bool preempted;
+	bool blocked;
 	struct kvm_vcpu_arch arch;
 };
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ba53fd6..6deb994 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -233,6 +233,9 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 
 	INIT_WORK(&vcpu->wakeup_worker, wakeup_thread);
 
+	vcpu->wakeup_cpu = -1;
+	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
+
 	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!page) {
 		r = -ENOMEM;
@@ -243,6 +246,7 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
 	kvm_vcpu_set_dy_eligible(vcpu, false);
 	vcpu->preempted = false;
+	vcpu->blocked = false;
 
 	r = kvm_arch_vcpu_init(vcpu);
 	if (r < 0)
@@ -1752,6 +1756,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	DEFINE_WAIT(wait);
 
 	for (;;) {
+		vcpu->blocked = true;
 		prepare_to_wait(&vcpu->wq, &wait, TASK_INTERRUPTIBLE);
 
 		if (kvm_arch_vcpu_runnable(vcpu)) {
@@ -1767,6 +1772,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	}
 
 	finish_wait(&vcpu->wq, &wait);
+	vcpu->blocked = false;
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_block);
 
-- 
1.9.1
