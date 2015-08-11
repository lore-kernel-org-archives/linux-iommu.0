From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 12/16] KVM: Add an arch specific hooks in 'struct
	kvm_kernel_irqfd'
Date: Tue, 11 Aug 2015 14:03:54 +0800
Message-ID: <1439273038-59463-13-git-send-email-feng.wu@intel.com>
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

This patch adds an arch specific hooks 'arch_update' in
'struct kvm_kernel_irqfd'. On Intel side, it is used to
update the IRTE when VT-d posted-interrupts is used.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/x86.c              |  5 +++++
 include/linux/kvm_host.h        | 11 +++++++++++
 include/linux/kvm_irqfd.h       |  2 ++
 virt/kvm/eventfd.c              | 12 +++++++++++-
 5 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3038c1b..22269b4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -176,6 +176,8 @@ enum {
  */
 #define KVM_APIC_PV_EOI_PENDING	1
 
+#define __KVM_HAVE_ARCH_IRQFD_INIT 1
+
 struct kvm_kernel_irq_routing_entry;
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8df7b0d..74a1d83 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8360,6 +8360,11 @@ void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *cons)
 {
 }
 
+void kvm_arch_irqfd_init(struct kvm_kernel_irqfd *irqfd)
+{
+	irqfd->arch_update = kvm_arch_update_pi_irte;
+}
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5f183fb..f4005dc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -34,6 +34,8 @@
 
 #include <asm/kvm_host.h>
 
+struct kvm_kernel_irqfd;
+
 /*
  * The bit 16 ~ bit 31 of kvm_memory_region::flags are internally used
  * in kvm, other bits are visible for userspace which are defined in
@@ -1145,6 +1147,15 @@ extern struct kvm_device_ops kvm_xics_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v2_ops;
 extern struct kvm_device_ops kvm_arm_vgic_v3_ops;
 
+#ifdef __KVM_HAVE_ARCH_IRQFD_INIT
+void kvm_arch_irqfd_init(struct kvm_kernel_irqfd *irqfd);
+#else
+static inline void kvm_arch_irqfd_init(struct kvm_kernel_irqfd *irqfd)
+{
+	irqfd->arch_update = NULL;
+}
+#endif
+
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
 static inline void kvm_vcpu_set_in_spin_loop(struct kvm_vcpu *vcpu, bool val)
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index 0c1de05..b7aab52 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -66,6 +66,8 @@ struct kvm_kernel_irqfd {
 	struct work_struct shutdown;
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
+	int (*arch_update)(struct kvm *kvm, unsigned int host_irq,
+			   uint32_t guest_irq, bool set);
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index d7a230f..3204283 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -278,6 +278,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	INIT_LIST_HEAD(&irqfd->list);
 	INIT_WORK(&irqfd->inject, irqfd_inject);
 	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
+	kvm_arch_irqfd_init(irqfd);
 	seqcount_init(&irqfd->irq_entry_sc);
 
 	f = fdget(args->fd);
@@ -570,13 +571,22 @@ kvm_irqfd_release(struct kvm *kvm)
  */
 void kvm_irq_routing_update(struct kvm *kvm)
 {
+	int ret;
 	struct kvm_kernel_irqfd *irqfd;
 
 	spin_lock_irq(&kvm->irqfds.lock);
 
-	list_for_each_entry(irqfd, &kvm->irqfds.items, list)
+	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
 		irqfd_update(kvm, irqfd);
 
+		if (irqfd->arch_update && irqfd->producer) {
+			ret = irqfd->arch_update(
+					irqfd->kvm, irqfd->producer->irq,
+					irqfd->gsi, 1);
+			WARN_ON(ret);
+		}
+	}
+
 	spin_unlock_irq(&kvm->irqfds.lock);
 }
 
-- 
2.1.0
