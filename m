Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F45361672
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066958; cv=none; b=GBcCqaBjWhjQiagFvGYeNVcH1dhbC8bHu5FvDcTrVpSmI7ygkA4AoJjx+2OZd5uVu2ayiGLqHs1q0to4MwjGsxHKGiWSsbzgplDq4SrphJulgYgQuVXOLcTGiTddd07OJQJSbpdciEoCTkm8PWNxsky614sW2702nl3WHM6z5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066958; c=relaxed/simple;
	bh=+7WrisxzJPTb+jIANYEWDvxID/6Zp20bW93uIFrDtxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7BKRi8SRgFcgAA8JAae9MiDaVWwwH17wgrbEHkAbyuHhIwIMqsvS4wcOO28ohmjBBi8brTaG256gHf1i4w7HXMUPZdnnq1aWVifbkGNeqcOUYwhnmpx8+2fwHt6GQv0ZH0NaOHgUiSznmCg5nculyhNReksEBNJ31/piN7wPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyKQ4tuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyKQ4tuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B15C116C6;
	Thu, 22 Jan 2026 07:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769066958;
	bh=+7WrisxzJPTb+jIANYEWDvxID/6Zp20bW93uIFrDtxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyKQ4tuVhNqRf/3lToAQ+xyeiHn0pe9vXWTZas5uCPU+cdsEkLunGuXpQXK/4HwFi
	 0lg0+UOwDq9vQv3P3RvVlowCiWt97xDono4wYwfD1Ad+rC+aqjIn6tB92RhWYBNr1H
	 Kx9cLahiKPczljn9lcl+ykbuJuhchczv6853S7wiyuQJuxSSBgMgIs3FO/m80BGEKe
	 Ymg2LH6poZXTHgbNAGafboiUGM6i6EawBZG52l4mQsh8F61iOrXV+asOPJFuDzFgsW
	 IJ8NJQWU/gqnaCfhUqRw/kcQEgykYTu+GRGadcPimOtmQDSnQlnes2vAQV6Ew9FEbd
	 fhNlNP471ahOA==
Date: Thu, 22 Jan 2026 09:29:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>, iommu@lists.linux.dev,
	intel-xe@lists.freedesktop.org, Joerg Roedel <joerg.roedel@amd.com>,
	Calvin Owens <calvin@wbinvd.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: Xe performance regression with recent IOMMU changes
Message-ID: <20260122072913.GJ13201@unreal>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
 <20260121180449.GA1490142@nvidia.com>
 <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>

On Wed, Jan 21, 2026 at 10:15:14PM -0800, Matthew Brost wrote:
> On Wed, Jan 21, 2026 at 02:04:49PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 21, 2026 at 09:11:35AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Jan 21, 2026 at 02:02:16PM +0100, Francois Dugast wrote:
> > > > I am reporting a slowdown in Xe caused by a couple of IOMMU changes. It
> > > > can be observed during DMA mappings/unmappings required to issue copies
> > > > between system memory and the device, when handling GPU faults. Not sure
> > > > how other use cases or vendors are affected but below is the impact on
> > > > execution times for BMG:
> > > > 
> > > > Before changes:
> > > >   4KB
> > > >     drm_pagemap_migrate_map_pages: 0.4 us
> > > >     drm_pagemap_migrate_unmap_pages: 0.4 us
> > > >   64KB
> > > >     drm_pagemap_migrate_map_pages: 2.5 us
> > > >     drm_pagemap_migrate_unmap_pages: 3.5 us
> > > >   2MB
> > > >     drm_pagemap_migrate_map_pages: 88 us
> > > >     drm_pagemap_migrate_unmap_pages: 108 us
> > > > 
> > > > After changes:
> > > >   4KB
> > > >     drm_pagemap_migrate_map_pages: 0.7 us
> > > >     drm_pagemap_migrate_unmap_pages: 0.7 us
> > > >   64KB
> > > >     drm_pagemap_migrate_map_pages: 3.5 us
> > > >     drm_pagemap_migrate_unmap_pages: 10.5 us
> > > >   2MB
> > > >     drm_pagemap_migrate_map_pages: 102 us
> > > >     drm_pagemap_migrate_unmap_pages: 330 us
> > > 
> > > I posted some more optimizations for these cases, it should reduce the
> > > numbers.
> > > 
> 
> We can try those — link? I believe I know the series, but just to make
> sure we’re on the same page.
> 
> > > This is the opposite of the benchmark numbers I ran which showed
> > > significant gains as the page count and sizes increased.
> > > 
> > > But something weird is going on to see a 3x increase in unmap, that
> > > shouldn't be just algorithm overhead. That almost seems like
> > > additional IOTLB invalidation overhead or something else going wrong.
> > > 
> > > Is this from a system with the VT-d cache flushing requirement? That
> > > logic changed around too and could have this kind of big impact.
> > 
> > Oh looking at the code a bit you've got pretty much the slowest
> > possible thing you can do here:
> 
> This was a fairly common pattern prior to Leon’s series, I believe. The
> cross-references show this pattern appearing frequently in the kernel
> [1]. I do agree with the point below that, with Leon’s changes applied,
> this could be refactored into an IOVA alloc/link/unlink/free flow, which
> would work better (also 2M device pages reduces the common 2M case to a
> mute point).
> 
> But that’s not what we’re discussing here. We’re talking about a
> regression introduced in the dma-mapping API for x86, which in my view
> is unacceptable for a kernel release. So IMO we should revert those
> changes [2].
> 
> [1] https://elixir.bootlin.com/linux/v6.18.6/A/ident/dma_unmap_page

I think this comparison is unfair. The previous behavior was bad for
everyone, while the current issue affects only the specific
drm_pagemap_migrate_unmap_pages() flow. Cases where the performance of
dma_unmap_page() in non-direct mode matters are extremely rare.

It should be relatively straightforward to add a link/unlink path to the
drm_pagemap_*() helpers and achieve decent performance.

Thanks

> [2]
> e6fbd544619c50b4a4d96ccb4676cac03cb iommupt/vtd: Support mgaw's less than a 4 level walk for first stage
> d856f9d27885c499d96ab7fe506083346ccf145d iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires
> 6cbc09b7719ec7fd9f650f18b3828b7f60c17881 iommu/vt-d: Restore previous domain::aperture_end calculation
> a97fbc3ee3e2a536fafaff04f21f45472db71769 syscore: Pass context data to callbacks
> 101a2854110fa8787226dae1202892071ff2c369 iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry
> d373449d8e97891434db0c64afca79d903c1194e iommu/vt-d: Use the generic iommu page table
> 
> > 
> > 	for (i = 0; i < npages;) {
> > 		if (!pagemap_addr[i].addr || dma_mapping_error(dev, pagemap_addr[i].addr))
> > 			goto next;
> > 
> > 		dma_unmap_page(dev, pagemap_addr[i].addr, PAGE_SIZE << pagemap_addr[i].order, dir);
> > 
> > It is weird though:
> > 
> > 0.7 us * 512 = 358us so it is about the reported speed.
> > 
> > But the old one is 0.4 us * 512 = 204 us which is twice as
> > slow as reported?? It got 2x faster the more times you loop it? Huh?
> > 
> > The real way to fix this up is to use the new DMA API so this can be
> > collapsed into a single unmap. Then it will take < 1us for all those cases.
> > 
> > Look at the patches Leon made for the RDMA ODP stuff, it has a similar
> > looking workflow.
> > 
> 
> See above. I agree this is the right direction, but we can’t simply
> regress kernels from existing performance.
> 
> > The optimizations I posted will help this noticably.
> > 
> 
> I think we need to start with a revert and then discuss whether your
> subsequent changes actually fix the problem.
> 
> Matt
> 
> > Jason
> 
