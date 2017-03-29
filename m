From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH] of: Fix DMA configuration for non-DT masters
Date: Wed, 29 Mar 2017 18:42:56 +0100
Message-ID: <b02ace9b-f8f3-269d-6db4-3c1b1ea1e816@arm.com>
References: <67d1f46172599be243405f4341665fd0ef9ab969.1490726288.git.robin.murphy@arm.com>
 <CAMSpPPfJKKRkuDKxUgVBdg7vp7Ux5=PiHSxnMLc7-LMcCSatzg@mail.gmail.com>
 <CAMSpPPcSWxua_6ECZd4iEbTiAYk-KtapBDcOUxNdGaQkFF-LOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMSpPPcSWxua_6ECZd4iEbTiAYk-KtapBDcOUxNdGaQkFF-LOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 29/03/17 06:46, Oza Oza wrote:
> On Wed, Mar 29, 2017 at 10:23 AM, Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> On Wed, Mar 29, 2017 at 12:27 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>>> For PCI masters not represented in DT, we pass the OF node of their
>>> associated host bridge to of_dma_configure(), such that they can inherit
>>> the appropriate DMA configuration from whatever is described there.
>>> Unfortunately, whilst this has worked for the "dma-coherent" property,
>>> it turns out to miss the case where the host bridge node has a non-empty
>>> "dma-ranges", since nobody is expecting the 'device' to be a bus itself.
>>>
>>> It transpires, though, that the de-facto interface since the prototype
>>> change in 1f5c69aa51f9 ("of: Move of_dma_configure() to device.c to help
>>> re-use") is very clear-cut: either the master_np argument is redundant
>>> with dev->of_node, or dev->of_node is NULL and master_np is the relevant
>>> parent bus. Let's ratify that behaviour, then teach the whole
>>> of_dma_configure() pipeline to cope with both cases properly.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

[...]

>>
>> pci and memory mapped device world is different.

???

No they aren't. There is nothing magic about PCI. PCI *is* a
memory-mapped bus.

The only PCI-specific aspect here is the Linux code path which passes a
host controller node into of_dma_configure() where the latter expects a
node for the actual endpoint device. It managed to work for
"dma-coherent", because that may appear either directly on a device node
or on any of its parent buses, but "dma-ranges" is *only* valid for DT
nodes representing buses, thus reveals that using a parent bus to stand
in for a device isn't actually correct. I only posted that horrible hack
patch to prove the point that having a child node to represent the
actual device is indeed sufficient to make of_dma_configure() work
correctly for PCI masters as-is (modulo the other issues).

> of course if you talk
>> from iommu perspective, all the master are same for IOMMU

I don't understand what you mean by that. There's nothing about IOMMUs
here, it's purely about parsing DT properties correctly.

>> but the original intention of the patch is to try to solve 2 problems.
>> please refer to https://lkml.org/lkml/2017/3/29/10

One patch should not solve two separate problems anyway. Taking a step
back, there are at least 3 things that this discussion has brought up:

1) The way in which we call of_dma_configure() for PCI devices causes
the "dma-ranges" property on PCI host controllers to be ignored.

2) of_dma_get_range() only considers the first entry in any "dma-ranges"
property.

3) When of_dma_configure() does set a DMA mask, there is nothing on
arm64 and other architectures to prevent drivers overriding that with a
wider mask later.

Those are 3 separate problems, to solve with 3 or more separate patches,
and I have deliberately put the second and third to one side for the
moment. This patch fixes problem 1.

>> 1) expose generic API for pci world clients to configure their
>> dma-ranges. right now there is none.
>> 2) same API can be used by IOMMU to derive dma_mask.
>>
>> while the current patch posted to handle dma-ranges for both memory
>> mapped and pci devices, which I think is overdoing.

No, of_dma_configure() handles the "dma-ranges" property as it is
defined in the DT spec to describe the mapping between a child bus
address space and a parent bus address space. Whether those
memory-mapped parent and child buses are PCI, ISA, AMBA, HyperTransport,
or anything else is irrelevant other than for the encoding of the
address specifiers. All this patch does is sort out the cases where we
have a real device node to start at, from the cases where we don't and
so start directly at the device's parent bus node instead.

>> besides we have different configuration of dma-ranges based on iommu
>> is enabled or not enabled.

That doesn't sound right, unless you mean the firmware actually programs
the host controller's AXI bridge differently for system configurations
where the IOMMU is expected to be used or not? (and even then, I don't
really see why it would be necessary to do that...)

>>  #define PCIE_DMA_RANGES dma-ranges = <0x43000000 0x00 0x80000000 0x00
>> 0x80000000 0x00 0x80000000 \
>>                                       0x43000000 0x08 0x00000000 0x08
>> 0x00000000 0x08 0x00000000 \
>>                                       0x43000000 0x80 0x00000000 0x80
>> 0x00000000 0x40 0x00000000>;
>> Not sure if this patch will consider above dma-ranges.
>>
>> my suggestion is to leave existing of_dma_get_range as is, and have
>> new function for pci world as discussed in
>> please refer to https://lkml.org/lkml/2017/3/29/10

And then we keep adding new functions to do the exact same thing for
every other discoverable bus type whose bridge is be described in DT? I
fail to see how that is in any way better than simply fixing the
existing code to work as it was intended to.

of_dma_get_ranges() uses of_translate_dma_address() just the same way as
existing PowerPC PCI code does, which further disproves your assertion
that parsing PCI addresses is somehow special - it's really only a
matter of getting the right number of address cells in order to to read
a child address to give to of_translate_dma_address() in the first
place. Incidentally, I now notice that the proposed
of_pci_get_dma_ranges() is incomplete as it doesn't use
of_translate_dma_address() or otherwise traverse upwards through the
dma-ranges of any further parent buses.

>>
>> Regards,
>> Oza.
> 
> also I see that, in case of multiple ranges of_dma_get_range doesnt handle that.
> and also it is not meant to handle.

Yes, the existing code doesn't handle multiple dma-ranges entries,
because nobody's had the need to implement that so far, and this patch
does not change that because it's fixing a separate problem.

Now, of course of_dma_get_range() *should* be capable of handling
multiple entries regardless of this patch, and I'm going to write *that*
patch right now (it's going to be a case of adding a handful of lines
which probably won't even conflict with this one at all). If we had a
bunch of different range parsing functions, we'd then have to duplicate
the equivalent logic across all of them, which is clearly undesirable
when it can easily be avoided altogether.

Robin.

> so with this patch will return wrong size and hence wrong dma_mask.
> having said, I think it is better to separate pci world dma-ranges
> function on of_pci.c
> 
> for which my discussion with Rob already, (same thread)
> https://lkml.org/lkml/2017/3/29/10
> Waiting for Rob's viewpoint on this.
> 
> 
> Regards,
> Oza.
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
