From: Julien Grall <julien.grall@arm.com>
Subject: [PATCH 4/7] irqchip/gic-v3-its: Don't map the MSI page in its_irq_compose_msi_msg
Date: Thu, 18 Apr 2019 18:26:08 +0100
Message-ID: <20190418172611.21561-5-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418172611.21561-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
List-Id: iommu@lists.linux-foundation.org

The function its_irq_compose_msi_msg may be called from non-preemptible
context. However, on RT, iommu_dma_map_msi_msg requires to be called
from a preemptible context.

A recent patch split the function iommu_dma_map_msi_msg in 2 functions:
one that should be called in preemptible context, the other does
not have any requirement.

This patch reworks the GICv3 ITS driver to avoid executing preemptible
code in non-preemptible context by preparing the MSI mapping when
allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7577755bdcf4..1e8e01797d9b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1179,7 +1179,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	msg->address_hi		= upper_32_bits(addr);
 	msg->data		= its_get_event_id(d);
 
-	iommu_dma_map_msi_msg(d->irq, msg);
+	iommu_dma_compose_msi_msg(d->irq, msg);
 }
 
 static int its_irq_set_irqchip_state(struct irq_data *d,
@@ -2566,6 +2566,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	msi_alloc_info_t *info = args;
 	struct its_device *its_dev = info->scratchpad[0].ptr;
+	struct its_node *its = its_dev->its;
 	irq_hw_number_t hwirq;
 	int err;
 	int i;
@@ -2574,6 +2575,8 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		return err;
 
+	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
-- 
2.11.0
