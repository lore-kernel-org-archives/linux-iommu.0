Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31D2EBDFE
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763937; cv=none; b=hLzC6Yuf7K/ciUR64MeavikH4dSIL1e7G+Dkwe568OHFPdyydw07xHePw+CZcunB6hAQRDrqBtRvayPRw4XEKOdLZU1cPw7fbBxKaUt4ABIY7CLbW9DQLMwo2FUJQpVLCnWZEO1p4vbJdogsT8ZuaNjlcGlix1gMUZSgoiIZovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763937; c=relaxed/simple;
	bh=Vq8uMF8YMJwWYSPgh5fezl1rhACOH0zQjjkAVNB2Fn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMfkVKRG3jRk1vbrOYaEIiRzykpPJMB9kv9oeCdLN+GAumJo/VbxIQCBWVQaeOPZW161PbdkWH4zC20gn6BfTjzPVf6S+rmQhOdaGXcfE5QXLZjcryXpyerhFudlOW+l2Ymw3sHpzK05eMTICGfi1FY/EdMz7/b8gVebzQKJkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRIh0Y58; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRIh0Y58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105A2C4CEE3;
	Thu, 17 Jul 2025 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763937;
	bh=Vq8uMF8YMJwWYSPgh5fezl1rhACOH0zQjjkAVNB2Fn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRIh0Y58AciH6PT8gYJjsGzyYtin0WBoudgiXts2CNGdb2knO6NyeBamSAkXLui6w
	 1Qto0MJ2dIOJZPZxPU1JGSm7Y5ztWoGbE3GvO7BpJGXFCaJsjXJdpKioSRwXVBqWbs
	 S1vgLR/uzEf4zxmN2Q9CzGFexc6Iz3miDiVFGGw/CwXIpMZUbiC1BYeH1MFmv3hu1Q
	 SEoAtLcHkHTn5UWLQVK4a0w+8KjjuP+xH4TENd0i+a60BajgPhiVgvu5yjguMQa/Cu
	 07cjJn/eQ63PtXuWBCTyln+Fz8RcNGc0B+zOoC3FcnI+0lPuxrLEgyjey/hUH07BAQ
	 pOreyBfh2QjaQ==
Date: Thu, 17 Jul 2025 17:52:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] dma-mapping: prepare dma_map_ops to conversion to
 physical address
Message-ID: <20250717145213.GB402218@unreal>
References: <cover.1752734252.git.leon@kernel.org>
 <1798a3351dcabccaf0749221e9e9b66585a7b2c6.1752734252.git.leon@kernel.org>
 <20250717134435.GA2206214@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717134435.GA2206214@ziepe.ca>

On Thu, Jul 17, 2025 at 10:44:35AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 17, 2025 at 09:47:09AM +0300, Leon Romanovsky wrote:
> 
> > @@ -183,7 +187,11 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
> >  		 * All platforms which implement .map_page() don't support
> >  		 * non-struct page backed addresses.
> >  		 */
> > -		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> > +		if (ops->map_phys)
> > +			addr = ops->map_phys(dev, phys, size, dir, attrs);
> > +		if (ops->map_page)
> > +			addr = ops->map_page(dev, page, offset, size, dir,
> > +					     attrs);
> 
> I would expect 'else if'

I don't expect both of them to exist. There is WARN_ON_ONCE() to catch it.
If it is important, I can add else.

> 
> > @@ -213,8 +221,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
> >  		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
> >  	else if (use_dma_iommu(dev))
> >  		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
> > -	else
> > -		ops->unmap_page(dev, addr, size, dir, attrs);
> > +	else {
> > +		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
> > +			/* We shouldn't have both functions */
> > +			WARN_ON_ONCE(ops->unmap_page && ops->unmap_phys);
> > +
> > +		if (ops->unmap_phys)
> > +			ops->unmap_phys(dev, addr, size, dir, attrs);
> > +		if (ops->unmap_page)
> > +			ops->unmap_page(dev, addr, size, dir, attrs);
> 
> Here too
> 
> What is the practical difference between unmap_phys and unmap_page?

There is no difference. It is provided to provide symmetrical interface
to .map_phys, simple rename.

Thanks
