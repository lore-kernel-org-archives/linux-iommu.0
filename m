From: Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 5/7] irqchip/ls-scfg-msi: Don't map the MSI page in ls_scfg_msi_compose_msg()
Date: Wed,  1 May 2019 14:58:22 +0100
Message-ID: <20190501135824.25586-6-julien.grall@arm.com>
References: <20190501135824.25586-1-julien.grall@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501135824.25586-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
List-Id: iommu@lists.linux-foundation.org

ls_scfg_msi_compose_msg() may be called from non-preemptible context.
However, on RT, iommu_dma_map_msi_msg() requires to be called from a
preemptible context.

A recent patch split iommu_dma_map_msi_msg() in two new functions:
one that should be called in preemptible context, the other does
not have any requirement.

The FreeScale SCFG MSI driver is reworked to avoid executing preemptible
code in non-preemptible context. This can be achieved by preparing the
MSI maping when allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Rework the commit message to use imperative mood
---
 drivers/irqchip/irq-ls-scfg-msi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index c671b3212010..669d29105772 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -100,7 +100,7 @@ static void ls_scfg_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 		msg->data |= cpumask_first(mask);
 	}
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
 static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
@@ -141,6 +141,7 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 					unsigned int nr_irqs,
 					void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct ls_scfg_msi *msi_data = domain->host_data;
 	int pos, err = 0;
 
@@ -157,6 +158,10 @@ static int ls_scfg_msi_domain_irq_alloc(struct irq_domain *domain,
 	if (err)
 		return err;
 
+	err = iommu_dma_prepare_msi(info->desc, msi_data->msiir_addr);
+	if (err)
+		return err;
+
 	irq_domain_set_info(domain, virq, pos,
 			    &ls_scfg_msi_parent_chip, msi_data,
 			    handle_simple_irq, NULL, NULL);
-- 
2.11.0
