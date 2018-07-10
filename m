From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] dma-mapping: Clean up dma_get_required_mask()
	hooks
Date: Tue, 10 Jul 2018 13:39:08 +0200
Message-ID: <20180710113908.GB32688@lst.de>
References: <55ac9550c311f056dcfeed9b2c8265375f17b155.1530726467.git.robin.murphy@arm.com>
	<08256121f325ceed7f6b88c1a5d3cf949698787d.1530726467.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <08256121f325ceed7f6b88c1a5d3cf949698787d.1530726467.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 04, 2018 at 06:50:12PM +0100, Robin Murphy wrote:
> As for the other mask-related hooks, standardise the arch override into
> a Kconfig option, and also pull the generic implementation into the DMA
> mapping code rather than having it hide away in the platform bus code.

I compared this a bit to what I had around against an older kernel,
and I think we should probably go with something more like the
version I had, which I can dust off again.

What I've done is to:

 1) provide the get_required_mask unconditionally in struct dma_map_ops
 2) default to what is the current dma_get_required_mask implementation
    if nothing else is specified.

What I still had on my todo list but not done yet:

 3) go through all instances and check if the current default
    makes sense, at it based on direct addressability.  For most
    iommu instances it seems like we should just return a 64-bit mask.
 4) figure out how to take the dma offsets into account for it
 5) move the function to the dma-direct code, as that is where it
    belongs
 5) figure out if there is a better name for the method, as with
    swiotlb & co it isn't really the required mask, but more something
    like the optimal mask
 6) document the whole thing..
 7) sort out the powerpc indirection mess.

Do you agree with that general plan?  If so I can dust off my old
patch.
