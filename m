From: Christoph Hellwig <hch@lst.de>
Subject: Re: remove dma_zalloc_coherent
Date: Fri, 11 Jan 2019 19:16:30 +0100
Message-ID: <20190111181630.GA21720@lst.de>
References: <20190108130701.14161-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108130701.14161-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Luis Chamberlain <mcgrof@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Linus,

any chance you could take this before -rc2?  That should avoid a lot
of churn going forward.  Any fine tuning of the memset-removal
cochinnelle scripts can be queued up with normal updates.

On Tue, Jan 08, 2019 at 08:06:58AM -0500, Christoph Hellwig wrote:
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
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
