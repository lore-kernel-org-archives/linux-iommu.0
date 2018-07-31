From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Stop losing firmware-set DMA masks
Date: Tue, 31 Jul 2018 12:24:07 +0100
Message-ID: <1ccccc4b-7d4c-a3ee-23a2-f108916705e9@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<CAK8P3a3HDJ6svNN_cwvegxu20yNv8+tvc0D1A6Ooeq8agawbFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAK8P3a3HDJ6svNN_cwvegxu20yNv8+tvc0D1A6Ooeq8agawbFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On 29/07/18 13:32, Arnd Bergmann wrote:
> On Tue, Jul 24, 2018 at 12:16 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> Whilst the common firmware code invoked by dma_configure() initialises
>> devices' DMA masks according to limitations described by the respective
>> properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
>> the dma_set_mask() API leads to that information getting lost when
>> well-behaved drivers probe and set a 64-bit mask, since in general
>> there's no way to tell the difference between a firmware-described mask
>> (which should be respected) and whatever default may have come from the
>> bus code (which should be replaced outright). This can break DMA on
>> systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
>> only knows its maximum supported address size, not how many of those
>> address bits might actually be wired up between any of its input
>> interfaces and the associated DMA master devices. Similarly, some PCIe
>> root complexes only have a 32-bit native interface on their host bridge,
>> which leads to the same DMA-address-truncation problem in systems with a
>> larger physical memory map and RAM above 4GB (e.g. [2]).
>>
>> These patches attempt to deal with this in the simplest way possible by
>> generalising the specific quirk for 32-bit bridges into an arbitrary
>> mask which can then also be plumbed into the firmware code. In the
>> interest of being minimally invasive, I've only included a point fix
>> for the IOMMU issue as seen on arm64 - there may be further tweaks
>> needed in DMA ops (e.g. in arch/arm/ and other OF users) to catch all
>> possible incarnations of this problem, but at least any that I'm not
>> fixing here have always been broken. It is also noteworthy that
>> of_dma_get_range() has never worked properly for the way PCI host
>> bridges are passed into of_dma_configure() - I'll be working on
>> further patches to sort that out once this part is done.
> 
> Thanks a lot for working on this, this has bugged me for many years,
> and I've discussed possible solutions with lots of people over time.
> 
> I /think/ all your patches are good, but I'm currently travelling and don't
> have a chance to review the resulting overall implementation.
> Could you summarize what happens in the following corner cases of
> DT dma-ranges after your changes (with a driver not setting a mask,
> setting a 64-bit mask and setting a 24-bit mask, respectively)?
> 
> a) a device with no dma-ranges property anywhere in its parents
> b) a device with with a 64-bit dma-ranges translation in its parent
>     but none in its grandparent
> c) a device with no dma-ranges in its parent but a 64-bit mask
>     in its grandparent
> d) a device with a 24-bit mask in its parent.

In terms of the actual dma-ranges parsing, nothing should be changed by 
these patches, so the weirdness and inconsistency that I'm pretty sure 
exists for some of those cases will still be there for the moment - I'm 
starting on actually fixing of_dma_get_range() now.

The effect after these patches is that a device with a "valid" (per the 
current of_dma_get_range() implementation) dma-ranges translation gets 
it bus_dma_mask set to cover the given range, whereas a device with no 
valid dma-ranges effectively gets a 32-bit bus_dma_mask. That's slightly 
different from the ACPI default behaviour, due to subtle spec 
differences, but I think it's in line with what you've proposed before 
for DT, and it's certainly still flexible if anyone has a different 
view. The bus_dma_mask in itself should also be low-impact, since it 
will only currently be enforced in the generic dma-direct and iommu-dma 
paths, so the likes of powerpc shouldn't see any change at all just yet.

Robin.
