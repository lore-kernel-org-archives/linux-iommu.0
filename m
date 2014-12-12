From: Feng Wu <feng.wu@intel.com>
Subject: [v3 14/26] KVM: Get Posted-Interrupts descriptor address from struct kvm_vcpu
Date: Fri, 12 Dec 2014 23:14:48 +0800
Message-ID: <1418397300-10870-15-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, gleb@kernel.org, pbonzini@redhat.com, dwmw2@infradead.org, joro@8bytes.org, alex.williamson@redhat.com, jiang.liu@linux.intel.com
Cc: eric.auger@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Define a interface to get PI descriptor address from the vCPU structure.

Signed-off-by: Feng Wu <feng.wu@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx.c              | 12 ++++++++++++
 2 files changed, 13 insertions(+)

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
1.9.1
