Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302144594D
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817505; cv=none; b=JBydiqqshIZCSHoQZ7WV5SCShdcFUJu0eVDXjGwktLPURhzMBsAnZZvqzADjaWzQ5jEoq3sXx3oZb+BtS8uv2iOv+jsTR7TJLIehgyMZbuqP5DtVhkFJvOotZaMXkIU997/7/Sc0p/2c1+N4Ay/sMHVpE9HgjDye+WTTsGRN/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817505; c=relaxed/simple;
	bh=u/Ohh38LvveP2wA5piidfFPO5CYKk/98ALw6FSU+qCg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WhXZvVXeuBKf8gXgpcQlF07sVdLtu0l7/nLundJ6qVQ4vptHwHaWcJIMjwU1xw0j8ssiTUcHXFZk8VJ41Y+00ghYrUDg6OnKALJIgAjUaEFbxIi0YcM+KhS6hDxcUJKvaV5lNPZnMe7mIiyBy8fLE7m8LTYjwQzDRCn+VhWt5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gAqpq3Of; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gAqpq3Of"
Received: from [100.65.217.8] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DA6720B7165;
	Fri, 12 Jul 2024 13:51:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DA6720B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720817497;
	bh=lmvwD21XAr2jkswT4nVPWFHqGQ/8E2miXUrnqK1v1lo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gAqpq3OfRgA82fEYqRsLyk7csxlmeB5VPZ5jfZdgW3ut61kFVQK92lmcWEXhcKbAO
	 pmybDShHSZIr0BjRWMdgATdnzKGYz5OJ88G2o72Tro92UFtnPrV76AJbhkZ9pe26ny
	 pujX2+I9wCcMpTalj92S2EmVRMnIesuRsqoxTwJI=
Message-ID: <3912d498-5696-4e87-bab0-f35ef7ac6083@linux.microsoft.com>
Date: Fri, 12 Jul 2024 13:51:36 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Leon Romanovsky <leonro@nvidia.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/2024 3:38 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the IOMMU drivers are using the same DMA operations, which are
> default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
> to properly set them as a default with direct call without need to
> perform function pointer dereference.
> 
> During system initialization, the IOMMU driver can set its own DMA and
> in such case, the default DMA operations will be overridden.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  MAINTAINERS               |  1 +
>  drivers/iommu/dma-iommu.c | 24 +++++++-------
>  include/linux/iommu-dma.h | 50 +++++++++++++++++++++++++++++
>  kernel/dma/iommu.h        | 67 +++++++++++++++++++++++++++++++++++++++
>  kernel/dma/mapping.c      |  9 +++---
>  5 files changed, 134 insertions(+), 17 deletions(-)
>  create mode 100644 include/linux/iommu-dma.h
>  create mode 100644 kernel/dma/iommu.h
> 

<snip>
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

Can we use _dma_iommu_* instead of the transposition pattern we have
going on here? Having dma_iommu_* call iommu_dma_* is, I feel, a recipe
for confusion when reading the code, especially after a few passes when
the eyes start to glaze over.

I think you're going for the typical pattern of iommu_dma* being an
internal detail that provides an implementation, but correct me if
there's some significance to the current naming scheme.

Thanks,
Easwar
