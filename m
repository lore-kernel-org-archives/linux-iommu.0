From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 08/13] KVM: Implement IRQ bypass consumer callbacks for x86
Date: Wed, 16 Sep 2015 16:50:04 +0800
Message-ID: <1442393409-2623-9-git-send-email-feng.wu@intel.com>
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

Implement the following callbacks for x86:

- kvm_arch_irq_bypass_add_producer
- kvm_arch_irq_bypass_del_producer
- kvm_arch_irq_bypass_stop: dummy callback
- kvm_arch_irq_bypass_resume: dummy callback

and set CONFIG_HAVE_KVM_IRQ_BYPASS for x86.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
v8:
- Move the weak irq bypas stop and irq bypass start to this patch.
- Call kvm_x86_ops->update_pi_irte() instead of kvm_arch_update_pi_irte().

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/Kconfig            |  1 +
 arch/x86/kvm/x86.c              | 44 +++++++++++++++++++++++++++++++++++++++++
 virt/kvm/eventfd.c              | 12 +++++++++++
 4 files changed, 58 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8c44286..0ddd353 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -24,6 +24,7 @@
 #include <linux/perf_event.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/clocksource.h>
+#include <linux/irqbypass.h>
 
 #include <asm/pvclock-abi.h>
 #include <asm/desc.h>
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index c951d44..b90776f 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -30,6 +30,7 @@ config KVM
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQFD
 	select IRQ_BYPASS_MANAGER
+	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_EVENTFD
 	select KVM_APIC_ARCHITECTURE
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9dcd501..79dac02 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -50,6 +50,8 @@
 #include <linux/pci.h>
 #include <linux/timekeeper_internal.h>
 #include <linux/pvclock_gtod.h>
+#include <linux/kvm_irqfd.h>
+#include <linux/irqbypass.h>
 #include <trace/events/kvm.h>
 
 #define CREATE_TRACE_POINTS
@@ -8249,6 +8251,48 @@ bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_arch_has_noncoherent_dma);
 
+int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
+				      struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+
+	if (kvm_x86_ops->update_pi_irte) {
+		irqfd->producer = prod;
+		return kvm_x86_ops->update_pi_irte(irqfd->kvm,
+				prod->irq, irqfd->gsi, 1);
+	}
+
+	return -EINVAL;
+}
+
+void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
+				      struct irq_bypass_producer *prod)
+{
+	int ret;
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+
+	if (!kvm_x86_ops->update_pi_irte) {
+		WARN_ON(irqfd->producer != NULL);
+		return;
+	}
+
+	WARN_ON(irqfd->producer != prod);
+	irqfd->producer = NULL;
+
+	/*
+	 * When producer of consumer is unregistered, we change back to
+	 * remapped mode, so we can re-use the current implementation
+	 * when the irq is masked/disabed or the consumer side (KVM
+	 * int this case doesn't want to receive the interrupts.
+	*/
+	ret = kvm_x86_ops->update_pi_irte(irqfd->kvm, prod->irq, irqfd->gsi, 0);
+	if (ret)
+		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
+		       " fails: %d\n", irqfd->consumer.token, ret);
+}
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index d7a230f..c0a56a1 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -256,6 +256,18 @@ static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
 	write_seqcount_end(&irqfd->irq_entry_sc);
 }
 
+#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+void __attribute__((weak)) kvm_arch_irq_bypass_stop(
+				struct irq_bypass_consumer *cons)
+{
+}
+
+void __attribute__((weak)) kvm_arch_irq_bypass_start(
+				struct irq_bypass_consumer *cons)
+{
+}
+#endif
+
 static int
 kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 {
-- 
2.1.0
