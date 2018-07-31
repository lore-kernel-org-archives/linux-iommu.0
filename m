From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: use the generic dma-noncoherent code for sh V2
Date: Tue, 31 Jul 2018 14:56:21 +0200
Message-ID: <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de> <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob@landley.net> wrote:
> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> can you review these patches to switch sh to use the generic
>>> dma-noncoherent code?  All the requirements are in mainline already
>>> and we've switched various architectures over to it already.
>>
>> Ok, there is one more issue with this version.   Wait for a new one
>> tomorrow.
>
> Speaking of DMA:
>
> I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
> fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
> reading through all that stuff, but the docs seem kinda... thin?
>
> Is there something I should have read other than
> Documentation/driver-model/platform.txt,
> Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
> source code and the sh7760 hardware pdf? (And watching the youtube video of
> Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
> DMAEngine, the Xilinx video on DMAEngine...)
>
> At first I thought the SH_DMAE could initialize itself, but the probe function
> needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
> _kind_ of like a model I can crib from:

> B) That platform data is supplying sh_dmae_slave_config preallocating slave
> channels to devices? (Does it have to? The docs gave me the impression the
> driver would dynamically request them and devices could even share. Wasn't that
> sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
> minimum amount of micromanaging I have to do?)

The thing here is that arch/sh is way behind on the API use, and it
has prevented us from cleaning up drivers as well. A slave driver
should have to just call dma_request_chan() with a constant
string to identify its channel rather than going two different ways
depending on whether it's used with DT or platform data.

If you hack on it, please convert the dmaengine platform data to use
a dma_slave_map array to pass the data into the dmaengine driver,
mapping the settings from a (pdev-name, channel-id) tuple to a pointer
that describes the channel configuration rather than having the
mapping from an numerical slave_id to a struct sh_dmae_slave_config
in the setup files. It should be a fairly mechanical conversion.

The other part I noticed is arch/sh/drivers/dma/*, which appears to
be entirely unused, and should probably removed.

         Arnd
