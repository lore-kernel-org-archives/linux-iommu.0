From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v9 05/18] KVM: introduce kvm_arch functions for IRQ bypass
Date: Fri, 18 Sep 2015 22:29:43 +0800
Message-ID: <1442586596-5920-6-git-send-email-feng.wu@intel.com>
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

From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patch introduces
- kvm_arch_irq_bypass_add_producer
- kvm_arch_irq_bypass_del_producer
- kvm_arch_irq_bypass_stop
- kvm_arch_irq_bypass_start

They make possible to specialize the KVM IRQ bypass consumer in
case CONFIG_KVM_HAVE_IRQ_BYPASS is set.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
v4 -> v5:
- remove static inline stub functions

v2 -> v3 (Feng Wu):
- use 'kvm_arch_irq_bypass_start' instead of 'kvm_arch_irq_bypass_resume'
- Remove 'kvm_arch_irq_bypass_update', which is not needed to be
  a irqbypass callback per Alex's comments.
- Make kvm_arch_irq_bypass_add_producer return 'int'

v1 -> v2:
- use CONFIG_KVM_HAVE_IRQ_BYPASS instead CONFIG_IRQ_BYPASS_MANAGER
- rename all functions according to Paolo's proposal
- add kvm_arch_irq_bypass_update according to Feng's need

 include/linux/kvm_host.h | 10 ++++++++++
 virt/kvm/Kconfig         |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 05e99b8..5ac8d21 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/irqflags.h>
 #include <linux/context_tracking.h>
+#include <linux/irqbypass.h>
 #include <asm/signal.h>
 
 #include <linux/kvm.h>
@@ -1151,5 +1152,14 @@ static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
 {
 }
 #endif /* CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
+
+#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *,
+			   struct irq_bypass_producer *);
+void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *,
+			   struct irq_bypass_producer *);
+void kvm_arch_irq_bypass_stop(struct irq_bypass_consumer *);
+void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *);
+#endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 #endif
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index e2c876d..9f8014d 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -47,3 +47,6 @@ config KVM_GENERIC_DIRTYLOG_READ_PROTECT
 config KVM_COMPAT
        def_bool y
        depends on COMPAT && !S390
+
+config HAVE_KVM_IRQ_BYPASS
+       bool
-- 
2.1.0
