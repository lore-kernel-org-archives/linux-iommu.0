From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Date: Mon, 28 Jan 2019 09:05:26 +0100
Message-ID: <20190128080526.GA3874@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org> <20190123163049.24863-6-joro@8bytes.org> <20190123213139.GD9032@lst.de> <20190124084011.GJ32526@8bytes.org> <20190124084221.GB19441@lst.de> <20190124095150.GL32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124095150.GL32526@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Christoph Hellwig <hch@lst.de>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 24, 2019 at 10:51:51AM +0100, Joerg Roedel wrote:
> On Thu, Jan 24, 2019 at 09:42:21AM +0100, Christoph Hellwig wrote:
> > Yes.  But more importantly it would fix the limit for all other block
> > drivers that set large segment sizes when running over swiotlb.
> 
> True, so it would be something like the diff below? I havn't worked on
> the block layer, so I don't know if that needs additional checks for
> ->dev or anything.

Looks sensible.  Maybe for now we'll just do the virtio-blk case
that triggered it, and we'll do something like this patch for the
next merge window.  We'll also need to apply the same magic to the
DMA boundary.
