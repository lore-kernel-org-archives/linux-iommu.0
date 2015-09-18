From: Feng Wu <feng.wu@intel.com>
Subject: [PATCH v9 10/18] KVM: Make struct kvm_irq_routing_table accessible
Date: Fri, 18 Sep 2015 22:29:48 +0800
Message-ID: <1442586596-5920-11-git-send-email-feng.wu@intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: pbonzini@redhat.com, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Move struct kvm_irq_routing_table from irqchip.c to kvm_host.h,
so we can use it outside of irqchip.c.

Signed-off-by: Feng Wu <feng.wu@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
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

