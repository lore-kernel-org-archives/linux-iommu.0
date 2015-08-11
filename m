From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 06/16] KVM: Make struct kvm_irq_routing_table accessible
Date: Tue, 11 Aug 2015 14:03:48 +0800
Message-ID: <1439273038-59463-7-git-send-email-feng.wu@intel.com>
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

Move struct kvm_irq_routing_table from irqchip.c to kvm_host.h,
so we can use it outside of irqchip.c.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/linux/kvm_host.h | 14 ++++++++++++++
 virt/kvm/irqchip.c       | 10 ----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5ac8d21..5f183fb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -328,6 +328,20 @@ struct kvm_kernel_irq_routing_entry {
 	struct hlist_node link;
 };
 
+#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
+
+struct kvm_irq_routing_table {
+	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
+	u32 nr_rt_entries;
+	/*
+	 * Array indexed by gsi. Each entry contains list of irq chips
+	 * the gsi is connected to.
+	 */
+	struct hlist_head map[0];
+};
+
+#endif
+
 #ifndef KVM_PRIVATE_MEM_SLOTS
 #define KVM_PRIVATE_MEM_SLOTS 0
 #endif
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 21c1424..2cf45d3 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -31,16 +31,6 @@
 #include <trace/events/kvm.h>
 #include "irq.h"
 
-struct kvm_irq_routing_table {
-	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
-	u32 nr_rt_entries;
-	/*
-	 * Array indexed by gsi. Each entry contains list of irq chips
-	 * the gsi is connected to.
-	 */
-	struct hlist_head map[0];
-};
-
 int kvm_irq_map_gsi(struct kvm *kvm,
 		    struct kvm_kernel_irq_routing_entry *entries, int gsi)
 {
-- 
2.1.0
