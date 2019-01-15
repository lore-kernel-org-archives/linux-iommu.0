From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/3] dma: Introduce dma_max_mapping_size()
Date: Tue, 15 Jan 2019 17:23:22 +0100
Message-ID: <20190115162322.GA4681@8bytes.org>
References: <20190115132257.6426-1-joro@8bytes.org>
 <20190115132257.6426-3-joro@8bytes.org>
 <20190115133754.GB29225@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115133754.GB29225@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 15, 2019 at 02:37:54PM +0100, Christoph Hellwig wrote:
> > +size_t dma_direct_max_mapping_size(struct device *dev)
> > +{
> > +	/*
> > +	 * Return the minimum of the direct DMA limit and the SWIOTLB limit.
> > +	 * Since direct DMA has no limit, it is fine to just return the SWIOTLB
> > +	 * limit.
> > +	 */
> > +	return swiotlb_max_mapping_size(dev);
> 
> Well, if we don't actually use the swiotlb buffers despite it being
> compiled in or even allocated we don't need the limit.

Right, I thought about that too, but didn't find a generic way to check
for all the cases. There are various checks that could be done:

	1) Check if SWIOTLB is initialized at all, if not, return
	   SIZE_MAX as the limit. This can't be checked from dma-direct
	   code right now, but could be easily implemented.

	2) Check for swiotlb=force needs to be done.

	3) Check whether the device can access all of available RAM. I
	   have no idea how to check that in an architecture independent
	   way. It also has to take memory hotplug into account as well
	   as the DMA mask of the device.

	   An easy approximation could be to omit the limit if the
	   dma-mask covers all of the physical address bits available
	   on the platform. It would require to pass the dma-mask as an
	   additional parameter like it is done in dma_supported().

Any better ideas for how to implement 3)?

Regards,

	Joerg
