Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593E16D9BB
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722206; cv=none; b=GeyT1KWcYCMgGCLSrbe54zDY+Auk1RDUMDiMce6vqNI/2btIeibVkM8C/AL/tS659XFCJh54UAK1oFktApwO7C89nBPryT4VwVDsvZLZrW/LRHGsX9dlIDdK9FK2Mez9VzuEAXGP+fEJUHCmFI3QXUyF6P2nrIbHcp1t6OWHr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722206; c=relaxed/simple;
	bh=Jg3xQ07nFj5pVxjhxyngxPmbMvOYrQ3u7amnqXeFXSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE1dxIXX5NsVDCSRp0YGCJEtB4GA4reFtq3VpTL7ENzrMtKQpEQsB/paVPaN7LNSS49us6I8EbtOpf7sdakiaJotplJOxodd7meGLvT0sTAhWpficjrS2v+0YBrxUCWqbDVVHXatEmfQRDVorG+2RVoOJ5IyS2ymxKblc4HYOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3BAD1007;
	Thu, 11 Jul 2024 11:23:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADD963F766;
	Thu, 11 Jul 2024 11:23:21 -0700 (PDT)
Message-ID: <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
Date: Thu, 11 Jul 2024 19:23:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 11:38 am, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the IOMMU drivers are using the same DMA operations, which are
> default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
> to properly set them as a default with direct call without need to
> perform function pointer dereference.
> 
> During system initialization, the IOMMU driver can set its own DMA and
> in such case, the default DMA operations will be overridden.

I'm going to guess you don't actually mean "IOMMU drivers" in the usual 
sense of drivers/iommu/, but rather "arch DMA ops (which often, but not 
always, involve some sort of IOMMU)."

If so, I'd much rather see this done properly, i.e. hook everything up 
similarly to dma-direct and be able to drop CONFIG_DMA_OPS for "modern" 
dma-direct/iommu-dma architectures entirely. Furthermore the 
implementation here isn't right - not only is it not conceptually 
appropriate to make iommu-dma responsibile for proxying random arch DMA 
ops, but in practial terms it's just plain broken, since the 
architectures which still have their own DMA ops also don't use 
iommu-dma, so this is essentially disabling the entire streaming DMA API 
on ARM/PowerPC/etc.

Thanks,
Robin.

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   MAINTAINERS               |  1 +
>   drivers/iommu/dma-iommu.c | 24 +++++++-------
>   include/linux/iommu-dma.h | 50 +++++++++++++++++++++++++++++
>   kernel/dma/iommu.h        | 67 +++++++++++++++++++++++++++++++++++++++
>   kernel/dma/mapping.c      |  9 +++---
>   5 files changed, 134 insertions(+), 17 deletions(-)
>   create mode 100644 include/linux/iommu-dma.h
>   create mode 100644 kernel/dma/iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index da5352dbd4f3..1e64be463da7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11544,6 +11544,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>   F:	Documentation/devicetree/bindings/iommu/
>   F:	Documentation/userspace-api/iommu.rst
>   F:	drivers/iommu/
> +F:	include/linux/iommu-dma.h
>   F:	include/linux/iommu.h
>   F:	include/linux/iova.h
>   F:	include/linux/of_iommu.h
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 43520e7275cc..54e95792ed90 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -17,6 +17,7 @@
>   #include <linux/gfp.h>
>   #include <linux/huge_mm.h>
>   #include <linux/iommu.h>
> +#include <linux/iommu-dma.h>
>   #include <linux/iova.h>
>   #include <linux/irq.h>
>   #include <linux/list_sort.h>
> @@ -1134,9 +1135,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
>   }
>   
> -static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> -		unsigned long offset, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +			      unsigned long offset, size_t size,
> +			      enum dma_data_direction dir, unsigned long attrs)
>   {
>   	phys_addr_t phys = page_to_phys(page) + offset;
>   	bool coherent = dev_is_dma_coherent(dev);
> @@ -1194,8 +1195,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>   	return iova;
>   }
>   
> -static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +			  size_t size, enum dma_data_direction dir,
> +			  unsigned long attrs)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	phys_addr_t phys;
> @@ -1348,8 +1350,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>    * impedance-matching, to be able to hand off a suitably-aligned list,
>    * but still preserve the original offsets and sizes for the caller.
>    */
> -static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, unsigned long attrs)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> @@ -1468,8 +1470,8 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	return ret;
>   }
>   
> -static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> -		int nents, enum dma_data_direction dir, unsigned long attrs)
> +void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> +			enum dma_data_direction dir, unsigned long attrs)
>   {
>   	dma_addr_t end = 0, start;
>   	struct scatterlist *tmp;
> @@ -1731,10 +1733,6 @@ static const struct dma_map_ops iommu_dma_ops = {
>   	.free_noncontiguous	= iommu_dma_free_noncontiguous,
>   	.mmap			= iommu_dma_mmap,
>   	.get_sgtable		= iommu_dma_get_sgtable,
> -	.map_page		= iommu_dma_map_page,
> -	.unmap_page		= iommu_dma_unmap_page,
> -	.map_sg			= iommu_dma_map_sg,
> -	.unmap_sg		= iommu_dma_unmap_sg,
>   	.sync_single_for_cpu	= iommu_dma_sync_single_for_cpu,
>   	.sync_single_for_device	= iommu_dma_sync_single_for_device,
>   	.sync_sg_for_cpu	= iommu_dma_sync_sg_for_cpu,
> diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
> new file mode 100644
> index 000000000000..b42487bf8f8e
> --- /dev/null
> +++ b/include/linux/iommu-dma.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + *
> + * DMA operations that map physical memory through IOMMU.
> + */
> +#ifndef _LINUX_IOMMU_DMA_H
> +#define _LINUX_IOMMU_DMA_H
> +
> +#include <linux/dma-direction.h>
> +
> +#ifdef CONFIG_IOMMU_API
> +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> +			      unsigned long offset, size_t size,
> +			      enum dma_data_direction dir, unsigned long attrs);
> +void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> +			  size_t size, enum dma_data_direction dir,
> +			  unsigned long attrs);
> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> +		     enum dma_data_direction dir, unsigned long attrs);
> +void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> +			enum dma_data_direction dir, unsigned long attrs);
> +#else
> +static inline dma_addr_t iommu_dma_map_page(struct device *dev,
> +					    struct page *page,
> +					    unsigned long offset, size_t size,
> +					    enum dma_data_direction dir,
> +					    unsigned long attrs)
> +{
> +	return DMA_MAPPING_ERROR;
> +}
> +static inline void iommu_dma_unmap_page(struct device *dev,
> +					dma_addr_t dma_handle, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +}
> +static inline int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> +				   int nents, enum dma_data_direction dir,
> +				   unsigned long attrs)
> +{
> +	return -EINVAL;
> +}
> +static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> +			       int nents, enum dma_data_direction dir,
> +			       unsigned long attrs)
> +{
> +}
> +#endif /* CONFIG_IOMMU_API */
> +#endif /* _LINUX_IOMMU_DMA_H */
> diff --git a/kernel/dma/iommu.h b/kernel/dma/iommu.h
> new file mode 100644
> index 000000000000..4abaea2dfc49
> --- /dev/null
> +++ b/kernel/dma/iommu.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + *
> + * DMA operations that map physical memory through IOMMU.
> + */
> +#ifndef _KERNEL_DMA_IOMMU_H
> +#define _KERNEL_DMA_IOMMU_H
> +
> +#include <linux/iommu-dma.h>
> +
> +static inline dma_addr_t dma_iommu_map_page(struct device *dev,
> +					    struct page *page, size_t offset,
> +					    size_t size,
> +					    enum dma_data_direction dir,
> +					    unsigned long attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (ops->map_page)
> +		return ops->map_page(dev, page, offset, size, dir, attrs);
> +
> +	return iommu_dma_map_page(dev, page, offset, size, dir, attrs);
> +}
> +
> +static inline void dma_iommu_unmap_page(struct device *dev, dma_addr_t addr,
> +					size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (ops->unmap_page) {
> +		ops->unmap_page(dev, addr, size, dir, attrs);
> +		return;
> +	}
> +
> +	iommu_dma_unmap_page(dev, addr, size, dir, attrs);
> +}
> +
> +static inline int dma_iommu_map_sg(struct device *dev, struct scatterlist *sg,
> +				   int nents, enum dma_data_direction dir,
> +				   unsigned long attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (ops->map_sg)
> +		return ops->map_sg(dev, sg, nents, dir, attrs);
> +
> +	return iommu_dma_map_sg(dev, sg, nents, dir, attrs);
> +}
> +
> +static inline void dma_iommu_unmap_sg(struct device *dev,
> +				      struct scatterlist *sg, int nents,
> +				      enum dma_data_direction dir,
> +				      unsigned long attrs)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (ops->unmap_sg) {
> +		ops->unmap_sg(dev, sg, nents, dir, attrs);
> +		return;
> +	}
> +
> +	iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
> +}
> +#endif /* _KERNEL_DMA_IOMMU_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 6832fd6f0796..a9aa4036362a 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -16,6 +16,7 @@
>   #include <linux/vmalloc.h>
>   #include "debug.h"
>   #include "direct.h"
> +#include "iommu.h"
>   
>   #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>   	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> @@ -160,7 +161,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
>   	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
>   		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
>   	else
> -		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> +		addr = dma_iommu_map_page(dev, page, offset, size, dir, attrs);
>   	kmsan_handle_dma(page, offset, size, dir);
>   	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
>   
> @@ -178,7 +179,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   	    arch_dma_unmap_page_direct(dev, addr + size))
>   		dma_direct_unmap_page(dev, addr, size, dir, attrs);
>   	else
> -		ops->unmap_page(dev, addr, size, dir, attrs);
> +		dma_iommu_unmap_page(dev, addr, size, dir, attrs);
>   	debug_dma_unmap_page(dev, addr, size, dir);
>   }
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
> @@ -198,7 +199,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	    arch_dma_map_sg_direct(dev, sg, nents))
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
> -		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> +		ents = dma_iommu_map_sg(dev, sg, nents, dir, attrs);
>   
>   	if (ents > 0) {
>   		kmsan_handle_dma_sg(sg, nents, dir);
> @@ -292,7 +293,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	    arch_dma_unmap_sg_direct(dev, sg, nents))
>   		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
>   	else
> -		ops->unmap_sg(dev, sg, nents, dir, attrs);
> +		dma_iommu_unmap_sg(dev, sg, nents, dir, attrs);
>   }
>   EXPORT_SYMBOL(dma_unmap_sg_attrs);
>   
