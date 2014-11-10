From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/13] x86,
	irq: Define a global vector for VT-d Posted-Interrupts
Date: Mon, 10 Nov 2014 14:26:46 +0800
Message-ID: <1415600812-27773-8-git-send-email-feng.wu@intel.com>
References: <1415600812-27773-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415600812-27773-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, we use a global vector as the Posted-Interrupts
Notification Event for all the VCPUs in the system. We need
to introduce another global vector for VT-d Posted-Interrtups,
which will be used to wakeup the sleep VCPU when an external
interrupt from a direct-assigned device happens for that VCPU.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/entry_arch.h  |    2 ++
 arch/x86/include/asm/hardirq.h     |    1 +
 arch/x86/include/asm/hw_irq.h      |    2 ++
 arch/x86/include/asm/irq_vectors.h |    1 +
 arch/x86/kernel/entry_64.S         |    2 ++
 arch/x86/kernel/irq.c              |   27 +++++++++++++++++++++++++++
 arch/x86/kernel/irqinit.c          |    2 ++
 7 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index dc5fa66..27ca0af 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -23,6 +23,8 @@ BUILD_INTERRUPT(x86_platform_ipi, X86_PLATFORM_IPI_VECTOR)
 #ifdef CONFIG_HAVE_KVM
 BUILD_INTERRUPT3(kvm_posted_intr_ipi, POSTED_INTR_VECTOR,
 		 smp_kvm_posted_intr_ipi)
+BUILD_INTERRUPT3(kvm_posted_intr_wakeup_ipi, POSTED_INTR_WAKEUP_VECTOR,
+		 smp_kvm_posted_intr_wakeup_ipi)
 #endif
 
 /*
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 0f5fb6b..9866065 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -14,6 +14,7 @@ typedef struct {
 #endif
 #ifdef CONFIG_HAVE_KVM
 	unsigned int kvm_posted_intr_ipis;
+	unsigned int kvm_posted_intr_wakeup_ipis;
 #endif
 	unsigned int x86_platform_ipis;	/* arch dependent */
 	unsigned int apic_perf_irqs;
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 4615906..559563c 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -29,6 +29,7 @@
 extern asmlinkage void apic_timer_interrupt(void);
 extern asmlinkage void x86_platform_ipi(void);
 extern asmlinkage void kvm_posted_intr_ipi(void);
+extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void irq_work_interrupt(void);
 
@@ -92,6 +93,7 @@ extern void trace_call_function_single_interrupt(void);
 #define trace_irq_move_cleanup_interrupt  irq_move_cleanup_interrupt
 #define trace_reboot_interrupt  reboot_interrupt
 #define trace_kvm_posted_intr_ipi kvm_posted_intr_ipi
+#define trace_kvm_posted_intr_wakeup_ipi kvm_posted_intr_wakeup_ipi
 #endif /* CONFIG_TRACING */
 
 /* IOAPIC */
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 5702d7e..1343349 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -105,6 +105,7 @@
 /* Vector for KVM to deliver posted interrupt IPI */
 #ifdef CONFIG_HAVE_KVM
 #define POSTED_INTR_VECTOR		0xf2
+#define POSTED_INTR_WAKEUP_VECTOR	0xf1
 #endif
 
 /*
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index df088bb..7663aaa 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1004,6 +1004,8 @@ apicinterrupt X86_PLATFORM_IPI_VECTOR \
 #ifdef CONFIG_HAVE_KVM
 apicinterrupt3 POSTED_INTR_VECTOR \
 	kvm_posted_intr_ipi smp_kvm_posted_intr_ipi
+apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR \
+	kvm_posted_intr_wakeup_ipi smp_kvm_posted_intr_wakeup_ipi
 #endif
 
 #ifdef CONFIG_X86_MCE_THRESHOLD
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 922d285..47408c3 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -237,6 +237,9 @@ __visible void smp_x86_platform_ipi(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_HAVE_KVM
+void (*wakeup_handler_callback)(void) = NULL;
+EXPORT_SYMBOL_GPL(wakeup_handler_callback);
+
 /*
  * Handler for POSTED_INTERRUPT_VECTOR.
  */
@@ -256,6 +259,30 @@ __visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs)
 
 	set_irq_regs(old_regs);
 }
+
+/*
+ * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
+ */
+__visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	ack_APIC_irq();
+
+	irq_enter();
+
+	exit_idle();
+
+	inc_irq_stat(kvm_posted_intr_wakeup_ipis);
+
+	if (wakeup_handler_callback)
+		wakeup_handler_callback();
+
+	irq_exit();
+
+	set_irq_regs(old_regs);
+}
+
 #endif
 
 __visible void smp_trace_x86_platform_ipi(struct pt_regs *regs)
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index 4de73ee..659cde3 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -168,6 +168,8 @@ static void __init apic_intr_init(void)
 #ifdef CONFIG_HAVE_KVM
 	/* IPI for KVM to deliver posted interrupt */
 	alloc_intr_gate(POSTED_INTR_VECTOR, kvm_posted_intr_ipi);
+	/* IPI for KVM to deliver interrupt to wake up tasks */
+	alloc_intr_gate(POSTED_INTR_WAKEUP_VECTOR, kvm_posted_intr_wakeup_ipi);
 #endif
 
 	/* IPI vectors for APIC spurious and error interrupts */
-- 
1.7.1
