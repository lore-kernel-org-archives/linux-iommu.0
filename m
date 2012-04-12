From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 09:16:31 -0400
Message-ID: <CADnq5_Oiez8zAHqFw-_qXk=3PnnEqgm3ir9M3KsWaQr-dLS5pw@mail.gmail.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412092106.GU3852@pengutronix.de>
	<20120412093301.GB23336@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120412093301.GB23336-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 12, 2012 at 5:33 AM, Thierry Reding
<thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> * Sascha Hauer wrote:
>> You might want to have a look at the sdrm patches I recently posted to
>> dri-devel and arm Linux Kernel. Among other things they allow to
>> register crtcs/connectors/encoders seperately so that each of them can
>> have its own representation in the devicetree. I haven't looked into
>> devicetree support for DRM, but with or without devicetree the problem
>> that we do not have a single PCI card for registering all DRM components
>> is the same.
>
> I'll do that. One interesting use-case that's been on my mind for some time
> is if it would be possible to provide a CRTC via DRM that isn't part of the
> SoC or DRM "device" but which can display a framebuffer prepared by the DRM
> framework.
>
> In other words I would like to use the Tegra hardware to render content into
> a framebuffer (using potentially the 3D engine or HW accelerated video
> decoding blocks) but display that framebuffer with a CRTC registered by a
> different driver (perhaps provided by a PCIe or USB device).
>
> I think such a setup would be possible if the CRTC registration can be
> decoupled from the DRM driver. Perhaps sdrm even supports that already?

You should be able to do something like that already with dma_buf and
the drm prime infrastructure.  There's even a drm driver for the udl
USB framebuffer devices.

Alex
