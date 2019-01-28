From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/5 v3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 28 Jan 2019 10:53:22 -0500
Message-ID: <20190128155322.GA32686@char.us.oracle.com>
References: <20190123163049.24863-1-joro@8bytes.org>
	<20190123135000-mutt-send-email-mst@kernel.org>
	<20190123211453.GA2474@char.us.oracle.com>
	<20190128101852-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190128101852-mutt-send-email-mst-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, brijesh.singh-5C7GfCeVMHo@public.gmane.org, jon.grimm-5C7GfCeVMHo@public.gmane.org, jfehlig-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 28, 2019 at 10:20:05AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 23, 2019 at 04:14:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jan 23, 2019 at 01:51:29PM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Jan 23, 2019 at 05:30:44PM +0100, Joerg Roedel wrote:
> > > > Hi,
> > > > 
> > > > here is the third version of this patch-set. Previous
> > > > versions can be found here:
> > > > 
> > > > 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/
> > > > 
> > > > 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org/
> > > > 
> > > > The problem solved here is a limitation of the SWIOTLB implementation,
> > > > which does not support allocations larger than 256kb.  When the
> > > > virtio-blk driver tries to read/write a block larger than that, the
> > > > allocation of the dma-handle fails and an IO error is reported.
> > > 
> > > 
> > > OK looks good to me.
> > > I will park this in my tree for now this way it will get
> > > testing in linux-next.
> > > Can I get an ack from DMA maintainers on the DMA bits for
> > > merging this in 5.0?
> > 
> > You got mine (SWIOTBL is my area).
> 
> OK so
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Yes :-)
> 
> 
> 
> > > 
> > > > Changes to v2 are:
> > > > 
> > > > 	* Check if SWIOTLB is active before returning its limit in
> > > > 	  dma_direct_max_mapping_size()
> > > > 
> > > > 	* Only apply the maximum segment limit in virtio-blk when
> > > > 	  DMA-API is used for the vring
> > > > 
> > > > Please review.
> > > > 
> > > > Thanks,
> > > > 
> > > > 	Joerg
> > > > 
> > > > Joerg Roedel (5):
> > > >   swiotlb: Introduce swiotlb_max_mapping_size()
> > > >   swiotlb: Add is_swiotlb_active() function
> > > >   dma: Introduce dma_max_mapping_size()
> > > >   virtio: Introduce virtio_max_dma_size()
> > > >   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> > > > 
> > > >  drivers/block/virtio_blk.c   | 10 ++++++----
> > > >  drivers/virtio/virtio_ring.c | 10 ++++++++++
> > > >  include/linux/dma-mapping.h  | 16 ++++++++++++++++
> > > >  include/linux/swiotlb.h      | 11 +++++++++++
> > > >  include/linux/virtio.h       |  2 ++
> > > >  kernel/dma/direct.c          | 11 +++++++++++
> > > >  kernel/dma/swiotlb.c         | 10 ++++++++++
> > > >  7 files changed, 66 insertions(+), 4 deletions(-)
> > > > 
> > > > -- 
> > > > 2.17.1
