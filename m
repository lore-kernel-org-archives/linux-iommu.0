From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
Date: Fri, 19 Oct 2018 09:46:30 -0400
Message-ID: <20181019134629.GE54336@Konrads-MacBook-Pro.local>
References: <20181008080246.20543-1-hch@lst.de>
	<20181008080246.20543-8-hch@lst.de>
	<35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
	<20181019003715.GI1251@char.us.oracle.com>
	<20181019065258.GA29249@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181019065258.GA29249-jcswGhMUV9g@public.gmane.org>
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
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 19, 2018 at 08:52:58AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 18, 2018 at 08:37:15PM -0400, Konrad Rzeszutek Wilk wrote:
> > > > +	if (!dma_capable(dev, dma_addr, size) ||
> > > > +	    swiotlb_force == SWIOTLB_FORCE) {
> > > > +		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
> > > > +		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
> > > > +	}
> > > 
> > > FWIW I prefer the inverse condition and early return of the original code
> > > here, which also then allows a tail-call to swiotlb_bounce_page() (and saves
> > > a couple of lines), but it's no biggie.
> > > 
> > > Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > 
> > I agree with Robin - it certainly makes it easier to read.
> > 
> > With that small change:
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> So I did this edit, and in this patch it does indeed look much cleaner.
> But in patch 9 we introduce the cache maintainance, and have to invert
> the condition again if we don't want a goto mess:

Right. In which case please leave this patch as it is. And please
plaster the Reviewed-by on the patch. Thank you!
