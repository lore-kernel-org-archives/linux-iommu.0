From: Geetha sowjanya <gakula@caviumnetworks.com>
Subject: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum 28168
Date: Sat, 22 Oct 2016 10:24:21 +0530
Message-ID: <1477112061-12868-1-git-send-email-gakula@caviumnetworks.com>
References: <1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robin.murphy@arm.com, will.deacon@arm.com, mark.rutland@arm.com
Cc: Prasun.Kapoor@cavium.com, iommu@lists.linux-foundation.org, Geetha sowjanya <gakula@caviumnetworks.com>, Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>

  This patch implements Cavium ThunderX erratum 28168.

  PCI requires stores complete in order. Due to erratum #28168
  PCI-inbound MSI-X store to the interrupt controller are delivered
  to the interrupt controller before older PCI-inbound memory stores
  are committed.
  Doing a sync on SMMU will make sure all prior transactions are
  completed.

Signed-off-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
---
 arch/arm64/Kconfig               |   11 +++++++++++
 drivers/iommu/arm-smmu.c         |   38 ++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic-common.h |    1 +
 drivers/irqchip/irq-gic-v3-its.c |   22 ++++++++++++++++++++++
 kernel/irq/chip.c                |    4 ++++
 5 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30398db..57f5c9b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -474,6 +474,17 @@ config CAVIUM_ERRATUM_27456
 
 	  If unsure, say Y.
 
+config CAVIUM_ERRATUM_28168
+	bool "Cavium erratum 28168: Make sure ITS and SMMU TLB are in sync"
+	default y
+	help
+	 Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
+	 controller are delivered to the interrupt controller before older
+	 PCI-inbound memory stores are committed. Doing a sync on SMMU
+	 will make sure all prior transactions are completed.
+
+	 If unsure, say Y.
+
 endmenu
 
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9740846..20a61c6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -378,6 +378,7 @@ struct arm_smmu_device {
 	unsigned int			*irqs;
 
 	u32				cavium_id_base; /* Specific to Cavium */
+	spinlock_t			tlb_lock;
 };
 
 enum arm_smmu_context_fmt {
@@ -576,9 +577,39 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 static void arm_smmu_tlb_sync(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu->tlb_lock, flags);
 	__arm_smmu_tlb_sync(smmu_domain->smmu);
+	spin_unlock_irqrestore(&smmu->tlb_lock, flags)
 }
 
+/*
+ * Cavium ThunderX erratum 28168
+ *
+ * Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
+ * controller are delivered to the interrupt controller before older
+ * PCI-inbound memory stores are committed. Doing a sync on SMMU
+ * will make sure all prior transactions are completed.
+ *
+ */
+void cavium_smmu_tlb_sync(struct device *dev)
+{
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_master_cfg *cfg;
+	unsigned long flags;
+
+	smmu = find_smmu_for_device(dev);
+	if (!smmu)
+		return;
+
+	spin_lock_irqsave(&smmu->tlb_lock, flags);
+	 __arm_smmu_tlb_sync(smmu);
+	spin_unlock_irqrestore(&smmu->tlb_lock, flags)
+}
+EXPORT_SYMBOL(cavium_smmu_tlb_sync);
+
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
@@ -586,6 +617,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	void __iomem *base;
+	unsigned long flags;
 
 	if (stage1) {
 		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
@@ -597,7 +629,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 			       base + ARM_SMMU_GR0_TLBIVMID);
 	}
 
+	spin_lock_irqsave(&smmu->tlb_lock, flags);
 	__arm_smmu_tlb_sync(smmu);
+	spin_unlock_irqrestore(&smmu->tlb_lock, flags)
 }
 
 static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
@@ -1562,6 +1596,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	void __iomem *cb_base;
 	int i;
+	unsigned long flags;
 	u32 reg, major;
 
 	/* clear global FSR */
@@ -1633,7 +1668,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		reg |= sCR0_VMID16EN;
 
 	/* Push the button */
+	spin_lock_irqsave(&smmu->tlb_lock, flags)
 	__arm_smmu_tlb_sync(smmu);
+	spin_unlock_irqrestore(&smmu->tlb_lock, flags)
 	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
@@ -2001,6 +2038,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
+	spin_lock_init(&smmu->tlb_lock);
 	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 205e5fd..0228ba0 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -38,4 +38,5 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 
 void gic_set_kvm_info(const struct gic_kvm_info *info);
 
+void cavium_smmu_tlb_sync(void *iommu);
 #endif /* _IRQ_GIC_COMMON_H */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 003495d..88e9958 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -112,6 +112,7 @@ struct its_device {
 	struct its_node		*its;
 	struct event_lpi_map	event_map;
 	void			*itt;
+	struct device           *dev;
 	u32			nr_ites;
 	u32			device_id;
 };
@@ -664,10 +665,29 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	iommu_dma_map_msi_msg(d->irq, msg);
 }
 
+/**
+ * Due to erratum in ThunderX,
+ * we need to make sure SMMU is in sync with ITS translations.
+ **/
+static void its_ack_irq(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct pci_dev *pdev;
+
+		if (!dev_is_pci(its_dev->dev))
+			return;
+
+		pdev = to_pci_dev(its_dev->dev);
+		if (pdev->vendor != 0x177d)
+			cavium_smmu_tlb_sync(its_dev->dev);
+
+}
+
 static struct irq_chip its_irq_chip = {
 	.name			= "ITS",
 	.irq_mask		= its_mask_irq,
 	.irq_unmask		= its_unmask_irq,
+	.irq_ack                = its_ack_irq,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
@@ -1422,6 +1442,8 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 	if (!its_dev)
 		return -ENOMEM;
 
+	its_dev->dev = dev;
+
 	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
 out:
 	info->scratchpad[0].ptr = its_dev;
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index be3c34e..6add8da 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -585,6 +585,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 		goto out;
 	}
 
+#ifdef CONFIG_CAVIUM_ERRATUM_28168
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+#endif
 	kstat_incr_irqs_this_cpu(desc);
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
-- 
1.7.1
