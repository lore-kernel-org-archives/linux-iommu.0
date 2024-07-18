Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD078C93
	for <iommu@lists.linux.dev>; Thu, 18 Jul 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305853; cv=none; b=FgpPZF5sQ+hYjykEz+Jxn8DeCj4wxK0xgLh6pwsy9tG3TWdIioQx+V4Od1wC95z7mlaAx7kTuyO/uGbAjPzDQ8fM1jrqmU6ySGy8h0G+OyVdYJbZa+b3ZT37U8ySe4sg5tl4B+oRPW/hINCR8d4MV30ucJPEIShpi1zXu6Hqr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305853; c=relaxed/simple;
	bh=+BQPttCG8Vi+PW3CzK6Fn0OfTzFnIcYog1acBzANm6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKJ/+ZnRhVNsIHPynha8abL0zKVY0u3MNaCKWvgJRCUpL16fnkfGYTC1hlv3WC2pgN4Os0wa+HIT1S5dAX+x2HAPa19Zzs84dS7Zsuq4/LOWymlkfTUlItmLYTwQnhzosx3lNV5BzJHx0mHgYp2FQyEZ+U0Osqvsup+vAft0QZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34D1A68AFE; Thu, 18 Jul 2024 14:30:39 +0200 (CEST)
Date: Thu, 18 Jul 2024 14:30:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240718123038.GA27055@lst.de>
References: <cover.1721219730.git.leon@kernel.org> <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org> <20240718034854.GA31912@lst.de> <20240718070406.GK5630@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718070406.GK5630@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 18, 2024 at 10:04:06AM +0300, Leon Romanovsky wrote:
> Whom should I add?

Greg as the device model maintainer.

> > The normal style would be to move the ifdefs outside the helper
> > function.
> 
> I think you are talking about the style of functions declarations in
> header files. This function is inside c-file and it is much easier
> to write it this way. 

But also much harder to read, which will happen much more often.

> > >  #ifdef CONFIG_DMA_OPS_BYPASS
> > > +	WARN_ON_ONCE(dev->dma_ops_bypass && dma_is_default_iommu(dev));
> > >  	if (dev->dma_ops_bypass)
> > 
> > Let's skip this and think about it if we ever use the bypass for
> > something that is not powerpc with it's own dma ops.
> 
> I wanted to catch misconfigurations, but I can remove it. Is this what
> you are suggesting?
> 
>   126 static bool dma_go_direct(struct device *dev, dma_addr_t mask, 
>   127                 const struct dma_map_ops *ops)                
>   128 {                                                            
>   129         if (likely(!ops && !dma_is_default_iommu(dev)))     
>   130                 return true;                               
>   131                                                           
>   132         if (dma_is_default_iommu(dev))    
>   133                 return false;

I'd go for:

		if (use_dma_iommu(dev))
			return false;
		if (likely(!ops))
			return true;
		...

