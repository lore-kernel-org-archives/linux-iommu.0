From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/vt-d: Implement dma_[un]map_resource()
Date: Mon, 21 Jan 2019 18:42:13 +0100
Message-ID: <20190121174213.GA31247@lst.de>
References: <20190119000559.12784-1-logang@deltatee.com> <20190119094002.GA21653@lst.de> <9f25790b-4418-19a4-708a-27c502f82c4f@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9f25790b-4418-19a4-708a-27c502f82c4f@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jan 19, 2019 at 11:46:22AM -0700, Logan Gunthorpe wrote:
> > Instead of having two tiny wrappers I'd just revert
> > 964f2311a6862f1fbcc044d0828ad90030928b7f if we need to pass a real
> > physical address now.
> 
> Ok, I can resubmit this with that cleanup. Should I do it in two commits
> (1 revert + 1 new) or is one commit that just restores the original
> helper fine?

I think a single commit is fine.
