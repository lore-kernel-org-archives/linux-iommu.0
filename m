From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/10] swiotlb: do not panic on mapping failures
Date: Fri, 19 Oct 2018 08:04:25 +0200
Message-ID: <20181019060425.GA28108@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-4-hch@lst.de> <20181019001714.GD1251@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181019001714.GD1251@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 18, 2018 at 08:17:14PM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Oct 08, 2018 at 10:02:39AM +0200, Christoph Hellwig wrote:
> > All properly written drivers now have error handling in the
> > dma_map_single / dma_map_page callers.  As swiotlb_tbl_map_single already
> > prints a useful warning when running out of swiotlb pool swace we can
> 
> s/swace/space/
> 
> > also remove swiotlb_full entirely as it serves no purpose now.
> 
> The panic albeit was useful for those drivers that didn't handle it.
> 
> Thoughts? I am kind of thinking screw them but then I am not too thrilled
> about silent data corruption errors.

I can add an (optional) panic back in common code so that the different
mapping types are covered.

Btw, are you fine with taking this through the dma mapping tree for
this merge window?  I'd probably leave it in linux-next for another
week or so and don't send it with the first pull request on Monday.
