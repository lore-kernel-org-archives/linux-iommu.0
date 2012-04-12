From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Fri, 13 Apr 2012 01:10:18 +0200
Message-ID: <1334272218.1619.11.camel@antimon>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<20120411133512.GL4296@phenom.ffwll.local>
	<20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
	<201204111518.41968.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201204111518.41968.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Am Mittwoch, den 11.04.2012, 15:18 +0000 schrieb Arnd Bergmann:
> On Wednesday 11 April 2012, Thierry Reding wrote:
> >   * Daniel Vetter wrote:
> > > On Wed, Apr 11, 2012 at 03:23:26PM +0200, Thierry Reding wrote:
> > > > * Daniel Vetter wrote:
> > > > > On Wed, Apr 11, 2012 at 02:10:30PM +0200, Thierry Reding wrote:
> > > > > > This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> > > > > > currently has rudimentary GEM support and can run a console on the
> > > > > > framebuffer as well as X using the xf86-video-modesetting driver.
> > > > > > Only the RGB output is supported. Quite a lot of things still need
> > > > > > to be worked out and there is a lot of room for cleanup.
> > > > > 
> > > > > Indeed, after a quick look there are tons of functions that are just stubs
> > > > > ;-) One thing I wonder though is why you directly use the iommu api and
> > > > > not wrap it up into dma_map? Is arm infrastructure just not there yet or
> > > > > do you plan to tightly integrate the tegra drm with the iommu (e.g. for
> > > > > process space switching or similarly funky stuff)?
> > > > 
> > > > I'm not sure I know what you are referring to. Looking for all users of
> > > > iommu_map() doesn't turn up anything related to dma_map. Can you point me in
> > > > the right direction?
> > > 
> > > Well, you use the iommu api to map/unmap memory into the iommu for tegra,
> > > whereas usually device drivers just use the dma api to do that. The usual
> > > interface is dma_map_sg/dma_unmap_sg, but there are quite a few variants
> > > around. I'm just wondering why this you've choosen this.
> > 
> > I don't think this works on ARM. Maybe I'm not seeing the whole picture but
> > judging by a quick look through the kernel tree there aren't any users that
> > map DMA memory through an IOMMU.
> 
> 
> dma_map_sg is certainly the right interface to use, and Marek Szyprowski has
> patches to make that work on ARM, hopefully going into v3.5, so you could
> use those.

Just jumping in here to make sure everyone understands the limitations
of the Tegra 2 GART IOMMU we are talking about here. It has no isolation
capabilities and a really small remapping window of 32MB. So it's
impossible to remap every buffer used by the graphics engines. The only
sane way to handle this is to set aside a chunk of stolen system memory
as VRAM and let a memory manager like TTM handle the allocation of
linear regions and GART mappings. This means a more tight integration of
the DRM driver and the IOMMU, where I think that using the IOMMU API
directly and completely controlling the GART from one driver is the
right way to go for a number of reasons, where my biggest concern is
that we can't implement a sane out-of-remapping space when we go through
the dma_map API.

It's too late for me to go into the details now, but I wanted to make it
clear that I think that using the IOMMU only and exclusively from the
DRM driver with a high level of tie in is the way to go. If you want to
know more details I'm available to discuss this matter in the next days.

-- Lucas
> 
> 	Arnd
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
