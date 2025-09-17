Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60E3016E5;
	Wed, 17 Sep 2025 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134792; cv=none; b=Z0cTs2FjQxMPuzZqYn6AbFd6KWl7AAiZPRfxx0e1MwPzcyuQRUFtDHJ0HgpzGXg5NIt3E2bk8YyiK2PxvJVjAvWyEiwd28Bs8uTsmsXImX9yMVTpj70On7nhEGz9EDvkQuewgDZkcZTT89YE9kTeh4InkAfenqKJVYNxEqJOQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134792; c=relaxed/simple;
	bh=XfxdX33JVvC2rTvQ5qzTsTE9zaKknGx6DU8yDTlw1vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8CZgPt5IG4aQv+8E4/V4PSpuh9DU6mB+qBtLNk4pZ9Oav74UAL4QT04ii0UHDWBfkwbAQP29uqNtrpEs2JSLYcjo3dDb1iqSlbKLiFJpb09M5Bhz5yDcbDxTPMAphog/iKkJ0/pnC7mlvzNmg0AVOwrxc16oPhs8Hh7Ci1tlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNjT3Y6D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNjT3Y6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B8C4CEF9;
	Wed, 17 Sep 2025 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758134791;
	bh=XfxdX33JVvC2rTvQ5qzTsTE9zaKknGx6DU8yDTlw1vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNjT3Y6D3/qxn1gVIjdWu1wmKpUJ75cLnWQZW5KkyFeUa2RuoBmflnQLROj5ScRUi
	 0shpzP/bFN2lGdssCIYyhCQoiCTJr7oOxsSIaXEpUVwyFxKZaBgmvxCpIchv2qGKSC
	 cKVAcQwYDSpLkadCHIDiGwRMr5q89qXgqFcju2yEmBuhvJyTO1ny6P22G+jZPFNQXn
	 THWeEnnpNNn2+r0grhXtdz2fQf5epUzyaJcjvAyMstlC+87EE6XRDjMt0nhSC8F6pS
	 oN4yUEJ3lET5bFqQ68P7buDUqyS3FvqQtjUNZQcP9ZXvoCSBTAzpI+AFay/cxTmLn9
	 U8gbaYNT1eO5g==
Date: Wed, 17 Sep 2025 21:46:25 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250917184625.GA10800@unreal>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
 <20250916184617.GW1086830@nvidia.com>
 <20250917103644.GB6464@unreal>
 <20250917113248.GA1086830@nvidia.com>
 <20250917134128.GC6464@unreal>
 <20250917135819.GA1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917135819.GA1391379@nvidia.com>

On Wed, Sep 17, 2025 at 10:58:19AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 04:41:28PM +0300, Leon Romanovsky wrote:
> > On Wed, Sep 17, 2025 at 08:32:48AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 17, 2025 at 01:36:44PM +0300, Leon Romanovsky wrote:
> > > > On Tue, Sep 16, 2025 at 03:46:17PM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Sep 16, 2025 at 10:32:06AM +0300, Leon Romanovsky wrote:
> > > > > > +	if (!dev->dma_coherent &&
> > > > > > +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> > > > > > +		__dma_page_cpu_to_dev(phys_to_page(phys), offset, size, dir);
> > > > > 
> > > > > I'd keep going and get rid of the page here too, maybe as a second
> > > > > patch in this series:
> > > > 
> > > > Thanks, it is always unclear how far to go with cleanups.
> > > 
> > > IMHO to maximally support what Matthew is working on I'd remove all
> > > the struct page things and prefer the pfn/phys variations from the MM
> > > side.
> > 
> > ok, my patches can be found here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dmabuf-vfio
> > 
> > I converted "struct page" path from all archs with .map_page.
> 
> Yeah, that's right, I would split this into a few series
> 
> This group is all fairly trivial stuff that didn't use the struct
> page or virt address at all:
> 
>  MIPS/jazzdma
>  x86
>  vdpa
>  xen: swiotlb:  (though make a phys_to_xen_pfn() macro)
> 
> I'd also drop the ATTR_MMIO checks from x86 and jazzdma
> since the code is obviously fine with any phys.

It is not trivial as it sounds.

Let's take as an example MIPS/jazzdma, should we call to vdma_alloc()
in DMA_ATTR_MMIO case? or directly return "phys" as it is done in other
architectures?

> 
> vdpa can support ATTR_MMIO with the same iommu prot MMIO adjustment,
> that would be a good additional patch.

There is "bounce page" in VDPA, it sounds like swiotlb to me, which
doesn't work with MMIO.

> 
> Then there are more conversions that don't use struct page or va but
> are not so trivial
> 
> alpha
> parisc
> 
> Then the last ones sparc/power are quite complicated and do use
> __va/etc.
> 
> Jason
> 
