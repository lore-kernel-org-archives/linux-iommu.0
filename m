From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: remove dma_zalloc_coherent
Date: Tue, 8 Jan 2019 14:56:59 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1901081456370.6130@hadrien>
References: <20190108130701.14161-1-hch@lst.de>
	<alpine.DEB.2.20.1901081453380.6130@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.20.1901081453380.6130@hadrien>
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
Cc: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On Tue, 8 Jan 2019, Julia Lawall wrote:

>
>
> On Tue, 8 Jan 2019, Christoph Hellwig wrote:
>
> > Hi Linus and world,
> >
> > We've always had a weird situation around dma_zalloc_coherent.  To
> > safely support mapping the allocations to userspace major architectures
> > like x86 and arm have always zeroed allocations from dma_alloc_coherent,
> > but a couple other architectures were missing that zeroing either always
> > or in corner cases.  Then later we grew anothe dma_zalloc_coherent
> > interface to explicitly request zeroing, but that just added __GFP_ZERO
> > to the allocation flags, which for some allocators that didn't end
> > up using the page allocator ended up being a no-op and still not
> > zeroing the allocations.
> >
> > So for this merge window I fixed up all remaining architectures to zero
> > the memory in dma_alloc_coherent, and made dma_zalloc_coherent a no-op
> > wrapper around dma_alloc_coherent, which fixes all of the above issues.
> >
> > dma_zalloc_coherent is now pointless and can go away, and Luis helped
> > me writing a cocchinelle script and patch series to kill it, which I
> > think we should apply now just after -rc1 to finally settle these
> > issue.
> >
> > The script that generated the first patch is included here:
> >
> > @ replace_dma_zalloc_coherent @
> > expression dev, size, data, handle, flags;
> > @@
> >
> > -dma_zalloc_coherent(dev, size, handle, flags)
> > +dma_alloc_coherent(dev, size, handle, flags)
>
> Great.  We should also update api/alloc/zalloc-simple.cocci.  The message
> could just say that the z version is no longer needed.

Oops, I see that you already took care of it.  Thanks!

julia
