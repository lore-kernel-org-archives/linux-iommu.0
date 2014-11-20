From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch V1] genirq: Introduce irq_set_vcpu_affinity() to target an
	interrupt to a VCPU
Date: Thu, 20 Nov 2014 15:10:00 +0800
Message-ID: <1416467404-5031-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

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
Guest update MSI/MSI-X interrupt configuratoin
	-->QEMU and KVM handle this
	-->KVM call this interface (passing posted interrupts descriptor
	   and guest vector)
	-->irq core will transfer the control to IOMMU
	-->IOMMU will do the real work of updating IRTE (IRTE has new
	   format for VT-d Posted-Interrupts)

You can find the VT-d Posted-Interrtups Spec. in the following URL:
http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/linux/irq.h |    6 ++++++
 kernel/irq/manage.c |   19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 8badf34baf0f..0a3c8ac38ffb 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -29,6 +29,7 @@
 struct seq_file;
 struct module;
 struct msi_msg;
+struct irq_vcpu_id;
 
 /*
  * IRQ line status.
@@ -323,6 +324,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  *				irq_request_resources
  * @irq_compose_msi_msg:	optional to compose message content for MSI
  * @irq_write_msi_msg:	optional to write message content for MSI
+ * @irq_set_vcpu_affinity:	optional to target a virtual CPU in a virtual
+ *				machine
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -362,6 +365,8 @@ struct irq_chip {
 	void		(*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg *msg);
 	void		(*irq_write_msi_msg)(struct irq_data *data, struct msi_msg *msg);
 
+	int		(*irq_set_vcpu_affinity)(struct irq_data *data, struct irq_vcpu_id *vcpu_id);
+
 	unsigned long	flags;
 };
 
@@ -415,6 +420,7 @@ extern void irq_cpu_online(void);
 extern void irq_cpu_offline(void);
 extern int irq_set_affinity_locked(struct irq_data *data,
 				   const struct cpumask *cpumask, bool force);
+extern int irq_set_vcpu_affinity(unsigned int irq, struct irq_vcpu_id *vcpu_id);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
 void irq_move_irq(struct irq_data *data);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 80692373abd6..4ae8f243293a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -247,6 +247,25 @@ int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 }
 EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
 
+int irq_set_vcpu_affinity(unsigned int irq, struct irq_vcpu_id *vcpu_id)
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
+		ret = chip->irq_set_vcpu_affinity(&desc->irq_data, vcpu_id);
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	return ret;
+}
+
 static void irq_affinity_notify(struct work_struct *work)
 {
 	struct irq_affinity_notify *notify =
-- 
1.7.10.4
