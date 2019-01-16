From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/3] virtio-blk: Consider dma_max_mapping_size() for
 maximum segment size
Date: Wed, 16 Jan 2019 15:10:43 +0100
Message-ID: <20190116141043.qbsdbdt72akxpdtj@suse.de>
References: <20190115132257.6426-1-joro@8bytes.org>
 <20190115132257.6426-4-joro@8bytes.org>
 <20190116090355-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116090355-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 16, 2019 at 09:05:40AM -0500, Michael S. Tsirkin wrote:
> On Tue, Jan 15, 2019 at 02:22:57PM +0100, Joerg Roedel wrote:
> > +	max_size = dma_max_mapping_size(&vdev->dev);
> > +
> 
> 
> Should this be limited to ACCESS_PLATFORM?
> 
> I see no reason to limit this without as guest can
> access any memory.

Actually, yes. This should be inside a use_dma_api check. I had it in
v1, but it went away without the vring layer for propagating the limit.
I'll add that again.

Thanks,

	Joerg
