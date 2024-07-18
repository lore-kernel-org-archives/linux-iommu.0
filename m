Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8974058;
	Thu, 18 Jul 2024 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286251; cv=none; b=CfUxKSe3aKaYaOVa/YB+EzohlHyqQhXXTZ7XpHAuVGUt9cvPGqZerbzynbIoVuXcI9qdPeKoaCaMq71SE/FQOvhPyVCpBnLF2PgI9PqFFkexbTNN9M6ERIQ7xIudnA6xIOr2AvFdsq6aXIXX6LpeTCqeBFeRbyk8vBM72BrXWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286251; c=relaxed/simple;
	bh=pAIKRUOe4rqwHdGMj8JeiKi4lyWdhmkJFpi2cWSoqW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAxzBDuUeKwY0SRVeK+C+abd+DqPGVpzDpg2rLnsga2i22Nc/sA7BB67o8rBTWniOeImtMhdmdJPdr1kQ/Ty4TmihvcIx3EKALAhRBd+IUG/rEGcXBSpo8eEgTBYFRicZt7a+ElNxfSO/KOXjc13tgS2ZXd+3mtGSuGvWGQXzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0zyEpA0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0zyEpA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58487C116B1;
	Thu, 18 Jul 2024 07:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721286250;
	bh=pAIKRUOe4rqwHdGMj8JeiKi4lyWdhmkJFpi2cWSoqW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0zyEpA03KDfPUPqxa8E0tRYAieqTSVOLhMT1QkWTyfDO0HCIexuYbbCfWmXu7nJI
	 mNt3GdjTWLEcVOD1BbGxSc91b5IbzbL7oA0WZdPjwtlJfSV2h1/4oRdRmw6oIqAuxa
	 UAuCQkU04Vo8uZApACdt1rIf6V9O+h91qCwVY/7PauzWy3F+3c98btHRAKJKXiuXn5
	 Fnorbk0QsSg2Z7QnFaOmtsz8XSsKBHCr/+LVNbxlhChjYid8c5izz1L4xF//KDQqUq
	 +o0JwH4kEGmwYId5ravPpOk+CkUyo/s1AoSW86DkuZmrrVAqS+qNJ+DnL/DQrMSFAx
	 tvH/PPrTfmHKA==
Date: Thu, 18 Jul 2024 10:04:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240718070406.GK5630@unreal>
References: <cover.1721219730.git.leon@kernel.org>
 <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>
 <20240718034854.GA31912@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240718034854.GA31912@lst.de>

On Thu, Jul 18, 2024 at 05:48:54AM +0200, Christoph Hellwig wrote:
> On Wed, Jul 17, 2024 at 03:37:11PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Most of the arch DMA ops (which often, but not  always, involve
> > some sort of IOMMU) are using the same DMA operations. These DMA
> > operations are default ones implemented in drivers/iomem/dma-iommu.c.
> 
> I'm not sure I agree with the exact wording.  There's tons of arch DMA
> ops not in any way tied to dma-iommu (or the iommu subsystem, but not
> dma-iommu like the arm32 ones), but for all modern platforms dma-iommu
> is what actually matters.

I can change to any other wording, whatever you think is better.

> 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> 
> A double-signoff for the same person is a bit weird, isn't it?

Sorry about that, it is a mistake in my tooling.

> 
> >  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> > @@ -1756,10 +1733,10 @@ void iommu_setup_dma_ops(struct device *dev)
> >  	if (iommu_is_dma_domain(domain)) {
> >  		if (iommu_dma_init_domain(domain, dev))
> >  			goto out_err;
> > +		dev->dma_iommu = true;
> > +	} else if (dev->dma_iommu) {
> >  		/* Clean up if we've switched *from* a DMA domain */
> > +		dev->dma_iommu = false;
> >  	}
> 
> Strictly speaking we can no remove the if part of the else if above.
> Or reword this a bit to:
> 
> 	dev->dma_iommu = iommu_is_dma_domain(domain);
> 	if (dev->dma_iommu && iommu_dma_init_domain(domain, dev))
> 		goto out_err;

I'll change

> 
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index ace039151cb8..7fa1e40b617a 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -822,6 +822,9 @@ struct device {
> >  #ifdef CONFIG_DMA_NEED_SYNC
> >  	bool			dma_skip_sync:1;
> >  #endif
> > +#ifdef CONFIG_IOMMU_DMA
> > +	bool			dma_iommu : 1;
> > +#endif
> 
> The kerneldoc above should be updated to describe this field.

Will do

> Please also add the maintainers of this file to the next round.

I added them, there is no special maintainer for include/linux/device.h file:
➜  kernel git:(dma-static-calls-v2) ✗ ./scripts/get_maintainer.pl --git-min-percent 100 /tmp/e/v2-0002-dma-add-IOMMU-static-calls-with-clear-default-ops.patch
Joerg Roedel <joro@8bytes.org> (maintainer:IOMMU SUBSYSTEM)
Will Deacon <will@kernel.org> (maintainer:IOMMU SUBSYSTEM)
Robin Murphy <robin.murphy@arm.com> (reviewer:IOMMU SUBSYSTEM)
Christoph Hellwig <hch@lst.de> (supporter:DMA MAPPING HELPERS)
Marek Szyprowski <m.szyprowski@samsung.com> (supporter:DMA MAPPING HELPERS)
linux-kernel@vger.kernel.org (open list)
iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM)

Whom should I add?

> 
> > +static inline bool dma_is_default_iommu(struct device *dev)
> > +{
> > +#ifdef CONFIG_IOMMU_DMA
> > +	return dev->dma_iommu;
> > +#else
> > +	return false;
> > +#endif
> > +}
> 
> The normal style would be to move the ifdefs outside the helper
> function.

I think you are talking about the style of functions declarations in
header files. This function is inside c-file and it is much easier
to write it this way. 


> Also maybe name this use_dma_iommu?

Sure, I'll change it.

> 
> >  static bool dma_go_direct(struct device *dev, dma_addr_t mask,
> >  		const struct dma_map_ops *ops)
> >  {
> > +	WARN_ON_ONCE(ops && dma_is_default_iommu(dev));
> 
> I'd prefer to keep this out of the fast path and only do it in
> say dma_set_mask.  And fail the call while we're at it.

I will add it to dma_supported().

> 
> > +	if (likely(!ops) && !dma_is_default_iommu(dev))
> 
> The likely should cover both conditions.

Sure

> 
> >  		return true;
> > +
> >  #ifdef CONFIG_DMA_OPS_BYPASS
> > +	WARN_ON_ONCE(dev->dma_ops_bypass && dma_is_default_iommu(dev));
> >  	if (dev->dma_ops_bypass)
> 
> Let's skip this and think about it if we ever use the bypass for
> something that is not powerpc with it's own dma ops.

I wanted to catch misconfigurations, but I can remove it. Is this what
you are suggesting?

  126 static bool dma_go_direct(struct device *dev, dma_addr_t mask, 
  127                 const struct dma_map_ops *ops)                
  128 {                                                            
  129         if (likely(!ops && !dma_is_default_iommu(dev)))     
  130                 return true;                               
  131                                                           
  132         if (dma_is_default_iommu(dev))    
  133                 return false;
  134                             
  135 #ifdef CONFIG_DMA_OPS_BYPASS 
  136         if (dev->dma_ops_bypass)
  137                 return min_not_zero(mask, dev->bus_dma_limit) >= 
  138                             dma_direct_get_required_mask(dev);  
  139 #endif                                                         
  140         return false;                                         
  141 }         

> 
> > @@ -323,8 +346,12 @@ void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
> >  	const struct dma_map_ops *ops = get_dma_ops(dev);
> >  
> >  	BUG_ON(!valid_dma_direction(dir));
> > -	if (!dma_map_direct(dev, ops) && ops->unmap_resource)
> > -		ops->unmap_resource(dev, addr, size, dir, attrs);
> > +	if (!dma_map_direct(dev, ops)) {
> > +		if (dma_is_default_iommu(dev))
> > +			iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
> > +		else if (ops->unmap_resource)
> > +			ops->unmap_resource(dev, addr, size, dir, attrs);
> > +	}
> 
> I'd prefer to order this as:
> 
> 	if (dma_map_direct(dev, ops))
> 		; /* nothing to do: uncached and no swiotlb */
> 	else if (use_dma_iommu(dev))
> 		iommu_dma_unmap_resource(dev, addr, size, dir, attrs);
> 	else if (ops->unmap_resource)
> 		ops->unmap_resource(dev, addr, size, dir, attrs);

I will change.

> 
> > +	return (!ops || dma_is_default_iommu(dev));
> 
> dma_is_default_iommu implies !ops, so the second condition is
> redundant.

Right

> 
> >  EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
> > @@ -888,7 +943,12 @@ unsigned long dma_get_merge_boundary(struct device *dev)
> >  {
> >  	const struct dma_map_ops *ops = get_dma_ops(dev);
> >  
> > +	if (!ops)
> > +		return 0;	/* can't merge */
> > +	if (dma_is_default_iommu(dev))
> > +		return iommu_dma_get_merge_boundary(dev);
> 
> The second check needs to move up here.

Right, will fix.

I'll send v3 after weekend.

Thanks
