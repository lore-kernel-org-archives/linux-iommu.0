From: Feng Wu <feng.wu@intel.com>
Subject: [PATCH v7 04/17] KVM: Get Posted-Interrupts descriptor address from 'struct kvm_vcpu'
Date: Tue, 25 Aug 2015 16:50:07 +0800
Message-ID: <1440492620-15934-5-git-send-email-feng.wu@intel.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pbonzini@redhat.com, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Define an interface to get PI descriptor address from the vCPU structure.

Signed-off-by: Feng Wu <feng.wu@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx.c              | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index af11bca..d50c1d3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -858,6 +858,8 @@ struct kvm_x86_ops {
 	void (*enable_log_dirty_pt_masked)(struct kvm *kvm,
 					   struct kvm_memory_slot *slot,
 					   gfn_t offset, unsigned long mask);
+
+	u64 (*get_pi_desc_addr)(struct kvm_vcpu *vcpu);
 	/* pmu operations of sub-arch */
 	const struct kvm_pmu_ops *pmu_ops;
 };
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 316f9bf..81a995c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -610,6 +610,10 @@ static inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
 #define FIELD64(number, name)	[number] = VMCS12_OFFSET(name), \
 				[number##_HIGH] = VMCS12_OFFSET(name)+4
 
+struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
+{
+	return &(to_vmx(vcpu)->pi_desc);
+}
 
 static unsigned long shadow_read_only_fields[] = {
 	/*
@@ -4487,6 +4491,11 @@ static void vmx_sync_pir_to_irr_dummy(struct kvm_vcpu *vcpu)
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
@@ -10460,6 +10469,8 @@ static struct kvm_x86_ops vmx_x86_ops = {
 	.flush_log_dirty = vmx_flush_log_dirty,
 	.enable_log_dirty_pt_masked = vmx_enable_log_dirty_pt_masked,
 
+	.get_pi_desc_addr = vmx_get_pi_desc_addr,
+
 	.pmu_ops = &intel_pmu_ops,
 };
 
-- 
2.1.0
