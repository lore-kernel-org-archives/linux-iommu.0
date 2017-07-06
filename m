From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [RFC PATCH 1/5] base: dma-mapping: Export commonly used symbols
Date: Thu, 6 Jul 2017 17:36:10 +0900
Message-ID: <CAAFQd5BFLvWS5n8owm053GNC5VniMq-8Gh0BHo43B-TYShpsnA@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org> <20170705071215.17603-2-tfiga@chromium.org>
 <20170705151728.GA2479@lst.de> <CAAFQd5DijKbNJ-8wHh=+2Z2y1nSF-LC8R+d+NktTRF4iQqPsrA@mail.gmail.com>
 <20170705172019.GB5246@lst.de> <CAAFQd5CkVYd6uyoFP_15N8ZaZp8jivJ-4S=CAvrTynRU2ShFYg@mail.gmail.com>
 <CAK8P3a2htZ7q=npfwJVW7Lr90O78Ey+OR5e0ivaR7GwV4YBs=A@mail.gmail.com> <CAAFQd5BMorNa8CD+cEap2=boD2-=jr+DFF9cXTNXzSSfe7FnLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <CAAFQd5BMorNa8CD+cEap2=boD2-=jr+DFF9cXTNXzSSfe7FnLg@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Vineet Gupta <vgupta@synopsys.com>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Mitchel Humpherys <mitchelh@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Sakari Ailus <sakari.ailus@iki.fi>, Pawel Osciak <posciak@chromium.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 5:34 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Thu, Jul 6, 2017 at 5:26 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Jul 6, 2017 at 3:44 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>> On Thu, Jul 6, 2017 at 2:20 AM, Christoph Hellwig <hch@lst.de> wrote:
>>>> On Thu, Jul 06, 2017 at 12:22:35AM +0900, Tomasz Figa wrote:
>>
>>>> In general I think moving dma
>>>> ops and iommu implementations into modules is a bad idea
>>>
>>> Could you elaborate on this? I'd be interested in seeing the reasoning
>>> behind this.
>>>
>>>> but I
>>>> don't want to reject the idea before seeing the code.  Or maybe
>>>> by looking at the user we can come up with an even better idea
>>>> to solve the original issue you're trying to solve, so please also
>>>> explain your rationale.
>>
>> I had pretty much the same thoughts here.
>>
>>> Basically we have an x86 platform with a camera subsystem that is a
>>> PCI device, has its own MMU and needs cache maintenance. Moreover, the
>>> V4L2 subsystem, which is the right place for camera drivers, heavily
>>> relies on DMA mapping as a way to abstract memory allocation, mapping
>>> and cache maintenance. So it feels natural to me to hide the hardware
>>> details (additional cache maintenance, mapping into the built-in
>>> IOMMU) in the DMA mapping ops for this camera subsystem and simply
>>> make V4L2 just work without knowing those details.
>>
>> I can understand your reasoning here, but I'm also not convinced
>> that this is the best approach. There may be a middle ground somewhere
>> though.
>>
>> Generally speaking I don't want to have to deal with the horrors of
>> deciding whether an IOMMU is going to be there eventually or not
>> at probe() time. At some point, we had decided that IOMMUs need to
>> be initialized (almost) as early as irqchips and clocksources so we can
>> rely on them to be there at device discovery time. That got pushed
>> back already, and now we may have to deal with -EPROBE_DEFER
>> when an IOMMU has not been fully initialized at device probe time,
>> but at least we can reliably see if one is there or not. Making IOMMUs
>> modular will add further uncertainty here. Obviously we cannot attach
>> an IOMMU to a device once we have started using DMA mapping
>> calls on it.
>
> The hardware can only work with IOMMU and so the main module is highly
> tied with the IOMMU module and it initialized it directly. There is no
> separate struct driver or device associated with the IOMMU, as it's a
> part of the one and only one PCI device (as visible from the system
> PCI bus point of view) and technically handled by one pci_driver.
>
>>
>> For your particular use case, I would instead leave the knowledge
>> about the IOMMU in the driver itself, like we do for the IOMMUs
>> that are integrated in desktop GPUs, and have the code use the
>> DMA mapping API with the system-provided dma_map_ops to
>> get dma_addr_t tokens which you then program into the device
>> IOMMU.
>>
>> An open question however would be whether to use the IOMMU
>> API without the DMA mapping API here, or whether to completely
>> leave the knowledge of the IOMMU inside of the driver itself.
>> I don't have a strong opinion on that part, and I guess this mostly
>> depends on what the hardware looks like.
>
> + linux-media and some media folks
>
> I'd say that this is something that has been consistently tried to be
> avoided by V4L2 and that's why it's so tightly integrated with DMA
> mapping. IMHO re-implementing the code that's already there in
> videobuf2 again in the driver, only because, for no good reason
> mentioned as for now, having a loadable module providing DMA ops was
> disliked.

Sorry, I intended to mean:

IMHO re-implementing the code that's already there in videobuf2 again
in the driver, only because, for no good reason mentioned as for now,
having a loadable module providing DMA ops was disliked, would make no
sense.

>
> Similarly with IOMMU API. It provides a lot of help in managing the
> mappings and re-implementing this would be IMHO backwards.
>
> Best regards,
> Tomasz
