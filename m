From: Christoph Hellwig <hch@lst.de>
Subject: Re: fix up nowarn confusion in the dma mapping layer
Date: Mon, 8 Oct 2018 09:03:58 +0200
Message-ID: <20181008070358.GA3182@lst.de>
References: <20181001201257.366-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181001201257.366-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Any comments on these rather trivial patches?

On Mon, Oct 01, 2018 at 01:12:55PM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series sorts out how we deal with the nowarn flags in the dma
> mapping code.  We still support __GFP_NOWARN for the legacy APIs that
> don't support passing the dma specific flags, but we generally want
> every implementation to actually check DMA_ATTR_NO_WARN instead.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
