From: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
Subject: Re: dmaengine for sh7760 (was Re: use the generic dma-noncoherent
	code for sh V2)
Date: Sun, 19 Aug 2018 00:38:13 -0500
Message-ID: <3f9fed2a-9800-8a86-2b1f-f7baaea74e54@landley.net>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
	<18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
	<CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
	<418f3fa1-036f-d775-f1bc-e96778b4a4d8@landley.net>
	<CAK8P3a3x0f_op8PxOaWGNHQ3udg05T6NZggFAd7awns-FoL4yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAK8P3a3x0f_op8PxOaWGNHQ3udg05T6NZggFAd7awns-FoL4yA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 08/17/2018 03:23 PM, Arnd Bergmann wrote:
> On Fri, Aug 17, 2018 at 7:04 PM Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org> wrote:
>> On 07/31/2018 07:56 AM, Arnd Bergmann wrote:
>>> On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org> wrote:
>>>> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
>>>>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>>>>>> Hi all,
>>> If you hack on it, please convert the dmaengine platform data to use
>>> a dma_slave_map array to pass the data into the dmaengine driver,
>>
>> The dmatest module didn't need it? I don't see why the ethernet driver would?
>> (Isn't the point of an allocator to allocate from a request?)
> 
> I guess you have hit two of the special cases here:
> 
> - dmatest uses the memory-to-memory DMA engine interface, not the slave
>   API, so you don't have to configure a slave at all

I've read through
https://www.kernel.org/doc/Documentation/driver-api/dmaengine/client.rst twice
and am still very unclear on the slave API.

> - smc91x (and its smc911x.c relative) are apparently special in that they
>   use they use the DMA slave API

Only sort of. In 4.14 at least it's under #ifdef ARCH_PXA and full of PXA
constants (PXAD_PRIO_LOWEST and such).

> but (AFAICT) require programming
>   the dmaengine hardware into a memory-to-memory transfer with no
>   DMA slave request signal and completely synchronous operation
>   (the IRQ handler polls for the DMA descriptor to be complete),
>   see also https://lkml.org/lkml/2018/4/3/464 for the discussion about
>   the recent rework of that driver's implementation.

Bookmarked, thanks.

(Being able to just upgrade to a 4.19 kernel or something and have DMA work in
this driver if I've got dmaengine set up for the platform would be lovely.)

>>> mapping the settings from a (pdev-name, channel-id) tuple to a pointer
>>> that describes the channel configuration rather than having the
>>> mapping from an numerical slave_id to a struct sh_dmae_slave_config
>>> in the setup files. It should be a fairly mechanical conversion.
>>
>> I think all 8 channels are generic. Drivers should be able to grab them and
>> release them at will, why does it need a table?
>>
>> (I say this not having made the smc91x.c driver use this yet, its "conversion"
>> to device tree left it full of PXA #ifdefs and constants, and I've tried the
> 
> Another point about smc91x is that it only uses DMA on the PXA platform,
> which is not part of the "multiplatform" ARM setup. It's likely that no
> other platform actually has a DMA engine that can talk to this device in
> the absence of a request signal, or that on more modern CPU cores,
> a readsl() is actually just as fast, but it avoids the setup cost of talking
> to the dma engine. Possibly both of the above.

The sh7760 has the CPU pegged at 100% trying to keep up with ethernet traffic.
Being able to use DMA on this would be very nice.

>> last half-dozen kernel releases and qemu releases and have yet to find an arm
>> mainstone board under qemu that _doesn't_ time out trying to use DMA with this
>> card. But that's another post...)
> 
> Is smc91x the only driver that you want to make use of the DMA engine?

This driver's the low-hanging fruit, yeah. Copying NOR flash jffs2 data into
page cache would be nice but there's a decompression step so I'm not sure that's
a win.

> I suspect that every other one currently relies on passing a slave ID
> shdma_chan_filter into dma_request_slave_channel_compat() or
> dma_request_channel() , which are some of the interfaces we want to
> remove in the future, to make everything work the same across
> all platforms.

What are "all platforms" in this context? I tried to find an x86 variant that
uses DMAEngine but came up empty. Can I use DMAEngine on a raspberry pi perhaps?
Is there a QEMU taret I can play with DMAEngine under?

I built a mainstone kernel with dmaengine amd smc91x both enabled, and booted it
on qemu-system-arm -M mainstone, and it works fine until I try to ping the host
(via the 10.0.2.2 redirect), at which point no packets are received and a timer
expires all over the console a few seconds later. I.E. the DMA claims to be
there, but the transfer never occurs.

I built and tested every Linux version back to 4.2 (before the smc91x was
converted from PXA dma to use DMAEngine, albeit in a very PXA specific manner).
I also tested each qemu release back to 2.3.0, with no obvious behavioral
difference.

I can dig further back in qemu history maybe? Ask on the qemu list? (Did this
ever work for anyone? I can post my kernel config and qemu command line if you
think it would help?)

> shdma_chan_filter() is one of those that expect its pointer argument to
> be a number that is in turn associated with an sh_dmae_slave_config
> structure in the platform data of the dma engine. What the newer
> dma_request_chan() interface does is to pass a pointer to the
> slave device and a string as identifier for the same data, which then
> gets associated through the dma_slave_map. On smc91x, both
> the device and name argument are NULL, which triggers the special
> case in the pxa dmaengine driver.

I do not understand what the slave map is for, is it documented anywhere? (The
Documentation/randomdir/dmaengine/client.nolongertxt file says: "The association
is done via DT, ACPI or board file based dma_slave_map matching table." which is
its only mention of the existence of dma_slave_map.

If the driver just needs "a channel" and doesn't care which one, why isn't the
config info for that channel in the driver as a generic request for resource?

>>> The other part I noticed is arch/sh/drivers/dma/*, which appears to
>>> be entirely unused, and should probably removed.
>>
>> I had to switch that off to get this to work, yes. I believe it predates
>> dmaengine and was obsoleted by it.
> 
> Ok. Have you found any reason to keep it around though?

I have not.

>        Arnd

Rob
