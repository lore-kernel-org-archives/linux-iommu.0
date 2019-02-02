From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swiotlb: Return error from swiotlb_init_with_tbl()
Date: Sat, 2 Feb 2019 18:06:08 +0100
Message-ID: <20190202170608.GA2801@lst.de>
References: <20190131162424.10477-1-joro@8bytes.org> <20190201081208.GB15512@lst.de> <20190201165029.GU32526@8bytes.org> <20190201165610.GA7484@lst.de> <20190201165901.GV32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201165901.GV32526@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Christoph Hellwig <hch@lst.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Mike Rapoport <rppt@linux.vnet.ibm.com>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 01, 2019 at 05:59:01PM +0100, Joerg Roedel wrote:
> > > This sounds like a change to break quite a couple of places in the
> > > kernel. But okay, it just makes this hunk obsolete.
> > 
> > He also added either explicit panic calls or error handling (panic
> > in case of swiotlb):
> > 
> > https://patchwork.kernel.org/patch/10766115/
> 
> I see, are these patches queued somewhere? My patch needs to be based on
> his changes.

I think akpm queued them up in -mm.  At least I got some mails claiming
patches from the series have been applied.
