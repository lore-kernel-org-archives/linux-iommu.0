From: "hch@lst.de" <hch@lst.de>
Subject: Re: revert dma direct internals abuse
Date: Tue, 9 Apr 2019 11:57:40 +0200
Message-ID: <20190409095740.GE6827@lst.de>
References: <20190408105525.5493-1-hch@lst.de> <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Hellstrom <thellstrom@vmware.com>
Cc: "hch@lst.de" <hch@lst.de>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Singh Rawat <drawat@vmware.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2019 at 06:47:52PM +0000, Thomas Hellstrom wrote:
> We HAVE discussed our needs, although admittedly some of my emails
> ended up unanswered.

And than you haven't followed up, and instead ignored the layering
instructions and just commited a broken patch?

> We've as you're well aware of had a discussion with the other
> subsystems doing user-space DMA-buffers wanting this functionality from
> the dma api (AMD graphics and RDMA people IIRC). that is a bool that
> tells us whether streaming dma mappings are coherent, and I described
> in detail why we couldn't use the dma_sync_* API and
> dma_alloc_coherent().

And that is not at all what you either check or claim to do in the
changelog (which btw, are two different things).

> The other option we have is to just fail miserably without messages if
> streaming DMA is not coherent, which I think the other drivers might
> do... That's all I'm trying to avoid here. I'd much prefer to have the
> dma API export this bool.

Both DMA direct and non-DMA direct streaming mappings can be either
coherent or incoherent, so your patch doesn't archive that.  The
commit log claims the following:

"drm/vmwgfx: Improve on IOMMU detection
    
 instead of relying on intel_iommu_enabled, use the fact that the
 dma_map_ops::map_page != dma_direct_map_page"

which has nothing to do with the fact that streaming mappings are
coherent.  It also is incorrect as there are direct mapping that
do not use dma_direct_map_page (e.g. on ARM, or x86 with VMD).
