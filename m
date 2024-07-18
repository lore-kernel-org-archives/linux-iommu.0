Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9439FE4
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274544; cv=none; b=tk1uZeJhGdJaYF459l+tPAf4xzG+01pRgAcTd2i84wmYli6Ae6tOBs9JeCjHHhyo8P7GcCg+Mz8fx5breD6EeINjRTBuYwp4fRGsWbQ8wftXsW2qelznY1hz+Hm9t7lsgf3Mn5a6+n+Fnanidfj2gDnetXyHNCFHOEIylhBVvas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274544; c=relaxed/simple;
	bh=Tdxezc5XNOgn9ppSYX8AOYi8JFeWzTYe0VUchbryAek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lblpS20fC1N2Kym34NrP7TvMrAF0qSZ1uYaVJTG0CbSTPbNGwE4KVkC5BflonQu03fPFYjRtyhhspVAAsYbtkjMlc4nzXiRtJgn3iSyi2AKHfYZwyeQL4/3TVC8zaENhEXbkM4QJcesYX/v4CLO7bJQp/NEabBbDYH4Z469wenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A76FA68D07; Thu, 18 Jul 2024 05:48:55 +0200 (CEST)
Date: Thu, 18 Jul 2024 05:48:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240718034854.GA31912@lst.de>
References: <cover.1721219730.git.leon@kernel.org> <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 17, 2024 at 03:37:11PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Most of the arch DMA ops (which often, but not  always, involve
> some sort of IOMMU) are using the same DMA operations. These DMA
> operations are default ones implemented in drivers/iomem/dma-iommu.c.

I'm not sure I agree with the exact wording.  There's tons of arch DMA
ops not in any way tied to dma-iommu (or the iommu subsystem, but not
dma-iommu like the arm32 ones), but for all modern platforms dma-iommu
is what actually matters.

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>

A double-signoff for the same person is a bit weird, isn't it?

>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> @@ -1756,10 +1733,10 @@ void iommu_setup_dma_ops(struct device *dev)
>  	if (iommu_is_dma_domain(domain)) {
>  		if (iommu_dma_init_domain(domain, dev))
>  			goto out_err;
> +		dev->dma_iommu = true;
> +	} else if (dev->dma_iommu) {
>  		/* Clean up if we've switched *from* a DMA domain */
> +		dev->dma_iommu = false;
>  	}

Strictly speaking we can no remove the if part of the else if above.
Or reword this a bit to:

	dev->dma_iommu = iommu_is_dma_domain(domain);
	if (dev->dma_iommu && iommu_dma_init_domain(domain, dev))
		goto out_err;

> diff --git a/include/linux/device.h b/include/linux/device.h
> index ace039151cb8..7fa1e40b617a 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -822,6 +822,9 @@ struct device {
>  #ifdef CONFIG_DMA_NEED_SYNC
>  	bool			dma_skip_sync:1;
>  #endif
> +#ifdef CONFIG_IOMMU_DMA
> +	bool			dma_iommu : 1;
> +#endif

The kerneldoc above should be updated to describe this field.
Please also add the maintainers of this file to the next round.

> +static inline bool dma_is_default_iommu(struct device *dev)
> +{
> +#ifdef CONFIG_IOMMU_DMA
> +	return dev->dma_iommu;
> +#else
> +	return false;
> +#endif
> +}

The normal style would be to move the ifdefs outside the helper
function.  Also maybe name this use_dma_iommu?

>  static bool dma_go_direct(struct device *dev, dma_addr_t mask,
>  		const struct dma_map_ops *ops)
>  {
> +	WARN_ON_ONCE(ops && dma_is_default_iommu(dev));

I'd prefer to keep this out of the fast path and only do it in
say dma_set_mask.  And fail the call while we're at it.

> +	if (likely(!ops) && !dma_is_default_iommu(dev))

The likely should cover both conditions.

>  		return true;
> +
>  #ifdef CONFIG_DMA_OPS_BYPASS
> +	WARN_ON_ONCE(dev->dma_ops_bypass && dma_is_default_iommu(dev));
>  	if (dev->dma_ops_bypass)

Let's skip this and think about it if we ever use the bypass for
something that is not powerpc with it's own dma ops.

> @@ -323,8 +346,12 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
>  	BUG_ON(!valid_dma_direction(dir));
> -	if (!dma_map_direct(dev, ops) && ops->unmap_resource)
> -		ops->unmap_resource(dev, addr, size, dir, attrs);
> +	if (!dma_map_direct(dev, ops)) {
> +		if (dma_is_default_iommu(dev))
> +			iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
> +		else if (ops->unmap_resource)
> +			ops->unmap_resource(dev, addr, size, dir, attrs);
> +	}

I'd prefer to order this as:

	if (dma_map_direct(dev, ops))
		; /* nothing to do: uncached and no swiotlb */
	else if (use_dma_iommu(dev))
		iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
	else if (ops->unmap_resource)
		ops->unmap_resource(dev, addr, size, dir, attrs);

> +	return (!ops || dma_is_default_iommu(dev));

dma_is_default_iommu implies !ops, so the second condition is
redundant.

>  EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> @@ -888,7 +943,12 @@ unsigned long dma_get_merge_boundary(struct device *dev)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> +	if (!ops)
> +		return 0;	/* can't merge */
> +	if (dma_is_default_iommu(dev))
> +		return iommu_dma_get_merge_boundary(dev);

The second check needs to move up here.

