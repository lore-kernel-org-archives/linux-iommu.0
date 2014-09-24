From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Wed, 24 Sep 2014 17:33:38 +0100
Message-ID: <20140924163338.GF16244@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
	<20140922091934.GH1470@ulmo> <20140922174337.GI7936@arm.com>
	<20140923071355.GI30514@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140923071355.GI30514@ulmo>
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

On Tue, Sep 23, 2014 at 08:14:01AM +0100, Thierry Reding wrote:
> On Mon, Sep 22, 2014 at 06:43:37PM +0100, Will Deacon wrote:
> > Yup. In this case, the iommu_dma_mapping passed to arch_setup_dma_ops
> > contains a domain and an allocator for each IOMMU instance in the system.
> > It would then be up to the architecture how it makes use of those, but
> > the most obvious thing to do would be to attach devices mastering through
> > an IOMMU instance to that per-instance domain.
> > 
> > The other use-case is isolation (one domain per device), which I guess
> > matches what the ARM code is doing at the moment.
> 
> I think there are two cases here. You can have a composite device that
> wants to manage a single domain (using its own allocator) for a set of
> hardware devices. At the same time a set of devices (think 2D and 3D
> engines) could want to use a multiple domains for process separation.
> In that case I'd expect a logical DRM device to allocate one domain per
> process and then associate the 2D and 3D engines with that same domain
> on process switch.

Sure, but that's well outside of what the dma-mapping API is going to setup
as a default domain. These specialist setups are certainly possible, but I
think they should be driven by, for example, the DRM code as opposed to
being in the core dma-mapping code.

> What I proposed a while back was to leave it up to the IOMMU driver to
> choose an allocator for the device. Or rather, choose whether to use a
> custom allocator or the DMA/IOMMU integration allocator. The way this
> worked was to keep a list of devices in the IOMMU driver. Devices in
> this list would be added to domain reserved for DMA/IOMMU integration.
> Those would typically be devices such as SD/MMC, audio, ... devices that
> are in-kernel and need no per-process separation. By default devices
> wouldn't be added to a domain, so devices forming a composite DRM device
> would be able to manage their own domain.

I'd live to have as little of this as possible in the IOMMU drivers, as we
should leave those to deal with the IOMMU hardware and not domain
management. Having subsystems manage their own dma ops is an extension to
the dma-mapping API.

Will
