From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH] dma-mapping: create iommu mapping for newly
	allocated dma coherent mem
Date: Wed, 24 Apr 2019 16:57:05 +0200
Message-ID: <20190424145705.GB21480@lst.de>
References: <20190422165125.21704-1-laurentiu.tudor@nxp.com>
	<20190422181100.GB32490@lst.de>
	<VI1PR04MB513407A66107759EC0DFE175EC230@VI1PR04MB5134.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <VI1PR04MB513407A66107759EC0DFE175EC230-mr6QIVyDiCE39zapGMDXPM9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

I'd be happy to offload all of the mentioned tasks to you if you
volunteer.

I think the first step is to move the two USB controller that can only
DMA to their own BAR off the existing DMA coherent infrastructure.  The
controllers are already identified using the HCD_LOCAL_MEM flag, so we
just need to key off that in the hcd_buffer_* routines and call into a
genalloc that has been fed using the bar, replacing the current
dma_declare_coherent usage.  Take a look at drivers/pci/p2pdma.c
for another example of allocating bits of a BAR using genalloc.

Another issue in that are just popped up, which is remoteproc_virtio.c,
which looks like a complete trainwreck.  I'll need to spend time to
figure out what the hell they are trying to first, though.

Then we need to kill the dma_declare_coherent_memory and
dma_release_declared_memory exports ASAP to avoid growing more users.

Next is figuring out how we want to plumb the OF / early boot coherent
regions into the iommu drivers.  I think I want to handle them similar
to the per-device CMA regions, that is each of the DMA ops has to
manually call into it instead of the page allocator.  Fortunately we
are down to only about a hand full of instances that are relevant
for the reserved memory now.
