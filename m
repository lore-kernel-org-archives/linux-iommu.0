From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hang (due to HW?) in qi_submit_sync()
Date: Mon, 05 Jan 2015 23:48:21 -0700
Message-ID: <1420526901.3541.96.camel@redhat.com>
References: <1420505840-30096-1-git-send-email-roland@kernel.org>
	<1420512860.3541.77.camel@redhat.com>
	<CAG4TOxPOgTOKYZa7q9Of8XzHV_wAadtJmXFC0bmyN2Qds7T9RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAG4TOxPOgTOKYZa7q9Of8XzHV_wAadtJmXFC0bmyN2Qds7T9RA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Roland Dreier <roland-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-01-05 at 20:39 -0800, Roland Dreier wrote:
> On Mon, Jan 5, 2015 at 6:54 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Try disabling CONFIG_NET_DMA
> 
> We already have that disabled (well, in 3.10 it depends on BROKEN, and
> we don't have BROKEN enabled :).

Only since v3.10.26 is it marked BROKEN.

> However I'm curious why you suggest that.  Because some of the devices
> we're accessing via vfio are in fact Intel DMA engines (we blacklist
> ioatdma and use the DMA devices directly from userspace).  Is there
> some known interaction between the Intel DMA engines and interrupt
> remapping?

I suggest it because I spent several weeks isolating why we hit the same
lockup in qi_submit_sync() as you're seeing after we backported a number
of iommu patches.  In our case, finding that it's toggled by
CONFIG_NET_DMA, which has since been marked broken and removed is a
sufficient solution.  I agree though that regardless of what terrible
things NET_DMA was doing, we seem to be hitting a "broken hardware"
condition, potentially invoked by the DMA engine.

What I observed was that it occurs when flushing an irte entry, the
queued invalidation queue is working prior to this flush, but the wait
descriptor value is never written to the status address, the queue head
never advances past that wait descriptor once it gets wedged, and the
status register never indicates any sort of error.  Section 6.5.6 of the
VT-d spec on interrupt draining has an interesting statement:

        Interrupt draining is performed on Interrupt Entry Cache (IEC)
        invalidation requests. For IEC invalidations submitted through
        the queued invalidation interface, interrupt draining must be
        completed before the next Invalidation Wait Descriptor is
        completed by hardware.

Given the circumstances of the hang, that certainly makes me suspect
that queued invalidation is failing to complete interrupt draining and
hardware is therefore unable to advance past the subsequent wait
descriptor or complete the wait descriptor because of this requirement.
I wouldn't be surprised if there's an errata hidden in there somewhere.
Thanks,

Alex

PS - Thanks for using vfio :)
