From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] vfio: hugepage support for vfio_iommu_type1
Date: Mon, 27 May 2013 07:37:10 -0600
Message-ID: <1369661830.2646.183.camel@ul30vt.home>
References: <20130524171613.14229.84050.stgit@bling.home>
	<20130524172438.14229.59476.stgit@bling.home>
	<C5ECD7A89D1DC44195F34B25E172658D552685@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D552685-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "chegu_vinod-VXdhtT5mjnY@public.gmane.org" <chegu_vinod-VXdhtT5mjnY@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-05-27 at 08:41 +0000, Sethi Varun-B16395 wrote:
> 
> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Alex Williamson
> > Sent: Friday, May 24, 2013 10:55 PM
> > To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; chegu_vinod-VXdhtT5mjnY@public.gmane.org; qemu-
> > devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: [PATCH 2/2] vfio: hugepage support for vfio_iommu_type1
> > 
> > We currently send all mappings to the iommu in PAGE_SIZE chunks, which
> > prevents the iommu from enabling support for larger page sizes.
> > We still need to pin pages, which means we step through them in PAGE_SIZE
> > chunks, but we can batch up contiguous physical memory chunks to allow
> > the iommu the opportunity to use larger pages.  The approach here is a
> > bit different that the one currently used for legacy KVM device
> > assignment.  Rather than looking at the vma page size and using that as
> > the maximum size to pass to the iommu, we instead simply look at whether
> > the next page is physically contiguous.  This means we might ask the
> > iommu to map a 4MB region, while legacy KVM might limit itself to a
> 
[Sethi Varun-B16395] Wouldn't this depend on the IOMMU page alignment
constraints?

The iommu_map() function handles this.

> > maximum of 2MB.
> > 
> > Splitting our mapping path also allows us to be smarter about locked
> > memory because we can more easily unwind if the user attempts to exceed
> > the limit.  Therefore, rather than assuming that a mapping will result in
> > locked memory, we test each page as it is pinned to determine whether it
> > locks RAM vs an mmap'd MMIO region.  This should result in better locking
> > granularity and less locked page fudge factors in userspace.
> > 
> > The unmap path uses the same algorithm as legacy KVM.  We don't want to
> > track the pfn for each mapping ourselves, but we need the pfn in order to
> > unpin pages.  We therefore ask the iommu for the iova to physical address
> > translation, ask it to unpin a page, and see how many pages were actually
> > unpinned.  iommus supporting large pages will often return something
> > bigger than a page here, which we know will be physically contiguous and
> > we can unpin a batch of pfns.  iommus not supporting large mappings won't
> > see an improvement in batching here as they only unmap a page at a time.
> > 
> > With this change, we also make a clarification to the API for mapping and
> > unmapping DMA.  We can only guarantee unmaps at the same granularity as
> > used for the original mapping.  In other words, unmapping a subregion of
> > a previous mapping is not guaranteed and may result in a larger or
> > smaller unmapping than requested.  The size field in the unmapping
> > structure is updated to reflect this.
> > Previously this was unmodified on mapping, always returning the the
> > requested unmap size.  This is now updated to return the actual unmap
> > size on success, allowing userspace to appropriately track mappings.
> > 
> [Sethi Varun-B16395] The main problem here is that the user space
> application is oblivious of the physical memory contiguity, right?

Yes.

> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c |  523 +++++++++++++++++++++++++--------
> > ------
> > +static long vfio_unpin_pages(unsigned long pfn, long npage,
> > +			     int prot, bool do_accounting)
> > +{
> > +	unsigned long unlocked = 0;
> > +	long i;
> > +
> > +	for (i = 0; i < npage; i++)
> > +		unlocked += put_pfn(pfn++, prot);
> > +
> > +	if (do_accounting)
> > +		vfio_lock_acct(-unlocked);
> > +
> > +	return unlocked;
> > +}
> > +
> > +static int vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma
> > *dma,
> > +			    dma_addr_t iova, size_t *size)
> > +{
> > +	dma_addr_t start = iova, end = iova + *size;
> > +	long unlocked = 0;
> > +
> > +	while (iova < end) {
> > +		size_t unmapped;
> > +		phys_addr_t phys;
> > +
> >  		/*
> > -		 * Only add actual locked pages to accounting
> > -		 * XXX We're effectively marking a page locked for every
> > -		 * IOVA page even though it's possible the user could be
> > -		 * backing multiple IOVAs with the same vaddr.  This over-
> > -		 * penalizes the user process, but we currently have no
> > -		 * easy way to do this properly.
> > +		 * We use the IOMMU to track the physical address.  This
> > +		 * saves us from having a lot more entries in our mapping
> > +		 * tree.  The downside is that we don't track the size
> > +		 * used to do the mapping.  We request unmap of a single
> > +		 * page, but expect IOMMUs that support large pages to
> > +		 * unmap a larger chunk.
> >  		 */
> > -		if (!is_invalid_reserved_pfn(pfn))
> > -			locked++;
> > -
> > -		ret = iommu_map(iommu->domain, iova,
> > -				(phys_addr_t)pfn << PAGE_SHIFT,
> > -				PAGE_SIZE, prot);
> > -		if (ret) {
> > -			/* Back out mappings on error */
> > -			put_pfn(pfn, prot);
> > -			__vfio_dma_do_unmap(iommu, start, i, prot);
> > -			return ret;
> > +		phys = iommu_iova_to_phys(iommu->domain, iova);
> > +		if (WARN_ON(!phys)) {
> [Sethi Varun-B16395] When can this happen? Why won't this be treated
> as an error? 

I think this should never happen, which is why I just have a WARN and
continue path vs return error out to the user.

> > +			iova += PAGE_SIZE;
> > +			continue;
> >  		}
> > +
> > +		unmapped = iommu_unmap(iommu->domain, iova, PAGE_SIZE);
> > +		if (!unmapped)
> > +			break;
> > +
> > +		unlocked += vfio_unpin_pages(phys >> PAGE_SHIFT,
> > +					     unmapped >> PAGE_SHIFT,
> > +					     dma->prot, false);
> > +		iova += unmapped;
> >  	}
> > -	vfio_lock_acct(locked);
> > +
> > +	vfio_lock_acct(-unlocked);
> > +
> > +	*size = iova - start;
> > +
> >  	return 0;
> >  }
> > 
> >  static int vfio_remove_dma_overlap(struct vfio_iommu *iommu, dma_addr_t
> > start,
> > -				   size_t size, struct vfio_dma *dma)
> > +				   size_t *size, struct vfio_dma *dma)
> >  {
> > +	size_t offset, overlap, tmp;
> >  	struct vfio_dma *split;
> > -	long npage_lo, npage_hi;
> > +	int ret;
> > +
> > +	/*
> > +	 * Existing dma region is completely covered, unmap all.  This is
> > +	 * the likely case since userspace tends to map and unmap buffers
> > +	 * in one shot rather than multiple mappings within a buffer.
> > +	 */
> > +	if (likely(start <= dma->iova &&
> > +		   start + *size >= dma->iova + dma->size)) {
> > +		*size = dma->size;
> > +		ret = vfio_unmap_unpin(iommu, dma, dma->iova, size);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/*
> > +		 * Did we remove more than we have?  Should never happen
> > +		 * since a vfio_dma is contiguous in iova and vaddr.
> > +		 */
> > +		WARN_ON(*size != dma->size);
> [Sethi Varun-B16395] Doesn't this indicate something wrong with the IOMMU mappings?

Yes, we should always be able to remove one of our struct vfio_dma
tracking structures entirely because it will be a superset of previous
mappings that are both contiguous in virtual address and iova.  This is
a sanity check WARN to make sure that's true.  Thanks,

Alex
