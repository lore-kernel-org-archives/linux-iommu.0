From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 7/8] genirq/msi: map/unmap the MSI doorbells on
	msi_domain_alloc/free_irqs
Date: Wed, 4 May 2016 14:21:26 +0100
Message-ID: <5729F756.7060500@arm.com>
References: <1461831730-5575-1-git-send-email-eric.auger@linaro.org>
	<1461831730-5575-8-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461831730-5575-8-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/04/16 09:22, Eric Auger wrote:
> This patch handles the iommu mapping of MSI doorbells that require to
> be mapped in an iommu domain. This happens on msi_domain_alloc/free_irqs
> since this is called in code that can sleep (pci_enable/disable_msi):
> iommu_map/unmap is not stated as atomic. On msi_domain_(de)activate and
> msi_domain_set_affinity, which must be atomic, we just lookup for this
> pre-allocated/mapped IOVA.
> 
> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> ---
> v7 -> v8:
> - new percpu pointer type
> - exit from the irq domain hierarchy parsing on first map/unmap success
> - reset desc->irq to 0 on mapping failure
> 
> v7: creation
> ---
>  kernel/irq/msi.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 79 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 72bf4d6..d5f95e6 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -14,6 +14,8 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/msi.h>
> +#include <linux/msi-iommu.h>
> +#include <linux/iommu.h>
>  
>  /* Temparory solution for building, will be removed later */
>  #include <linux/pci.h>
> @@ -322,6 +324,56 @@ int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
>  }
>  
>  /**
> + * msi_handle_doorbell_mappings: in case the irq data corresponds to an
> + * MSI that requires iommu mapping, traverse the irq domain hierarchy
> + * to retrieve the doorbells to handle and iommu_map/unmap them according
> + * to @map boolean.
> + *
> + * @data: irq data handle
> + * @map: mapping if true, unmapping if false
> + */
> +static int msi_handle_doorbell_mappings(struct irq_data *data, bool map)
> +{
> +	for (; data; data = data->parent_data) {
> +		struct device *dev =
> +			msi_desc_to_dev(irq_data_get_msi_desc(data));
> +		struct irq_chip *chip = irq_data_get_irq_chip(data);
> +		const struct irq_chip_msi_doorbell_info *dbinfo;
> +		struct iommu_domain *domain;
> +		phys_addr_t __percpu *db_addr;
> +		dma_addr_t iova;
> +		int ret = 0, i;
> +
> +		domain = iommu_msi_domain(dev);
> +		if (!domain)
> +			continue;
> +
> +		if (!chip->msi_doorbell_info)
> +			continue;
> +
> +		dbinfo = chip->msi_doorbell_info(data);
> +		if (!dbinfo)
> +			return -EINVAL;
> +
> +		for (i = 0; i < dbinfo->nb_doorbells; i++) {
> +			db_addr = per_cpu_ptr(dbinfo->percpu_doorbells, i);
> +			if (map) {
> +				ret = iommu_msi_get_doorbell_iova(domain,
> +								  *db_addr,
> +								  dbinfo->size,
> +								  dbinfo->prot,
> +								  &iova);
> +				if (ret)
> +					return ret;
> +			} else
> +				iommu_msi_put_doorbell_iova(domain, *db_addr);
> +		}
> +		break;
> +	}
> +	return 0;
> +}

I'm really not fond of this whole loop. Could you try to decouple the
irq_data parsing (looking for a msi_doorbell_info method) from the
actual mapping/unmapping? This would make it a lot more readable.
Something along the lines of:

	struct device *dev;
	struct irq_chip *chip;
	struct iommu_domain *domain;
	const struct irq_chip_msi_doorbell_info *dbinfo;

	while (data) {
		dev = msi_desc_to_dev(irq_data_get_msi_desc(data));
		domain = iommu_msi_domain(dev);
		if (!domain)
			continue;

		chip = irq_data_get_irq_chip(data);
		if (chip->msi_doorbell_info)
			break;

		data = data->parent;
	}

	if (!data)
		return 0;

	dbinfo = chip->msi_doorbell_info(data);
	if (!dbinfo)
		return -EINVAL;

	[... handle mapping/unmapping here ...]

> +
> +/**
>   * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
>   * @domain:	The domain to allocate from
>   * @dev:	Pointer to device struct of the device for which the interrupts
> @@ -352,17 +404,26 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  
>  		virq = __irq_domain_alloc_irqs(domain, virq, desc->nvec_used,
>  					       dev_to_node(dev), &arg, false);
> -		if (virq < 0) {
> -			ret = -ENOSPC;
> -			if (ops->handle_error)
> -				ret = ops->handle_error(domain, desc, ret);
> -			if (ops->msi_finish)
> -				ops->msi_finish(&arg, ret);
> -			return ret;
> -		}
> +		if (virq < 0)
> +			goto error;
>  
>  		for (i = 0; i < desc->nvec_used; i++)
>  			irq_set_msi_desc_off(virq, i, desc);
> +
> +		for (i = 0; i < desc->nvec_used; i++) {
> +			ret = msi_handle_doorbell_mappings(
> +				irq_get_irq_data(virq + i), true);

Do not be afraid of longer lines. Or if you are, create an intermediate
variable. But this kind of construct makes my brain work harder, and I
hate the feeling... ;-)

> +			if (ret)
> +				break;
> +		}
> +		if (ret) {
> +			for (; i >= 0; i--)
> +				msi_handle_doorbell_mappings(
> +					irq_get_irq_data(virq + i), false);
> +			irq_domain_free_irqs(virq, desc->nvec_used);
> +			desc->irq = 0;
> +			goto error;
> +		}
>  	}
>  
>  	if (ops->msi_finish)
> @@ -377,6 +438,13 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  	}
>  
>  	return 0;
> +error:
> +	ret = -ENOSPC;
> +	if (ops->handle_error)
> +		ret = ops->handle_error(domain, desc, ret);
> +	if (ops->msi_finish)
> +		ops->msi_finish(&arg, ret);
> +	return ret;
>  }
>  
>  /**
> @@ -396,6 +464,9 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>  		 * entry. If that's the case, don't do anything.
>  		 */
>  		if (desc->irq) {
> +			msi_handle_doorbell_mappings(
> +				irq_get_irq_data(desc->irq),
> +				false);
>  			irq_domain_free_irqs(desc->irq, desc->nvec_used);
>  			desc->irq = 0;
>  		}
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
