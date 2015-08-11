From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 2/3] arm64: Add IOMMU dma_ops
Date: Tue, 11 Aug 2015 21:15:51 +0100
Message-ID: <55CA57F7.1070000@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
	<8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
	<20150807085233.GV14980@8bytes.org> <55C4CE7C.7050205@arm.com>
	<20150811094951.GD14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150811094951.GD14980-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 11/08/15 10:49, Joerg Roedel wrote:
> On Fri, Aug 07, 2015 at 04:27:56PM +0100, Robin Murphy wrote:
>> As per the comments, the issue here lies in the order in which the
>> OF/driver core code currently calls things for platform devices: as
>> it stands we can't attach the device to a domain in
>> arch_setup_dma_ops() because it doesn't have a group, and we can't
>> even add it to a group ourselves because it isn't fully created and
>> doesn't exist in sysfs yet. The only reason arch/arm is currently
>> getting away without this workaround is that the few IOMMU drivers
>> there hooked up to the generic infrastructure don't actually mind
>> that they get an attach_device from arch_setup_dma_ops() before
>> they've even seen an add_device (largely because they don't care
>> about groups).
>
> Hmm, what about just registering the iommu-driver in arch_setup_dma_ops
> with bus_set_iommu and not care about devices? The code will iterate
> over the devices already on the bus and tries to attach them to the
> iommu driver. But as you said, the devices are not yet on the bus, so
> when a device is later added by the OF/driver core code you can do
> everything needed for the device in the add_device call-back.

The main problem here is that "the bus" turns out to be a nebulous and 
poorly-defined thing. "The PCI bus" breaks down as soon as you have 
multiple host controllers - you could quite easily build a SoC/chipset 
where not all the host controllers/root complexes are behind IOMMUs, or 
some are behind different types of IOMMU, and then what? The "platform 
bus" is just a glorified holding pen for device structures and utterly 
useless as any kind of abstraction.

Since I'm not concerning myself with PCI at the moment; considering the 
perspective of "the" IOMMU driver on the platform bus (assuming said 
driver is up and running first, either via OF_DECLARE or deferred 
probing of masters), the issues with relying on the add_device callback 
from the bus notifier alone are:

1) We get these callbacks for everything - devices behind one of our 
IOMMUs, devices behind different IOMMUs, devices with no IOMMU in their 
path at all - with nothing but a struct device pointer to try to 
distinguish one from the other.

2) Even for the devices actually relevant to us, we don't easily have 
the details we need to be able to set it up. In the PCI case, it's 
simple because the device has one bus ID which can trivially be looked 
up by common code; if you have driver-specific ACPI tables that identify 
platform devices and give them a single ID that you can kind of handle 
like a PCI device, fair enough; in the more general DT case, though, 
devices are going to have have any number of arbitrary IDs plus who 
knows what other associated data.

Now, both of those could probably be handled by having a big mess of 
open-coded DT parsing in every IOMMU driver's add_device, but that's 
exactly the kind of thing that having a generic DT binding should avoid. 
The generic binding is good enough to express most such arbitrary data 
pretty well, and even crazy stuff like a single device mastering through 
multiple IOMMUs with different IDs, so there's every argument for 
keeping the DT parsing generic and in core code. That's what the 
of_xlate infrastructure does: the appropriate IOMMU driver gets one or 
more of_xlate calls for a master device, from which it can collate all 
the "bus" information it needs, then later it gets the add_device 
callback once the device exists, at which point it can retrieve that 
data and use it to set up the device, allocate a group, etc.

If allocating a group for a platform device automatically set up a DMA 
mapping domain and attached it, then we wouldn't need to do anything 
with domains in arch_setup_dma_ops and the ordering problem vanishes. 
However, the drivers can't support DMA domains without a dma_ops 
implementation to back them up, which needs the DMA mapping code, which 
needs DMA domains in order to work... Hence the initial need to 
bootstrap the process via fake DMA domains in the arch code, enabling 
steady incremental development instead of one massive wide-reaching 
patch dump that's virtually impossible for me to test well and for 
others to develop against.

> This might include initializing the hardware iommu needed for the
> device and setting its per-device dma_ops.

I'm not sure that feels appropriate for our situation - If your IOMMU is 
tightly integrated into the I/O hub which forms your CPU's only 
connection to the outside world, then having it do architectural things 
seems reasonable. The kind of IOMMUs I'm dealing with here, however, are 
either just some IP block that you stitch into your SoC's mess of 
interconnects somewhere like any other peripheral (to keep your legacy 
32-bit devices behind), or even just a simple TLB with a page table 
walker and some control registers which you integrate directly into your 
own bigger devices. The latter are not really even general-purpose 
enough for arbitrary IOMMU API use, but treating them as separate IOMMUs 
makes sense from a common-driver perspective.

Having drivers for those kinds of IOMMU do things like setting dma_ops 
directly when they aren't even necessarily tied to a particular CPU 
architecture, and may have to coexist with drivers for incompatible 
IOMMUs in the same system, sounds like a recipe for tons of duplicated 
code and horrible hacks. I think on DT-based systems we *have* to keep 
system topology and device infrastructure handling in the core OF code 
and not have IOMMU drivers reinventing funnily-shaped and conflicting 
wheels all over the place.

>> Laurent's probe-deferral series largely solves these problems in the
>> right place - adding identical boilerplate code to every IOMMU
>> driver to do something they shouldn't have to know about (and don't
>> necessarily have all the right information for) is exactly what we
>> don't want to do. As discussed over on another thread, I'm planning
>> to pick that series up and polish it off after this, but my top
>> priority is getting the basic dma_ops functionality into arm64 that
>> people need right now. I will be only too happy when I can submit
>> the patch removing this notifier workaround ;)
>
> I've experienced it often that someone promises me to fix things later,
> but that it doesn't happen then, so please understand that I am pretty
> cautious about adding such hacks ;)

Oh, I understand completely - that's why I've tried as much as possible 
to keep all the workarounds out of the core code and local to arm64 
where it's easier for us to remove them cleanly. If it's any 
consolation, said patch is already written:

http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=af0110ed070c13417023ca7a560dc43e9d1c46f7

(the aforementioned rough WIP branch, from which I'm hoping to pull 
together an RFC for -rc1)

>> No driver other than the AMD IOMMU has any support yet. Support for
>> IOMMU_DOMAIN_DMA can easily be added to existing drivers based on
>> patch 1 of this series, but more generally it's not entirely clear
>> how default domains are going to work beyond x86. On systems like
>> Juno or Seattle with different sets of masters behind different
>> IOMMU instances (with limited domain contexts each), the most
>> sensible approach would be to have a single default domain per IOMMU
>> (spanning domains across instances would need some hideous
>> synchronisation logic for some implementations), but the current
>> domain_alloc interface gives us no way to do that. On something like
>> RK3288 with two different types of IOMMU on the platform "bus", it
>> breaks down even further as there's no way to guarantee that
>> iommu_domain_alloc() even gives you a domain from the right *driver*
>> (hence bypassing it by going through ops directly here).
>
> Default domain allocation comes down to how the bus organizes its
> iommu-groups. For every group (at least in its current design) a default
> domain is allocated. An a group is typically only behind a single iommu
> instance.

Default-domain-per-group is great for device isolation, but the main 
thing people seem to want on ARM is the opposite of that - assembling 
big bits of virtually-contiguous memory that are visible to all the 
devices that need to share them. Per-IOMMU (or even per-system if 
appropriate) default domains provide a really neat solution for that 
use-case and mean we could mostly completely remove the IOMMU-specific 
code from GPU drivers, which is one of the things standing in the way of 
having arch/arm share the common implementation.

I'll note that limited contexts aren't a made-up consideration either. 
The PCIe SMMU in my Juno can support a maximum of 4 domains, yet the bus 
has onboard LAN and SATA plus 4 slots...

>> Only for PCI devices, via iommu_group_get_for_pci_dev(). The code
>> here, however, only runs for platform devices - ops will be always
>> null for a PCI device since of_iommu_configure() will have bailed
>> out (see the silly warning removed by my patch you picked up the
>> other day). Once iommu_group_get_for_dev() supports platform
>> devices, this too can go away. In the meantime if someone adds PCI
>> support to of_iommu_configure() and IOMMU_DOMAIN_DMA support to
>> their IOMMU driver, then we'll get a domain back from
>> iommu_get_domain_for_dev() and just use that.
>
> What is the plan for getting an iommu-groups implementation for the
> platform bus?

The realistic options are trying to handle it with logic in the drivers 
(engenders code duplication, has potentially unsolvable ordering issues) 
or defining groups statically in DT via a new binding (needs to avoid 
being too much of a Linux-specific implementation detail). I tried 
prototyping the former ages ago and it got overcomplicated very quickly. 
Having considered the static DT method more recently, I've sketched out 
some ideas for a binding and a rough design for the code, but nothing's 
actually written yet. It is another of the "make stuff work on arm64" 
balls I have in the air, though, if only because the USB SMMU on Juno is 
otherwise unusable (well, unless you hack out one or other of the 
EHCI/OHCI pair).

Robin.
