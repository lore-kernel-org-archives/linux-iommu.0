From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 04/10] iommu/dma-reserved-iommu:
	alloc/free_reserved_iova_domain
Date: Wed, 20 Apr 2016 14:03:38 +0100
Message-ID: <57177E2A.9090602@arm.com>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
	<1461084994-2355-5-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461084994-2355-5-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/04/16 17:56, Eric Auger wrote:
> Introduce alloc/free_reserved_iova_domain in the IOMMU API.
> alloc_reserved_iova_domain initializes an iova domain at a given
> iova base address and with a given size. This iova domain will
> be used to allocate iova within that window. Those IOVAs will be reserved
> for special purpose, typically MSI frame binding. Allocation function
> within the reserved iova domain will be introduced in subsequent patches.

Am I the only one thinking "Yo dawg, I heard you like IOVA allocators, 
so we put an IOVA allocator in your IOVA allocator so you can allocate 
IOVAs while you allocate IOVAs."

> Those functions are fully implemented if CONFIG_IOMMU_DMA_RESERVED
> is set.

DMA? I thought we were going to be dealing with MSI descriptors?

> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> ---
> v7:
> - fix locking
> - add iova_cache_get/put
> - static inline functions when CONFIG_IOMMU_DMA_RESERVED is not set
> - introduce struct reserved_iova_domain to encapsulate prot info &
>    add prot parameter in alloc_reserved_iova_domain
>
> v5 -> v6:
> - use spin lock instead of mutex
>
> v3 -> v4:
> - formerly in "iommu/arm-smmu: implement alloc/free_reserved_iova_domain" &
>    "iommu: add alloc/free_reserved_iova_domain"
>
> v2 -> v3:
> - remove iommu_alloc_reserved_iova_domain & iommu_free_reserved_iova_domain
>    static implementation in case CONFIG_IOMMU_API is not set
>
> v1 -> v2:
> - moved from vfio API to IOMMU API
> ---
>   drivers/iommu/Kconfig              |  8 +++
>   drivers/iommu/Makefile             |  1 +
>   drivers/iommu/dma-reserved-iommu.c | 99 ++++++++++++++++++++++++++++++++++++++
>   include/linux/dma-reserved-iommu.h | 59 +++++++++++++++++++++++
>   4 files changed, 167 insertions(+)
>   create mode 100644 drivers/iommu/dma-reserved-iommu.c
>   create mode 100644 include/linux/dma-reserved-iommu.h
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dd1dc39..a5a1530 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -74,6 +74,12 @@ config IOMMU_DMA
>   	select IOMMU_IOVA
>   	select NEED_SG_DMA_LENGTH
>
> +# IOMMU reserved IOVA mapping (MSI doorbell)

The only reference to MSIs I can see, but I can't make head nor tail of 
it. Sorry, I don't understand this patch at all :(

Robin.

> +config IOMMU_DMA_RESERVED
> +	bool
> +	select IOMMU_API
> +	select IOMMU_IOVA
> +
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
>   	depends on PPC32
> @@ -307,6 +313,7 @@ config SPAPR_TCE_IOMMU
>   config ARM_SMMU
>   	bool "ARM Ltd. System MMU (SMMU) Support"
>   	depends on (ARM64 || ARM) && MMU
> +	select IOMMU_DMA_RESERVED
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_LPAE
>   	select ARM_DMA_USE_IOMMU if ARM
> @@ -320,6 +327,7 @@ config ARM_SMMU
>   config ARM_SMMU_V3
>   	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
>   	depends on ARM64 && PCI
> +	select IOMMU_DMA_RESERVED
>   	select IOMMU_API
>   	select IOMMU_IO_PGTABLE_LPAE
>   	select GENERIC_MSI_IRQ_DOMAIN
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index c6edb31..6c9ae99 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -2,6 +2,7 @@ obj-$(CONFIG_IOMMU_API) += iommu.o
>   obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>   obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
> +obj-$(CONFIG_IOMMU_DMA_RESERVED) += dma-reserved-iommu.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> diff --git a/drivers/iommu/dma-reserved-iommu.c b/drivers/iommu/dma-reserved-iommu.c
> new file mode 100644
> index 0000000..2562af0
> --- /dev/null
> +++ b/drivers/iommu/dma-reserved-iommu.c
> @@ -0,0 +1,99 @@
> +/*
> + * Reserved IOVA Management
> + *
> + * Copyright (c) 2015 Linaro Ltd.
> + *              www.linaro.org
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/iommu.h>
> +#include <linux/iova.h>
> +
> +struct reserved_iova_domain {
> +	struct iova_domain *iovad;
> +	int prot; /* iommu protection attributes to be obeyed */
> +};
> +
> +int iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
> +				     dma_addr_t iova, size_t size, int prot,
> +				     unsigned long order)
> +{
> +	unsigned long granule, mask, flags;
> +	struct reserved_iova_domain *rid;
> +	int ret = 0;
> +
> +	granule = 1UL << order;
> +	mask = granule - 1;
> +	if (iova & mask || (!size) || (size & mask))
> +		return -EINVAL;
> +
> +	rid = kzalloc(sizeof(struct reserved_iova_domain), GFP_KERNEL);
> +	if (!rid)
> +		return -ENOMEM;
> +
> +	rid->iovad = kzalloc(sizeof(struct iova_domain), GFP_KERNEL);
> +	if (!rid->iovad) {
> +		kfree(rid);
> +		return -ENOMEM;
> +	}
> +
> +	iova_cache_get();
> +
> +	init_iova_domain(rid->iovad, granule,
> +			 iova >> order, (iova + size - 1) >> order);
> +
> +	spin_lock_irqsave(&domain->reserved_lock, flags);
> +
> +	if (domain->reserved_iova_cookie) {
> +		ret = -EEXIST;
> +		goto unlock;
> +	}
> +
> +	domain->reserved_iova_cookie = rid;
> +
> +unlock:
> +	spin_unlock_irqrestore(&domain->reserved_lock, flags);
> +	if (ret) {
> +		put_iova_domain(rid->iovad);
> +		kfree(rid->iovad);
> +		kfree(rid);
> +		iova_cache_put();
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_alloc_reserved_iova_domain);
> +
> +void iommu_free_reserved_iova_domain(struct iommu_domain *domain)
> +{
> +	struct reserved_iova_domain *rid;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&domain->reserved_lock, flags);
> +
> +	rid = (struct reserved_iova_domain *)domain->reserved_iova_cookie;
> +	if (!rid) {
> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
> +	domain->reserved_iova_cookie = NULL;
> +unlock:
> +	spin_unlock_irqrestore(&domain->reserved_lock, flags);
> +	if (!ret) {
> +		put_iova_domain(rid->iovad);
> +		kfree(rid->iovad);
> +		kfree(rid);
> +		iova_cache_put();
> +	}
> +}
> +EXPORT_SYMBOL_GPL(iommu_free_reserved_iova_domain);
> diff --git a/include/linux/dma-reserved-iommu.h b/include/linux/dma-reserved-iommu.h
> new file mode 100644
> index 0000000..01ec385
> --- /dev/null
> +++ b/include/linux/dma-reserved-iommu.h
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright (c) 2015 Linaro Ltd.
> + *              www.linaro.org
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#ifndef __DMA_RESERVED_IOMMU_H
> +#define __DMA_RESERVED_IOMMU_H
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +
> +struct iommu_domain;
> +
> +#ifdef CONFIG_IOMMU_DMA_RESERVED
> +
> +/**
> + * iommu_alloc_reserved_iova_domain: allocate the reserved iova domain
> + *
> + * @domain: iommu domain handle
> + * @iova: base iova address
> + * @size: iova window size
> + * @prot: protection attribute flags
> + * @order: page order
> + */
> +int iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
> +				     dma_addr_t iova, size_t size, int prot,
> +				     unsigned long order);
> +
> +/**
> + * iommu_free_reserved_iova_domain: free the reserved iova domain
> + *
> + * @domain: iommu domain handle
> + */
> +void iommu_free_reserved_iova_domain(struct iommu_domain *domain);
> +
> +#else
> +
> +static inline int
> +iommu_alloc_reserved_iova_domain(struct iommu_domain *domain,
> +				 dma_addr_t iova, size_t size, int prot,
> +				 unsigned long order)
> +{
> +	return -ENOENT;
> +}
> +
> +static inline void
> +iommu_free_reserved_iova_domain(struct iommu_domain *domain) {}
> +
> +#endif	/* CONFIG_IOMMU_DMA_RESERVED */
> +#endif	/* __DMA_RESERVED_IOMMU_H */
>
