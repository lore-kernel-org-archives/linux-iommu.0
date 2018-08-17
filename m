From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: dmaengine for sh7760 (was Re: use the generic dma-noncoherent
 code for sh V2)
Date: Fri, 17 Aug 2018 22:23:49 +0200
Message-ID: <CAK8P3a3x0f_op8PxOaWGNHQ3udg05T6NZggFAd7awns-FoL4yA@mail.gmail.com>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
 <18df6608-61c1-963d-bb1a-d46320232f40@landley.net> <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
 <418f3fa1-036f-d775-f1bc-e96778b4a4d8@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <418f3fa1-036f-d775-f1bc-e96778b4a4d8@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 17, 2018 at 7:04 PM Rob Landley <rob@landley.net> wrote:
> On 07/31/2018 07:56 AM, Arnd Bergmann wrote:
> > On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob@landley.net> wrote:
> >> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
> >>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
> >>>> Hi all,
> > If you hack on it, please convert the dmaengine platform data to use
> > a dma_slave_map array to pass the data into the dmaengine driver,
>
> The dmatest module didn't need it? I don't see why the ethernet driver would?
> (Isn't the point of an allocator to allocate from a request?)

I guess you have hit two of the special cases here:

- dmatest uses the memory-to-memory DMA engine interface, not the slave
  API, so you don't have to configure a slave at all

- smc91x (and its smc911x.c relative) are apparently special in that they
  use they use the DMA slave API but (AFAICT) require programming
  the dmaengine hardware into a memory-to-memory transfer with no
  DMA slave request signal and completely synchronous operation
  (the IRQ handler polls for the DMA descriptor to be complete),
  see also https://lkml.org/lkml/2018/4/3/464 for the discussion about
  the recent rework of that driver's implementation.

> > mapping the settings from a (pdev-name, channel-id) tuple to a pointer
> > that describes the channel configuration rather than having the
> > mapping from an numerical slave_id to a struct sh_dmae_slave_config
> > in the setup files. It should be a fairly mechanical conversion.
>
> I think all 8 channels are generic. Drivers should be able to grab them and
> release them at will, why does it need a table?
>
> (I say this not having made the smc91x.c driver use this yet, its "conversion"
> to device tree left it full of PXA #ifdefs and constants, and I've tried the

Another point about smc91x is that it only uses DMA on the PXA platform,
which is not part of the "multiplatform" ARM setup. It's likely that no
other platform actually has a DMA engine that can talk to this device in
the absence of a request signal, or that on more modern CPU cores,
a readsl() is actually just as fast, but it avoids the setup cost of talking
to the dma engine. Possibly both of the above.

> last half-dozen kernel releases and qemu releases and have yet to find an arm
> mainstone board under qemu that _doesn't_ time out trying to use DMA with this
> card. But that's another post...)

Is smc91x the only driver that you want to make use of the DMA engine?
I suspect that every other one currently relies on passing a slave ID
shdma_chan_filter into dma_request_slave_channel_compat() or
dma_request_channel() , which are some of the interfaces we want to
remove in the future, to make everything work the same across
all platforms.

shdma_chan_filter() is one of those that expect its pointer argument to
be a number that is in turn associated with an sh_dmae_slave_config
structure in the platform data of the dma engine. What the newer
dma_request_chan() interface does is to pass a pointer to the
slave device and a string as identifier for the same data, which then
gets associated through the dma_slave_map. On smc91x, both
the device and name argument are NULL, which triggers the special
case in the pxa dmaengine driver.

> > The other part I noticed is arch/sh/drivers/dma/*, which appears to
> > be entirely unused, and should probably removed.
>
> I had to switch that off to get this to work, yes. I believe it predates
> dmaengine and was obsoleted by it.

Ok. Have you found any reason to keep it around though?

       Arnd
