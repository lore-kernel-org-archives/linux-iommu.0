From: Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Fri, 20 Apr 2012 12:54:43 -0700
Message-ID: <4F91BF03.6030509@nvidia.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>	 <20120419173537.GA7692@avionic-0098.adnet.avionic-design.de>	 <CAPM=9tzK83yYS33eNruvFDwb62ycZxJMC31davVRN=yaZD53YA@mail.gmail.com>	 <20120419204016.GA8954@avionic-0098.mockup.avionic-design.de>	 <4F907CBB.4080705@nvidia.com>	 <20120420050231.GA15313@avionic-0098.adnet.avionic-design.de> <1334901911.1361.11.camel@tellur>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334901911.1361.11.camel@tellur>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On 04/19/2012 11:05 PM, Lucas Stach wrote:
> Am Freitag, den 20.04.2012, 07:02 +0200 schrieb Thierry Reding:
*cut*
>
> Yes, I think we should go the route that Jerome Glisse pointed out: get
> in a basic KMS driver first and hide any accel ioctl under a staging
> config option.

Everyone seems happy with that, I have no objections.

*cut*
>
> I'm really interested how this turns out in the end. I hope we can get a
> somewhat stable cooperation between NVIDIA and the community, like AMD
> has established at the moment.

Well, we always strive to be better than AMD ;-)
But seriously, I don't think GPU technology would be where it is today 
if NVIDIA and AMD didn't compete aggressively.

But our mobile division is more like TI, Qualcomm, Freescale and other 
SoC vendors. Upstreaming changes for arch/arm has so far been a 
different challenge than only updating drivers/gpu for x86. Mostly 
because there are so many aspects to SoCs compared to a driver for a 
graphics card or PC chipset. And it doesn't help that arch/arm is a real 
mess of wildly different SoCs, and it lacks the stability and maturity 
of the x86 code base. The state of ARM is every vendor's fault, every 
chip generation can be a complete resign of one or more subsystems. x86 
tends to be layers of extensions and enhancements from 1-3 vendors.

But even if Mobile doesn't consider AMD or Intel to be among the 
competition, we certainly watch and listen to good open source 
contributors and try to learn from their successes and mistakes. (and 
our own mistakes, we're not perfect!)

What I'm trying to say is that Tegra's business needs are different, so 
you should not be surprised to see different behavior from us. There are 
a lot of difficult issues with open sourcing the work done by my desktop 
colleagues. But those barriers don't apply to Tegra. Different product, 
different market, different rules.

>>
>>> (My vote is NVIDIA starts using this DRM in-house and builds new
>>> extensions on top of it, sharing patches on LKML when the hardware is
>>> released)
>>
>> That sounds like a good plan. Ideally you should even share the patches as
>> soon as they're ready. That'll give viewers some head start and you can fix
>> the code even before the hardware is released.
>
> One thing I would like to have is upstream first. We have seen much
> Tegra development in both the nv-linux and chromium trees, but those
> things are going upstream extremely slowly. I can understand that this
> strategy was beneficial for a fast bring up of the new Tegra hardware,
> but the DRM driver shouldn't be time critical and so everything should
> be done to meet upstream quality from the start.
>
> -- Lucas
>
>

We have a team of interested engineers assigned to just that problem.
Fractured trees are not efficient for us internally either. We want 
upstream to be our common repository for most changes. And internally we 
have been stricter about conforming to Linux kernel coding conventions 
in attempt to give ourselves less work when we get to upstreaming a 
change. I'll be happy when I can tell my customers they can just grab 
the latest Tegra updates from git.kernel.org

Hopefully our efforts will begin to convince you.

- Jon
