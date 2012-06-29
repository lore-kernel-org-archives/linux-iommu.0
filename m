From: =?UTF-8?B?VGVyamUgQmVyZ3N0csO2bQ==?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Fri, 29 Jun 2012 16:20:31 +0300
Message-ID: <4FEDAB9F.5040406@nvidia.com>
References: <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>  <4FEA6E09.30800@nvidia.com>  <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>  <4FEA7472.7050201@nvidia.com>  <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>  <20120627155907.871b2a506374b7db14c202c4@nvidia.com>  <20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>  <20120627172914.30a2ccfd1344161ca7724722@nvidia.com>  <20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>  <1340812795.1350.7.camel@antimon>  <20120628111253.GC15137@avionic-0098.mockup.avionic-design.de>  <4FEC8B91.6010107@wwwdotorg.org> <1340903992.1348.27.camel@antimon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340903992.1348.27.camel@antimon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 28.06.2012 20:19, Lucas Stach wrote:
> TTM though solves more advanced matters, like buffer synchronisation
> between 3D and 2D block of hardware or syncing buffer access between GPU
> and CPU.
> One of the most interesting things of TTM is the ability to purge the
> GPU DMA buffers to scattered sysmem or even swap them out, if they are
> not currently used by the GPU. It then makes sure to move them in the
> contig space again when the GPU really needs them and fix up the GPU
> command stream with the new buffer address.

We preferably should choose dma_buf as a common interface towards
buffers. That way whatever we choose as the memory manager, all dma_buf
aware drivers will be able to use buffers allocated by other drivers.

We probably need to accommodate multiple memory managers to take care of
legacy and new drivers. If V4L2 and DRM projects all move to dma_buf, we
have the possibility to do zero-copy video without forcing everybody to
use the same memory manager.

As I understand, TTM is good for platforms where we have a separate
frame buffer memory, as is the case with most of the graphics cards. In
Tegra, graphics and CPU occupy the same memory, so I'm not sure if we
require the level of functionality that TTM provides. I guess the level
of functionality and the complexity that it brings is one reason why TTM
hasn't really caught on in the ARM world.

The synchronization primitives attached to TTM are slightly confusing.
At the bottom level, it's operations which need to be synchronized
between each other. That's the API level that we should to export from
kernel to user space. It's then up to libdrm level (or whatever is doing
the rendering in user space) to decide which operations it wants to have
completed before a buffer can be reused/read/passed on to the next stage.

Anyway, if we hide the memory manager behind dma_buf, we're free to muck
around with multiple of them and see what works best.

Terje
