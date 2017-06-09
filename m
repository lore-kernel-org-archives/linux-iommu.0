From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 03/12] intel-ipu3: Add DMA API implementation
Date: Fri, 9 Jun 2017 15:20:53 +0900
Message-ID: <CAAFQd5A=PLHXCA60Rv1T1A=kKQRg4AC3hd-NC798dkqQBJZj3Q@mail.gmail.com>
References: <1496695157-19926-1-git-send-email-yong.zhi@intel.com>
	<1496695157-19926-4-git-send-email-yong.zhi@intel.com>
	<CAAFQd5CLXUsDv6H1C22tc4qjG9e7tm5jtxwYBjV5gx9qrDw50A@mail.gmail.com>
	<73992991-65a9-915b-a450-b23aeb3baaed@arm.com>
	<CAAFQd5AWGN_qSXGG32D-eWKZRoRme+XCD9v1r8qJ5bthtS9z9w@mail.gmail.com>
	<949a467a-e711-d746-859d-fc006bf59773@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <949a467a-e711-d746-859d-fc006bf59773-5wv7dgnIgG8@public.gmane.org>
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
Cc: "Zheng, Jian Xu" <jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Toivonen, Tuukka" <tuukka.toivonen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mani,
	Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 9, 2017 at 3:07 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 08/06/17 15:35, Tomasz Figa wrote:
>> On Thu, Jun 8, 2017 at 10:22 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>>> On 07/06/17 10:47, Tomasz Figa wrote:
>>>> Hi Yong,
>>>>
>>>> +Robin, Joerg, IOMMU ML
>>>>
>>>> Please see my comments inline.
>>>>
>>>> On Tue, Jun 6, 2017 at 5:39 AM, Yong Zhi <yong.zhi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> [snip]
>>>>> +
>>>>> +/* End of things adapted from arch/arm/mm/dma-mapping.c */
>>>>> +static void ipu3_dmamap_sync_single_for_cpu(struct device *dev,
>>>>> +                                           dma_addr_t dma_handle, size_t size,
>>>>> +                                           enum dma_data_direction dir)
>>>>> +{
>>>>> +       struct ipu3_mmu *mmu = to_ipu3_mmu(dev);
>>>>> +       dma_addr_t daddr = iommu_iova_to_phys(mmu->domain, dma_handle);
>>>>> +
>>>>> +       clflush_cache_range(phys_to_virt(daddr), size);
>>>>
>>>> You might need to consider another IOMMU on the way here. Generally,
>>>> given that daddr is your MMU DMA address (not necessarily CPU physical
>>>> address), you should be able to call
>>>>
>>>> dma_sync_single_for_cpu(<your pci device>, daddr, size, dir)
>>>
>>> I'd hope that this IPU complex is some kind of embedded endpoint thing
>>> that bypasses the VT-d IOMMU or is always using its own local RAM,
>>> because it would be pretty much unworkable otherwise.
>>
>> It uses system RAM and, as far as my understanding goes, by default it
>> operates without the VT-d IOMMU and that's how it's used right now.
>
> OK, if it *is* behind a DMAR unit then booting with "iommu=force" (or
> whatever the exact incantation for intel-iommu is) should be fun...
>
>> I'm suggesting VT-d IOMMU as a way to further strengthen the security
>> and error resilience in future (due to the IPU complex being
>> non-coherent and also running a closed source firmware).
>
> TBH, doing DMA remapping through *two* IOMMUS will add horrible hardware
> overhead,

Not necessarily, if done right and with right hardware (I lack the
details about Intel hardware unfortunately). One can for example
notice the fact that the IOVA ranges from the parent IOMMU are going
to be contiguous for the child IOMMU, so one could use huge pages in
the child IOMMU and essentially make a selective 1:1 mapping.

> increase the scope for kernel-side bugs, and not much more. If
> we don't trust this IOMMU to behave, why are we trying to drive it in
> the first place? If we do, then a second IOMMU behind it won't protect
> anything that the first one doesn't already.

That's a valid point, right. But on the other hand, I lack the
hardware details on whether we can just disable the internal IOMMU and
use DMAR alone instead.

>
>>> The whole
>>> infrastructure isn't really capable of dealing with nested IOMMUs, and
>>> nested DMA ops would be an equally horrible idea.
>>
>> Could you elaborate a bit more on this? I think we should be able to
>> deal with this in a way I suggested before:
>>
>> a) the PCI device would use the system DMA ops,
>> b) the PCI device would implement a secondary bus for which it would
>> provide its own DMA and IOMMU ops.
>> c) a secondary device would be registered on the secondary bus,
>> d) all memory for the IPU would be managed on behalf of the secondary device.
>>
>> In fact, the driver already is designed in a way that all the points
>> above are true. If I'm not missing something, the only significant
>> missing point is calling into system DMA ops from IPU DMA ops.
>
> I don't believe x86 has any non-coherent DMA ops, therefore the IPU DMA
> ops would still probably have to do all their own cache maintenance.

I'd argue that it means that we need to add non-coherent DMA ops on
x86, as we have on other archs, which can have both coherent and
non-coherent devices in the same system.

> Allocation/mapping, though, would have to be done with the parent DMA
> ops first (in case DMA address != physical address), *then* mapped at
> the IPU MMU, which is the real killer - if the PCI DMA ops are from
> intel-iommu, then there's little need for the IPU MMU mapping to be
> anything other than 1:1, so you may as well not bother.

Okay, I think I can agree with you on this. It indeed makes little
sense to use both MMUs at the same time, if there is a way to disable
one of them.

Let's just keep this unaware of DMAR at this point of time, as a
starter, and get back to it later whenever someone wants to use DMAR
instead. I guess the way to proceed then would be either disabling the
internal MMU, if possible, or making it use a 1:1 (huge page, if
possible) mapping, if not.

> If the PCI DMA
> ops are from SWIOTLB, then the constraints of having to go through that
> first eliminate all the scatter-gather benefit of the IPU MMU.

Does the SWIOTLB give you a physically contiguous memory? If not, you
still need the IPU MMU to actually be able to access the memory.

>
> The IOMMU API ops would have to be handled similarly, by checking for
> ops on the parent bus, calling those first if present, then running the
> intermediate results through the IPU MMU's own functions. Sure, it's not
> impossible, but it's really really grim. Not to mention that all the IPU
> MMU's page tables/control structures/etc. would also have to be
> DMA-allocated/mapped because it may or may not be operating in physical
> address space.

DMA-allocation isn't really good for this use case, but is a DMA
mapping operation really such a bad thing?

>
> The reasonable option - assuming the topology really is this way - would
> seem to be special-casing the IPU in intel-iommu in a similar manner to
> integrated graphics, to make sure it gets a passthrough domain for DMA
> ops, but still allowing the whole PCI device to be passed through to a
> guest VM via VFIO if desired (which is really the only case where nested
> translation does start to make sense).

Yeah, given that we need some start, it sounds sane to me. We can then
revisit different options later. Thanks a lot for your input.

Best regards,
Tomasz
