From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 3/7] irqchip/gicv2m: Don't map the MSI page in
 gicv2m_compose_msi_msg()
Date: Tue, 30 Apr 2019 14:34:48 +0200
Message-ID: <c4013c08-3d32-769c-447b-38a0a0dcf152@redhat.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-4-julien.grall@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429144428.29254-4-julien.grall@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com, robin.murphy@arm.com, miquel.raynal@bootlin.com, tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Julien,

On 4/29/19 4:44 PM, Julien Grall wrote:
> gicv2m_compose_msi_msg() may be called from non-preemptible context.
> However, on RT, iommu_dma_map_msi_msg() requires to be called from a
> preemptible context.
> 
> A recent change split iommu_dma_map_msi_msg() in two new functions:
> one that should be called in preemptible context, the other does
> not have any requirement.
> 
> The GICv2m driver is reworked to avoid executing preemptible code in
> non-preemptible context. This can be achieved by preparing the MSI
> mapping when allocating the MSI interrupt.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> ---
>     Changes in v2:
>         - Rework the commit message to use imperative mood
> ---
>  drivers/irqchip/irq-gic-v2m.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index f5fe0100f9ff..4359f0583377 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -110,7 +110,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
>  		msg->data -= v2m->spi_offset;
>  
> -	iommu_dma_map_msi_msg(data->irq, msg);
> +	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
>  }
>  
>  static struct irq_chip gicv2m_irq_chip = {
> @@ -167,6 +167,7 @@ static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq,
>  static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  				   unsigned int nr_irqs, void *args)
>  {
> +	msi_alloc_info_t *info = args;
>  	struct v2m_data *v2m = NULL, *tmp;
>  	int hwirq, offset, i, err = 0;
>  
> @@ -186,6 +187,11 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	hwirq = v2m->spi_start + offset;
>  
> +	err = iommu_dma_prepare_msi(info->desc,
> +				    v2m->res.start + V2M_MSI_SETSPI_NS);
> +	if (err)
> +		return err;
> +
>  	for (i = 0; i < nr_irqs; i++) {
>  		err = gicv2m_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
>  		if (err)
> 
