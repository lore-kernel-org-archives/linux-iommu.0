From: Christoph Hellwig <hch@lst.de>
Subject: remove dma_zalloc_coherent
Date: Tue,  8 Jan 2019 08:06:58 -0500
Message-ID: <20190108130701.14161-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Linus and world,

We've always had a weird situation around dma_zalloc_coherent.  To
safely support mapping the allocations to userspace major architectures
like x86 and arm have always zeroed allocations from dma_alloc_coherent,
but a couple other architectures were missing that zeroing either always
or in corner cases.  Then later we grew anothe dma_zalloc_coherent
interface to explicitly request zeroing, but that just added __GFP_ZERO
to the allocation flags, which for some allocators that didn't end
up using the page allocator ended up being a no-op and still not
zeroing the allocations.

So for this merge window I fixed up all remaining architectures to zero
the memory in dma_alloc_coherent, and made dma_zalloc_coherent a no-op
wrapper around dma_alloc_coherent, which fixes all of the above issues.

dma_zalloc_coherent is now pointless and can go away, and Luis helped
me writing a cocchinelle script and patch series to kill it, which I
think we should apply now just after -rc1 to finally settle these
issue.

The script that generated the first patch is included here:

@ replace_dma_zalloc_coherent @
expression dev, size, data, handle, flags;
@@

-dma_zalloc_coherent(dev, size, handle, flags)
+dma_alloc_coherent(dev, size, handle, flags)
