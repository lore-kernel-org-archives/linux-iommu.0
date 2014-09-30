From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Tue, 30 Sep 2014 17:00:35 +0100
Message-ID: <20140930160035.GM2548@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
	<20140922091934.GH1470@ulmo> <20140922174337.GI7936@arm.com>
	<20140923071355.GI30514@ulmo> <20140924163338.GF16244@arm.com>
	<20140925064022.GC12423@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140925064022.GC12423@ulmo>
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

On Thu, Sep 25, 2014 at 07:40:23AM +0100, Thierry Reding wrote:
> On Wed, Sep 24, 2014 at 05:33:38PM +0100, Will Deacon wrote:
> > On Tue, Sep 23, 2014 at 08:14:01AM +0100, Thierry Reding wrote:
> > > On Mon, Sep 22, 2014 at 06:43:37PM +0100, Will Deacon wrote:
> > > > Yup. In this case, the iommu_dma_mapping passed to arch_setup_dma_ops
> > > > contains a domain and an allocator for each IOMMU instance in the system.
> > > > It would then be up to the architecture how it makes use of those, but
> > > > the most obvious thing to do would be to attach devices mastering through
> > > > an IOMMU instance to that per-instance domain.
> > > > 
> > > > The other use-case is isolation (one domain per device), which I guess
> > > > matches what the ARM code is doing at the moment.
> > > 
> > > I think there are two cases here. You can have a composite device that
> > > wants to manage a single domain (using its own allocator) for a set of
> > > hardware devices. At the same time a set of devices (think 2D and 3D
> > > engines) could want to use a multiple domains for process separation.
> > > In that case I'd expect a logical DRM device to allocate one domain per
> > > process and then associate the 2D and 3D engines with that same domain
> > > on process switch.
> > 
> > Sure, but that's well outside of what the dma-mapping API is going to setup
> > as a default domain. These specialist setups are certainly possible, but I
> > think they should be driven by, for example, the DRM code as opposed to
> > being in the core dma-mapping code.
> 
> I completely agree that these special cases should be driven by the
> drivers that need them. However the problem here is that the current
> patch will already attach the device to an IOMMU domain by default.

Sure, but that's not an unfixable problem if somebody cares enough to do it.
Right now, I see a small handful of callers for the IOMMU API and nearly all
of them would work perfectly well with a default domain. The big exception
to that is VFIO, but that requires the device to be unbound from the host
driver, so we could detach the mapping at that point.

> So I think what we're going to need is a way to prevent the default
> attachment to DMA/IOMMU. Or alternatively not associate devices with
> IOMMU domains by default but let drivers explicitly make the decision.

Which drivers and how would they know what to do? I think you might be
jumping the gun a bit here, given where mainline is with using the IOMMU
for anything at all.

> > > What I proposed a while back was to leave it up to the IOMMU driver to
> > > choose an allocator for the device. Or rather, choose whether to use a
> > > custom allocator or the DMA/IOMMU integration allocator. The way this
> > > worked was to keep a list of devices in the IOMMU driver. Devices in
> > > this list would be added to domain reserved for DMA/IOMMU integration.
> > > Those would typically be devices such as SD/MMC, audio, ... devices that
> > > are in-kernel and need no per-process separation. By default devices
> > > wouldn't be added to a domain, so devices forming a composite DRM device
> > > would be able to manage their own domain.
> > 
> > I'd live to have as little of this as possible in the IOMMU drivers, as we
> > should leave those to deal with the IOMMU hardware and not domain
> > management. Having subsystems manage their own dma ops is an extension to
> > the dma-mapping API.
> 
> It's not an extension, really. It's more that both need to be able to
> coexist. For some devices you may want to create an IOMMU domain and
> hook it up with the DMA mapping functions, for others you don't and
> handle mapping to IOVA space explicitly.

I think it's an extension in the sense that mainline doesn't currently do
what you want, regardless of this patch series. My motivation is to enable
IOMMU-backed DMA-mapping so that I can continue implementing the virtual
SMMU work I started a while back. Patches welcome to enable any other
use-cases -- I don't think they're mutually exclusive.

> There is another issue with the approach you propose. I'm not sure if
> Tegra is special in this case (I'd expect not), but what we do is make
> an IOMMU domain correspond to an address space. Address spaces are a
> pretty limited resource (earlier generations have 4, newer have 128)
> and each address space can be up to 4 GiB. So I've always envisioned
> that we should be using a single IOMMU domain for devices that don't
> expose direct buffer access to userspace (SATA, PCIe, audio, SD/MMC,
> USB, ...). All of those would typically need only a small number of
> small buffers, so using a separate address space for each seems like a
> big waste.

I agree here, the ARM DMA-mapping code should really be doing one domain
per SMMU instance; all I've done is hook up the existing code which wasn't
previously being called.

> Doing so would leave a large number of address spaces available for
> things like a GPU driver to keep per-process address spaces for
> isolation.
> 
> I don't see how we'd be able to do that with the approach that you
> propose in this series since it assumes that each device will be
> associated with a separate domain.

No, that's an artifact of the existing code on ARM. My series adds a list of
domains to each device, but those domains are per-IOMMU instance and can
appear in multiple lists.

Will
