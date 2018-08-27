From: Christoph Hellwig <hch@lst.de>
Subject: Re: swiotlb cleanup (resend)
Date: Mon, 27 Aug 2018 20:33:08 +0200
Message-ID: <20180827183308.GA496@lst.de>
References: <20180725113802.18943-1-hch@lst.de> <20180827181309.GA3834@0021ccb48c25>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827181309.GA3834@0021ccb48c25>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: Christoph Hellwig <hch@lst.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 27, 2018 at 02:13:11PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 25, 2018 at 01:37:56PM +0200, Christoph Hellwig wrote:
> > Hi Konrad,
> > 
> > below are a few swiotlb patches.  Mostly just cleanups, but the removal
> > of the panic option is an actual change in (rarely used) functionality.
> > 
> > I'd be happy to pick them up through the dma-mapping tree if you are
> > fine with that.
> 
> Hey,
> 
> I put them in my 'devel/for-linus-4.19' as I would like to make
> sure that they work just fine with Xen-SWIOTLB and some baremetal
> machines.

I actually have a new version of these combined with merging
arm64 support into the main swiotlb ops.  Please hold off a bit for
now.
