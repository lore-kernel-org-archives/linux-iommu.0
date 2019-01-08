From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: remove dma_zalloc_coherent
Date: Tue, 8 Jan 2019 14:55:42 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1901081453380.6130@hadrien>
References: <20190108130701.14161-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108130701.14161-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On Tue, 8 Jan 2019, Christoph Hellwig wrote:

> Hi Linus and world,
>
> We've always had a weird situation around dma_zalloc_coherent.  To
> safely support mapping the allocations to userspace major architectures
> like x86 and arm have always zeroed allocations from dma_alloc_coherent,
> but a couple other architectures were missing that zeroing either always
> or in corner cases.  Then later we grew anothe dma_zalloc_coherent
> interface to explicitly request zeroing, but that just added __GFP_ZERO
> to the allocation flags, which for some allocators that didn't end
> up using the page allocator ended up being a no-op and still not
> zeroing the allocations.
>
> So for this merge window I fixed up all remaining architectures to zero
> the memory in dma_alloc_coherent, and made dma_zalloc_coherent a no-op
> wrapper around dma_alloc_coherent, which fixes all of the above issues.
>
> dma_zalloc_coherent is now pointless and can go away, and Luis helped
> me writing a cocchinelle script and patch series to kill it, which I
> think we should apply now just after -rc1 to finally settle these
> issue.
>
> The script that generated the first patch is included here:
>
> @ replace_dma_zalloc_coherent @
> expression dev, size, data, handle, flags;
> @@
>
> -dma_zalloc_coherent(dev, size, handle, flags)
> +dma_alloc_coherent(dev, size, handle, flags)

Great.  We should also update api/alloc/zalloc-simple.cocci.  The message
could just say that the z version is no longer needed.

julia
