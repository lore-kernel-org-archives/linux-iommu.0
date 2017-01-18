From: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Subject: Re: [PATCH v8 12/18] irqdomain: Add irq domain MSI and MSI_REMAP
 flags
Date: Wed, 18 Jan 2017 09:35:53 +0100
Message-ID: <5b5695c2-2607-4997-516a-699b39bfdb43@caviumnetworks.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
 <1484127714-3263-13-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484127714-3263-13-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: drjones@redhat.com, kvm@vger.kernel.org, punit.agrawal@arm.com, linux-kernel@vger.kernel.org, geethasowjanya.akula@gmail.com, diana.craciun@nxp.com, iommu@lists.linux-foundation.org, pranav.sawargaonkar@gmail.com, bharat.bhushan@nxp.com, shankerd@codeaurora.org, gpkulkarni@gmail.com
List-Id: iommu@lists.linux-foundation.org

On 11.01.2017 10:41, Eric Auger wrote:
> We introduce two new enum values for the irq domain flag:
> - IRQ_DOMAIN_FLAG_MSI indicates the irq domain corresponds to
>   an MSI domain
> - IRQ_DOMAIN_FLAG_MSI_REMAP indicates the irq domain has MSI
>   remapping capabilities.
>
> Those values will be useful to check all MSI irq domains have
> MSI remapping support when assessing the safety of IRQ assignment
> to a guest.
>
> irq_domain_hierarchical_is_msi_remap() allows to check if an
> irq domain or any parent implements MSI remapping.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>

Thanks,
Tomasz

>
> ---
>
> v7 -> v8:
> - remove h variable in irq_domain_hierarchical_is_msi_remap
> - add Marc's R-b
>
> v6:
> - add IRQ_DOMAIN_FLAG_MSI as suggested by Marc
> - add irq_domain_is_msi, irq_domain_is_msi_remap and
>   irq_domain_hierarchical_is_msi_remap
> ---
>  include/linux/irqdomain.h | 35 +++++++++++++++++++++++++++++++++++
>  kernel/irq/irqdomain.c    | 14 ++++++++++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index ffb8460..bc2f571 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -183,6 +183,12 @@ enum {
>  	/* Irq domain is an IPI domain with single virq */
>  	IRQ_DOMAIN_FLAG_IPI_SINGLE	= (1 << 3),
>
> +	/* Irq domain implements MSIs */
> +	IRQ_DOMAIN_FLAG_MSI		= (1 << 4),
> +
> +	/* Irq domain implements MSI remapping */
> +	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 5),
> +
>  	/*
>  	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
>  	 * for implementation specific purposes and ignored by the
> @@ -446,6 +452,19 @@ static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
>  {
>  	return domain->flags & IRQ_DOMAIN_FLAG_IPI_SINGLE;
>  }
> +
> +static inline bool irq_domain_is_msi(struct irq_domain *domain)
> +{
> +	return domain->flags & IRQ_DOMAIN_FLAG_MSI;
> +}
> +
> +static inline bool irq_domain_is_msi_remap(struct irq_domain *domain)
> +{
> +	return domain->flags & IRQ_DOMAIN_FLAG_MSI_REMAP;
> +}
> +
> +extern bool irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain);
> +
>  #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>  static inline void irq_domain_activate_irq(struct irq_data *data) { }
>  static inline void irq_domain_deactivate_irq(struct irq_data *data) { }
> @@ -477,6 +496,22 @@ static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
>  {
>  	return false;
>  }
> +
> +static inline bool irq_domain_is_msi(struct irq_domain *domain)
> +{
> +	return false;
> +}
> +
> +static inline bool irq_domain_is_msi_remap(struct irq_domain *domain)
> +{
> +	return false;
> +}
> +
> +static inline bool
> +irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain)
> +{
> +	return false;
> +}
>  #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>
>  #else /* CONFIG_IRQ_DOMAIN */
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 8c0a0ae..876e131 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1392,6 +1392,20 @@ static void irq_domain_check_hierarchy(struct irq_domain *domain)
>  	if (domain->ops->alloc)
>  		domain->flags |= IRQ_DOMAIN_FLAG_HIERARCHY;
>  }
> +
> +/**
> + * irq_domain_hierarchical_is_msi_remap - Check if the domain or any
> + * parent has MSI remapping support
> + * @domain: domain pointer
> + */
> +bool irq_domain_hierarchical_is_msi_remap(struct irq_domain *domain)
> +{
> +	for (; domain; domain = domain->parent) {
> +		if (irq_domain_is_msi_remap(domain))
> +			return true;
> +	}
> +	return false;
> +}
>  #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>  /**
>   * irq_domain_get_irq_data - Get irq_data associated with @virq and @domain
>
