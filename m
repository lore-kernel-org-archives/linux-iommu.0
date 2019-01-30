From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/5 v5] Fix virtio-blk issue with SWIOTLB
Date: Wed, 30 Jan 2019 13:35:13 -0500
Message-ID: <20190130183513.GB27284@char.us.oracle.com>
References: <20190130164007.26497-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130164007.26497-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de, Thomas.Lendacky@amd.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 05:40:02PM +0100, Joerg Roedel wrote:
> Hi,
> 
> here is the next version of this patch-set. Previous
> versions can be found here:
> 
> 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> 
> 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> 
> 	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro@8bytes.org/
> 
> 	V4: https://lore.kernel.org/lkml/20190129084342.26030-1-joro@8bytes.org/
> 
> The problem solved here is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb.  When the
> virtio-blk driver tries to read/write a block larger than that, the
> allocation of the dma-handle fails and an IO error is reported.
> 
> Changes to v4 are:
> 
> 	- Added Reviewed-by tags from Christoph
> 
> 	- Added missing EXPORT_SYMBOL(_GPL) lines
> 
> Please review.

I can put it in my tree and send it to Linus .. unless folks want
to do it through a different tree?


> 
> Thanks,
> 
> 	Joerg
> Joerg Roedel (5):
>   swiotlb: Introduce swiotlb_max_mapping_size()
>   swiotlb: Add is_swiotlb_active() function
>   dma: Introduce dma_max_mapping_size()
>   virtio: Introduce virtio_max_dma_size()
>   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> 
>  Documentation/DMA-API.txt    |  8 ++++++++
>  drivers/block/virtio_blk.c   | 10 ++++++----
>  drivers/virtio/virtio_ring.c | 11 +++++++++++
>  include/linux/dma-mapping.h  | 16 ++++++++++++++++
>  include/linux/swiotlb.h      | 11 +++++++++++
>  include/linux/virtio.h       |  2 ++
>  kernel/dma/direct.c          | 12 ++++++++++++
>  kernel/dma/swiotlb.c         | 14 ++++++++++++++
>  8 files changed, 80 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
> 
