Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95F17BBE;
	Fri, 12 Jul 2024 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720764180; cv=none; b=pIt2N80oLNIBaQ5sQq5e3hqVFIAFwxlNYgtqguC4R5VvuAyF40nBxhL88cBkMKV17Pf/bbQg/K/PmW+7cvj5DHNdAAzjee2btpXUWlyrk8h4iO7X3Vnw9VdsdSZ9YQb0x/GagrXyRW6F9DFelG6pafLXRKMGuMix1wVgPkwH7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720764180; c=relaxed/simple;
	bh=RsAXgj9MwgndFd4GQNPnkS4lbDaoNLWMLSj6/Z2CJmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llBdApXejjBw/HWQ2RyH5S1qq/oCvcP8PXqit8pFY9xQnagf6p3GlRePNyCsJ89YEUruFcOKgSzgYIm4JXla5qsmTZYmYiqcQvsjW1XGCDdbqw3xnvoI7Jzc9AmoD7f6RB91EjlYeG8fYHfAsnIcHeBGQHZouz5c7eet725zhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWqZaVMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWqZaVMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BFAC3277B;
	Fri, 12 Jul 2024 06:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720764179;
	bh=RsAXgj9MwgndFd4GQNPnkS4lbDaoNLWMLSj6/Z2CJmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWqZaVMyyZT0ByT2wHTfH3Yak5jgh8ecS4eOJ3cBOPs4+8jIlIQX3CEwsYPQGWxYD
	 4eBhH0RF4PpG0/6+nPEghQSzGZzBYQMWtAjGmU9wmiiUQ3GO9lIy5pJsjf0+bkP7jA
	 vF7GcKeDJUohzO3J0bCEl+Y7drbx07vOoUeUrQofboe/BEmygFNAlJaJW8epSv6yuE
	 jm1WfefO7VIrECJQjkxGjKYdnjAD495HyJ1nugAY6mXYTIOeHa40TglS9Z/OSCiWfB
	 BTXg9OqNN5Z59l4yEuSwMWaVO8NNAPsn2947UaSvUmLc+31BQ05NmuxBLfKXIaYHmw
	 A+tpZQQZYMAdw==
Date: Fri, 12 Jul 2024 09:02:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
Message-ID: <20240712060255.GF1815706@unreal>
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
 <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
 <20240712044937.GA4709@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712044937.GA4709@lst.de>

On Fri, Jul 12, 2024 at 06:49:37AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 11, 2024 at 07:23:20PM +0100, Robin Murphy wrote:
> > If so, I'd much rather see this done properly, i.e. hook everything up 
> > similarly to dma-direct and be able to drop CONFIG_DMA_OPS for "modern" 
> > dma-direct/iommu-dma architectures entirely.
> 
> Yes.  That is much better than doing hacks based on missing ops.

There is nothing wrong to do conversion to iommu direct in the steps.
The first step is to add the dma-iommu calls with if (!..) checks,
so everyone will get better performance right now. The second step
is to remove the if (!..) checks together with dummy ops.

Thanks

> 
> Note that the media subsystems just added another abuse of dma_map_ops
> in drivers/ in addition to the existing vdpa one that we'll need to
> kill again to fully get rid of dma_map_ops for common setups (in
> addition to merging swiotlb-xen into main swiotlb finally).
> 
