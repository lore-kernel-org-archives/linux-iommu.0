Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAB4FDA54;
	Tue, 13 Oct 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903952; cv=none; b=aF/oYBw8FvqmZqfHFyvCCwZ6jCMuGKdK1NXD/QqAiGHxAezRof1IRt00FHgyxYfMVHGCpjVMkBFMpmmWi+F+Vr59QCrgBtQ5USaH6raLCFoNFEYbRsahZqZolhDLW/GfjQvuWUVv972og4kFzv4b562h40lrCzCyynXX2YmXBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903952; c=relaxed/simple;
	bh=TsSXJ6AcimMDA3wKcYdq5H2Lyd8izdg27uZhrWgs+EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1nltrg6xmjQeBVXzi91PkAtA2phcCJ0tqRlDFI5N/SbYmkvlN6EZNx4vajd14aczb50OzPCHpxfOm1hO+4tZSvMTuGUIWjSwgcvlKSx++EolKAySdxoymX1XHi4MFzVXN2emHBPiUOj/ZUiiaD17RPrJKxi1T0C+qXsgp+Xsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk3myzYG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk3myzYG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A321F00893;
	Tue, 13 Oct 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903950;
	bh=QpABNF00LStKgcWLsuqZ/vwNxiSOO1LVEOoRVaJszDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jk3myzYGWOMbObJWnAQLff6frjIlQeAkZ6AgVOrWLLPK6MZe02tC/abuepKkMuDCI
	 NkzbKt/blJywPjeuFtCbkPyAEkuTeP8Kwm6HLzb1re8MHdAOliAAsEWxc/sgfyyAiB
	 4QPFb55bWwDDZ89X2DfBXK7YyrqonPlrWoujeGrauZHHHuUI6XiyaN2gcjXsP5bIVR
	 LQ3VT2xllKzCsnPEvlTSN7oOKeADdscc6FPbQ7OciMiiVZX0Morbn+yBYhvPLeWKQb
	 JesK2pGqkTgCufzhyUCF4hahdtFjCtJjKUhFwPoCrwwnZeCma98BUHRwtJAm4+8rvn
	 3X0TN6jpQoxkg==
Date: Tue, 13 Oct 2026 18:05:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: Skip cacheline tracking for MMIO mappings
Message-ID: <20261013150546.GR219304@unreal>
References: <20261013-dma-debug-fixes-v1-1-1ad1f471cc61@nvidia.com>
 <e7b6e74a-4ec9-4146-a6b0-9183a9fb7933@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b6e74a-4ec9-4146-a6b0-9183a9fb7933@arm.com>

On Tue, Oct 13, 2026 at 01:43:56PM +0100, Robin Murphy wrote:
> On 13/10/2026 12:44 pm, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Mapping one MMIO dma-buf for many RDMA importers overflows dma-debug's
> > cacheline overlap counter and triggers a warning. DMA_ATTR_MMIO mappings
> > must never be CPU-cacheable, so CPU cacheline overlap tracking does not
> > apply to them.
> > 
> > Skip MMIO entries in both cacheline insertion and removal. Keep them in
> > the DMA entry hash so mapping and unmapping checks still run.
> 
> Seems fair;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> [...]
> > 
> > Fixes: 0e74b34dfc33 ("dma-debug: add support for resource mappings")
> 
> Although it would be a challenge to backport _that_ far, so more
> realistically I'd probably say:
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping
> routine")

This error was probably observed when we started exercising dma-buf in
various corner cases.

Thanks

> 
> since regular dma_map_resource() users are still never going to hit this
> making their one-off mapping of a UART FIFO or whatever.
> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   kernel/dma/debug.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 026d50de340e..36c1f7cbb2ae 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -489,8 +489,10 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
> >   	/* If the device is not writing memory then we don't have any
> >   	 * concerns about the cpu consuming stale data.  This mitigates
> >   	 * legitimate usages of overlapping mappings.
> > +	 * MMIO mappings are never CPU-cacheable and do not need tracking either.
> >   	 */
> > -	if (entry->direction == DMA_TO_DEVICE)
> > +	if (entry->direction == DMA_TO_DEVICE ||
> > +	    entry->attrs & DMA_ATTR_MMIO)
> >   		return 0;
> >   	spin_lock_irqsave(&radix_lock, flags);
> > @@ -519,7 +521,8 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
> >   	unsigned long flags;
> >   	/* ...mirror the insert case */
> > -	if (entry->direction == DMA_TO_DEVICE)
> > +	if (entry->direction == DMA_TO_DEVICE ||
> > +	    entry->attrs & DMA_ATTR_MMIO)
> >   		return;
> >   	spin_lock_irqsave(&radix_lock, flags);
> > 
> > ---
> > base-commit: 39d3758108bb0ef9da484062d65288bbe9cada0e
> > change-id: 20261013-dma-debug-fixes-5aaf1bb17544
> > 
> > Best regards,
> > --
> > Leon Romanovsky <leonro@nvidia.com>
> > 
> 
> 
