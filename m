From: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Subject: Re: fix DMA ops layering violations in vmwgfx
Date: Tue, 8 Jan 2019 18:25:32 +0000
Message-ID: <842d92f893669381578a2d5fd31603195a2cb19f.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
	<99091bb861e21d5bb4182f08dedbc494c637cc0f.camel@vmware.com>
	<20190108131227.GB6003@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190108131227.GB6003-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <9E1EE877606E5F4190E59AE021DE7242-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux-graphics-maintainer <Linux-graphics-maintainer-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2019-01-08 at 14:12 +0100, hch-jcswGhMUV9g@public.gmane.org wrote:
> On Tue, Jan 08, 2019 at 09:51:45AM +0000, Thomas Hellstrom wrote:
> > Hi, Christoph,
> > 
> > On Sat, 2019-01-05 at 09:01 +0100, Christoph Hellwig wrote:
> > > Hi Thomas,
> > > 
> > > vmwgfx has been doing some odd checks based on DMA ops which rely
> > > on deep DMA mapping layer internals, and I think the changes in
> > > Linux 4.21 finally broke most of these implicit assumptions.
> > 
> > Thanks. 
> > What we're really trying to do here is to try to detect the
> > situation
> > where DMA remapping using hardware IOMMUs is going on but memory is
> > still coherent, since the driver can currently only work with
> > coherent
> > memory[1]. Currently we use intel_iommu_enabled to detect this
> > situation, but it would be really helpful if there were a generic
> > bool
> > that advertizes this situation since we need to deal with other
> > IOMMUs
> > as well going forward. Any suggestion?
> 
> I'm missing the link of the [1] reference above. 

Sorry. I meant to remove the reference since the explanation would be
rather lengthy.

> But if you need
> coherent memory you should simply always use dma_alloc_coherent, that
> is the only gurantee you get.  If you use any other dma mapping
> methods
> you will otherwise need to explicitly transfer ownership by mapping/
> unmapping or using dma_sync* before and after every device access.

The problem is that graphics applications typically allocate huge
amounts of DMA memory. The GPU may want to map half of available system
memory or more. Moreover this memory might need to be mappable by
multiple devices, which would rule out dma_alloc_coherent() in many
situations.

Using SWIOTLB with bounce-buffers is also typically out of the question
for performance- and memory usage reasons. Moreover the sync operations
would often affect sub-regions of 2D and 3D textures, which makes the
dma_sync API inefficient even if it maps to no-ops. vmwgfx would rather
not load in these situations.

Finally graphics applications, do not always provide conservative sync
regions.

> 
> And the whole DMA API bypass using the phys mode is something that
> I'd really prefer not to see in any driver as it tends to cause
> major problems sooner or later.

I fully understand this. However, given the above, the DMA API is quite
awkward for graphics operation. It would be easier to motivate a full
removal of the phys mode if we could query the DMA API whether the
dma_sync operations are no-ops or not.

/Thomas
