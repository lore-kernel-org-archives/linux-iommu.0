From: Rob Landley <rob@landley.net>
Subject: Re: use the generic dma-noncoherent code for sh V2
Date: Fri, 27 Jul 2018 11:20:21 -0500
Message-ID: <18df6608-61c1-963d-bb1a-d46320232f40@landley.net>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724202115.GA4685@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, iommu@lists.linux-foundation.org, Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 07/24/2018 03:21 PM, Christoph Hellwig wrote:
> On Tue, Jul 24, 2018 at 02:01:42PM +0200, Christoph Hellwig wrote:
>> Hi all,
>>
>> can you review these patches to switch sh to use the generic
>> dma-noncoherent code?  All the requirements are in mainline already
>> and we've switched various architectures over to it already.
>
> Ok, there is one more issue with this version.   Wait for a new one
> tomorrow.

Speaking of DMA:

I'm trying to wire up DMAEngine to an sh7760 board that uses platform data (and
fix the smc91x.c driver to use DMAEngine without #ifdef arm), so I've been
reading through all that stuff, but the docs seem kinda... thin?

Is there something I should have read other than
Documentation/driver-model/platform.txt,
Documentation/dmaegine/{provider,client}.txt, then trying to picking through the
source code and the sh7760 hardware pdf? (And watching the youtube video of
Laurent Pinchart's 2014 ELC talk on DMA, Maxime Ripard's 2015 ELC overview of
DMAEngine, the Xilinx video on DMAEngine...)

At first I thought the SH_DMAE could initialize itself, but the probe function
needs platform data, and although arch/sh/kernel/cpu/sh4a/setup-sh7722.c looks
_kind_ of like a model I can crib from:

A) "make ARCH=sh se7722_defconfig" results in a config with SH_DMA disabled??!?
(This is why I use miniconfig instead of defconfig format, I'm assuming that's
bit rot?)

B) That platform data is supplying sh_dmae_slave_config preallocating slave
channels to devices? (Does it have to? The docs gave me the impression the
driver would dynamically request them and devices could even share. Wasn't that
sort of the point of DMAEngine? Can my new board data _not_ do that? What's the
minimum amount of micromanaging I have to do?)

C) It's full of stuff like setting ts_low_shift to CHCR_TS_LOW_SHIFT where both
grepping Docuemntation and Google "dmaengine ts_low_shift" are unhelpful.

What I'd really like is a "hello world" version of DMAEngine somewhere I can
build and run on a supported qemu target, to set up _one_ channel with a block
device or something using it. I can't tell what's optional, or what the minimal
version of this looks like.

(Currently I've only managed to update this kernel to 4.14 because 4.15
introduced an intermittent data corruption bug in the flash, which takes long
enough to reproduce bisecting it is fiddly and ship deadlines are all blinky and
red. But next release should be current, _and_ with at least the 4.14 source
published so I can point people at it. Heck, maybe I can convince them to let me
port it to device tree next cycle, but I need to get it to _work_ first. And
doing PIO on a 100baseT controller, I.E. a ~200 mhz embedded CPU trying to copy
11 megabytes/second across a 16 bit bus with a for(;;) loop... bit of a
performance bottleneck even before you add https.)

Thanks,

Rob

>>
>> Changes since V1:
>>  - fixed two stupid compile errors and verified them using a local
>>    cross toolchain instead of the 0day buildbot
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
