From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:608
Date: Mon, 8 Apr 2019 12:05:37 -0600
Message-ID: <20190408120537.059b380f@x1.home>
References: <a523ea10-3dab-fa2c-1ecf-5cf32077565f@acm.org>
	<20190407150650.060cc508@x1.home>
	<8d876549-21da-e027-0157-8737b10e26f8@acm.org>
	<20190407173132.24032810@x1.home>
	<1554736414.118779.265.camel@acm.org>
	<20190408092345.01751472@x1.home>
	<c5511683-9739-9c74-418b-cf2aed6b294a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c5511683-9739-9c74-418b-cf2aed6b294a-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: James Smart <jsmart2021-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 8 Apr 2019 18:10:05 +0100
Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> On 08/04/2019 16:23, Alex Williamson wrote:
> > On Mon, 08 Apr 2019 08:13:34 -0700
> > Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org> wrote:
> >   
> >> On Sun, 2019-04-07 at 17:31 -0600, Alex Williamson wrote:  
> >>> It's not possible to do what you want with this configuration.  An IOMMU
> >>> group represents the smallest set of devices that are isolated from
> >>> other sets of devices and is also therefore the minimum granularity we
> >>> can assign devices to userspace (ex. QEMU).  The kernel reacts to
> >>> breaking the isolation of the group with a BUG_ON.  If you managed not
> >>> to hit the BUG_ON here, you'd hit the BUG_ON in vfio code when the loss
> >>> of isolation is detected there. IOMMU groups are formed at the highest
> >>> point in the topology which guarantees isolation.  This can be
> >>> indicated either via native PCIe ACS support or ACS-equivalent quirks
> >>> in the code.  If the root port provides neither of these, then all
> >>> devices downstream are grouped together as well as all peer root ports
> >>> in the same PCI slot and all devices downstream of those.  If a
> >>> multifunction endpoint does not provide ACS or equivalent quirks, the
> >>> functions will be grouped together. Not all endpoint devices or systems
> >>> are designed for minimum possible granularity.  You can learn more
> >>> here[1].  Thanks,
> >>>
> >>> Alex
> >>>
> >>> [1] http://vfio.blogspot.com/2014/08/iommu-groups-inside-and-out.html  
> >>
> >> Hi Alex,
> >>
> >> Thank you for the detailed reply. The background information you provided
> >> makes it very clear why the devices I mentioned in my e-mail ended up in the
> >> same IOMMU group.
> >>
> >> But it seems that I was not clear enough in my original e-mail. My concern is
> >> that a user space action (modprobe) should never trigger a kernel BUG(). Is
> >> there any way to make sure that the sequence of actions I performed causes
> >> modprobe to fail with an error code instead of triggering a kernel BUG()?  
> > 
> > Loading modules is privileged:
> > 
> > $ modprobe vfio-pci
> > modprobe: ERROR: could not insert 'vfio_pci': Operation not permitted
> > 
> > Granting a device to a user for device assignment purposes is also a
> > privileged operation.  Can you describe a scenario where this is
> > reachable without elevated privileges?  The driver core maintainer has
> > indicated previously that manipulation of driver binding is effectively
> > at your own risk.  It's entirely possible to bind devices to the wrong
> > driver creating all sorts of bad behavior.  In this case, it appears
> > that the system has been improperly configured if devices from a user
> > owned group can accidentally be bound to host drivers.  Thanks,  
> 
> The fundamental problem seems to be that VFIO is checking the viability 
> of a group a bit too late, or not being strict enough to begin with. 
> I've just reproduced much the equivalent thing on an arm64 system where 
> I have a single group containing 2 real devices (plus a bunch of bridges):
> 
>    echo 0000:03:00.0 > /sys/bus/pci/devices/0000:03:00.0/driver/unbind
>    echo 0000:08:00.0 > /sys/bus/pci/devices/0000:08:00.0/driver/unbind
> 
>    echo $VID $DID > /sys/bus/pci/drivers/vfio-pci/new_id #IDs for 08:00.0
> 
>    lkvm run Image --vfio-pci 08:00.0 ...
>    # guest runs...
> 
> Then back on the host,
> 
>    echo 0000:03:00.0 > /sys/bus/pci/drivers_probe
> 
> and bang:
> 
>    [ 1091.768165] ------------[ cut here ]------------
>    [ 1091.772732] kernel BUG at drivers/vfio/vfio.c:759!
>    [ 1091.777472] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>    [ 1091.782898] Modules linked in:
>    [ 1091.785920] CPU: 1 PID: 1090 Comm: sh Not tainted 5.1.0-rc1+ #77
>    [ 1091.791862] Hardware name: ARM LTD ARM Juno Development 
> Platform/ARM Juno Development Platform, BIOS EDK II Feb 25 2019
>    [ 1091.802535] pstate: 60000005 (nZCv daif -PAN -UAO)
>    [ 1091.807279] pc : vfio_iommu_group_notifier+0x1c8/0x360
>    [ 1091.812361] lr : vfio_iommu_group_notifier+0x1c4/0x360
>    ...
> 
> Yes, they're all privileged operations so you can say "well don't do 
> that then", but it's still a rather unexpected behaviour. This is 
> actually slightly worse than Bart's case, since arm-smmu doesn't have an 
> equivalent to that BUG_ON() check in __intel_map_page(), so the host 
> driver for 03:00.0 may have successfully started DMA during probing and 
> potentially corrupted guest memory by that point. AFAICS, ideally in 
> this situation vfio_iommu_group_notifier() could catch 
> IOMMU_GROUP_NOTIFY_BIND_DRIVER and prevent any new drivers from binding 
> while the rest of the group is assigned, but at a glance there seems to 
> be some core plumbing missing to allow that to happen :/
> 
> Alternatively, maybe we could just tighten up and stop treating unbound 
> devices as viable - that certainly seems easier to implement, but 
> whether it impacts real use-cases I don't know.
> 
> I guess this comes down to that "TBD - interface for disabling driver 
> probing/locking a device." in Documentation/vfio.txt.

I've tried to fix this previously...

https://patchwork.kernel.org/patch/9799841/
https://lore.kernel.org/patchwork/patch/803695/

You can see in the first link where I've been advised that users
mucking with driver binding and things breaking is par for the course.
It's clearly not ideal to crash the kernel, but once the isolation has
already been broken, our options are limited.  At that point it's not
enough to kill the user process.  I tried a couple approaches to
prevent the situation and didn't get traction.  New ideas welcome.
Thanks,

Alex
