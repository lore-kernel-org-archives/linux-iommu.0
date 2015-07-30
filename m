From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Bugfix]
Date: Fri, 31 Jul 2015 00:44:40 +0800
Message-ID: <1438274680-27916-1-git-send-email-jiang.liu@linux.intel.com>
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
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>, Mark Rustad <mark.d.rustad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alexander, Mark, Alex,
	Could you please help to apply the debug patch and send me back
the dmesg? Please also help to turn kernel paramemter "apic=debug".

Hi Mark,
	It seems that this regression is caused by support of multiple-MSI,
but I have no PCI card supportting multiple-MSI at hand. So may I remotely
access your system from Intel internal network?  That will definitely speed
up fix.
Thanks!
Gerry

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c           |   15 +++++++++++++--
 drivers/iommu/intel_irq_remapping.c |    4 ++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a57e9b749895..c039ed9333a4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3916,8 +3916,8 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	union irte *irte = &data->irte_entry;
 	struct IO_APIC_route_entry *entry;
 
-	data->irq_2_irte.devid = devid;
-	data->irq_2_irte.index = index + sub_handle;
+	irte_info->devid = devid;
+	irte_info->index = index + sub_handle;
 
 	/* Setup IRTE for IOMMU */
 	irte->val = 0;
@@ -3926,6 +3926,10 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	irte->fields.destination = irq_cfg->dest_apicid;
 	irte->fields.dm          = apic->irq_dest_mode;
 	irte->fields.valid       = 1;
+	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+		pr_warn("irqdomain: IRTE%d vector %d APICID%d data%p cfg%p\n",
+			irte_info->index, irte->fields.vector,
+			irte->fields.destination, data, irq_cfg);
 
 	switch (info->type) {
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
@@ -3972,6 +3976,9 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	    info->type != X86_IRQ_ALLOC_TYPE_MSIX)
 		return -EINVAL;
 
+	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+		pr_warn("irqdomain: allocate %d MSI IRQ, VIRQ%d\n", nr_irqs, virq);
+
 	/*
 	 * With IRQ remapping enabled, don't need contiguous CPU vectors
 	 * to support multiple MSI interrupts.
@@ -3986,6 +3993,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret < 0)
 		return ret;
+	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+		pr_warn("irqdomain: allocate parent returns %d\n", ret);
 
 	ret = -ENOMEM;
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -4005,6 +4014,8 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		kfree(data);
 		goto out_free_parent;
 	}
+	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+		pr_warn("irqdomain: allocate IRTE index %d\n", index);
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f15692a410c7..bb093bc6b334 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1234,6 +1234,8 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 				  MSI_ADDR_IR_SHV |
 				  MSI_ADDR_IR_INDEX1(index) |
 				  MSI_ADDR_IR_INDEX2(index);
+		if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+			pr_warn("irqdomain: allocate index%d, subhandle%d, irte%llx,%llx\n", index, sub_handle, irte->high, irte->low);
 		break;
 
 	default:
@@ -1305,6 +1307,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
 		kfree(data);
 		goto out_free_parent;
 	}
+	if (info->type == X86_IRQ_ALLOC_TYPE_MSI)
+		pr_warn("irqdomain: allocate VIRQ%d, count%d, index%d\n", virq, nr_irqs, index);
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_data = irq_domain_get_irq_data(domain, virq + i);
-- 
1.7.10.4
