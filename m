From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA
        operation
Date: Wed, 8 Aug 2018 08:19:42 +0200
Message-ID: <20180808061941.GB15443@lst.de>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de> <20180725032948.GG12771@codeaurora.org> <20180725043927.GA10827@lst.de> <20180731152229.GA956@lst.de> <20180807070136.GA32634@lst.de> <20180808001927.GA20752@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808001927.GA20752@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 07, 2018 at 07:19:27PM -0500, Richard Kuo wrote:
> I am here, and I have the patch queued up but it's waiting for approval
> before I get to push it out through my tree.
> 
> That said, I am perfectly fine with this going through a different tree
> if expedience is needed.

I just want to make sure it makes it for 4.19.  In general going through
the arch maintainer tree is preferred, I just don't want to lose it.
