From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 0/5] Fix virtio-blk issue with SWIOTLB
Date: Thu,  7 Feb 2019 12:59:12 +0100
Message-ID: <20190207115917.20535-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Michael S . Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, jon.grimm-5C7GfCeVMHo@public.gmane.org, jfehlig-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is the next version of this patch-set. Previous
versions can be found here:

	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/

	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/

	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/

	V4: https://lore.kernel.org/lkml/20190129084342.26030-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/

	V5: https://lore.kernel.org/lkml/20190130164007.26497-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/

	V6: https://lore.kernel.org/lkml/20190131163403.11363-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/

The problem solved here is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb.  When the
virtio-blk driver tries to read/write a block larger than that, the
allocation of the dma-handle fails and an IO error is reported.

Changes to v6 are:

	- Fix build errors with CONFIG_SWIOTLB=n

Please review.

Thanks,

	Joerg

Joerg Roedel (5):
  swiotlb: Introduce swiotlb_max_mapping_size()
  swiotlb: Add is_swiotlb_active() function
  dma: Introduce dma_max_mapping_size()
  virtio: Introduce virtio_max_dma_size()
  virtio-blk: Consider virtio_max_dma_size() for maximum segment size

 Documentation/DMA-API.txt    |  8 ++++++++
 drivers/block/virtio_blk.c   | 10 ++++++----
 drivers/virtio/virtio_ring.c | 11 +++++++++++
 include/linux/dma-mapping.h  |  8 ++++++++
 include/linux/swiotlb.h      | 11 +++++++++++
 include/linux/virtio.h       |  2 ++
 kernel/dma/direct.c          | 11 +++++++++++
 kernel/dma/mapping.c         | 14 ++++++++++++++
 kernel/dma/swiotlb.c         | 14 ++++++++++++++
 9 files changed, 85 insertions(+), 4 deletions(-)

-- 
2.17.1
