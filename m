From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Wed, 11 Apr 2012 16:34:56 +0200
Message-ID: <20120411143456.GM4296@phenom.ffwll.local>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
 <20120411124810.GK4296@phenom.ffwll.local>
 <20120411132326.GD27337@avionic-0098.adnet.avionic-design.de>
 <20120411133512.GL4296@phenom.ffwll.local>
 <20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120411141108.GI27337-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 11, 2012 at 04:11:08PM +0200, Thierry Reding wrote:
> * Daniel Vetter wrote:
> > On Wed, Apr 11, 2012 at 03:23:26PM +0200, Thierry Reding wrote:
> > > * Daniel Vetter wrote:
> > > > On Wed, Apr 11, 2012 at 02:10:30PM +0200, Thierry Reding wrote:
> > > > > This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> > > > > currently has rudimentary GEM support and can run a console on the
> > > > > framebuffer as well as X using the xf86-video-modesetting driver.
> > > > > Only the RGB output is supported. Quite a lot of things still need
> > > > > to be worked out and there is a lot of room for cleanup.
> > > > 
> > > > Indeed, after a quick look there are tons of functions that are just stubs
> > > > ;-) One thing I wonder though is why you directly use the iommu api and
> > > > not wrap it up into dma_map? Is arm infrastructure just not there yet or
> > > > do you plan to tightly integrate the tegra drm with the iommu (e.g. for
> > > > process space switching or similarly funky stuff)?
> > > 
> > > I'm not sure I know what you are referring to. Looking for all users of
> > > iommu_map() doesn't turn up anything related to dma_map. Can you point me in
> > > the right direction?
> > 
> > Well, you use the iommu api to map/unmap memory into the iommu for tegra,
> > whereas usually device drivers just use the dma api to do that. The usual
> > interface is dma_map_sg/dma_unmap_sg, but there are quite a few variants
> > around. I'm just wondering why this you've choosen this.
> 
> I don't think this works on ARM. Maybe I'm not seeing the whole picture but
> judging by a quick look through the kernel tree there aren't any users that
> map DMA memory through an IOMMU.
> 
> Maybe your question is answered by my reply to Alan's comment. The mapping
> is actually done to get a linear view for the display controller which
> doesn't support SG transfers. The kernel and user-space already have virtual
> linear buffers.

Hm, in that case it looks like your iommu works more like the gtt on intel
chips and less like the iommu on intel platforms (which we access through
the dma_map api). I wonder whether that will end up in some layering fun
together with dma_buf, which conceptually is at the same level as the dma
api, which usually uses an underlying iommu exposed with the iommu api
you're using.

> Perhaps I'm being dense?

Doesn't sound like that over here ;-)
-Daniel
-- 
Daniel Vetter
Mail: daniel-/w4YWyX8dFk@public.gmane.org
Mobile: +41 (0)79 365 57 48
