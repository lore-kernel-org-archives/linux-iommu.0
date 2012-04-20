From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Fri, 20 Apr 2012 08:05:11 +0200
Message-ID: <1334901911.1361.11.camel@tellur>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	 <20120419173537.GA7692@avionic-0098.adnet.avionic-design.de>
	 <CAPM=9tzK83yYS33eNruvFDwb62ycZxJMC31davVRN=yaZD53YA@mail.gmail.com>
	 <20120419204016.GA8954@avionic-0098.mockup.avionic-design.de>
	 <4F907CBB.4080705@nvidia.com>
	 <20120420050231.GA15313@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120420050231.GA15313-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am Freitag, den 20.04.2012, 07:02 +0200 schrieb Thierry Reding:
> * Jon Mayo wrote:
> > On 04/19/2012 01:40 PM, Thierry Reding wrote:
> [...]
> > >So would it be possible to get a basic dumb KMS driver into mainline
> > >(non-staging) and phase in acceleration later on, with ABI guarantees? I
> > >guess development can go on in separate trees until the ABI is stable and can
> > >subsequently be ported to the mainline driver.
> > >
> > >Is that an acceptable approach?
> > 
> > That certainly seems like the most reasonable approach to me. Get
> > KMS only in first. It's a useful driver as-is, and has the lowest
> > barrier to entry into upstream.
> > 
> > Then later we can phase in enhancements. We certainly have plenty of
> > places internally and externally to hash out acceleration
> > interfaces, and come to some consensus at at later date (either on
> > linux-tegra or direct email).
> 
> Okay. Let's do that then.

Yes, I think we should go the route that Jerome Glisse pointed out: get
in a basic KMS driver first and hide any accel ioctl under a staging
config option.
> 
> > We have a lot of concerns here. What is best for X11, what is best
> > for Android, how do we keep healthy open source implementations, and
> > how does NVIDIA move forward with supporting new Tegra on an open
> > source implementation.
> 
> I think by supporting the DRM we can get pretty far for X11. Writing a Tegra-
> specific driver based off xf86-video-modesetting can be done to use advanced
> features if they can't be abstracted away properly. DRM also paves the way
> for Wayland support.
> 
> What I see as somewhat of a problem is how to get NVIDIA and the community to
> work together (and work together well). We'll have to see how this works out,
> but I'd hate to see more resources wasted because everybody starts doing
> their own thing.

I'm really interested how this turns out in the end. I hope we can get a
somewhat stable cooperation between NVIDIA and the community, like AMD
has established at the moment.
> 
> > (My vote is NVIDIA starts using this DRM in-house and builds new
> > extensions on top of it, sharing patches on LKML when the hardware is
> > released)
> 
> That sounds like a good plan. Ideally you should even share the patches as
> soon as they're ready. That'll give viewers some head start and you can fix
> the code even before the hardware is released.

One thing I would like to have is upstream first. We have seen much
Tegra development in both the nv-linux and chromium trees, but those
things are going upstream extremely slowly. I can understand that this
strategy was beneficial for a fast bring up of the new Tegra hardware,
but the DRM driver shouldn't be time critical and so everything should
be done to meet upstream quality from the start.

-- Lucas
