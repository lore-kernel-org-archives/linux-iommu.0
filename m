From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v2 01/25] genirq: Introduce irq_set_vcpu_affinity() to target an
	interrupt to a VCPU
Date: Wed,  3 Dec 2014 15:39:30 +0800
Message-ID: <1417592394-24343-2-git-send-email-feng.wu@intel.com>
References: <1417592394-24343-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417592394-24343-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

With Posted-Interrupts support in Intel CPU and IOMMU, an external
interrupt from assigned-devices could be directly delivered to a
virtual CPU in a virtual machine. Instead of hacking KVM and Intel
IOMMU drivers, we propose a platform independent interface to target
an interrupt to a specific virtual CPU in a virtual machine, or set
virtual CPU affinity for an interrupt.

By adopting this new interface and the hierarchy irqdomain, we could
easily support posted-interrupts on Intel platforms, and also provide
flexible enough interfaces for other platforms to support similar
features.

We may also cooperate between set_affinity() and set_vcpu_affinity()
in IRQ core or irq chip drivers.

Here is the usage scenario for this interface:
Guest update MSI/MSI-X interrupt configuration
	-->QEMU and KVM handle this
	-->KVM call this interface (passing posted interrupts descriptor
	   and guest vector)
	-->irq core will transfer the control to IOMMU
	-->IOMMU will do the real work of updating IRTE (IRTE has new
	   format for VT-d Posted-Interrupts)

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/linux/irq.h |    4 ++++
 kernel/irq/chip.c   |   14 ++++++++++++++
 kernel/irq/manage.c |   20 ++++++++++++++++++++
 3 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index f26e736..83abafc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -324,6 +324,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  *				irq_request_resources
  * @irq_compose_msi_msg:	optional to compose message content for MSI
  * @irq_write_msi_msg:	optional to write message content for MSI
+ * @irq_set_vcpu_affinity:	optional to target a virtual CPU in a virtual
+ *				machine
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -362,6 +364,7 @@ struct irq_chip {
 
 	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
 	void		(*irq_write_msi_msg)(struct irq_data *data, struct msi_msg *msg);
+	int		(*irq_set_vcpu_affinity)(struct irq_data *data, void *vcpu_info);
 
 	unsigned long	flags;
 };
@@ -416,6 +419,7 @@ extern void irq_cpu_online(void);
 extern void irq_cpu_offline(void);
 extern int irq_set_affinity_locked(struct irq_data *data,
 				   const struct cpumask *cpumask, bool force);
+extern int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
 void irq_move_irq(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6f1c7a5..fe0908f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -948,6 +948,20 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 
 	return -ENOSYS;
 }
+
+/**
+ * irq_chip_set_vcpu_affinity_parent - Set vcpu affinity on the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ * @dest:	The vcpu affinity information
+ */
+int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
+{
+	data = data->parent_data;
+	if (data->chip->irq_set_vcpu_affinity)
+		return data->chip->irq_set_vcpu_affinity(data, vcpu_info);
+
+	return -ENOSYS;
+}
 #endif
 
 /**
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8069237..bd3a1ba 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -247,6 +247,26 @@ int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 }
 EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
 
+int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_chip *chip;
+	unsigned long flags;
+	int ret = -ENOSYS;
+
+	if (!desc)
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	chip = desc->irq_data.chip;
+	if (chip && chip->irq_set_vcpu_affinity)
+		ret = chip->irq_set_vcpu_affinity(irq_desc_get_irq_data(desc),
+						  vcpu_info);
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(irq_set_vcpu_affinity);
+
 static void irq_affinity_notify(struct work_struct *work)
 {
 	struct irq_affinity_notify *notify =
-- 
1.7.1
