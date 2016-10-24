From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v14 00/16] KVM PCIe/MSI passthrough on ARM/ARM64
Date: Mon, 24 Oct 2016 20:39:40 +0100
Message-ID: <452b773f-826b-61cd-55e3-018ecb34b503@arm.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
	<20161020173224.GA32544@arm.com>
	<8132b350-59ff-0bfb-9539-e98e63d1adb6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8132b350-59ff-0bfb-9539-e98e63d1adb6-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 21/10/16 10:26, Auger Eric wrote:
> Hi Will,
> 
> On 20/10/2016 19:32, Will Deacon wrote:
>> Hi Eric,
>>
>> Thanks for posting this.
>>
>> On Wed, Oct 12, 2016 at 01:22:08PM +0000, Eric Auger wrote:
>>> This is the second respin on top of Robin's series [1], addressing Alex' comments.
>>>
>>> Major changes are:
>>> - MSI-doorbell API now is moved to DMA IOMMU API following Alex suggestion
>>>   to put all API pieces at the same place (so eventually in the IOMMU
>>>   subsystem)
>>> - new iommu_domain_msi_resv struct and accessor through DOMAIN_ATTR_MSI_RESV
>>>   domain with mirror VFIO capability
>>> - more robustness I think in the VFIO layer
>>> - added "iommu/iova: fix __alloc_and_insert_iova_range" since with the current
>>>   code I failed allocating an IOVA page in a single page domain with upper part
>>>   reserved
>>>
>>> IOVA range exclusion will be handled in a separate series
>>>
>>> The priority really is to discuss and freeze the API and especially the MSI
>>> doorbell's handling. Do we agree to put that in DMA IOMMU?
>>>
>>> Note: the size computation does not take into account possible page overlaps
>>> between doorbells but it would add quite a lot of complexity i think.
>>>
>>> Tested on AMD Overdrive (single GICv2m frame) with I350 VF assignment.
>>
>> Marc, Robin and I sat down and had a look at the series and, whilst it's
>> certainly addressing a problem that we desperately want to see fixed, we
>> think that it's slightly over-engineering in places and could probably
>> be simplified in the interest of getting something upstream that can be
>> used as a base, on which the ABI can be extended as concrete use-cases
>> become clear.
>>
>> Stepping back a minute, we're trying to reserve some of the VFIO virtual
>> address space so that it can be used by devices to map their MSI doorbells
>> using the SMMU. With your patches, this requires that (a) the kernel
>> tells userspace about the size and alignment of the doorbell region
>> (MSI_RESV) and (b) userspace tells the kernel the VA-range that can be
>> used (RESERVED_MSI_IOVA).
>>
>> However, this is all special-cased for MSI doorbells and there are
>> potentially other regions of the VFIO address space that are reserved
>> and need to be communicated to userspace as well. We already know of
>> hardware where the PCI RC intercepts p2p accesses before they make it
>> to the SMMU, and other hardware where the MSI doorbell is at a fixed
>> address. This means that we need a mechanism to communicate *fixed*
>> regions of virtual address space that are reserved by VFIO. I don't
>> even particularly care if VFIO_MAP_DMA enforces that, but we do need
>> a way to tell userspace "hey, you don't want to put memory here because
>> it won't work well with devices".
> 
> I think we all agree on this. Exposing an API to the user space
> reporting *fixed* reserved IOVA ranges is a requirement anyway. The
> problem was quite clearly stated by Alex in
> http://lkml.iu.edu/hypermail/linux/kernel/1610.0/03308.html
> (VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE)
> 
> I started working on this VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> capability but to me and I think according to Alex, it was a different
> API from MSI_RESV.
> 
>>
>> In that case, we end up with something like your MSI_RESV capability,
>> but actually specifying a virtual address range that is simply not to
>> be used by MAP_DMA -- we don't say anything about MSIs. Now, taking this
>> to its logical conclusion, we no longer need to distinguish between
>> remappable reserved regions and fixed reserved regions in the ABI.
>> Instead, we can have the kernel allocate the virtual address space for
>> the remappable reserved regions (probably somewhere in the bottom 4GB)
>> and expose them via the capability.
> 
> 
> If I understand correctly you want the host to arbitrarily choose where
> it puts the iovas reserved for MSI and not ask the userspace.
> 
> Well so we are back to the discussions we had in Dec 2015 (see Marc's
> answer in http://thread.gmane.org/gmane.comp.emulators.kvm.arm.devel/3858).

To an extent, yes, however the difference is that we now know we
definitely have to deal with situations in which userspace *cannot* be
in total control of the memory map, and that changes the game:

    _________
   /         \
  /  Fixed    \
 /  things (A) \
(   _________   )
 \ /   MSI   \ /
  X doorbells X
 / \___(B)___/ \
(               )
 \ Remappable  /
  \ things (C)/
   \_________/

In the absence of A, then B == C so it was very hard to not want to
implement C. As soon as A *has* to be implemented for other reasons,
then that is also sufficient to encompass B. C can still be implemented
later as a nice-to-have, but is not necessary to get B off the ground.

> - So I guess you will init an iova_domain seomewhere below the 4GB to
> allocate the MSIs. what size are you going to choose. Don't you have the
> same need to dimension the iova range.
> - we still need to assess the MSI assignment safety. How will we compute
> safety for VFIO?

Absolutely. We're talking in general terms of the userspace ABI here,
although that can't help but colour the underlying implementation
decisions. Of course the VFIO internals still have to handle the
specific case of MSIs, but that's basically no more than this:

  static bool msi_isolation = true; /* until proven otherwise */
  static unsigned long msi_remap_virt_base = 0x08000000; /* fits QEMU */
  static size_t msi_remap_size;

  vfio_msi_thing_callback(thing) {
  	msi_remap_size += thing->info.size;
  	msi_isolation &= thing->info.flags & PROVIDES_ISOLATION;
  }

  vfio_msi_init(...) {
  	...
  #ifdef CONFIG_X86
  	msi_remap_virt_base = 0xfee00000;
  	msi_remap_size = 0x100000;
  	msi_isolation = irq_remapping_enabled;
  #else
  	irq_for_each_msi_thing(vfio_msi_thing_callback);
  #endif
  	...
  }

  vfio_attach_group(...) {
  	...
  	if (!msi_isolation && !allow_unsafe_interrupts)
  		return -ENOWAY;
  	...
  	get_msi_region_cookie(domain, msi_remap_base, msi_remap_size);
  	...
  }

And when a well-behaved userspace queries the reserved regions, that
base address and size is just one of potentially several that it should
get back. It's that "querying the reserved regions" bit that needs to be
gotten right first time.

Note that at this point I'm no longer even overly bothered about the
details of irq_for_each_msi_thing(), as it's an internal kernel
interface and thus malleable, although obviously the simpler the better.
I have to say Punit's idea of iterating irq_domains does actually look
really neat and tidy as a proof-of-concept, and also makes me think off
on a tangent that it would be sweet to be able to retrieve base+size
from dev->msi_domain to pre-allocate MSI pages in default domains, and
obviate the compose 'failure' case.

>  This simplifies things in the
>> following ways:
>>
>>   * You don't need to keep track of MSI vs DMA addresses in the VFIO rbtree
> right: I guess you rely on iommu_map to return an error in case the iova
> is already mapped somewhere else.
>>   * You don't need to try collapsing doorbells into a single region
> why? at host level I guess you will init a single iova domain?

Yeah, right now this one goes either way - as things stand, it does make
life easier on the host side to make a single region to hang off the
back of the current iova_cookie magic, and as illustrated above it's
possibly the most trivial part of the whole thing, but the point is we
still don't *need* to. Since a userspace ABI for generic reservations
has to be able handle more than one region for the sake of non-MSI
things, we'd be free to change the kernel-side implementation in future
to just report multiple doorbells as individual regions - for starters,
if and when we add dynamic reservations and userspace gets to pick its
own IOVAs for those, it'll be a damn sight easier *not* to coalesce
everything.

>>   * You don't need a special MAP flavour to map MSI doorbells
> right
>>   * The ABI is reusable for PCI p2p and fixed doorbells
> right
> 
> Aren't we moving the issue at user-space? Currently QEMU mach-virt
> address space is fully static. Adapting mach-virt to adjust to host
> constraints is not straightforward. It is simple to reject the
> assignment in case of collision but more difficult to react positively.

The point is that we *have* to move at least some of the issue to
userspace, and by then I'm struggling to see any real difference between
these situations:

a) QEMU asks VFIO to map some pages for DMA, gets an error back because
VFIO detects it conflicts with a reserved region, and gives up.
b) QEMU starts by asking VFIO what regions are reserved, realises they
will overlap with its hard-coded RAM address, and gives up.

where (a) requires a bunch of kernel machinery to second-guess
userspace, while (b) simply relies on userspace not being broken. And if
userspace fails at not being broken, then we simply retain the behaviour
which actually happens right now:

c) QEMU maps some pages for DMA at the same address as PCI config space
on the underlying hardware. Hilarity ensues.

Of course, userspace could be anything other than QEMU as well, so it's
not necessarily second-guessable at all; maybe we make the arbitrary
msi_remap_virt_base a VFIO module parameter to be more accommodating.
Who knows, maybe it turns out that's enough to keep users happy and we
never need to implement fully dynamic reservations.

Robin.

>> I really think it would make your patch series both generally useful and
>> an awful lot smaller, whilst leaving the door open to ABI extension on
>> a case-by-case basis when we determine that it's really needed.
> 
> I would like to have a better understanding of how you assess the
> security and dimension the iova domain. This is the purpose of msi
> doorbell registration, which is not neat at all I acknowledge but well I
> did not find any other solution and did not get any other suggestion.
> Besides I think the per-cpu thing is over-engineered and this can
> definitively be simplified.
> 
> VFIO part was reviewed by Alex and I don't have the impression that this
> is the blocking part. besides there is on iova.c fix,
> IOMMU_CAP_INTR_REMAP removal; so is it really over-complicated?
> 
> Thanks
> 
> Eric
> 
>>
>> Thoughts?
>>
>> Will
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
