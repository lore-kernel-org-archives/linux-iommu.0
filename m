From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Tue, 2 Apr 2019 12:23:25 +0100
Message-ID: <bb389964-13af-5de0-099c-27443844f18a@arm.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
 <20190402003326.GB12934@rosenzweig.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402003326.GB12934@rosenzweig.io>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Rob Herring <robh@kernel.org>, Lyude Paul <lyude@redhat.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Eric Anholt <eric@anholt.net>, Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Neil Armstrong <narmstrong@baylibre.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, "Marty E . Plummer" <hanetzer@startmail.com>, Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 02/04/2019 01:33, Alyssa Rosenzweig wrote:
>> the userspace definitely doesn't support T624
> 
> This is true, yes. Shouldn't be too hard to backport; if there's still
> interest in Midgard 1st/2nd gen, I suppose I can grab hardware and sort
> it out...

I'm quite likely the only person trying this on an Arm Juno board, and 
even then it's really only for giggles because I can :)  I guess there 
might be a fair few Odroid-XU3/XU4 (T628) users interested, though.

>> You probably want a dma_set_mask_and_coherent() call for your 'real' output
>> address size somewhere - the default 32-bit mask works out OK for RK3399,
>> but on systems with RAM above 4GB io-pgtable will get very unhappy about DMA
>> bounce-buffering.
> 
> Out of curiosity, are there Mali systems with >4GB RAM? That sounds
> awesome :)

Now that the "early-access Armv8 silicon" angle has well and truly 
expired, Juno is essentially a prototyping platform where the SoC just 
serves to (slowly) drive interesting things in FPGA cards, so although 
it may have 8GB of RAM, it's not all that exciting. There is one 
somewhat more realistic board I'm aware of, namely HiKey 970 with a G72 
and 6GB.

>> Any chance of resurrecting the generic "arm,mali-midgard" compatible? :P
> 
> ...Would that require editing everybody's DT file?

If they already have one of the strings from the current upstream 
binding, no - I only mean to suggest adding it as an additional 
last-level fallback. That would aid compatibility with downstream DTs, 
for example RK3288 which currently has zero overlap:

upstream: "rockchip,rk3288-mali", "arm,mali-t760";

downstream: "arm,malit764", "arm,malit76x", "arm,malit7xx", 
"arm,mali-midgard";

Similarly, it might be reasonable for panfrost_{gpu,mmu,job}_init() to 
retry platform_get_irq_byname() with uppercase interrupt names if the 
expected ones aren't found - obviously the upstream binding comes first 
and foremost, but I don't see any harm in quietly supporting bits of the 
downstream binding if it makes users' lives easier when switching 
between mainline and vendor kernels.

Cheers,
Robin.
