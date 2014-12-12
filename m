From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 23/26] KVM: Update Posted-Interrupts Descriptor when vCPU is
	preempted
Date: Fri, 12 Dec 2014 23:14:57 +0800
Message-ID: <1418397300-10870-24-git-send-email-feng.wu@intel.com>
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
 arch/x86/kvm/vmx.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ee3b735..bf2e6cd 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1916,10 +1916,54 @@ static void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		vmcs_writel(HOST_IA32_SYSENTER_ESP, sysenter_esp); /* 22.2.3 */
 		vmx->loaded_vmcs->cpu = cpu;
 	}
+
+	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
+		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+		struct pi_desc old, new;
+		unsigned int dest;
+
+		memset(&old, 0, sizeof(old));
+		memset(&new, 0, sizeof(new));
+
+		do {
+			old.control = new.control = pi_desc->control;
+			if (vcpu->cpu != cpu) {
+				dest = cpu_physical_id(cpu);
+
+				if (x2apic_enabled())
+					new.ndst = dest;
+				else
+					new.ndst = (dest << 8) & 0xFF00;
+			}
+
+			pi_clear_sn(&new);
+
+			/* set 'NV' to 'notification vector' */
+			new.nv = POSTED_INTR_VECTOR;
+		} while (cmpxchg(&pi_desc->control, old.control,
+				new.control) != old.control);
+	}
 }
 
 static void vmx_vcpu_put(struct kvm_vcpu *vcpu)
 {
+	if (irq_remapping_cap(IRQ_POSTING_CAP)) {
+		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+		struct pi_desc old, new;
+
+		memset(&old, 0, sizeof(old));
+		memset(&new, 0, sizeof(new));
+
+		/* Set SN when the vCPU is preempted */
+		if (vcpu->preempted) {
+			do {
+				old.control = new.control = pi_desc->control;
+				pi_set_sn(&new);
+			} while (cmpxchg(&pi_desc->control, old.control,
+					new.control) != old.control);
+		}
+	}
+
 	__vmx_load_host_state(to_vmx(vcpu));
 	if (!vmm_exclusive) {
 		__loaded_vmcs_clear(to_vmx(vcpu)->loaded_vmcs);
-- 
1.9.1
