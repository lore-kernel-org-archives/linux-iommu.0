Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF742FFDD6
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077573; cv=none; b=KJFAURM/Qn+LQxCnjJaPc41sLULqaC4WjBOdD9kR2T3YS4bL1JZn9gB/lV+8V++WMGD4UwxbM8JWuP/fRZwK5rlzUNLdUq6aOHpNK1m2ko1tGvPvJsB1Y3TvJ2RYo3DLvo+1gHv5/lejKSYi8hZ6a7REAtWmZeFxymHIDkxoPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077573; c=relaxed/simple;
	bh=e1EPzldw91Ho5uT5Mgj2iuuebqOQUeSD880I5lTXzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTCgXVclvKxOr+J4fYOIvjsa39BxhOebhVOFxuaCgAoliuAw78d3bxcGTwARhhKSk4kyuz9yrFi6x5v8NvVE3kYWiSExDUXGbnZQpGTnFck+vdwuwik4LLRx7MW4Zccw7qjLFjdG5Gus+FLgQyOlSVFAStUus97movCct+MgO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+mW1Jni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+mW1Jni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E3BC116C6;
	Thu, 22 Jan 2026 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769077573;
	bh=e1EPzldw91Ho5uT5Mgj2iuuebqOQUeSD880I5lTXzvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+mW1JniIE3obYKPFV2lu9DGPBMqbDYh574WY4zKvlkpcCFTfg5mYVjYVd0IbDGi/
	 Z40H3mcwGS3HgBxGJdtJEuuxYBz78VtR4ReNLI6kNN1vbaMS43FmJUMKJgbHZowVlm
	 ytux24fGmcHVhEWCeJNPqT/v8cJ52n9VwOVze8LoMDW8/bPKZhSc5/7EeIytrmvEH9
	 K1hDtC0urC1ie6PIytkykcFQ5wUkhmYmRP4/d0PiEYTm5o6dVBDAT48CwbawV/if09
	 wuhJdm+HjjsaEf0ydbQE/7cYqgVYZYl7LQqmFtPCw4nfK8AAAQFfLRUwR+qUTM9VuO
	 MH4rNoSe4qAsQ==
Date: Thu, 22 Jan 2026 12:26:07 +0200
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
Message-ID: <20260122102607.GK13201@unreal>
References: <20260121130233.257428-1-francois.dugast@intel.com>
 <20260121131135.GF1134360@nvidia.com>
 <20260121180449.GA1490142@nvidia.com>
 <aXHAcibp/4pUB8f0@lstrano-desk.jf.intel.com>
 <20260122072913.GJ13201@unreal>
 <aXHTjz6SP5w/PTPa@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXHTjz6SP5w/PTPa@lstrano-desk.jf.intel.com>

On Wed, Jan 21, 2026 at 11:36:47PM -0800, Matthew Brost wrote:
> On Thu, Jan 22, 2026 at 09:29:13AM +0200, Leon Romanovsky wrote:
> > On Wed, Jan 21, 2026 at 10:15:14PM -0800, Matthew Brost wrote:
> > > On Wed, Jan 21, 2026 at 02:04:49PM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Jan 21, 2026 at 09:11:35AM -0400, Jason Gunthorpe wrote:
> > > > > On Wed, Jan 21, 2026 at 02:02:16PM +0100, Francois Dugast wrote:
> > > > > > I am reporting a slowdown in Xe caused by a couple of IOMMU changes. It
> > > > > > can be observed during DMA mappings/unmappings required to issue copies
> > > > > > between system memory and the device, when handling GPU faults. Not sure
> > > > > > how other use cases or vendors are affected but below is the impact on
> > > > > > execution times for BMG:
> > > > > > 
> > > > > > Before changes:
> > > > > >   4KB
> > > > > >     drm_pagemap_migrate_map_pages: 0.4 us
> > > > > >     drm_pagemap_migrate_unmap_pages: 0.4 us
> > > > > >   64KB
> > > > > >     drm_pagemap_migrate_map_pages: 2.5 us
> > > > > >     drm_pagemap_migrate_unmap_pages: 3.5 us
> > > > > >   2MB
> > > > > >     drm_pagemap_migrate_map_pages: 88 us
> > > > > >     drm_pagemap_migrate_unmap_pages: 108 us
> > > > > > 
> > > > > > After changes:
> > > > > >   4KB
> > > > > >     drm_pagemap_migrate_map_pages: 0.7 us
> > > > > >     drm_pagemap_migrate_unmap_pages: 0.7 us
> > > > > >   64KB
> > > > > >     drm_pagemap_migrate_map_pages: 3.5 us
> > > > > >     drm_pagemap_migrate_unmap_pages: 10.5 us
> > > > > >   2MB
> > > > > >     drm_pagemap_migrate_map_pages: 102 us
> > > > > >     drm_pagemap_migrate_unmap_pages: 330 us
> > > > > 
> > > > > I posted some more optimizations for these cases, it should reduce the
> > > > > numbers.
> > > > > 
> > > 
> > > We can try those — link? I believe I know the series, but just to make
> > > sure we’re on the same page.
> > > 
> > > > > This is the opposite of the benchmark numbers I ran which showed
> > > > > significant gains as the page count and sizes increased.
> > > > > 
> > > > > But something weird is going on to see a 3x increase in unmap, that
> > > > > shouldn't be just algorithm overhead. That almost seems like
> > > > > additional IOTLB invalidation overhead or something else going wrong.
> > > > > 
> > > > > Is this from a system with the VT-d cache flushing requirement? That
> > > > > logic changed around too and could have this kind of big impact.
> > > > 
> > > > Oh looking at the code a bit you've got pretty much the slowest
> > > > possible thing you can do here:
> > > 
> > > This was a fairly common pattern prior to Leon’s series, I believe. The
> > > cross-references show this pattern appearing frequently in the kernel
> > > [1]. I do agree with the point below that, with Leon’s changes applied,
> > > this could be refactored into an IOVA alloc/link/unlink/free flow, which
> > > would work better (also 2M device pages reduces the common 2M case to a
> > > mute point).
> > > 
> > > But that’s not what we’re discussing here. We’re talking about a
> > > regression introduced in the dma-mapping API for x86, which in my view
> > > is unacceptable for a kernel release. So IMO we should revert those
> > > changes [2].
> > > 
> > > [1] https://elixir.bootlin.com/linux/v6.18.6/A/ident/dma_unmap_page
> > 
> > I think this comparison is unfair. The previous behavior was bad for
> > everyone, while the current issue affects only the specific
> > drm_pagemap_migrate_unmap_pages() flow. Cases where the performance of
> > dma_unmap_page() in non-direct mode matters are extremely rare.
> > 
> 
> I don’t think you can reason about this without extensive testing across
> multiple platforms. Nor is it fair to say - sorry we slowed down your
> existing code, good luck.

It is not what I said. I only pointed to the specific point that loop
over dma_unmap_page() is universally performance critical.

Thanks
