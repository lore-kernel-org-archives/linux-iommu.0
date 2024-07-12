Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C617C69;
	Fri, 12 Jul 2024 05:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763251; cv=none; b=kMAFwKrY3179JsNKj1uEgv/YZwsNmaDaAGrY/LDNx/vk5VAvl1dfLw8U5HmB0F9FExubK9QH9MEY7ItRBm5hyQOE0PCYq97y2FrWltQT+BnsYf5WaBhuP8KRuqqs/zeuZSB7/EJ2KzWT1ICv54WcgUAJ3iFYx9rI7TBQ5Es45z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763251; c=relaxed/simple;
	bh=x4m6CN+jcRwCtuOs8+f1kpqn+DbKAfcl3QXghL7t3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDBmTS1qWsCdXOM53QwRlhjPqsVzvMIMyLsqMiCZz47J/d//XLnvSs/lYvIzdEuBP83naGnThP5kN2jT5epQ30wmZKf9UrULEfyaSXuIsPY2oJbq++BHYQpU7Gv74UmXxPCAH8pCHg879cqTOTZuR+AvYDzfXTUaTDLFOJeAAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnxpZxLl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnxpZxLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5D8C3277B;
	Fri, 12 Jul 2024 05:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720763250;
	bh=x4m6CN+jcRwCtuOs8+f1kpqn+DbKAfcl3QXghL7t3c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnxpZxLlsDr/BfhcWwxbtDkAkW42SZxubVwSbtiyCDBtqOvdWcZ35TsyYmssXCTva
	 8QCUYfZDkHTbL5Whk6+Ixkkw0kr4I0ocA3ixcxsRmqovtVFt21cXRYaeUoZmiB2i/C
	 bxTTDva4x6TKH02sbamDFnuEnaXzU5vgai6mN3HlQcmw/CTbYD/FsFSLTqCWDZ/Daf
	 FwAMA6gyy42/PBS5w3S9pVTufp6UVE6og/rlgM7uby6oZuouRoTiytPjVMH9w1rNXP
	 lbMLovPrgc5q6yliJ9pZeG/B+trWCrFIkuxkZULv6nCl1OYhw20nePWRbnmLmvtf4s
	 NdEI5aQ7/xiPQ==
Date: Fri, 12 Jul 2024 08:47:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] dma: call unconditionally to unmap_page and unmap_sg
 callbacks
Message-ID: <20240712054725.GD1815706@unreal>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <7ef6cd1e-3dc6-452e-ac1c-128ee98acdb0@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef6cd1e-3dc6-452e-ac1c-128ee98acdb0@arm.com>

On Thu, Jul 11, 2024 at 07:02:39PM +0100, Robin Murphy wrote:
> On 11/07/2024 11:38 am, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Almost all users of ->map_page()/map_sg() callbacks implement
> > ->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
> > is dummy DMA ops interface, and the use of this interface is to fail
> > the operation and in such case, there won't be any call to
> > ->unmap_page()/unmap_sg().
> > 
> > This patch removes the existence checks of ->unmap_page()/unmap_sg()
> > and calls to it directly to create symmetrical interface to
> > ->map_page()/map_sg().
> 
> Now that all the common cases have been mopped up by dma-direct, I'm
> inclined to agree that this seems reasonable. For sure there is code out
> there still abusing random DMA API calls as a cache maintenance interface
> because it thinks it knows better, but even that's going to be running on
> platforms where it expects unmap to have the desired effect anyway, so the
> chance of somehow ending up with the dummy ops and crashing seems
> sufficiently unlikely.
> 
> However, I'm a little wary of the static checker brigade noticing that and
> trying to "fix" it by reinstating these tests, so perhaps it's worth just
> adding unmaps to the dummy ops (with a WARN() in them) as well for the sake
> of cleanliness and avoidance of any doubt.

I'll add, however the plan is to get rid of dummy ops in the near future.

Thanks

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   kernel/dma/mapping.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 81de84318ccc..6832fd6f0796 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -177,7 +177,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
> >   	if (dma_map_direct(dev, ops) ||
> >   	    arch_dma_unmap_page_direct(dev, addr + size))
> >   		dma_direct_unmap_page(dev, addr, size, dir, attrs);
> > -	else if (ops->unmap_page)
> > +	else
> >   		ops->unmap_page(dev, addr, size, dir, attrs);
> >   	debug_dma_unmap_page(dev, addr, size, dir);
> >   }
> > @@ -291,7 +291,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
> >   	if (dma_map_direct(dev, ops) ||
> >   	    arch_dma_unmap_sg_direct(dev, sg, nents))
> >   		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
> > -	else if (ops->unmap_sg)
> > +	else
> >   		ops->unmap_sg(dev, sg, nents, dir, attrs);
> >   }
> >   EXPORT_SYMBOL(dma_unmap_sg_attrs);
