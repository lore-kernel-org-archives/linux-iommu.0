From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] base: dma-mapping: Export commonly used symbols
Date: Thu, 6 Jul 2017 10:26:19 +0200
Message-ID: <CAK8P3a2htZ7q=npfwJVW7Lr90O78Ey+OR5e0ivaR7GwV4YBs=A@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org>
	<20170705071215.17603-2-tfiga@chromium.org>
	<20170705151728.GA2479@lst.de>
	<CAAFQd5DijKbNJ-8wHh=+2Z2y1nSF-LC8R+d+NktTRF4iQqPsrA@mail.gmail.com>
	<20170705172019.GB5246@lst.de>
	<CAAFQd5CkVYd6uyoFP_15N8ZaZp8jivJ-4S=CAvrTynRU2ShFYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5CkVYd6uyoFP_15N8ZaZp8jivJ-4S=CAvrTynRU2ShFYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 3:44 AM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, Jul 6, 2017 at 2:20 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>> On Thu, Jul 06, 2017 at 12:22:35AM +0900, Tomasz Figa wrote:

>> In general I think moving dma
>> ops and iommu implementations into modules is a bad idea
>
> Could you elaborate on this? I'd be interested in seeing the reasoning
> behind this.
>
>> but I
>> don't want to reject the idea before seeing the code.  Or maybe
>> by looking at the user we can come up with an even better idea
>> to solve the original issue you're trying to solve, so please also
>> explain your rationale.

I had pretty much the same thoughts here.

> Basically we have an x86 platform with a camera subsystem that is a
> PCI device, has its own MMU and needs cache maintenance. Moreover, the
> V4L2 subsystem, which is the right place for camera drivers, heavily
> relies on DMA mapping as a way to abstract memory allocation, mapping
> and cache maintenance. So it feels natural to me to hide the hardware
> details (additional cache maintenance, mapping into the built-in
> IOMMU) in the DMA mapping ops for this camera subsystem and simply
> make V4L2 just work without knowing those details.

I can understand your reasoning here, but I'm also not convinced
that this is the best approach. There may be a middle ground somewhere
though.

Generally speaking I don't want to have to deal with the horrors of
deciding whether an IOMMU is going to be there eventually or not
at probe() time. At some point, we had decided that IOMMUs need to
be initialized (almost) as early as irqchips and clocksources so we can
rely on them to be there at device discovery time. That got pushed
back already, and now we may have to deal with -EPROBE_DEFER
when an IOMMU has not been fully initialized at device probe time,
but at least we can reliably see if one is there or not. Making IOMMUs
modular will add further uncertainty here. Obviously we cannot attach
an IOMMU to a device once we have started using DMA mapping
calls on it.

For your particular use case, I would instead leave the knowledge
about the IOMMU in the driver itself, like we do for the IOMMUs
that are integrated in desktop GPUs, and have the code use the
DMA mapping API with the system-provided dma_map_ops to
get dma_addr_t tokens which you then program into the device
IOMMU.

An open question however would be whether to use the IOMMU
API without the DMA mapping API here, or whether to completely
leave the knowledge of the IOMMU inside of the driver itself.
I don't have a strong opinion on that part, and I guess this mostly
depends on what the hardware looks like.

       Arnd
