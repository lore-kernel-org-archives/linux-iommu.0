From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Thu, 10 Nov 2016 12:14:40 +0100
Message-ID: <ddd8af9d-ad8f-78d8-3048-3d640b74470e@redhat.com>
References: <582371FB.2040808@redhat.com> <20161109192303.GD15676@cbox>
	<20161109203145.GO17771@arm.com> <20161109151709.74927f83@t450s.home>
	<20161109222522.GS17771@arm.com> <20161109162458.39594fdb@t450s.home>
	<20161109233847.GT17771@arm.com> <20161109165957.62c1eb61@t450s.home>
	<83b6440a-31eb-c1b4-642c-a4c311f37ef2@redhat.com>
	<20161109175517.174e7803@t450s.home> <20161110020130.GA19108@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161110020130.GA19108-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will, Alex,

On 10/11/2016 03:01, Will Deacon wrote:
> On Wed, Nov 09, 2016 at 05:55:17PM -0700, Alex Williamson wrote:
>> On Thu, 10 Nov 2016 01:14:42 +0100
>> Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> On 10/11/2016 00:59, Alex Williamson wrote:
>>>> On Wed, 9 Nov 2016 23:38:50 +0000
>>>> Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>>>>> On Wed, Nov 09, 2016 at 04:24:58PM -0700, Alex Williamson wrote:  
>>>>>> The VFIO_IOMMU_MAP_DMA ioctl is a contract, the user ask to map a range
>>>>>> of IOVAs to a range of virtual addresses for a given device.  If VFIO
>>>>>> cannot reasonably fulfill that contract, it must fail.  It's up to QEMU
>>>>>> how to manage the hotplug and what memory regions it asks VFIO to map
>>>>>> for a device, but VFIO must reject mappings that it (or the SMMU by
>>>>>> virtue of using the IOMMU API) know to overlap reserved ranges.  So I
>>>>>> still disagree with the referenced statement.  Thanks,    
>>>>>
>>>>> I think that's a pity. Not only does it mean that both QEMU and the kernel
>>>>> have more work to do (the former has to carve up its mapping requests,
>>>>> whilst the latter has to check that it is indeed doing this), but it also
>>>>> precludes the use of hugepage mappings on the IOMMU because of reserved
>>>>> regions. For example, a 4k hole someplace may mean we can't put down 1GB
>>>>> table entries for the guest memory in the SMMU.
>>>>>
>>>>> All this seems to do is add complexity and decrease performance. For what?
>>>>> QEMU has to go read the reserved regions from someplace anyway. It's also
>>>>> the way that VFIO works *today* on arm64 wrt reserved regions, it just has
>>>>> no way to identify those holes at present.  
>>>>
>>>> Sure, that sucks, but how is the alternative even an option?  The user
>>>> asked to map something, we can't, if we allow that to happen now it's a
>>>> bug.  Put the MSI doorbells somewhere that this won't be an issue.  If
>>>> the platform has it fixed somewhere that this is an issue, don't use
>>>> that platform.  The correctness of the interface is more important than
>>>> catering to a poorly designed system layout IMO.  Thanks,  
>>>
>>> Besides above problematic, I started to prototype the sysfs API. A first
>>> issue I face is the reserved regions become global to the iommu instead
>>> of characterizing the iommu_domain, ie. the "reserved_regions" attribute
>>> file sits below an iommu instance (~
>>> /sys/class/iommu/dmar0/intel-iommu/reserved_regions ||
>>> /sys/class/iommu/arm-smmu0/arm-smmu/reserved_regions).
>>>
>>> MSI reserved window can be considered global to the IOMMU. However PCIe
>>> host bridge P2P regions rather are per iommu-domain.
> 
> I don't think we can treat them as per-domain, given that we want to
> enumerate this stuff before we've decided to do a hotplug (and therefore
> don't have a domain).
That's the issue indeed. We need to wait for the PCIe device to be
connected to the iommu. Only on the VFIO SET_IOMMU we get the
comprehensive list of P2P regions that can impact IOVA mapping for this
iommu. This removes any advantage of sysfs API over previous VFIO
capability chain API for P2P IOVA range enumeration at early stage.

> 
>>>
>>> Do you confirm the attribute file should contain both global reserved
>>> regions and all per iommu_domain reserved regions?
>>>
>>> Thoughts?
>>
>> I don't think we have any business describing IOVA addresses consumed
>> by peer devices in an IOMMU sysfs file.  If it's a separate device it
>> should be exposed by examining the rest of the topology.  Regions
>> consumed by PCI endpoints and interconnects are already exposed in
>> sysfs.  In fact, is this perhaps a more accurate model for these MSI
>> controllers too?  Perhaps they should be exposed in the bus topology
>> somewhere as consuming the IOVA range.
Currently on x86 the P2P regions are not checked when allowing
passthrough. Aren't we more papist that the pope? As Don mentioned,
shouldn't we simply consider that a platform that does not support
proper ACS is not candidate for safe passthrough, like Juno?

At least we can state the feature also is missing on x86 and it would be
nice to report the risk to the userspace and urge him to opt-in.

To me taking into account those P2P still is controversial and induce
the bulk of the complexity. Considering the migration use case discussed
at LPC while only handling the MSI problem looks much easier.
host can choose an MSI base that is QEMU mach-virt friendly, ie. non RAM
region. Problem is to satisfy all potential uses though. When migrating,
mach-virt still is being used so there should not be any collision. Am I
missing some migration weird use cases here? Of course if we take into
consideration new host PCIe P2P regions this becomes completely different.

We still have the good old v14 where the user space chose where MSI
IOVA's are put without any risk of collision ;-)

>>  If DMA to an IOVA is consumed
>> by an intermediate device before it hits the IOMMU vs not being
>> translated as specified by the user at the IOMMU, I'm less inclined to
>> call that something VFIO should reject.
> 
> Oh, so perhaps we've been talking past each other. In all of these cases,
> the SMMU can translate the access if it makes it that far. The issue is
> that not all accesses do make it that far, because they may be "consumed"
> by another device, such as an MSI doorbell or another endpoint. In other
> words, I don't envisage a scenario where e.g. some address range just
> bypasses the SMMU straight to memory. I realise now that that's not clear
> from the slides I presented.
> 
>> However, instantiating a VM
>> with holes to account for every potential peer device seems like it
>> borders on insanity.  Thanks,
> 
> Ok, so rather than having a list of reserved regions under the iommu node,
> you're proposing that each region is attributed to the device that "owns"
> (consumes) it? I think that can work, but we need to make sure that:
> 
>  (a) The topology is walkable from userspace (where do you start?)
> 
>  (b) It also works for platform (non-PCI) devices, that lack much in the
>      way of bus hierarchy
> 
>  (c) It doesn't require Linux to have a driver bound to a device in order
>      for the ranges consumed by that device to be advertised (again,
>      more of an issue for non-PCI).
Looks a long way ...

Thanks

Eric

> 
> How is this currently advertised for PCI? I'd really like to use the same
> scheme irrespective of the bus type.
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
