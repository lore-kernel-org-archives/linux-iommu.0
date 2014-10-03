From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Fri, 3 Oct 2014 16:08:50 +0100
Message-ID: <20141003150850.GA32451@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
	<20140922091934.GH1470@ulmo> <20140922174337.GI7936@arm.com>
	<20140923071355.GI30514@ulmo> <20140924163338.GF16244@arm.com>
	<20140925064022.GC12423@ulmo> <20140930160035.GM2548@arm.com>
	<20141001084549.GE18463@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141001084549.GE18463@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On Wed, Oct 01, 2014 at 09:46:10AM +0100, Thierry Reding wrote:
> On Tue, Sep 30, 2014 at 05:00:35PM +0100, Will Deacon wrote:
> > On Thu, Sep 25, 2014 at 07:40:23AM +0100, Thierry Reding wrote:
> [...]
> > > So I think what we're going to need is a way to prevent the default
> > > attachment to DMA/IOMMU. Or alternatively not associate devices with
> > > IOMMU domains by default but let drivers explicitly make the decision.
> > 
> > Which drivers and how would they know what to do? I think you might be
> > jumping the gun a bit here, given where mainline is with using the IOMMU
> > for anything at all.
> 
> I don't think I am. I've been working on patches to enable IOMMU on
> Tegra, with the specific use-case that we want to use it to allow
> physically non-contiguous framebuffers to be used for scan out.
> 
> In order to do so the DRM driver allocates an IOMMU domain and adds both
> display controllers to it. When a framebuffer is created or imported
> from DMA-BUF, it gets mapped into this domain and both display
> controllers can use the IOVA address as the framebuffer base address.

Does that mean you manually swizzle the dma_map_ops for the device in the
DRM driver?

> Given that a device can only be attached to a single domain at a time
> this will cause breakage when the ARM glue code starts automatically
> attaching the display controllers to a default domain.

Why couldn't you just re-use the domain already allocated by the DMA mapping
API?

> > > > > What I proposed a while back was to leave it up to the IOMMU driver to
> > > > > choose an allocator for the device. Or rather, choose whether to use a
> > > > > custom allocator or the DMA/IOMMU integration allocator. The way this
> > > > > worked was to keep a list of devices in the IOMMU driver. Devices in
> > > > > this list would be added to domain reserved for DMA/IOMMU integration.
> > > > > Those would typically be devices such as SD/MMC, audio, ... devices that
> > > > > are in-kernel and need no per-process separation. By default devices
> > > > > wouldn't be added to a domain, so devices forming a composite DRM device
> > > > > would be able to manage their own domain.
> > > > 
> > > > I'd live to have as little of this as possible in the IOMMU drivers, as we
> > > > should leave those to deal with the IOMMU hardware and not domain
> > > > management. Having subsystems manage their own dma ops is an extension to
> > > > the dma-mapping API.
> > > 
> > > It's not an extension, really. It's more that both need to be able to
> > > coexist. For some devices you may want to create an IOMMU domain and
> > > hook it up with the DMA mapping functions, for others you don't and
> > > handle mapping to IOVA space explicitly.
> > 
> > I think it's an extension in the sense that mainline doesn't currently do
> > what you want, regardless of this patch series.
> 
> It's interesting since you're now the second person to say this. Can you
> please elaborate why you think that's the case?

Because the only way to set up DMA through an IOMMU on ARM is via the
arm_iommu_* functions, which are currently called from a subset of the
IOMMU drivers themselves:

  drivers/gpu/drm/exynos/exynos_drm_iommu.c
  drivers/iommu/ipmmu-vmsa.c
  drivers/iommu/shmobile-iommu.c
  drivers/media/platform/omap3isp/isp.c

Of these, ipmmu-vmsa.c and shmobile.c both allocate a domain per device.
The omap3 code seems to do something similar. That just leaves the exynos
driver, which Marek has been reworking anyway.

> I do have local patches that allow precisely this use-case to work
> without changes to the IOMMU core or requiring any extra ARM-specific
> glue.
> 
> There's a fair bit of jumping through hoops, because for example you
> don't know what IOMMU instance a domain belongs to at .domain_init()
> time, so I have to defer most of the actual domain initalization until a
> device is actually attached to it, but I digress.
> 
> > > Doing so would leave a large number of address spaces available for
> > > things like a GPU driver to keep per-process address spaces for
> > > isolation.
> > > 
> > > I don't see how we'd be able to do that with the approach that you
> > > propose in this series since it assumes that each device will be
> > > associated with a separate domain.
> > 
> > No, that's an artifact of the existing code on ARM. My series adds a list of
> > domains to each device, but those domains are per-IOMMU instance and can
> > appear in multiple lists.
> 
> So you're saying the end result will be that there's a single domain per
> IOMMU device that will be associated with all devices that have a master
> interface to it?

Yes, that's the plan. Having thought about it some more (after your
comments), subsystems can still call of_dma_deconfigure if they want to do
their own IOMMU domain management. That may well be useful for things like
VFIO, for example.

Will
