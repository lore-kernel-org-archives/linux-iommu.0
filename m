From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
	maximum segment size
Date: Thu, 24 Jan 2019 10:51:51 +0100
Message-ID: <20190124095150.GL32526@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
	<20190123163049.24863-6-joro@8bytes.org>
	<20190123213139.GD9032@lst.de> <20190124084011.GJ32526@8bytes.org>
	<20190124084221.GB19441@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190124084221.GB19441-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, jon.grimm-5C7GfCeVMHo@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Michael S . Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, jfehlig-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 24, 2019 at 09:42:21AM +0100, Christoph Hellwig wrote:
> Yes.  But more importantly it would fix the limit for all other block
> drivers that set large segment sizes when running over swiotlb.

True, so it would be something like the diff below? I havn't worked on
the block layer, so I don't know if that needs additional checks for
->dev or anything.

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 3e7038e475ee..9a927280c904 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -1,6 +1,7 @@
 /*
  * Functions related to setting various queue properties from drivers
  */
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -303,13 +304,17 @@ EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);
  **/
 void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
 {
+	unsigned int dma_max_size;
+
 	if (max_size < PAGE_SIZE) {
 		max_size = PAGE_SIZE;
 		printk(KERN_INFO "%s: set to minimum %d\n",
 		       __func__, max_size);
 	}
 
-	q->limits.max_segment_size = max_size;
+	dma_max_size = dma_max_mapping_size(q->backing_dev_info->dev);
+
+	q->limits.max_segment_size = min(max_size, dma_max_size);
 }
 EXPORT_SYMBOL(blk_queue_max_segment_size);
 
