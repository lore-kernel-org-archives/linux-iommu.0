From: Thomas Hellstrom via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: revert dma direct internals abuse
Date: Tue, 9 Apr 2019 13:04:51 +0000
Message-ID: <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
	<7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
	<20190409095740.GE6827@lst.de>
Reply-To: Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190409095740.GE6827-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <490CD89E2D46FA4C8C1C0C92F9FEC9BF-HX+pjaQZbrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Deepak Singh Rawat <drawat-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2019-04-09 at 11:57 +0200, hch-jcswGhMUV9g@public.gmane.org wrote:
> On Mon, Apr 08, 2019 at 06:47:52PM +0000, Thomas Hellstrom wrote:
> > We HAVE discussed our needs, although admittedly some of my emails
> > ended up unanswered.
> 
> And than you haven't followed up, and instead ignored the layering
> instructions and just commited a broken patch?

Yes, I'm really sorry for not observing the layering instructions. To
be completely honest I didn't observe that layering warning, rather
than ignoring it. The patch doesn't claim to be generic and I believe
that on the VMware platform it is functionally correct, please see
below. I also would like not to focus on who did what and why. I can't
see how that will help this discussion moving forward.

> 
> > We've as you're well aware of had a discussion with the other
> > subsystems doing user-space DMA-buffers wanting this functionality
> > from
> > the dma api (AMD graphics and RDMA people IIRC). that is a bool
> > that
> > tells us whether streaming dma mappings are coherent, and I
> > described
> > in detail why we couldn't use the dma_sync_* API and
> > dma_alloc_coherent().
> 
> And that is not at all what you either check or claim to do in the
> changelog (which btw, are two different things).
> 
> > The other option we have is to just fail miserably without messages
> > if
> > streaming DMA is not coherent, which I think the other drivers
> > might
> > do... That's all I'm trying to avoid here. I'd much prefer to have
> > the
> > dma API export this bool.
> 
> Both DMA direct and non-DMA direct streaming mappings can be either
> coherent or incoherent, so your patch doesn't archive that.  The
> commit log claims the following:
> 
> "drm/vmwgfx: Improve on IOMMU detection
>     
>  instead of relying on intel_iommu_enabled, use the fact that the
>  dma_map_ops::map_page != dma_direct_map_page"
> 
> which has nothing to do with the fact that streaming mappings are
> coherent.  It also is incorrect as there are direct mapping that
> do not use dma_direct_map_page (e.g. on ARM, or x86 with VMD).

On the VMware platform we have two possible vIOMMUS, the AMD iommu and
Intel VTD, Given those conditions I belive the patch is functionally
correct. We can't cover the AMD case with intel_iommu_enabled.
Furthermore the only form of incoherency that can affect our graphics
device is someone forcing SWIOTLB in which case that person would be
happier with software rendering. In any case, observing the fact that
the direct_ops are not used makes sure that SWIOTLB is not used.
Knowing that we're on the VMware platform, we're coherent and can
safely have the dma layer do dma address translation for us. All this
information was not explicilty written in the changelog, no.


In any case, assuming that that patch is reverted due to the layering
violation, Are you willing to help out with a small API to detect the
situation where streaming DMA is incoherent?

/Thomas
