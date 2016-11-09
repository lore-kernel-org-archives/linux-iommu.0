From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Wed, 9 Nov 2016 08:43:12 +0100
Message-ID: <001659cd-5806-7729-8cea-dd6982010c9f@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
	<20161103220205.37715b49@t450s.home> <20161108024559.GA20591@arm.com>
	<dae12190-1eb6-20a9-5740-9e5be8bb65fc@redhat.com>
	<20161108175457.GK20591@arm.com> <5822214F.2070500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5822214F.2070500-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,
On 08/11/2016 20:02, Don Dutile wrote:
> On 11/08/2016 12:54 PM, Will Deacon wrote:
>> On Tue, Nov 08, 2016 at 03:27:23PM +0100, Auger Eric wrote:
>>> On 08/11/2016 03:45, Will Deacon wrote:
>>>> Rather than treat these as separate problems, a better interface is to
>>>> tell userspace about a set of reserved regions, and have this include
>>>> the MSI doorbell, irrespective of whether or not it can be remapped.
>>>> Don suggested that we statically pick an address for the doorbell in a
>>>> similar way to x86, and have the kernel map it there. We could even
>>>> pick
>>>> 0xfee00000. If it conflicts with a reserved region on the platform (due
>>>> to (4)), then we'd obviously have to (deterministically?) allocate it
>>>> somewhere else, but probably within the bottom 4G.
>>> This is tentatively achieved now with
>>> [1] [RFC v2 0/8] KVM PCIe/MSI passthrough on ARM/ARM64 - Alt II
>>> (http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1264506.html)
>>>
>> Yup, I saw that fly by. Hopefully some of the internals can be reused
>> with the current thinking on user ABI.
>>
>>>> The next question is how to tell userspace about all of the reserved
>>>> regions. Initially, the idea was to extend VFIO, however Alex pointed
>>>> out a horrible scenario:
>>>>
>>>>    1. QEMU spawns a VM on system 0
>>>>    2. VM is migrated to system 1
>>>>    3. QEMU attempts to passthrough a device using PCI hotplug
>>>>
>>>> In this scenario, the guest memory map is chosen at step (1), yet there
>>>> is no VFIO fd available to determine the reserved regions. Furthermore,
>>>> the reserved regions may vary between system 0 and system 1. This
>>>> pretty
>>>> much rules out using VFIO to determine the reserved regions.Alex
>>>> suggested
>>>> that the SMMU driver can advertise the regions via
>>>> /sys/class/iommu/. This
>>>> would solve part of the problem, but migration between systems with
>>>> different memory maps can still cause problems if the reserved regions
>>>> of the new system conflict with the guest memory map chosen by QEMU.
>>>
>>> OK so I understand we do not want anymore the VFIO chain capability API
>>> (patch 5 of above series) but we prefer a sysfs approach instead.
>> Right.
>>
>>> I understand the sysfs approach which allows the userspace to get the
>>> info earlier and independently on VFIO. Keeping in mind current QEMU
>>> virt - which is not the only userspace - will not do much from this info
>>> until we bring upheavals in virt address space management. So if I am
>>> not wrong, at the moment the main action to be undertaken is the
>>> rejection of the PCI hotplug in case we detect a collision.
>> I don't think so; it should be up to userspace to reject the hotplug.
>> If userspace doesn't have support for the regions, then that's fine --
>> you just end up in a situation where the CPU page table maps memory
>> somewhere that the device can't see. In other words, you'll end up with
>> spurious DMA failures, but that's exactly what happens with current
>> systems
>> if you passthrough an overlapping region (Robin demonstrated this on
>> Juno).
>>
>> Additionally, you can imagine some future support where you can tell the
>> guest not to use certain regions of its memory for DMA. In this case, you
>> wouldn't want to refuse the hotplug in the case of overlapping regions.
>>
>> Really, I think the kernel side just needs to enumerate the fixed
>> reserved
>> regions, place the doorbell at a fixed address and then advertise these
>> via sysfs.
>>
>>> I can respin [1]
>>> - studying and taking into account Robin's comments about dm_regions
>>> similarities
>>> - removing the VFIO capability chain and replacing this by a sysfs API
>> Ideally, this would be reusable between different SMMU drivers so the
>> sysfs
>> entries have the same format etc.
>>
>>> Would that be OK?
>> Sounds good to me. Are you in a position to prototype something on the
>> qemu
>> side once we've got kernel-side agreement?
yes sure.
>>
>>> What about Alex comments who wanted to report the usable memory ranges
>>> instead of unusable memory ranges?
>>>
>>> Also did you have a chance to discuss the following items:
>>> 1) the VFIO irq safety assessment
>> The discussion really focussed on system topology, as opposed to
>> properties
>> of the doorbell. Regardless of how the device talks to the doorbell, if
>> the doorbell can't protect against things like MSI spoofing, then it's
>> unsafe. My opinion is that we shouldn't allow passthrough by default on
>> systems with unsafe doorbells (we could piggyback on
>> allow_unsafe_interrupts
>> cmdline option to VFIO).
OK.
>>
>> A first step would be making all this opt-in, and only supporting GICv3
>> ITS for now.
> You're trying to support a config that is < GICv3 and no ITS ? ...
> That would be the equiv. of x86 pre-intr-remap, and that's why
> allow_unsafe_interrupts
> hook was created ... to enable devel/kick-the-tires.
>>> 2) the MSI reserved size computation (is an arbitrary size OK?)
>> If we fix the base address, we could fix a size too. However, we'd still
>> need to enumerate the doorbells to check that they fit in the region we
>> have. If not, then we can warn during boot and treat it the same way as
>> a resource conflict (that is, reallocate the region in some deterministic
>> way).
OK

Thanks

Eric
>>
>> Will
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
