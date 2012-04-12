From: Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 11:56:01 -0700
Message-ID: <4F872541.3050200@nvidia.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de> <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de> <20120411124810.GK4296@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120411124810.GK4296-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On 04/11/2012 05:48 AM, Daniel Vetter wrote:
> On Wed, Apr 11, 2012 at 02:10:30PM +0200, Thierry Reding wrote:
>> This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
>> currently has rudimentary GEM support and can run a console on the
>> framebuffer as well as X using the xf86-video-modesetting driver.
>> Only the RGB output is supported. Quite a lot of things still need
>> to be worked out and there is a lot of room for cleanup.
>
> Indeed, after a quick look there are tons of functions that are just stubs
> ;-) One thing I wonder though is why you directly use the iommu api and
> not wrap it up into dma_map? Is arm infrastructure just not there yet or
> do you plan to tightly integrate the tegra drm with the iommu (e.g. for
> process space switching or similarly funky stuff)?
>
> Yours, Daniel

An abstraction to access iommu is preferable since Tegra2 and Tegra3 are 
quite a bit different when it comes to iommu.

But so far I'm pretty pleased with the driver Thierry has done. I'm 
hoping we can start using this as a base instead of the fb based driver 
that never made it upstream. (even if I have had a bit of a debate about 
GEM v. TTM v. ION v. ...)

- Jon
