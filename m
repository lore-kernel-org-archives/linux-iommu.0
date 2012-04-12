From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 10:09:10 -0400
Message-ID: <CADnq5_P-iGtCxtW+1Y2N34Q6WA5dUUC7ZxZNT29BXTAV0+VfpQ@mail.gmail.com>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<4F85C97E.50203@wwwdotorg.org>
	<20120412092106.GU3852@pengutronix.de>
	<20120412093301.GB23336@avionic-0098.mockup.avionic-design.de>
	<CADnq5_Oiez8zAHqFw-_qXk=3PnnEqgm3ir9M3KsWaQr-dLS5pw@mail.gmail.com>
	<20120412132531.GC5353@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120412132531.GC5353-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 12, 2012 at 9:25 AM, Thierry Reding
<thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> * Alex Deucher wrote:
>> On Thu, Apr 12, 2012 at 5:33 AM, Thierry Reding
>> <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
>> > In other words I would like to use the Tegra hardware to render co=
ntent into
>> > a framebuffer (using potentially the 3D engine or HW accelerated v=
ideo
>> > decoding blocks) but display that framebuffer with a CRTC register=
ed by a
>> > different driver (perhaps provided by a PCIe or USB device).
>> >
>> > I think such a setup would be possible if the CRTC registration ca=
n be
>> > decoupled from the DRM driver. Perhaps sdrm even supports that alr=
eady?
>>
>> You should be able to do something like that already with dma_buf an=
d
>> the drm prime infrastructure. =A0There's even a drm driver for the u=
dl
>> USB framebuffer devices.
>
> Using DRM PRIME requires user-space to be involved. I was thinking mo=
re along
> the lines of allowing a dumb DRM driver that only provides a CRTC to =
register
> with another driver so that it shows up as an output for the latter D=
RM
> device.

Even then it could get tricky with synchronization depending on the hw.

>
> Then again, having user-space control this may be more flexible. Perf=
ormance-
> wise both should be about the same, right? What I don't quite underst=
and yet
> is how the DMABUF would be synchronized on both ends. Is there some i=
nfra-
> structure to account for it or would I have to export two buffers and=
 flip
> them during the vblank of the "consumer"?

Performance should be about the same.  The tricky part is
synchronization.  dma_buf is for sharing.  There are ideas to make
generic sync objects, but for now, it's up to the userspace components
to handle it.

Alex
