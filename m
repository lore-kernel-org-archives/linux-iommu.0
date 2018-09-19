From: Christoph Hellwig <hch@lst.de>
Subject: Re: dma_get_required_mask tidyups
Date: Wed, 19 Sep 2018 17:01:48 +0200
Message-ID: <20180919150148.GA29588@lst.de>
References: <20180910061332.28187-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910061332.28187-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Any comments?  I have a a few things piled up that base on this, so
some forward progress would be great.

On Mon, Sep 10, 2018 at 08:13:29AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> the dma_get_required_mask dma API implementation has always been a little
> odd, in that we by default don't wire it up struct dma_map_ops, but
> instead hard code a default implementation.  powerpc and ia64 override
> this default and either call a method or otherwise duplicate the default.
> 
> This series always enabled the method and just falls back to the previous
> default implementation when it is not available, as well as fixing up
> a few bits in the default implementations.  This already allows removing
> the ia64 override of the implementation, and will also allow to remove
> the powerpc one together with a few additional cleanups in the powerpc
> code, but those will be sent separately with other powerpc DMA API
> patches.  Last but not least the method will allow us to return a more
> sensible value for typical iommu dma_ops eventually, but that is left
> to another series as well.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
