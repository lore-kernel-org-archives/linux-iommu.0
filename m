From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Hang (due to HW?) in qi_submit_sync()
Date: Thu, 08 Jan 2015 16:39:44 -0700
Message-ID: <1420760384.25367.101.camel@redhat.com>
References: <1420505840-30096-1-git-send-email-roland@kernel.org>
	<1420512860.3541.77.camel@redhat.com>
	<CAG4TOxPOgTOKYZa7q9Of8XzHV_wAadtJmXFC0bmyN2Qds7T9RA@mail.gmail.com>
	<1420526901.3541.96.camel@redhat.com>
	<1420756610-20918-1-git-send-email-roland@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420756610-20918-1-git-send-email-roland-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

On Thu, 2015-01-08 at 14:36 -0800, Roland Dreier wrote:
> Hi,
> 
> So we've managed to find one magic setup and workload that reproduces
> this reliably, and I've done a bit more debugging that leads me to
> believe we probably need Intel's help to really get to the bottom of
> this.

Can you share your test case?  My test case was also using vfio,
repeatedly booting a pair of VMs with assigned GPUs, but I haven't seen
any sign of the issue without NET_DMA.  I agree that it seems like the
hardware is getting somewhere that it shouldn't regardless of the
software, but are you able to reproduce on a more recent kernel?

I've also seen a report of the same problem without vfio by manipulating
IRQ affinity, but it was not a reliable test case.

> One question though: you mentioned that you saw this behavior until
> you turned off CONFIG_NET_DMA.  What platform was that on?  We see
> this on dual socket Xeon E5 v3 (Haswell EP / Grantley), and I don't
> really have any other setup I can try.  Did you see this on other
> platforms (Ivy Bridge / Romley maybe)?

I saw it on a dual socket Xeon E5 v2 (Ivy Bridge EP / Patsburg), and the
other report I mention above was the same, different systems though.

> Anyway, I added the debugging patch at the end of this mail to our
> kernel to dump some status when the driver detects a hung queue.
> Below we see some example output.  Things I notice:
> 
>  - IQH == IQT, in other words the QI hardware thinks it has picked up
>    and validated all the descriptors submitted by software.
>  - The queue has successfully processed many operations (although
>    everything that we can see succeeded is type 2h, ie "IOTLB
>    invalidate" as opposed to the type 4h "Interrupt Entry Cache
>    invalidate" that we're stuck on.
>  - There haven't been any faults and FSTS is clear.
>  - The hardware hasn't executed the "Invalidation wait" descriptor.

This is all consistent with my observations as well.

> Beyond that I'm not sure how to make much more progress without
> insight into the hardware -- it looks like the driver is doing
> everything right.  Anyone from Intel have any thoughts?

Agreed, the hardware appears to be getting wedged without and sort of
fault indication or recovery mechanism.  Thanks,

Alex
