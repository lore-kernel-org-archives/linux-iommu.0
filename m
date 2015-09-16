From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 10/13] KVM: Update Posted-Interrupts Descriptor when vCPU
	is preempted
Date: Wed, 16 Sep 2015 16:50:06 +0800
Message-ID: <1442393409-2623-11-git-send-email-feng.wu@intel.com>
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

This patch updates the Posted-Interrupts Descriptor when vCPU
is preempted.

sched out:
- Set 'SN' to suppress furture non-urgent interrupts posted for
the vCPU.

sched in:
- Clear 'SN'
- Change NDST if vCPU is scheduled to a different CPU
- Set 'NV' to POSTED_INTR_VECTOR

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
v8:
- Add two wrapper fucntion vmx_vcpu_pi_load() and vmx_vcpu_pi_put().
- Only handle VT-d PI related logic when the VM has assigned devices.

 arch/x86/kvm/vmx.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5a25651..5ceb280 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1943,6 +1943,52 @@ static void vmx_load_host_state(struct vcpu_vmx *vmx)
 	preempt_enable();
 }
 
+static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct pi_desc old, new;
+	unsigned int dest;
+
+	if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
+		(!kvm_arch_has_assigned_device(vcpu->kvm)))
+		return;
+
+	do {
+		old.control = new.control = pi_desc->control;
+
+		/*
+		 * If 'nv' field is POSTED_INTR_WAKEUP_VECTOR, there
+		 * are two possible cases:
+		 * 1. After running 'pi_pre_block', context switch
+		 *    happened. For this case, 'sn' was set in
+		 *    vmx_vcpu_put(), so we need to clear it here.
+		 * 2. After running 'pi_pre_block', we were blocked,
+		 *    and woken up by some other guy. For this case,
+		 *    we don't need to do anything, 'pi_post_block'
+		 *    will do everything for us. However, we cannot
+		 *    check whether it is case #1 or case #2 here
+		 *    (maybe, not needed), so we also clear sn here,
+		 *    I think it is not a big deal.
+		 */
+		if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR) {
+			if (vcpu->cpu != cpu) {
+				dest = cpu_physical_id(cpu);
+
+				if (x2apic_enabled())
+					new.ndst = dest;
+				else
+					new.ndst = (dest << 8) & 0xFF00;
+			}
+
+			/* set 'NV' to 'notification vector' */
+			new.nv = POSTED_INTR_VECTOR;
+		}
+
+		/* Allow posting non-urgent interrupts */
+		new.sn = 0;
+	} while (cmpxchg(&pi_desc->control, old.control,
+			new.control) != old.control);
+}
 /*
  * Switches to specified vcpu, until a matching vcpu_put(), but assumes
  * vcpu mutex is already taken.
@@ -1993,10 +2039,27 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		vmcs_writel(HOST_IA32_SYSENTER_ESP, sysenter_esp); /* 22.2.3 */
 		vmx->loaded_vmcs->cpu = cpu;
 	}
+
+	vmx_vcpu_pi_load(vcpu, cpu);
+}
+
+static void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+
+	if (!irq_remapping_cap(IRQ_POSTING_CAP) ||
+		(!kvm_arch_has_assigned_device(vcpu->kvm)))
+		return;
+
+	/* Set SN when the vCPU is preempted */
+	if (vcpu->preempted)
+		pi_set_sn(pi_desc);
 }
 
 static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	vmx_vcpu_pi_put(vcpu);
+
 	__vmx_load_host_state(to_vmx(vcpu));
 	if (!vmm_exclusive) {
 		__loaded_vmcs_clear(to_vmx(vcpu)->loaded_vmcs);
-- 
2.1.0
