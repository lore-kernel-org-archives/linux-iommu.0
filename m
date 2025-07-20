Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BC273FD
	for <iommu@lists.linux.dev>; Sun, 20 Jul 2025 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994379; cv=none; b=sml11fBXmMa9xbZ+eiHTcO3ZZgWs9F7mjuufpLJNBMuiQyaF/PmH+RIQ52YWIEuqHwlDQaSjl/8NYcJld5x9sWsrzIQIcgb80cm9hWgPgTuTJv1BPMaba5GKiO+PEG75TgXBn8TIzHvufPN2RyeVhm09rccGOmB19agjFG4oPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994379; c=relaxed/simple;
	bh=GKgsRMNlHYzfrLTtFpOoDaLGgBok2YsFVtCN2228bRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVjBYPGAgXY+fjM+bmwAE2OjbVdQ/U3yZlDNaDureI1sNE2Iu3SIomgUZZiWwOxSIQQoQ5Gt5o18Rf9lLhcLYjd1/wORD7tC6hMS973CXjzhtFbzt7bgOrk5Su3HQPfT6Wnz+l4oGqxMUHvlNXUzAbK0Q8miXXkKka5fH/wZNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSlZES7G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSlZES7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F2FC4CEE7;
	Sun, 20 Jul 2025 06:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752994379;
	bh=GKgsRMNlHYzfrLTtFpOoDaLGgBok2YsFVtCN2228bRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSlZES7GPfpkz1TISqpox2pxu/NH7BCxHmE/wmQzVsBySGkKGQGBEIyoGyjlfK13M
	 vuPFR2aZeqsGfVWnrMgYl+0SaBbniqm341tVEpEfgUkkebe8R1x+WNyCPLYtXpEpDB
	 kTpXYvt0vNBlHXZnGWovmoyAH9Q7Oz5LLQKelMaz83cEqI04A9gkFktmJ4rE85T1L1
	 32JrIlJqYXIDFZw7TadFTv9nfYlwObwR0Psq2HKq+ZCWak2YsFG3ZWyNi/4ZB3Vaw3
	 SWWmt5eZvLFj4xF/2pgrJlyN9Vc/r/Z6DtTs8k6xaHOWprU3bIvHwraWrdA4UI4fUw
	 4JqDNhBJ5OeUg==
Date: Sun, 20 Jul 2025 09:52:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] dma-mapping: prepare dma_map_ops to conversion to
 physical address
Message-ID: <20250720065255.GC402218@unreal>
References: <cover.1752734252.git.leon@kernel.org>
 <1798a3351dcabccaf0749221e9e9b66585a7b2c6.1752734252.git.leon@kernel.org>
 <20250717134435.GA2206214@ziepe.ca>
 <20250717145213.GB402218@unreal>
 <20250717170758.GB2206214@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717170758.GB2206214@ziepe.ca>

On Thu, Jul 17, 2025 at 02:07:58PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 17, 2025 at 05:52:13PM +0300, Leon Romanovsky wrote:
> > > I would expect 'else if'
> > 
> > I don't expect both of them to exist. There is WARN_ON_ONCE() to catch it.
> > If it is important, I can add else.
> 
> Compiler generates better code with the else.
> 
> > > > @@ -213,8 +221,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
> > > >  		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
> > > >  	else if (use_dma_iommu(dev))
> > > >  		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
> > > > -	else
> > > > -		ops->unmap_page(dev, addr, size, dir, attrs);
> > > > +	else {
> > > > +		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
> > > > +			/* We shouldn't have both functions */
> > > > +			WARN_ON_ONCE(ops->unmap_page && ops->unmap_phys);
> > > > +
> > > > +		if (ops->unmap_phys)
> > > > +			ops->unmap_phys(dev, addr, size, dir, attrs);
> > > > +		if (ops->unmap_page)
> > > > +			ops->unmap_page(dev, addr, size, dir, attrs);
> > > 
> > > Here too
> > > 
> > > What is the practical difference between unmap_phys and unmap_page?
> > 
> > There is no difference. It is provided to provide symmetrical interface
> > to .map_phys, simple rename.
> 
> We really should not be converting phys to page without knowing there
> is a page available..

I didn't want. See this email and followup discussion.
https://lore.kernel.org/all/20250627170213.GL17401@unreal/

Thanks
