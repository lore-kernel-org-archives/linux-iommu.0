From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 05/17] KVM: Add interfaces to control PI outside vmx
Date: Tue, 25 Aug 2015 16:50:08 +0800
Message-ID: <1440492620-15934-6-git-send-email-feng.wu@intel.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1440492620-15934-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

This patch adds pi_clear_sn and pi_set_sn to struct kvm_x86_ops,
so we can set/clear SN outside vmx.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/vmx.c              | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d50c1d3..c4f99f1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -860,6 +860,9 @@ struct kvm_x86_ops {
 					   gfn_t offset, unsigned long mask);
 
 	u64 (*get_pi_desc_addr)(struct kvm_vcpu *vcpu);
+
+	void (*pi_clear_sn)(struct kvm_vcpu *vcpu);
+	void (*pi_set_sn)(struct kvm_vcpu *vcpu);
 	/* pmu operations of sub-arch */
 	const struct kvm_pmu_ops *pmu_ops;
 };
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 81a995c..234f720 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -615,6 +615,16 @@ struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
 	return &(to_vmx(vcpu)->pi_desc);
 }
 
+static void vmx_pi_clear_sn(struct kvm_vcpu *vcpu)
+{
+	pi_clear_sn(vcpu_to_pi_desc(vcpu));
+}
+
+static void vmx_pi_set_sn(struct kvm_vcpu *vcpu)
+{
+	pi_set_sn(vcpu_to_pi_desc(vcpu));
+}
+
 static unsigned long shadow_read_only_fields[] = {
 	/*
 	 * We do NOT shadow fields that are modified when L0
@@ -10471,6 +10481,9 @@ static struct kvm_x86_ops vmx_x86_ops = {
 
 	.get_pi_desc_addr = vmx_get_pi_desc_addr,
 
+	.pi_clear_sn = vmx_pi_clear_sn,
+	.pi_set_sn = vmx_pi_set_sn,
+
 	.pmu_ops = &intel_pmu_ops,
 };
 
-- 
2.1.0
