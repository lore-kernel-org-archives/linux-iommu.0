From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [PATCH 0/2] RFC Isolation API
Date: Wed, 14 Mar 2012 00:57:25 +1100
Message-ID: <20120313135725.GR24916@truffala.fritz.box>
References: <20120312220109.30321.83419.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120312220109.30321.83419.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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

On Mon, Mar 12, 2012 at 04:32:46PM -0600, Alex Williamson wrote:
> VFIO is completely stalled waiting on a poorly defined device isolation
> infrastructure to take shape.  Rather than waiting any longer, I've
> decided to write my own.  This is nowhere near ready for upstream, but
> attempts to hash out some of the interactions of isolation groups.

Sigh, yeah, I've had trouble getting to this amongst other things,
thanks for pushing something forwards.

> To recap, an isolation group is a set of devices, between which there
> is no guaranteed isolation.  Between isolation groups, we do have
> isolation, generally provided by an IOMMU.  On x86 systems with either
> VT-d or AMD-Vi, we often have function level isolation (assuming you
> trust the device).  Hardware topologies such as PCIe-to-PCI bridges
> can decrease this granularity.  PowerPC systems often set the delimiter
> at the PCI bridge level and refer to these as Partitionable
> Endpoints.

So, this is a bit of an aside from the isolation infrastructure
itself, but it's pretty important I think, and the reason we don't
think the VFIO device-function centric approach is appropriate for
Power.  Function level isolation requires trusting the device a *lot*.
In addition to obvious bugs like those multi-function devices which
use function 0's RID for DMAs from all functions, isolation can be
broken if any of these is true:

    * IO or MMIO allows unvirtualized access to the device's config
space - this is a common debug/undocumented feature

    * The device can be made to cause a bus-wide error.  Given the
general quality of commodity hardware, I suspect this will be quite
common too.

    * There is a multifunction device with any kind of crosstalk
between the functions - again, (possibly undocumented) debug registers
which are shared between functions is pretty common.

    * The device can generate DMA bus cycles which might get decoded
by something other than the host bridge.  I suspect this one means
that a DMA capable pre-Express PCI device can never be truly isolated
from things on the same physical bus segment.

And those are just the ones I've thought of so far.  SR-IOV VFs are
probably ok (modulo the inevitable implementation bugs), but other
than that I suspect PCI devices which can really be trusted for
function-level isolation will be pretty rare.  If you have trustable
P2P bridges (as we do on Power servers), though, you can put any PCI
device behind it and have the bridge enforce isolation.  This is why
most pSeries setups have every PCI slot behind a separate P2P bridge,
or in many cases an entire separate host bridge.

> VFIO is a userspace driver interface tailored as a replacement for
> KVM device assignment.  In order to provide secure userspace driver
> interfaces, we must first ensure that we have an isolated device
> infrastructure.  This attempts to define the basics of such an
> interface.
> 
> In addition to isolation groups, this series also introduces the idea
> of an isolation "provider".  This is simply a driver which defines
> isolation groups, for example intel-iommu.  This interface supports
> multiple providers simultaneously.  We also have the idea of a "manager"
> for an isolation group.  When a manager is set for an isolation group,
> it changes the way driver matching works for devices.  We only allow
> matching to drivers registered by the isolation group manager.  Once all
> of the devices in an isolation group are bound to manager registered
> drivers (or no driver), the group is "locked" under manager control.

Yeah, I really should have posted my draft patch a while back which
added isolation group "binders", pretty much equivalent to your
"managers".

> This proposal is far from complete, but I hope it can re-fire some
> discussion and work in this space.  Please let me know what you like,
> what you don't like, and ideas for the gaps.  Thanks,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
