From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 20/26] KVM: x86: kvm-vfio: VT-d posted-interrupts setup
Date: Fri, 12 Dec 2014 23:14:54 +0800
Message-ID: <1418397300-10870-21-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch defines macro __KVM_HAVE_ARCH_KVM_VFIO_POST and
implement kvm_arch_vfio_update_pi_irte for x86 architecture.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/Makefile           |  2 +-
 arch/x86/kvm/kvm_vfio_x86.c     | 77 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kvm/kvm_vfio_x86.c

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cd4b174..13e3e40 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -82,6 +82,8 @@ static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
 		(base_gfn >> KVM_HPAGE_GFN_SHIFT(level));
 }
 
+#define __KVM_HAVE_ARCH_KVM_VFIO_POST
+
 #define SELECTOR_TI_MASK (1 << 2)
 #define SELECTOR_RPL_MASK 0x03
 
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 25d22b2..8809d58 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -14,7 +14,7 @@ kvm-$(CONFIG_KVM_DEVICE_ASSIGNMENT)	+= $(KVM)/assigned-dev.o $(KVM)/iommu.o
 kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 
 kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
-			   i8254.o cpuid.o pmu.o
+			   i8254.o cpuid.o pmu.o kvm_vfio_x86.o
 kvm-intel-y		+= vmx.o
 kvm-amd-y		+= svm.o
 
diff --git a/arch/x86/kvm/kvm_vfio_x86.c b/arch/x86/kvm/kvm_vfio_x86.c
new file mode 100644
index 0000000..2ba618e
--- /dev/null
+++ b/arch/x86/kvm/kvm_vfio_x86.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) 2014 Intel Corporation.
+ * Authors: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kvm_host.h>
+#include <asm/irq_remapping.h>
+
+/*
+ * kvm_arch_vfio_update_pi_irte - set IRTE for Posted-Interrupts
+ *
+ * @kvm: kvm
+ * @host_irq: host irq of the interrupt
+ * @guest_irq: gsi of the interrupt
+ * @set: set or unset PI
+ * returns 0 on success, < 0 on failure
+ */
+int kvm_arch_vfio_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+				 uint32_t guest_irq, bool set)
+{
+	struct kvm_kernel_irq_routing_entry *e;
+	struct kvm_irq_routing_table *irq_rt;
+	struct kvm_lapic_irq irq;
+	struct kvm_vcpu *vcpu;
+	struct vcpu_data vcpu_info;
+	int idx, ret = -EINVAL;
+
+	idx = srcu_read_lock(&kvm->irq_srcu);
+	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
+	BUG_ON(guest_irq >= irq_rt->nr_rt_entries);
+
+	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
+		if (e->type != KVM_IRQ_ROUTING_MSI)
+			continue;
+		/*
+		 * VT-d PI cannot support posting multicast/broadcast
+		 * interrupts to a VCPU, we still use interrupt remapping
+		 * for these kind of interrupts.
+		 */
+
+		kvm_set_msi_irq(e, &irq);
+		if (!kvm_find_dest_vcpu(kvm, &irq, &vcpu))
+			continue;
+
+		vcpu_info.pi_desc_addr = kvm_x86_ops->get_pi_desc_addr(vcpu);
+		vcpu_info.vector = irq.vector;
+
+		if (set)
+			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
+		else {
+			/* suppress notification event before unposting */
+			kvm_x86_ops->pi_set_sn(vcpu);
+			ret = irq_set_vcpu_affinity(host_irq, NULL);
+			kvm_x86_ops->pi_clear_sn(vcpu);
+		}
+
+		if (ret < 0) {
+			printk(KERN_INFO "%s: failed to update PI IRTE\n",
+					__func__);
+			goto out;
+		}
+	}
+
+	ret = 0;
+out:
+	srcu_read_unlock(&kvm->irq_srcu, idx);
+	return ret;
+}
-- 
1.9.1
