From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v9 06/18] KVM: eventfd: add irq bypass consumer management
Date: Fri, 18 Sep 2015 22:29:44 +0800
Message-ID: <1442586596-5920-7-git-send-email-feng.wu@intel.com>
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

This patch adds the registration/unregistration of an
irq_bypass_consumer on irqfd assignment/deassignment.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
v4 -> v5:
- due to removal of static inline stubs, add
  #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
  around consumer registration/unregistration
- add pr_info when registration fails

v2 -> v3 (Feng Wu):
- Use kvm_arch_irq_bypass_start
- Remove kvm_arch_irq_bypass_update
- Add member 'struct irq_bypass_producer *producer' in
  'struct kvm_kernel_irqfd', it is needed by posted interrupt.
- Remove 'irq_bypass_unregister_consumer' in kvm_irqfd_deassign()

v1 -> v2:
- populate of kvm and gsi removed
- unregister the consumer on irqfd_shutdown

 include/linux/kvm_irqfd.h |  2 ++
 virt/kvm/eventfd.c        | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index f926b39..0c1de05 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -64,6 +64,8 @@ struct kvm_kernel_irqfd {
 	struct list_head list;
 	poll_table pt;
 	struct work_struct shutdown;
+	struct irq_bypass_consumer consumer;
+	struct irq_bypass_producer *producer;
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 647ffb8..d7a230f 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -35,6 +35,7 @@
 #include <linux/srcu.h>
 #include <linux/slab.h>
 #include <linux/seqlock.h>
+#include <linux/irqbypass.h>
 #include <trace/events/kvm.h>
 
 #include <kvm/iodev.h>
@@ -140,6 +141,9 @@ irqfd_shutdown(struct work_struct *work)
 	/*
 	 * It is now safe to release the object's resources
 	 */
+#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+	irq_bypass_unregister_consumer(&irqfd->consumer);
+#endif
 	eventfd_ctx_put(irqfd->eventfd);
 	kfree(irqfd);
 }
@@ -379,6 +383,17 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	 * we might race against the POLLHUP
 	 */
 	fdput(f);
+#ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
+	irqfd->consumer.token = (void *)irqfd->eventfd;
+	irqfd->consumer.add_producer = kvm_arch_irq_bypass_add_producer;
+	irqfd->consumer.del_producer = kvm_arch_irq_bypass_del_producer;
+	irqfd->consumer.stop = kvm_arch_irq_bypass_stop;
+	irqfd->consumer.start = kvm_arch_irq_bypass_start;
+	ret = irq_bypass_register_consumer(&irqfd->consumer);
+	if (ret)
+		pr_info("irq bypass consumer (token %p) registration fails: %d\n",
+				irqfd->consumer.token, ret);
+#endif
 
 	return 0;
 
-- 
2.1.0
