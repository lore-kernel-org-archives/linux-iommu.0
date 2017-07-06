From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] base: dma-mapping: Export commonly used symbols
Date: Thu, 6 Jul 2017 16:27:06 +0200
Message-ID: <CAK8P3a0_S=ONcnfD0qrt61iu4N_2WQHbGTtED-WXHov-30gK=w@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org>
	<20170705071215.17603-2-tfiga@chromium.org>
	<20170705151728.GA2479@lst.de>
	<CAAFQd5DijKbNJ-8wHh=+2Z2y1nSF-LC8R+d+NktTRF4iQqPsrA@mail.gmail.com>
	<20170705172019.GB5246@lst.de>
	<CAAFQd5CkVYd6uyoFP_15N8ZaZp8jivJ-4S=CAvrTynRU2ShFYg@mail.gmail.com>
	<CAK8P3a2htZ7q=npfwJVW7Lr90O78Ey+OR5e0ivaR7GwV4YBs=A@mail.gmail.com>
	<CAAFQd5BMorNa8CD+cEap2=boD2-=jr+DFF9cXTNXzSSfe7FnLg@mail.gmail.com>
	<CAAFQd5BFLvWS5n8owm053GNC5VniMq-8Gh0BHo43B-TYShpsnA@mail.gmail.com>
	<CAK8P3a2JyQ-qLgh+ig4yWMJvB0AGjspMu8P8fNrPHgm3NMCGNw@mail.gmail.com>
	<CAAFQd5DS1NxKh4OJ52T2AJNTHg6K2fnuDm5-GHzmUk-kjowf2w@mail.gmail.com>
	<CAAFQd5Axz2yMnOo4rtP3jgEBJxUVOW0RLmFEGFejBHkYjq0s5A@mail.gmail.com>
	<CAK8P3a0xVjgD-w-uVDc54Mx0s6b1Bd3tRYt9rpetjNoMwDXvCA@mail.gmail.com>
	<CAAFQd5BgVRaEym9fXt3sMSafFPK1cXwTdMgSiB87w8QVeXzzVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5BgVRaEym9fXt3sMSafFPK1cXwTdMgSiB87w8QVeXzzVw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Pawel Osciak <posciak-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 4:06 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, Jul 6, 2017 at 11:02 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> On Thu, Jul 6, 2017 at 3:49 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>> On Thu, Jul 6, 2017 at 10:31 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>
>>>> On the other hand, if it's strictly about base/dma-mapping, we might
>>>> not need it indeed. The driver could call iommu-dma helpers directly,
>>>> without the need to provide its own DMA ops. One caveat, though, we
>>>> are not able to obtain coherent (i.e. uncached) memory with this
>>>> approach, which might have some performance effects and complicates
>>>> the code, that would now need to flush caches even for some small
>>>> internal buffers.
>>>
>>> I think I should add a bit of explanation here:
>>>  1) the device is non-coherent with CPU caches, even on x86,
>>>  2) it looks like x86 does not have non-coherent DMA ops, (but it
>>> might be something that could be fixed)
>>
>> I don't understand what this means here. The PCI on x86 is always
>> cache-coherent, so why is the device not?
>>
>> Do you mean that the device has its own caches that may need
>> flushing to make the device cache coherent with the CPU cache,
>> rather than flushing the CPU caches?
>
> Sakari might be able to explain this with more technical details, but
> generally the device is not a standard PCI device one might find on
> existing x86 systems.
>
> It is some kind of embedded subsystem that behaves mostly like a PCI
> device, with certain exceptions, one being the lack of coherency with
> CPU caches, at least for certain parts of the subsystem. The reference
> vendor code disables the coherency completely, for reasons not known
> to me, but AFAICT this is the preferred operating mode, possibly due
> to performance effects (this is a memory-heavy image processing

Ok, got it. I think something similar happens on integrated GPUs for
a certain CPU family. The DRM code has its own ways of dealing with
this kind of device. If you find that the hardware to be closely
related (either the implementation, or the location on the internal
buses) to the GPU on this machine, I'd recommend having a look
in drivers/gpu/drm to see how it's handled there, and if that code could
be shared.

        Arnd
