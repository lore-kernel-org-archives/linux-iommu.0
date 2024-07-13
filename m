Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B582914006;
	Sat, 13 Jul 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720863049; cv=none; b=n7PlhW1TzzjKhJcyzU8fnYEjuhUDqCZPubAtf+4mZY+EIjuZi9RY0sOT1APjj9vDkhJWMwbXOQ72L4ZIr7ZhzNGKZuLAXLTqmHdSSc//Q/9IDGxEpFZHtpSLv8/rshVKXxD+ML4x/f7famxKH0FzW6V94Xso9+m4tddPHnaathI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720863049; c=relaxed/simple;
	bh=egg7o9yZhEZ4EbCuIXAkxMp7kCxfrjNbsYkBpotkbek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePOV0UGK2YbPMCdHMS1fQXH1hVElbIhAFWlEnahry7UwaSnxBkWDn9crgghIwsKYKeNgLmBlUG5lZGN6i8gk8iEOrsbDnna2ISZIoDXJgISiwIQJM3hJFmQrr6635zpe+RsGxdNsgsEOoXdQQ63v3B9PLvvXLqxk+V6eId58EBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsBMuy+x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsBMuy+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4687C32781;
	Sat, 13 Jul 2024 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720863049;
	bh=egg7o9yZhEZ4EbCuIXAkxMp7kCxfrjNbsYkBpotkbek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsBMuy+x6YhhAPf/O+hmHpRhHG0Z5A99e16oKmuvbCV5oYqhaS/Box0aFULcsub9I
	 b+wcae51nzJgy1ftGuFrkVLkRydctBIgb5mUO9H88MxeLCi0jmg1zQ23/9F9X723bR
	 tDt/ZvgUdwi0L4ML2wVWunmL8+8M+WCyqcXVrZL4H3YtAYDPjMtFl0Ahg8lAQifMwF
	 Kaitum+YwaEwKdcbs6j6+L39YcnJJDtTKO28yUgkfn7DMcrPXl4nzYS2cNcM88QsZY
	 deg0uA4mNs6mWXamXcIrRmRnMgFPtCcERCtN4npChEBHpZSHM0GCiO0uTAIfDCCffJ
	 3mjlJztHsF/zQ==
Date: Sat, 13 Jul 2024 12:30:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240713093043.GG1815706@unreal>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
 <3912d498-5696-4e87-bab0-f35ef7ac6083@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3912d498-5696-4e87-bab0-f35ef7ac6083@linux.microsoft.com>

On Fri, Jul 12, 2024 at 01:51:36PM -0700, Easwar Hariharan wrote:
> On 7/11/2024 3:38 AM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Most of the IOMMU drivers are using the same DMA operations, which are
> > default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
> > to properly set them as a default with direct call without need to
> > perform function pointer dereference.
> > 
> > During system initialization, the IOMMU driver can set its own DMA and
> > in such case, the default DMA operations will be overridden.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  MAINTAINERS               |  1 +
> >  drivers/iommu/dma-iommu.c | 24 +++++++-------
> >  include/linux/iommu-dma.h | 50 +++++++++++++++++++++++++++++
> >  kernel/dma/iommu.h        | 67 +++++++++++++++++++++++++++++++++++++++
> >  kernel/dma/mapping.c      |  9 +++---
> >  5 files changed, 134 insertions(+), 17 deletions(-)
> >  create mode 100644 include/linux/iommu-dma.h
> >  create mode 100644 kernel/dma/iommu.h
> > 
> 
> <snip>
> > diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
> > new file mode 100644
> > index 000000000000..b42487bf8f8e
> > --- /dev/null
> > +++ b/include/linux/iommu-dma.h
> > @@ -0,0 +1,50 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> > + *
> > + * DMA operations that map physical memory through IOMMU.
> > + */
> > +#ifndef _LINUX_IOMMU_DMA_H
> > +#define _LINUX_IOMMU_DMA_H
> > +
> > +#include <linux/dma-direction.h>
> > +
> > +#ifdef CONFIG_IOMMU_API
> > +dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> > +			      unsigned long offset, size_t size,
> > +			      enum dma_data_direction dir, unsigned long attrs);
> > +void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
> > +			  size_t size, enum dma_data_direction dir,
> > +			  unsigned long attrs);
> > +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> > +		     enum dma_data_direction dir, unsigned long attrs);
> > +void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
> > +			enum dma_data_direction dir, unsigned long attrs);
> > +#else
> > +static inline dma_addr_t iommu_dma_map_page(struct device *dev,
> > +					    struct page *page,
> > +					    unsigned long offset, size_t size,
> > +					    enum dma_data_direction dir,
> > +					    unsigned long attrs)
> > +{
> > +	return DMA_MAPPING_ERROR;
> > +}
> > +static inline void iommu_dma_unmap_page(struct device *dev,
> > +					dma_addr_t dma_handle, size_t size,
> > +					enum dma_data_direction dir,
> > +					unsigned long attrs)
> > +{
> > +}
> > +static inline int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> > +				   int nents, enum dma_data_direction dir,
> > +				   unsigned long attrs)
> > +{
> > +	return -EINVAL;
> > +}
> > +static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> > +			       int nents, enum dma_data_direction dir,
> > +			       unsigned long attrs)
> > +{
> > +}
> > +#endif /* CONFIG_IOMMU_API */
> > +#endif /* _LINUX_IOMMU_DMA_H */
> > diff --git a/kernel/dma/iommu.h b/kernel/dma/iommu.h
> > new file mode 100644
> > index 000000000000..4abaea2dfc49
> > --- /dev/null
> > +++ b/kernel/dma/iommu.h
> > @@ -0,0 +1,67 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> > + *
> > + * DMA operations that map physical memory through IOMMU.
> > + */
> > +#ifndef _KERNEL_DMA_IOMMU_H
> > +#define _KERNEL_DMA_IOMMU_H
> > +
> > +#include <linux/iommu-dma.h>
> > +
> > +static inline dma_addr_t dma_iommu_map_page(struct device *dev,
> > +					    struct page *page, size_t offset,
> > +					    size_t size,
> > +					    enum dma_data_direction dir,
> > +					    unsigned long attrs)
> > +{
> > +	const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +	if (ops->map_page)
> > +		return ops->map_page(dev, page, offset, size, dir, attrs);
> > +
> > +	return iommu_dma_map_page(dev, page, offset, size, dir, attrs);
> > +}
> > +
> > +static inline void dma_iommu_unmap_page(struct device *dev, dma_addr_t addr,
> > +					size_t size,
> > +					enum dma_data_direction dir,
> > +					unsigned long attrs)
> > +{
> > +	const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +	if (ops->unmap_page) {
> > +		ops->unmap_page(dev, addr, size, dir, attrs);
> > +		return;
> > +	}
> > +
> > +	iommu_dma_unmap_page(dev, addr, size, dir, attrs);
> > +}
> > +
> > +static inline int dma_iommu_map_sg(struct device *dev, struct scatterlist *sg,
> > +				   int nents, enum dma_data_direction dir,
> > +				   unsigned long attrs)
> > +{
> > +	const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +	if (ops->map_sg)
> > +		return ops->map_sg(dev, sg, nents, dir, attrs);
> > +
> > +	return iommu_dma_map_sg(dev, sg, nents, dir, attrs);
> > +}
> > +
> > +static inline void dma_iommu_unmap_sg(struct device *dev,
> > +				      struct scatterlist *sg, int nents,
> > +				      enum dma_data_direction dir,
> > +				      unsigned long attrs)
> > +{
> > +	const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +	if (ops->unmap_sg) {
> > +		ops->unmap_sg(dev, sg, nents, dir, attrs);
> > +		return;
> > +	}
> > +
> > +	iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
> > +}
> 
> Can we use _dma_iommu_* instead of the transposition pattern we have
> going on here? Having dma_iommu_* call iommu_dma_* is, I feel, a recipe
> for confusion when reading the code, especially after a few passes when
> the eyes start to glaze over.
> 
> I think you're going for the typical pattern of iommu_dma* being an
> internal detail that provides an implementation, but correct me if
> there's some significance to the current naming scheme.

Given the review feedback from Robin and Christoph, I will drop this
layer anyway.

Thanks

> 
> Thanks,
> Easwar
