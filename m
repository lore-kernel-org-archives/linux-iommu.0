Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A182866
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795999; cv=none; b=QnReSod1ytCnjXs6ExxrFKCSvjMAIKg7LEnyShSx805tfUq/rni+xCvAc3tzNU/8BhhzYItiKO+q7ixWUicCuwscXrAV3IeukSO2aGxNxZemOP6gm6LU4lXPMNtRgPqf6ILCmB8Z5wQN9DFLMPTdPtqgiGdEcBLR9wB4C7lbwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795999; c=relaxed/simple;
	bh=h9ECst9GRtN753GzzVo+QAqWKw3BgWzvY/fJ/00n4eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niPuzJ31qZKpF0py0eNvcyTT6DVD0QOf+xx6MLnjM0IQ3sWzZRap0VZpLcpSdACVBQZ5EDo0fRecuWKdidHWjBf3xrPAu6vbgwJIEnEimylKJnviLdlwWRNH4YPNPds/oUKOcLRHaDf5sRUMnoMq49RICV1FlOiZeaC1UY+HRYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A87B227A87; Fri, 16 Aug 2024 10:13:12 +0200 (CEST)
Date: Fri, 16 Aug 2024 10:13:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240816081312.GA7724@lst.de>
References: <cover.1721818168.git.leon@kernel.org> <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org> <20369981-37c8-482a-9ffa-cf54d12dad2d@arm.com> <20240816071134.GA2943@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816071134.GA2943@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 16, 2024 at 09:11:34AM +0200, Christoph Hellwig wrote:
> >>   +# DMA IOMMU uses common ops helpers for certain operations, so let's 
> >> allow to build
> >> +# ops_helpers.c even if DMA_OPS is not enabled
> >
> > Hmm, but actually dma-direct also uses dma_common_contiguous_remap(), so 
> > something seems a little inconsistent here...
> 
> Yes, but that's not really new.  I'll look into a patch to select
> the helpers based on the conditions that make dma-direct use it.
> 
> I'll fix up all style issues and will apply the patch with that over
> the weekend so that we can get it into this merge window.

It turns out dma_common_contiguous_remap sits in kernel/dma/remap.c,
which is always built when CONFIG_MMU is set, so this isn't an
issue.  Maybe I need to clean up the namespaces a bit..
