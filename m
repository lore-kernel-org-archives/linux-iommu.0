From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC PATCH] of: Fix DMA configuration for non-DT masters
Date: Thu, 30 Mar 2017 15:42:16 +0530
Message-ID: <CAMSpPPeRs4vQ=HEEMLTYfVgXyz-bTgKpvA+85a6EhmPEc-EZyQ@mail.gmail.com>
References: <67d1f46172599be243405f4341665fd0ef9ab969.1490726288.git.robin.murphy@arm.com>
	<CAMSpPPfJKKRkuDKxUgVBdg7vp7Ux5=PiHSxnMLc7-LMcCSatzg@mail.gmail.com>
	<CAMSpPPcSWxua_6ECZd4iEbTiAYk-KtapBDcOUxNdGaQkFF-LOQ@mail.gmail.com>
	<b02ace9b-f8f3-269d-6db4-3c1b1ea1e816@arm.com>
	<CAMSpPPfw3+vDoD_rJD9Ny=kUtXf2v6Fm6Qksi=K=OEhfVNYy1Q@mail.gmail.com>
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMSpPPfw3+vDoD_rJD9Ny=kUtXf2v6Fm6Qksi=K=OEhfVNYy1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 30, 2017 at 8:51 AM, Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
> On Wed, Mar 29, 2017 at 11:12 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 29/03/17 06:46, Oza Oza wrote:
>>> On Wed, Mar 29, 2017 at 10:23 AM, Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>>>> On Wed, Mar 29, 2017 at 12:27 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>>>>> For PCI masters not represented in DT, we pass the OF node of their
>>>>> associated host bridge to of_dma_configure(), such that they can inherit
>>>>> the appropriate DMA configuration from whatever is described there.
>>>>> Unfortunately, whilst this has worked for the "dma-coherent" property,
>>>>> it turns out to miss the case where the host bridge node has a non-empty
>>>>> "dma-ranges", since nobody is expecting the 'device' to be a bus itself.
>>>>>
>>>>> It transpires, though, that the de-facto interface since the prototype
>>>>> change in 1f5c69aa51f9 ("of: Move of_dma_configure() to device.c to help
>>>>> re-use") is very clear-cut: either the master_np argument is redundant
>>>>> with dev->of_node, or dev->of_node is NULL and master_np is the relevant
>>>>> parent bus. Let's ratify that behaviour, then teach the whole
>>>>> of_dma_configure() pipeline to cope with both cases properly.
>>>>>
>>>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>
>> [...]
>>
>>>>
>>>> pci and memory mapped device world is different.
>>
>> ???
>>
>> No they aren't. There is nothing magic about PCI. PCI *is* a
>> memory-mapped bus.
>>
>> The only PCI-specific aspect here is the Linux code path which passes a
>> host controller node into of_dma_configure() where the latter expects a
>> node for the actual endpoint device. It managed to work for
>> "dma-coherent", because that may appear either directly on a device node
>> or on any of its parent buses, but "dma-ranges" is *only* valid for DT
>> nodes representing buses, thus reveals that using a parent bus to stand
>> in for a device isn't actually correct. I only posted that horrible hack
>> patch to prove the point that having a child node to represent the
>> actual device is indeed sufficient to make of_dma_configure() work
>> correctly for PCI masters as-is (modulo the other issues).
>>
>>> of course if you talk
>>>> from iommu perspective, all the master are same for IOMMU
>>
>> I don't understand what you mean by that. There's nothing about IOMMUs
>> here, it's purely about parsing DT properties correctly.
>>
>>>> but the original intention of the patch is to try to solve 2 problems.
>>>> please refer to https://lkml.org/lkml/2017/3/29/10
>>
>> One patch should not solve two separate problems anyway. Taking a step
>> back, there are at least 3 things that this discussion has brought up:
>>
>> 1) The way in which we call of_dma_configure() for PCI devices causes
>> the "dma-ranges" property on PCI host controllers to be ignored.
>>
>> 2) of_dma_get_range() only considers the first entry in any "dma-ranges"
>> property.
>>
>> 3) When of_dma_configure() does set a DMA mask, there is nothing on
>> arm64 and other architectures to prevent drivers overriding that with a
>> wider mask later.
>>
>> Those are 3 separate problems, to solve with 3 or more separate patches,
>> and I have deliberately put the second and third to one side for the
>> moment. This patch fixes problem 1.
>>
>>>> 1) expose generic API for pci world clients to configure their
>>>> dma-ranges. right now there is none.
>>>> 2) same API can be used by IOMMU to derive dma_mask.
>>>>
>>>> while the current patch posted to handle dma-ranges for both memory
>>>> mapped and pci devices, which I think is overdoing.
>>
>> No, of_dma_configure() handles the "dma-ranges" property as it is
>> defined in the DT spec to describe the mapping between a child bus
>> address space and a parent bus address space. Whether those
>> memory-mapped parent and child buses are PCI, ISA, AMBA, HyperTransport,
>> or anything else is irrelevant other than for the encoding of the
>> address specifiers. All this patch does is sort out the cases where we
>> have a real device node to start at, from the cases where we don't and
>> so start directly at the device's parent bus node instead.
>>
>>>> besides we have different configuration of dma-ranges based on iommu
>>>> is enabled or not enabled.
>>
>> That doesn't sound right, unless you mean the firmware actually programs
>> the host controller's AXI bridge differently for system configurations
>> where the IOMMU is expected to be used or not? (and even then, I don't
>> really see why it would be necessary to do that...)
>>
>>>>  #define PCIE_DMA_RANGES dma-ranges = <0x43000000 0x00 0x80000000 0x00
>>>> 0x80000000 0x00 0x80000000 \
>>>>                                       0x43000000 0x08 0x00000000 0x08
>>>> 0x00000000 0x08 0x00000000 \
>>>>                                       0x43000000 0x80 0x00000000 0x80
>>>> 0x00000000 0x40 0x00000000>;
>>>> Not sure if this patch will consider above dma-ranges.
>>>>
>>>> my suggestion is to leave existing of_dma_get_range as is, and have
>>>> new function for pci world as discussed in
>>>> please refer to https://lkml.org/lkml/2017/3/29/10
>>
>> And then we keep adding new functions to do the exact same thing for
>> every other discoverable bus type whose bridge is be described in DT? I
>> fail to see how that is in any way better than simply fixing the
>> existing code to work as it was intended to.
>>
>> of_dma_get_ranges() uses of_translate_dma_address() just the same way as
>> existing PowerPC PCI code does, which further disproves your assertion
>> that parsing PCI addresses is somehow special - it's really only a
>> matter of getting the right number of address cells in order to to read
>> a child address to give to of_translate_dma_address() in the first
>> place. Incidentally, I now notice that the proposed
>> of_pci_get_dma_ranges() is incomplete as it doesn't use
>> of_translate_dma_address() or otherwise traverse upwards through the
>> dma-ranges of any further parent buses.
>>
>>>>
>>>> Regards,
>>>> Oza.
>>>
>>> also I see that, in case of multiple ranges of_dma_get_range doesnt handle that.
>>> and also it is not meant to handle.
>>
>> Yes, the existing code doesn't handle multiple dma-ranges entries,
>> because nobody's had the need to implement that so far, and this patch
>> does not change that because it's fixing a separate problem.
>>
>> Now, of course of_dma_get_range() *should* be capable of handling
>> multiple entries regardless of this patch, and I'm going to write *that*
>> patch right now (it's going to be a case of adding a handful of lines
>> which probably won't even conflict with this one at all). If we had a
>> bunch of different range parsing functions, we'd then have to duplicate
>> the equivalent logic across all of them, which is clearly undesirable
>> when it can easily be avoided altogether.
>>
>> Robin.
>>
>>> so with this patch will return wrong size and hence wrong dma_mask.
>>> having said, I think it is better to separate pci world dma-ranges
>>> function on of_pci.c
>>>
>>> for which my discussion with Rob already, (same thread)
>>> https://lkml.org/lkml/2017/3/29/10
>>> Waiting for Rob's viewpoint on this.
>>>
>>>
>>> Regards,
>>> Oza.
>>>
>>
>
> In my opinion NAKing to this, because
>
> 1) some reasons already mentioned in https://lkml.org/lkml/2017/3/29/10
>
> 2) also of_dma_get_range is supposed to handle traditional dma-ranges
> (not pci one)
>
> 3) we need separate function for pci users such as iproc or rcar SOCs
> to have their dma-ranges parsed,
> which can be extended later for e.g. pci flags have some meanings.
>
> besides of_dma_configure is written to pass only single out parameter
> (..., *dma_addr, *size)
> handling multiple ranges here, and passing only one range out is not desirable.
>
> also you would not like to handle pci flags (the first portion of DT
> entry) in this function if required in future.
>
> this new function will be similar to of_pci_get_host_bridge_resources
> https://lkml.org/lkml/2017/3/29/10
> which I am writing/improving right now..
>
>
> Regards,
> Oza.


Hi Robin,

Gentle request to have a look at following approach and patch.

[RFC PATCH 2/2] of/pci: call pci specific dma-ranges instead of memory-mapped.
[RFC PATCH 1/2] of/pci: implement inbound dma-ranges for PCI

I have tested this on our platform, with and without iommu, and seems to work.

of course it requires your "in discussion" iommu dma_mask" changes to work.
which I believe you will take it ahead. so I have removed all the
iommu related changes now.
and this addresses purely pci world now.

let me know your view on this.

Regards,
Oza.
