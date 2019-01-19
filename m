From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] arm64/xen: fix xen-swiotlb cache flushing
Date: Sat, 19 Jan 2019 10:43:01 +0100
Message-ID: <20190119094301.GB21653@lst.de>
References: <20190117171842.26173-1-hch@lst.de>
	<alpine.DEB.2.10.1901181612150.18561@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901181612150.18561@sstabellini-ThinkPad-X260>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: jgross-IBi9RG/b67k@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, julien.grall-5wv7dgnIgG8@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[full quote deleted, please take a little more care when quoting]

On Fri, Jan 18, 2019 at 04:44:23PM -0800, Stefano Stabellini wrote:
> >  #ifdef CONFIG_XEN
> > -	if (xen_initial_domain()) {
> > -		dev->archdata.dev_dma_ops = dev->dma_ops;
> > +	if (xen_initial_domain())
> >  		dev->dma_ops = xen_dma_ops;
> > -	}
> >  #endif
> >  }
> 
> This is an optional suggestion, but it would be nice to add a check on
> dev->dma_ops being unset here, something like:
> 
>   #ifdef CONFIG_XEN
>   if (xen_initial_domain()) {
>       if (dev->dma_ops != NULL)
>           warning/error
>       dev->dma_ops = xen_dma_ops;
>   }
> 
> Does it make sense?

Well, no such check existed before, so this probably should be a
separate patch if we care enough.  I have a series for 5.1 pending
that moves the IOMMU handling to the comment code which will make
the ops assginment a lot cleaner, and I guess I could fold such
a check in that.  Doing it now will just create churn as it would
have to get reworked anyway

> Reviewed-by: Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Where should we pick this up?  I could pick it up through the dma-mapping
tree given that is where the problem is introduced, but the Xen or arm64
trees would also fit.
