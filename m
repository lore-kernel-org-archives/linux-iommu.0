From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA
        operation
Date: Tue, 31 Jul 2018 17:22:29 +0200
Message-ID: <20180731152229.GA956@lst.de>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de> <20180725032948.GG12771@codeaurora.org> <20180725043927.GA10827@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180725043927.GA10827@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 25, 2018 at 06:39:27AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 24, 2018 at 10:29:48PM -0500, Richard Kuo wrote:
> > Patch series looks good.  Definitely appreciate the cleanup.
> > 
> > I can take it through my tree, or if not:
> > 
> > Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 
> Please take it through your tree, thanks!

I haven't seen it in linux-next yet, do you still plan to take it?

Otherwise I'll merge it in the dma-mapping tree.
