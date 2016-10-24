From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64: SMMU-v2: Workaround for Cavium ThunderX erratum
	28168
Date: Mon, 24 Oct 2016 14:44:35 +0100
Message-ID: <fbc51a32-aaba-0ee6-c0bd-07a02fb2a6b4@arm.com>
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
To: Geetha sowjanya <gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tirumalesh Chalamarla <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Geetha,

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

Thanks Robin for looping me in. Geetha, please use get_maintainers.pl to
keep the relevant people on CC, specially as you're touching some of the
core infrastructure.

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
> +
> +	 If unsure, say Y.

Please add an entry to Documentation/arm64/silicon-errata.txt.

> +
>  endmenu
>  
>  
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9740846..20a61c6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c

I'll skip the SMMU code on which Robin has commented already, and move
to the irq part, which is equally entertaining.

[...]

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

This doesn't work in the presence of anything that will multiplex
multiple RequesterIDs onto a single DeviceID (non transparent PCI
bridge, for example).

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

How about non PCI devices?

> +
> +		pdev = to_pci_dev(its_dev->dev);
> +		if (pdev->vendor != 0x177d)
> +			cavium_smmu_tlb_sync(its_dev->dev);

What makes Cavium devices so special that they do not need to respect
the PCI memory ordering with respect to MSI delivery?

> +
> +}
> +
>  static struct irq_chip its_irq_chip = {
>  	.name			= "ITS",
>  	.irq_mask		= its_mask_irq,
>  	.irq_unmask		= its_unmask_irq,
> +	.irq_ack                = its_ack_irq,

Nice try, but no, thank you. If you really want to go down that road,
have a look at CONFIG_IRQ_PREFLOW_FASTEOI, and make this workaround a
per interrupt thing. At least, you won't pollute the core code with
another hack.

Also, it would be good to find a way for that hack to be confined to the
SMMU driver, since that's where the oddity is being handled. Something
that would occur when the device is mapping memory is probably on good spot.

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

Overall, this workaround is not acceptable as it is. You need to find
ways to make it less invasive, and hopefully the above pointers will
help. Please keep the current distribution list posted once you update
this patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
