From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Thu, 10 Jan 2019 14:44:30 +0100
Message-ID: <20190110134433.15672-1-joro@8bytes.org>
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
To: "Michael S . Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, brijesh.singh-5C7GfCeVMHo@public.gmane.org, jon.grimm-5C7GfCeVMHo@public.gmane.org, jfehlig-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

there is a problem with virtio-blk driven devices when
virtio-ring uses SWIOTLB through the DMA-API. This happens
for example in AMD-SEV enabled guests, where the guest RAM
is mostly encrypted and all emulated DMA has to happen
to/from the SWIOTLB aperture.

The problem is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb. When
the virtio-blk driver tries to read/write a block larger
than that, the allocation of the dma-handle fails and an IO
error is reported.

This patch-set adds a check to the virtio-code whether it
might be using SWIOTLB bounce buffering and limits the
maximum segment size in the virtio-blk driver in this case,
so that it doesn't try to do larger reads/writes.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  swiotlb: Export maximum allocation size
  virtio: Introduce virtio_max_dma_size()
  virtio-blk: Consider virtio_max_dma_size() for maximum segment size

 drivers/block/virtio_blk.c   | 10 ++++++----
 drivers/virtio/virtio_ring.c | 11 +++++++++++
 include/linux/swiotlb.h      | 12 ++++++++++++
 include/linux/virtio.h       |  2 ++
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.17.1
