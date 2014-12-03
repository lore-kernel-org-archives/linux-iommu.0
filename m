From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v2 14/25] KVM: Get Posted-Interrupts descriptor address from struct
	kvm_vcpu
Date: Wed,  3 Dec 2014 15:39:43 +0800
Message-ID: <1417592394-24343-15-git-send-email-feng.wu@intel.com>
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

Define a interface to get PI descriptor address from the vCPU structure.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |    1 +
 arch/x86/kvm/vmx.c              |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7a41808..9b45b78 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -772,6 +772,7 @@ struct kvm_x86_ops {
 	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
 
 	void (*sched_in)(struct kvm_vcpu *kvm, int cpu);
+	u64 (*get_pi_desc_addr)(struct kvm_vcpu *vcpu);
 };
 
 struct kvm_arch_async_pf {
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 66ca275..81f239b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -562,6 +562,11 @@ static inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
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
@@ -4298,6 +4303,11 @@ static void vmx_sync_pir_to_irr_dummy(struct kvm_vcpu *vcpu)
 	return;
 }
 
+static u64 vmx_get_pi_desc_addr(struct kvm_vcpu *vcpu)
+{
+	return __pa((u64)vcpu_to_pi_desc(vcpu));
+}
+
 /*
  * Set up the vmcs's constant host-state fields, i.e., host-state fields that
  * will not change in the lifetime of the guest.
@@ -9244,6 +9254,8 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.check_nested_events = vmx_check_nested_events,
 
 	.sched_in = vmx_sched_in,
+
+	.get_pi_desc_addr = vmx_get_pi_desc_addr,
 };
 
 static int __init vmx_init(void)
-- 
1.7.1
