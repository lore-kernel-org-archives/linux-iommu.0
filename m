From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] vfio: hugepage support for vfio_iommu_type1
Date: Sat, 25 May 2013 08:23:48 -0600
Message-ID: <1369491828.2646.155.camel@ul30vt.home>
References: <20130524171613.14229.84050.stgit@bling.home>
	<20130524172438.14229.59476.stgit@bling.home>
	<20130525112009.GC2418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130525112009.GC2418-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, chegu_vinod-VXdhtT5mjnY@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, 2013-05-25 at 07:20 -0400, Konrad Rzeszutek Wilk wrote:
> > + * Turns out AMD IOMMU has a page table bug where it won't map large pages
> > + * to a region that previously mapped smaller pages.  This should be fixed
> > + * soon, so this is just a temporary workaround to break mappings down into
> > + * PAGE_SIZE.  Better to map smaller pages than nothing.
> > + */
> > +static int map_try_harder(struct vfio_iommu *iommu, dma_addr_t iova,
> > +			  unsigned long pfn, long npage, int prot)
> > +{
> > +	long i;
> > +	int ret;
> > +
> > +	for (i = 0; i < npage; i++, pfn++, iova += PAGE_SIZE) {
> > +		ret = iommu_map(iommu->domain, iova,
> > +				(phys_addr_t)pfn << PAGE_SHIFT,
> > +				PAGE_SIZE, prot);
> > +		if (ret)
> > +			break;
> > +	}
> > +
> > +	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
> > +		iommu_unmap(iommu->domain, iova, PAGE_SIZE);
> > +
> >  	return ret;
> >  }
> 
> This looks to belong to a vfio-quirk file (a something else) that deals with
> various IOMMU's quirks.

This is a software bug in amd_iommu, which Joerg knows about, so I'm
hoping this is a short lived quirk.  I dropped it here for convenience,
but I expect to be able to remove it before long.  If we find some
hardware quirks, I expect we'd want the quirks in the drivers themselves
so the consumers, like vfio, don't need to worry about them.  Thanks,

Alex
