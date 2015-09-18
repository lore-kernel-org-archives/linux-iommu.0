From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v9 09/18] KVM: Define a new interface kvm_intr_is_single_vcpu()
Date: Fri, 18 Sep 2015 22:29:47 +0800
Message-ID: <1442586596-5920-10-git-send-email-feng.wu@intel.com>
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

This patch defines a new interface kvm_intr_is_single_vcpu(),
which can returns whether the interrupt is for single-CPU or not.

It is used by VT-d PI, since now we only support single-CPU
interrupts, For lowest-priority interrupts, if user configures
it via /proc/irq or uses irqbalance to make it single-CPU, we
can use PI to deliver the interrupts to it. Full functionality
of lowest-priority support will be added later.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
v9:
- Move kvm_intr_is_single_vcpu_fast() to lapic.c
- Remove incorrect WARN_ON_ONCE()

v8:
- Some optimizations in kvm_intr_is_single_vcpu().
- Expose kvm_intr_is_single_vcpu() so we can use it in vmx code.
- Add kvm_intr_is_single_vcpu_fast() as the fast path to find
  the target vCPU for the single-destination interrupt

 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/irq_comm.c         | 27 +++++++++++++++++++
 arch/x86/kvm/lapic.c            | 59 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/lapic.h            |  2 ++
 4 files changed, 91 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 49ec903..af11bca 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1204,4 +1204,7 @@ int __x86_set_memory_region(struct kvm *kvm,
 int x86_set_memory_region(struct kvm *kvm,
 			  const struct kvm_userspace_memory_region *mem);
 
+bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
+			     struct kvm_vcpu **dest_vcpu);
+
 #endif /* _ASM_X86_KVM_HOST_H */
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 9efff9e..f86a0da 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -297,6 +297,33 @@ out:
 	return r;
 }
 
+bool kvm_intr_is_single_vcpu(struct kvm *kvm, struct kvm_lapic_irq *irq,
+			     struct kvm_vcpu **dest_vcpu)
+{
+	int i, r = 0;
+	struct kvm_vcpu *vcpu;
+
+	if (kvm_intr_is_single_vcpu_fast(kvm, irq, dest_vcpu))
+		return true;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (!kvm_apic_present(vcpu))
+			continue;
+
+		if (!kvm_apic_match_dest(vcpu, NULL, irq->shorthand,
+					irq->dest_id, irq->dest_mode))
+			continue;
+
+		if (++r == 2)
+			return false;
+
+		*dest_vcpu = vcpu;
+	}
+
+	return r == 1;
+}
+EXPORT_SYMBOL_GPL(kvm_intr_is_single_vcpu);
+
 #define IOAPIC_ROUTING_ENTRY(irq) \
 	{ .gsi = irq, .type = KVM_IRQ_ROUTING_IRQCHIP,	\
 	  .u.irqchip = { .irqchip = KVM_IRQCHIP_IOAPIC, .pin = (irq) } }
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 2a5ca97..3c8fc71 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -764,6 +764,65 @@ out:
 	return ret;
 }
 
+bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm, struct kvm_lapic_irq *irq,
+			struct kvm_vcpu **dest_vcpu)
+{
+	struct kvm_apic_map *map;
+	bool ret = false;
+	struct kvm_lapic *dst = NULL;
+
+	if (irq->shorthand)
+		return false;
+
+	rcu_read_lock();
+	map = rcu_dereference(kvm->arch.apic_map);
+
+	if (!map)
+		goto out;
+
+	if (irq->dest_mode == APIC_DEST_PHYSICAL) {
+		if (irq->dest_id == 0xFF)
+			goto out;
+
+		if (irq->dest_id >= ARRAY_SIZE(map->phys_map))
+			goto out;
+
+		dst = map->phys_map[irq->dest_id];
+		if (dst && kvm_apic_present(dst->vcpu))
+			*dest_vcpu = dst->vcpu;
+		else
+			goto out;
+	} else {
+		u16 cid;
+		unsigned long bitmap = 1;
+		int i, r = 0;
+
+		if (!kvm_apic_logical_map_valid(map))
+			goto out;
+
+		apic_logical_id(map, irq->dest_id, &cid, (u16 *)&bitmap);
+
+		if (cid >= ARRAY_SIZE(map->logical_map))
+			goto out;
+
+		for_each_set_bit(i, &bitmap, 16) {
+			dst = map->logical_map[cid][i];
+			if (++r == 2)
+				goto out;
+		}
+
+		if (dst && kvm_apic_present(dst->vcpu))
+			*dest_vcpu = dst->vcpu;
+		else
+			goto out;
+	}
+
+	ret = true;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 /*
  * Add a pending IRQ into lapic.
  * Return 1 if successfully added and 0 if discarded.
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 7195274..032fe2d 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -169,4 +169,6 @@ bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
 
 void wait_lapic_expire(struct kvm_vcpu *vcpu);
 
+bool kvm_intr_is_single_vcpu_fast(struct kvm *kvm, struct kvm_lapic_irq *irq,
+			struct kvm_vcpu **dest_vcpu);
 #endif
-- 
2.1.0
