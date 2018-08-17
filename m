From: Rob Landley <rob@landley.net>
Subject: dmaengine for sh7760 (was Re: use the generic dma-noncoherent code
 for sh V2)
Date: Fri, 17 Aug 2018 12:04:33 -0500
Message-ID: <418f3fa1-036f-d775-f1bc-e96778b4a4d8@landley.net>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
 <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
 <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3bwFupzM14eigXfoQsLtj3cq_xv_p3=O924cgSceLE0g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.orgRich Felker <dalias@libc.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 07/31/2018 07:56 AM, Arnd Bergmann wrote:
> On Fri, Jul 27, 2018 at 6:20 PM, Rob Landley <rob@landley.net> wrote:
>> On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
>>> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>>>> Hi all,
>>>>
>>>> can you review these patches to switch sh to use the generic
>>>> dma-noncoherent code?  All the requirements are in mainline already
>>>> and we've switched various architectures over to it already.
>>>
>>> Ok, there is one more issue with this version.   Wait for a new one
>>> tomorrow.
>>
>> Speaking of DMA:
>>
>> I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
>> fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
>> reading through all that stuff, but the docs seem kinda... thin?
>>
>> Is there something I should have read other than
>> Documentation/driver-model/platform.txt,
>> Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
>> source code and the sh7760 hardware pdf? (And watching the youtube video of
>> Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
>> DMAEngine, the Xilinx video on DMAEngine...)
>>
>> At first I thought the SH_DMAE could initialize itself, but the probe function
>> needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
>> _kind_ of like a model I can crib from:
> 
>> B) That platform data is supplying sh_dmae_slave_config preallocating slave
>> channels to devices? (Does it have to? The docs gave me the impression the
>> driver would dynamically request them and devices could even share. Wasn't that
>> sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
>> minimum amount of micromanaging I have to do?)
> 
> The thing here is that arch/sh is way behind on the API use, and it
> has prevented us from cleaning up drivers as well. A slave driver
> should have to just call dma_request_chan() with a constant
> string to identify its channel rather than going two different ways
> depending on whether it's used with DT or platform data.

I got the DMA controller hooked up to DMAEngine and the dmatest module is happy
with the result on all 8 channels. (Finding
arch/sh/kernel/cpu/sh4a/setup-sh7722.c helped a lot, finding it earlier would
have helped more. :)

The config symbols are:

CONFIG_SH_DMA=y
CONFIG_DMADEVICES=y
CONFIG_SH_DMAE_BASE=y
CONFIG_SH_DMAE=y
CONFIG_DMATEST=y #optional

The platform data is:

#include <cpu/dma-register.h>
#include <cpu/dma.h>
#include <linux/sh_dma.h>

/* DMA */
static struct resource sh7760_dma_resources[] = {
	{
		.start  = SH_DMAC_BASE0,
		.end    = SH_DMAC_BASE0 + 9*16 - 1,
		.flags  = IORESOURCE_MEM,
	}, {
		.start  = DMTE0_IRQ,
		.end    = DMTE0_IRQ,
		.flags  = IORESOURCE_IRQ,
	}
};

static struct sh_dmae_channel dma_chan[] = {
	{
		.offset = 0,
		.dmars = 0,
		.dmars_bit = 0,
	}, {
		.offset = 0x10,
		.dmars = 0,
		.dmars_bit = 8,
	}, {
		.offset = 0x20,
		.dmars = 4,
		.dmars_bit = 0,
	}, {
		.offset = 0x30,
		.dmars = 4,
		.dmars_bit = 8,
	}, {
		.offset = 0x50,
		.dmars = 8,
		.dmars_bit = 0,
	}, {
		.offset = 0x60,
		.dmars = 8,
		.dmars_bit = 8,
	}, {
		.offset = 0x70,
		.dmars = 12,
		.dmars_bit = 0,
	}, {
		.offset = 0x80,
		.dmars = 12,
		.dmars_bit = 8,
	}
};

static const unsigned int ts_shift[] = TS_SHIFT;

static struct sh_dmae_pdata sh7760_dma_pdata = {
	.channel = dma_chan,
	.channel_num = ARRAY_SIZE(dma_chan),
        .ts_low_shift   = CHCR_TS_LOW_SHIFT,
        .ts_low_mask    = CHCR_TS_LOW_MASK,
        .ts_high_shift  = CHCR_TS_HIGH_SHIFT,
        .ts_high_mask   = CHCR_TS_HIGH_MASK,
        .ts_shift       = ts_shift,
        .ts_shift_num   = ARRAY_SIZE(ts_shift),
        .dmaor_init     = DMAOR_INIT,
	.dmaor_is_32bit = 1,
};

struct platform_device sh7760_dma_device = {
        .name           = "sh-dma-engine",
        .id             = -1,
        .num_resources  = ARRAY_SIZE(sh7760_dma_resources),
        .resource       = sh7760_dma_resources,
	.dev = {.platform_data = &sh7760_dma_pdata},
};


And then add sh7760_dma_device to your struct platform_device array.

> If you hack on it, please convert the dmaengine platform data to use
> a dma_slave_map array to pass the data into the dmaengine driver,

The dmatest module didn't need it? I don't see why the ethernet driver would?
(Isn't the point of an allocator to allocate from a request?)

> mapping the settings from a (pdev-name, channel-id) tuple to a pointer
> that describes the channel configuration rather than having the
> mapping from an numerical slave_id to a struct sh_dmae_slave_config
> in the setup files. It should be a fairly mechanical conversion.

I think all 8 channels are generic. Drivers should be able to grab them and
release them at will, why does it need a table?

(I say this not having made the smc91x.c driver use this yet, its "conversion"
to device tree left it full of PXA #ifdefs and constants, and I've tried the
last half-dozen kernel releases and qemu releases and have yet to find an arm
mainstone board under qemu that _doesn't_ time out trying to use DMA with this
card. But that's another post...)

> The other part I noticed is arch/sh/drivers/dma/*, which appears to
> be entirely unused, and should probably removed.

I had to switch that off to get this to work, yes. I believe it predates
dmaengine and was obsoleted by it.

>          Arnd
> 

Rob
