From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
 maximum segment size
Date: Wed, 23 Jan 2019 17:25:00 -0500
Message-ID: <20190123170850-mutt-send-email-mst@kernel.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-6-joro@8bytes.org>
 <20190123213139.GD9032@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123213139.GD9032@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de, pbonzini@redhat.com, jsnow@redhat.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 23, 2019 at 10:31:39PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 23, 2019 at 05:30:49PM +0100, Joerg Roedel wrote:
> > +	max_size = virtio_max_dma_size(vdev);
> > +
> >  	/* Host can optionally specify maximum segment size and number of
> >  	 * segments. */
> >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
> >  				   struct virtio_blk_config, size_max, &v);
> >  	if (!err)
> > -		blk_queue_max_segment_size(q, v);
> > -	else
> > -		blk_queue_max_segment_size(q, -1U);
> > +		max_size = min(max_size, v);
> > +
> > +	blk_queue_max_segment_size(q, max_size);
> 
> I wonder if we should just move the dma max segment size check
> into blk_queue_max_segment_size so that all block drivers benefit
> from it.  Even if not I think at least the SCSI midlayer should
> be updated to support it.
> 
> Btw, I wonder why virtio-scsi sticks to the default segment size,
> unlike virtio-blk.

Well no one bothered exposing that through that device.
Why does virtio block have it? Hard for me to say. First driver version
had it already but QEMU does not seem to use it and it seems that it
never did.


-- 
MST
