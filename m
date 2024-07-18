Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0A84E11;
	Thu, 18 Jul 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309179; cv=none; b=tBMx8eXiKg8/04pr1cd5kXSbmWacizwa7m/uGjK/osq6DObj0Dc5tpTdXPYOWl2mfX6dHItCKxsqcbK372ss/u7utTliXtgjSZLed61vkHaNiEuCJTcM6v2saawWLqr2bX7vVqTxtiJlJi0ES+MgGT8bwg5nt5fT62f+7KKSN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309179; c=relaxed/simple;
	bh=WWIYlpDXQm783D9m/jAvKaCjz9DEW+KZ86P21mQMfSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX3rb2Tu1aFlxHawArsuKPwHbwOsbdVA2r/3QWvgiAp2SkqKzp8jtIarDroFU9flUAK0hQQyESN3inOgPu71slMV+u23imlSUX/kBIqYtF8DMDVTIq9FCZ7voUUBNmXlD4m4RYDWLyGw9Je5BcolaOrPDRkGOgzlJGpD5DetNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCXtRszX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCXtRszX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35156C116B1;
	Thu, 18 Jul 2024 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309179;
	bh=WWIYlpDXQm783D9m/jAvKaCjz9DEW+KZ86P21mQMfSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCXtRszXKIng7/f0BsBiszMubZHc1RcAak/lURtqS5Bp+2Cs2G4Ff5kzJNV78HR7I
	 vYGsVz2kiLJQ/6/hsNIketBqaNd/XC7vb/bkl/CkrZkykh7HDtuobSk+7aFG8RiySx
	 eCLvrJlqqTtQtTLHG/gmns71YW2oLxVkSiHhQK9WXHtKlKOR68yTxosCTpvs59Cgbv
	 W/ROTXCeqxYb0swWls0bm7HBPJKOnaNeWghhChhzMVvSxrxX3ooCLsLN5OXLexu7XZ
	 XNCL5t/mezPvNVbqXJuCny87Z7YbIf081udmNXkjs6w8FbzNvK0MlkGUPT++Ua4UhQ
	 cYb99hRxtXGlA==
Date: Thu, 18 Jul 2024 16:26:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240718132613.GA1265781@unreal>
References: <cover.1721219730.git.leon@kernel.org>
 <dd34bf3ecef252b4910d70aa21ff5273b5e8b19b.1721219730.git.leon@kernel.org>
 <20240718034854.GA31912@lst.de>
 <20240718070406.GK5630@unreal>
 <20240718123038.GA27055@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718123038.GA27055@lst.de>

On Thu, Jul 18, 2024 at 02:30:38PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 18, 2024 at 10:04:06AM +0300, Leon Romanovsky wrote:
> > Whom should I add?
> 
> Greg as the device model maintainer.

No problem, I will add him to the next version.

> 
> > > The normal style would be to move the ifdefs outside the helper
> > > function.
> > 
> > I think you are talking about the style of functions declarations in
> > header files. This function is inside c-file and it is much easier
> > to write it this way. 
> 
> But also much harder to read, which will happen much more often.

I'll change.

> 
> > > >  #ifdef CONFIG_DMA_OPS_BYPASS
> > > > +	WARN_ON_ONCE(dev->dma_ops_bypass && dma_is_default_iommu(dev));
> > > >  	if (dev->dma_ops_bypass)
> > > 
> > > Let's skip this and think about it if we ever use the bypass for
> > > something that is not powerpc with it's own dma ops.
> > 
> > I wanted to catch misconfigurations, but I can remove it. Is this what
> > you are suggesting?
> > 
> >   126 static bool dma_go_direct(struct device *dev, dma_addr_t mask, 
> >   127                 const struct dma_map_ops *ops)                
> >   128 {                                                            
> >   129         if (likely(!ops && !dma_is_default_iommu(dev)))     
> >   130                 return true;                               
> >   131                                                           
> >   132         if (dma_is_default_iommu(dev))    
> >   133                 return false;
> 
> I'd go for:
> 
> 		if (use_dma_iommu(dev))
> 			return false;
> 		if (likely(!ops))
> 			return true;
> 		...
> 

I will change.

Thanks
