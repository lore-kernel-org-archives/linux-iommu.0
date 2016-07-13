From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 16/20 v2] iommu/amd: Optimize map_sg and unmap_sg
Date: Wed, 13 Jul 2016 12:27:18 +0200
Message-ID: <20160713102718.GD27306@suse.de>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
	<1467978311-28322-17-git-send-email-joro@8bytes.org>
	<5784D597.4010703@arm.com> <20160712133042.GG12639@8bytes.org>
	<57850DF8.9040507@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57850DF8.9040507-5wv7dgnIgG8@public.gmane.org>
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
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 12, 2016 at 04:34:16PM +0100, Robin Murphy wrote:
> The boundary masks for block devices are tricky to track down through so
> many layers of indirection in the common frameworks, but there are a lot
> of 64K ones there. After some more impromptu digging into the subject
> I've finally satisfied my curiosity - it seems this restriction stems
> from the ATA DMA PRD table format, so it could perhaps still be a real
> concern for anyone using some crusty old PCI IDE card in their modern
> system.

The boundary-mask is a capability of the underlying PCI device, no? The
ATA or whatever-stack above should have no influence on it.
> 
> Indeed, I wasn't suggesting making more than one call, just that
> alloc_iova_fast() is quite likely to have to fall back to alloc_iova()
> here, so there may be some mileage in going directly to the latter, with
> the benefit of then being able to rely on find_iova() later (since you
> know for sure you allocated out of the tree rather than the caches). My
> hunch is that dma_map_sg() tends to be called for bulk data transfer
> (block devices, DRM, etc.) so is probably a less contended path compared
> to the network layer hammering dma_map_single().

Using different functions for allocation would also require special
handling in the queued-freeing code, as I have to track the allocation
then to know wheter I free it with the _fast variant or not.

> > +	mask          = dma_get_seg_boundary(dev);
> > +	boundary_size = mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHIFT :
> > +				   1UL << (BITS_PER_LONG - PAGE_SHIFT);
> 
> (mask >> PAGE_SHIFT) + 1 ?

Should make no difference unless some of the first PAGE_SHIFT bits of
mask is 0 (which shouldn't happen).



	Joerg
