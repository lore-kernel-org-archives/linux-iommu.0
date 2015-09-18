From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v9 11/18] KVM: make kvm_set_msi_irq() public
Date: Fri, 18 Sep 2015 22:29:49 +0800
Message-ID: <1442586596-5920-12-git-send-email-feng.wu@intel.com>
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

Make kvm_set_msi_irq() public, we can use this function outside.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
v8:
- Export kvm_set_msi_irq() so we can use it in vmx code

 arch/x86/include/asm/kvm_host.h | 4 ++++
 arch/x86/kvm/irq_comm.c         | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index af11bca..daa6126 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -175,6 +175,8 @@ enum {
  */
 #define KVM_APIC_PV_EOI_PENDING	1
 
+struct kvm_kernel_irq_routing_entry;
+
 /*
  * We don't want allocation failures within the mmu code, so we preallocate
  * enough memory for a single page fault in a cache.
@@ -1207,4 +1209,6 @@ int x86_set_memory_region(struct kvm *kvm,
 bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
 			     struct kvm_vcpu **dest_vcpu);
 
+void kvm_set_msi_irq(struct kvm_kernel_irq_routing_entry *e,
+		     struct kvm_lapic_irq *irq);
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index f86a0da..4f6fa67 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -91,8 +91,8 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
 	return r;
 }
 
-static inline void kvm_set_msi_irq(struct kvm_kernel_irq_routing_entry *e,
-				   struct kvm_lapic_irq *irq)
+void kvm_set_msi_irq(struct kvm_kernel_irq_routing_entry *e,
+		     struct kvm_lapic_irq *irq)
 {
 	trace_kvm_msi_set_irq(e->msi.address_lo, e->msi.data);
 
@@ -108,6 +108,7 @@ static inline void kvm_set_msi_irq(struct kvm_kernel_irq_routing_entry *e,
 	irq->level = 1;
 	irq->shorthand = 0;
 }
+EXPORT_SYMBOL_GPL(kvm_set_msi_irq);
 
 int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
 		struct kvm *kvm, int irq_source_id, int level, bool line_status)
-- 
2.1.0
