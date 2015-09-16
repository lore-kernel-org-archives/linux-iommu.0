From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 09/13] KVM: Add an arch specific hooks in 'struct
	kvm_kernel_irqfd'
Date: Wed, 16 Sep 2015 16:50:05 +0800
Message-ID: <1442393409-2623-10-git-send-email-feng.wu@intel.com>
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

This patch adds an arch specific hooks 'arch_update' in
'struct kvm_kernel_irqfd'. On Intel side, it is used to
update the IRTE when VT-d posted-interrupts is used.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
v8:
- Remove callback .arch_update()
- Remove kvm_arch_irqfd_init()
- Call kvm_arch_update_irqfd_routing() instead.

 arch/x86/kvm/x86.c       |  7 +++++++
 include/linux/kvm_host.h |  2 ++
 virt/kvm/eventfd.c       | 19 ++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79dac02..e189a94 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8293,6 +8293,13 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 		       " fails: %d\n", irqfd->consumer.token, ret);
 }
 
+int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
+				   uint32_t guest_irq, bool set)
+{
+	return !kvm_x86_ops->update_pi_irte ? -EINVAL :
+		kvm_x86_ops->update_pi_irte(kvm, host_irq, guest_irq, set);
+}
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5f183fb..feba1fb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1174,6 +1174,8 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *,
 			   struct irq_bypass_producer *);
 void kvm_arch_irq_bypass_stop(struct irq_bypass_consumer *);
 void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *);
+int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
+				  uint32_t guest_irq, bool set);
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 #endif
 
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index c0a56a1..89c9635 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -266,6 +266,12 @@ void __attribute__((weak)) kvm_arch_irq_bypass_start(
 				struct irq_bypass_consumer *cons)
 {
 }
+int  __attribute__((weak)) kvm_arch_update_irqfd_routing(
+				struct kvm *kvm, unsigned int host_irq,
+				uint32_t guest_irq, bool set)
+{
+	return 0;
+}
 #endif
 
 static int
@@ -582,13 +588,24 @@ kvm_irqfd_release(struct kvm *kvm)
  */
 void kvm_irq_routing_update(struct kvm *kvm)
 {
+	int ret;
 	struct kvm_kernel_irqfd *irqfd;
 
 	spin_lock_irq(&kvm->irqfds.lock);
 
-	list_for_each_entry(irqfd, &kvm->irqfds.items, list)
+	list_for_each_entry(irqfd, &kvm->irqfds.items, list) {
 		irqfd_update(kvm, irqfd);
 
+#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+		if (irqfd->producer) {
+			ret = kvm_arch_update_irqfd_routing(
+					irqfd->kvm, irqfd->producer->irq,
+					irqfd->gsi, 1);
+			WARN_ON(ret);
+		}
+#endif
+	}
+
 	spin_unlock_irq(&kvm->irqfds.lock);
 }
 
-- 
2.1.0
