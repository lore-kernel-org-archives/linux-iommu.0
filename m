From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: RFC: Device isolation groups
Date: Fri, 9 Mar 2012 14:40:02 +1100
Message-ID: <20120309034002.GP10735@truffala.fritz.box>
References: <1328071614-8320-1-git-send-email-david@gibson.dropbear.id.au>
	<1328126919.6937.254.camel@bling.home>
	<20120202012414.GE8700@truffala.fritz.box>
	<1330543855.29701.180.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1330543855.29701.180.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 29, 2012 at 12:30:55PM -0700, Alex Williamson wrote:
> On Thu, 2012-02-02 at 12:24 +1100, David Gibson wrote:
> > On Wed, Feb 01, 2012 at 01:08:39PM -0700, Alex Williamson wrote:
[snip]
> Any update to this series?  It would be great if we could map out the
> functionality to the point of breaking down and distributing work... or
> determining if the end result has any value add to what VFIO already
> does.  Thanks,

Yes and no.

No real change on the isolation code per se.  I had been hoping for
feedback from David Woodhouse, but I guess he's been too busy.

In the meantime, however, Alexey has been working on a different
approach to doing PCI passthrough which is more suitable for our
machines.  It is based on passing through an entire virtual host
bridge (which could be a whole host side host bridge, or a subset,
depending on host isolation capabilities), rather than individual
devices.  This makes it substantially simpler than VFIO (we don't need
to virtualize config space or device addresses), and it provides
better enforcement of isolation guarantees (VFIO isolation can be
broken if devices have MMIO backdoors to config space, or if they can
be made to DMA to other devices MMIO addresses instead of RAM
addresses), but does require suitable bridge hardware - pSeries has
such hardware, x86 mostly doesn't (although it wouldn't surprise me if
large server class x86 machines do or will provide the necessary
things).  Even on this sort of hardware the device-centred VFIO
approach may have uses, since it might allow finer grained division,
at the cost of isolation enforcement.

This provides a more concrete case for the isolation infrastructure,
since it would allow the virtual-PHB and VFIO approaches to co-exist.
As Alexey's prototype comes into shape, it should illuminate what
other content we need in the isolation infrastructure to make it fully
usable.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
