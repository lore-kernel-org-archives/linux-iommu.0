Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8C515970;
	Fri, 18 Sep 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748880; cv=none; b=jORRdGQ8PgRGHN6N3w7+upHOSbWZ7nmMTy3U21ZTWrJ3rQ26KRBgBc+3DZAjkxxtPhxSWdjkJgZZjQTOu89FUba9T0Sc3FdXHKhBo98bYPALEYn0wBoRHRHzK+25h32bbbs94802mO7IGcG+h5SOb1B+R7xySyG9dulvtPk0MVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748880; c=relaxed/simple;
	bh=ENg1B8J2XgujwhJsbFW+JURLUykzaMIaRBR8Q2TvvDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrDFhKt/jhEz1VDkcmPz5kFGHApCIwWMLIkdnLddwJiLA3Auku8SgXCMYNsO5JGzElvkyEb1Y/csu15i2dG02/u0s0CAcxgg52YL3JSjjnkG7ip1kQJydahxXQHxFNYzHxnK+MGDgQXFS+R+6LFXCjlyU5O1Iff5jY8koeZ1rus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz5E76IC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz5E76IC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067F71F000FF;
	Fri, 18 Sep 2026 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748870;
	bh=RUrki9PiihwqQhD1He2HPnPY/iXNXQ626jiFsHj9jNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oz5E76IC1AW958/OUCiLVFPK5O7IA+IxOlkLIFaPL/lstGjxdAu9qkLwneHvOXAm8
	 /xsMM1GKPycYfyUcVsfLeJ+zz/LmAi+r4ijC6UisTu8rfZKebDQTq3ndKWvKZRW6/L
	 tvVmTbPn/42oV4pvF3FAVzMs1Fl2HNBs91bqs2Pi5Ni7+OPTKLwyaUz4vgyRcODGLM
	 aa0zQzqttJ9ShuLZM7S32GyDsYhEUnp8A2mfzjxWzWxZ/QPHswu8KO9/EvikoSGcRI
	 rMVHRJFoIEsgkxWwKuM3ET9catgXFbWZ2t17QkcjeUfJHfJkB3pmrB7GA56iZdyad7
	 rSr3njC0LIivw==
Date: Fri, 18 Sep 2026 17:27:43 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH v2 00/10] dma-mapping: Add preservation of direct
 allocations
Message-ID: <aq1mf_EXzn2hUwy4@willie-the-truck>
References: <20260708234854.4044652-1-skhawaja@google.com>
 <20260826183112.GA3703145@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826183112.GA3703145@nvidia.com>

On Wed, Aug 26, 2026 at 03:31:12PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 08, 2026 at 11:48:44PM +0000, Samiullah Khawaja wrote:
> > This is an RFC v2 to discuss the preservation of DMA allocations for
> > devices that are using direct allocation mode. Note preservation here
> > means preservation of physical memory using KHO only. IOVAs and IOMMU
> > mappings are out of scope.
> > 
> > The complexity and need of this was discussed in the thread mentioned
> > below. It was proposed to allow preservation of only a subset of
> > allocations with minimum support. Offline discussion with Will Deacon
> > concluded that this series is still needed, because we still want to use
> > coherent allocations for Arm sMMUv3 ste/cds, so sending this v2.
> 
> Was this before or after concluding that ARM was OK with using
> cachable memory?

That discussion was primarily about the page-tables iirc.

I still think drivers should be able to use the coherent DMA API and not
have to use an entirely different interface depending on whether or not
they need to support KHO.

> >  include/linux/dma-direct.h        |  29 +++++
> >  include/linux/dma-map-ops.h       |  10 ++
> >  include/linux/dma-mapping.h       | 100 ++++++++++++++
> >  include/linux/kho/abi/dma_alloc.h |  32 +++++
> >  kernel/dma/Kconfig                |  12 ++
> >  kernel/dma/Makefile               |   1 +
> >  kernel/dma/coherent.c             |  11 ++
> >  kernel/dma/contiguous.c           |  27 ++++
> >  kernel/dma/direct.c               | 189 +++++++++++++++++++++++++++
> >  kernel/dma/direct_test.c          | 208 ++++++++++++++++++++++++++++++
> >  kernel/dma/mapping.c              | 132 +++++++++++++++++++
> >  kernel/dma/pool.c                 |  17 +++
> >  12 files changed, 768 insertions(+)
> 
> Because this seems like quite a big change to swallow compared to just
> using iommu pages.h

Maybe, but I think it's in the right place rather than scattered across
a bunch of drivers. A good chunk of it is also test code and empty
static inline functions.

Will
