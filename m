From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Mon, 24 Oct 2016 12:28:47 +0100
Message-ID: <945fec94-40e2-03b8-a823-f29afb7d104e@arm.com>
References: <1> <1477112061-12868-1-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1477112061-12868-1-git-send-email-gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[+Thomas, Jason, Marc]

On 22/10/16 05:54, Geetha sowjanya wrote:
> From: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
>   This patch implements Cavium ThunderX erratum 28168.
> 
>   PCI requires stores complete in order. Due to erratum #28168
>   PCI-inbound MSI-X store to the interrupt controller are delivered
>   to the interrupt controller before older PCI-inbound memory stores
>   are committed.
>   Doing a sync on SMMU will make sure all prior transactions are
>   completed.
> 
> Signed-off-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm64/Kconfig               |   11 +++++++++++
>  drivers/iommu/arm-smmu.c         |   38 ++++++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-common.h |    1 +
>  drivers/irqchip/irq-gic-v3-its.c |   22 ++++++++++++++++++++++
>  kernel/irq/chip.c                |    4 ++++

The irqchip maintainers should absolutely be CC'ed on this. Please use
get_maintainer.pl to check.

>  5 files changed, 76 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 30398db..57f5c9b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -474,6 +474,17 @@ config CAVIUM_ERRATUM_27456
>  
>  	  If unsure, say Y.
>  
> +config CAVIUM_ERRATUM_28168
> +	bool "Cavium erratum 28168: Make sure ITS and SMMU TLB are in sync"
> +	default y
> +	help
> +	 Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
> +	 controller are delivered to the interrupt controller before older
> +	 PCI-inbound memory stores are committed. Doing a sync on SMMU
> +	 will make sure all prior transactions are completed.

Ouch! Is there definitely no other possible workaround, like overriding
transaction attributes, disabling hit-under-miss handling, or somesuch?
Does it have to be a global sync, or is syncing the relevant context
bank sufficient? (I have some half-finished patches to split up the TLB
maintenance ops, including finer-grained syncs wherever possible, which
I can resurrect).

> +
> +	 If unsure, say Y.
> +
>  endmenu
>  
>  
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9740846..20a61c6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -378,6 +378,7 @@ struct arm_smmu_device {
>  	unsigned int			*irqs;
>  
>  	u32				cavium_id_base; /* Specific to Cavium */
> +	spinlock_t			tlb_lock;
>  };
>  
>  enum arm_smmu_context_fmt {
> @@ -576,9 +577,39 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>  static void arm_smmu_tlb_sync(void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu->tlb_lock, flags);

So *every* unmap operation on any SMMU ever now has to poll some slow
hardware for up to a second with IRQs disabled unconditionally? I don't
think that's acceptable for the general case.

>  	__arm_smmu_tlb_sync(smmu_domain->smmu);
> +	spin_unlock_irqrestore(&smmu->tlb_lock, flags)
>  }
>  
> +/*
> + * Cavium ThunderX erratum 28168
> + *
> + * Due to erratum #28168 PCI-inbound MSI-X store to the interrupt
> + * controller are delivered to the interrupt controller before older
> + * PCI-inbound memory stores are committed. Doing a sync on SMMU
> + * will make sure all prior transactions are completed.
> + *
> + */
> +void cavium_smmu_tlb_sync(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_master_cfg *cfg;
> +	unsigned long flags;
> +
> +	smmu = find_smmu_for_device(dev);

Won't compile - that function no longer exists.

> +	if (!smmu)
> +		return;
> +
> +	spin_lock_irqsave(&smmu->tlb_lock, flags);
> +	 __arm_smmu_tlb_sync(smmu);
> +	spin_unlock_irqrestore(&smmu->tlb_lock, flags)
> +}
> +EXPORT_SYMBOL(cavium_smmu_tlb_sync);
> +
>  static void arm_smmu_tlb_inv_context(void *cookie)
>  {
>  	struct arm_smmu_domain *smmu_domain = cookie;
> @@ -586,6 +617,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
>  	void __iomem *base;
> +	unsigned long flags;
>  
>  	if (stage1) {
>  		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
> @@ -597,7 +629,9 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  			       base + ARM_SMMU_GR0_TLBIVMID);
>  	}
>  
> +	spin_lock_irqsave(&smmu->tlb_lock, flags);
>  	__arm_smmu_tlb_sync(smmu);
> +	spin_unlock_irqrestore(&smmu->tlb_lock, flags)
>  }
>  
>  static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> @@ -1562,6 +1596,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>  	void __iomem *cb_base;
>  	int i;
> +	unsigned long flags;
>  	u32 reg, major;
>  
>  	/* clear global FSR */
> @@ -1633,7 +1668,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		reg |= sCR0_VMID16EN;
>  
>  	/* Push the button */
> +	spin_lock_irqsave(&smmu->tlb_lock, flags)
>  	__arm_smmu_tlb_sync(smmu);
> +	spin_unlock_irqrestore(&smmu->tlb_lock, flags)

After the fourth identical wrapping of the same function call, does it
not start to seem a better idea to implement a workaround *inside*
__arm_smmu_tlb_sync()?

>  	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>  }
>  
> @@ -2001,6 +2038,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	spin_lock_init(&smmu->tlb_lock);
>  	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
>  	platform_set_drvdata(pdev, smmu);
>  	arm_smmu_device_reset(smmu);
> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
> index 205e5fd..0228ba0 100644
> --- a/drivers/irqchip/irq-gic-common.h
> +++ b/drivers/irqchip/irq-gic-common.h
> @@ -38,4 +38,5 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>  
>  void gic_set_kvm_info(const struct gic_kvm_info *info);
>  
> +void cavium_smmu_tlb_sync(void *iommu);
>  #endif /* _IRQ_GIC_COMMON_H */
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 003495d..88e9958 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -112,6 +112,7 @@ struct its_device {
>  	struct its_node		*its;
>  	struct event_lpi_map	event_map;
>  	void			*itt;
> +	struct device           *dev;
>  	u32			nr_ites;
>  	u32			device_id;
>  };
> @@ -664,10 +665,29 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  	iommu_dma_map_msi_msg(d->irq, msg);
>  }
>  
> +/**
> + * Due to erratum in ThunderX,
> + * we need to make sure SMMU is in sync with ITS translations.
> + **/
> +static void its_ack_irq(struct irq_data *d)
> +{
> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> +	struct pci_dev *pdev;
> +
> +		if (!dev_is_pci(its_dev->dev))
> +			return;
> +
> +		pdev = to_pci_dev(its_dev->dev);
> +		if (pdev->vendor != 0x177d)
> +			cavium_smmu_tlb_sync(its_dev->dev);

I'm pretty sure that makes any kernel built without CONFIG_ARM_SMMU fail
to link.

Robin.

> +
> +}
> +
>  static struct irq_chip its_irq_chip = {
>  	.name			= "ITS",
>  	.irq_mask		= its_mask_irq,
>  	.irq_unmask		= its_unmask_irq,
> +	.irq_ack                = its_ack_irq,
>  	.irq_eoi		= irq_chip_eoi_parent,
>  	.irq_set_affinity	= its_set_affinity,
>  	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
> @@ -1422,6 +1442,8 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	if (!its_dev)
>  		return -ENOMEM;
>  
> +	its_dev->dev = dev;
> +
>  	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
>  out:
>  	info->scratchpad[0].ptr = its_dev;
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index be3c34e..6add8da 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -585,6 +585,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
>  		goto out;
>  	}
>  
> +#ifdef CONFIG_CAVIUM_ERRATUM_28168
> +	if (chip->irq_ack)
> +		chip->irq_ack(&desc->irq_data);
> +#endif
>  	kstat_incr_irqs_this_cpu(desc);
>  	if (desc->istate & IRQS_ONESHOT)
>  		mask_irq(desc);
> 
