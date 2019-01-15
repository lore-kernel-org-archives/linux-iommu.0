From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3 v2] Fix virtio-blk issue with SWIOTLB
Date: Tue, 15 Jan 2019 14:22:54 +0100
Message-ID: <20190115132257.6426-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the second version of my patch-set to fix a DMA
mapping size issue triggered by the virtio-blk driver.

The problem is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb.  When
the virtio-blk driver tries to read/write a block larger
than that, the allocation of the dma-handle fails and an IO
error is reported.

v1 of the patch-set can be found here:

https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/

The change to v1 is that the maximum mapping size is now
officially propagated through the DMA-API, as suggested by
Christoph Hellwig.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  swiotlb: Introduce swiotlb_max_mapping_size()
  dma: Introduce dma_max_mapping_size()
  virtio-blk: Consider dma_max_mapping_size() for maximum segment size

 drivers/block/virtio_blk.c  | 10 ++++++----
 include/linux/dma-mapping.h | 16 ++++++++++++++++
 include/linux/swiotlb.h     |  5 +++++
 kernel/dma/direct.c         | 10 ++++++++++
 kernel/dma/swiotlb.c        |  5 +++++
 5 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.17.1
