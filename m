From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 6 Oct 2014 11:52:50 +0200
Message-ID: <20141006095249.GA25202@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
	<20140922091934.GH1470@ulmo> <20140922174337.GI7936@arm.com>
	<20140923071355.GI30514@ulmo> <20140924163338.GF16244@arm.com>
	<20140925064022.GC12423@ulmo> <20140930160035.GM2548@arm.com>
	<20141001084549.GE18463@ulmo> <20141003150850.GA32451@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2252837032028041639=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141003150850.GA32451-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2252837032028041639==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2014 at 04:08:50PM +0100, Will Deacon wrote:
> Hi Thierry,
>=20
> On Wed, Oct 01, 2014 at 09:46:10AM +0100, Thierry Reding wrote:
> > On Tue, Sep 30, 2014 at 05:00:35PM +0100, Will Deacon wrote:
> > > On Thu, Sep 25, 2014 at 07:40:23AM +0100, Thierry Reding wrote:
> > [...]
> > > > So I think what we're going to need is a way to prevent the default
> > > > attachment to DMA/IOMMU. Or alternatively not associate devices with
> > > > IOMMU domains by default but let drivers explicitly make the decisi=
on.
> > >=20
> > > Which drivers and how would they know what to do? I think you might be
> > > jumping the gun a bit here, given where mainline is with using the IO=
MMU
> > > for anything at all.
> >=20
> > I don't think I am. I've been working on patches to enable IOMMU on
> > Tegra, with the specific use-case that we want to use it to allow
> > physically non-contiguous framebuffers to be used for scan out.
> >=20
> > In order to do so the DRM driver allocates an IOMMU domain and adds both
> > display controllers to it. When a framebuffer is created or imported
> > from DMA-BUF, it gets mapped into this domain and both display
> > controllers can use the IOVA address as the framebuffer base address.
>=20
> Does that mean you manually swizzle the dma_map_ops for the device in the
> DRM driver?

No. It means we use the IOMMU API directly instead of the DMA mapping
API.

> > Given that a device can only be attached to a single domain at a time
> > this will cause breakage when the ARM glue code starts automatically
> > attaching the display controllers to a default domain.
>=20
> Why couldn't you just re-use the domain already allocated by the DMA mapp=
ing
> API?

Because I don't see how you'd get access to it. And provided that we
could do that it would also mean that there'd be at least two domains
(one for each display controller) and we'd need to decide on using a
single one of them. Which one do we choose? And what about the unused
one? If there's no way to detach it we loose a precious resource.

> > > > > > What I proposed a while back was to leave it up to the IOMMU dr=
iver to
> > > > > > choose an allocator for the device. Or rather, choose whether t=
o use a
> > > > > > custom allocator or the DMA/IOMMU integration allocator. The wa=
y this
> > > > > > worked was to keep a list of devices in the IOMMU driver. Devic=
es in
> > > > > > this list would be added to domain reserved for DMA/IOMMU integ=
ration.
> > > > > > Those would typically be devices such as SD/MMC, audio, ... dev=
ices that
> > > > > > are in-kernel and need no per-process separation. By default de=
vices
> > > > > > wouldn't be added to a domain, so devices forming a composite D=
RM device
> > > > > > would be able to manage their own domain.
> > > > >=20
> > > > > I'd live to have as little of this as possible in the IOMMU drive=
rs, as we
> > > > > should leave those to deal with the IOMMU hardware and not domain
> > > > > management. Having subsystems manage their own dma ops is an exte=
nsion to
> > > > > the dma-mapping API.
> > > >=20
> > > > It's not an extension, really. It's more that both need to be able =
to
> > > > coexist. For some devices you may want to create an IOMMU domain and
> > > > hook it up with the DMA mapping functions, for others you don't and
> > > > handle mapping to IOVA space explicitly.
> > >=20
> > > I think it's an extension in the sense that mainline doesn't currentl=
y do
> > > what you want, regardless of this patch series.
> >=20
> > It's interesting since you're now the second person to say this. Can you
> > please elaborate why you think that's the case?
>=20
> Because the only way to set up DMA through an IOMMU on ARM is via the
> arm_iommu_* functions,

No, you can use the IOMMU API directly just fine.

> which are currently called from a subset of the IOMMU drivers themselves:
>=20
>   drivers/gpu/drm/exynos/exynos_drm_iommu.c
>   drivers/iommu/ipmmu-vmsa.c
>   drivers/iommu/shmobile-iommu.c
>   drivers/media/platform/omap3isp/isp.c
>=20
> Of these, ipmmu-vmsa.c and shmobile.c both allocate a domain per device.
> The omap3 code seems to do something similar. That just leaves the exynos
> driver, which Marek has been reworking anyway.

Right, and as I remember one of the things that Marek did was introduce
a flag to mark drivers as doing their own IOMMU domain management so
that they wouldn't be automatically associated with a "mapping".

> > I do have local patches that allow precisely this use-case to work
> > without changes to the IOMMU core or requiring any extra ARM-specific
> > glue.
> >=20
> > There's a fair bit of jumping through hoops, because for example you
> > don't know what IOMMU instance a domain belongs to at .domain_init()
> > time, so I have to defer most of the actual domain initalization until a
> > device is actually attached to it, but I digress.
> >=20
> > > > Doing so would leave a large number of address spaces available for
> > > > things like a GPU driver to keep per-process address spaces for
> > > > isolation.
> > > >=20
> > > > I don't see how we'd be able to do that with the approach that you
> > > > propose in this series since it assumes that each device will be
> > > > associated with a separate domain.
> > >=20
> > > No, that's an artifact of the existing code on ARM. My series adds a =
list of
> > > domains to each device, but those domains are per-IOMMU instance and =
can
> > > appear in multiple lists.
> >=20
> > So you're saying the end result will be that there's a single domain per
> > IOMMU device that will be associated with all devices that have a master
> > interface to it?
>=20
> Yes, that's the plan. Having thought about it some more (after your
> comments), subsystems can still call of_dma_deconfigure if they want to do
> their own IOMMU domain management. That may well be useful for things like
> VFIO, for example.

I think it's really weird to set up some complicated data structures at
early boot without knowing that they'll ever be used and then require
drivers to undo that if they decide not to use it.

As mentioned in an earlier reply I don't see why we need to set this all
up that early in the boot in the first place. It only becomes important
right before a driver's .probe() is called because the device can't
perform any DMA-related operations before that point in time.

Now if we postpone initialization of the IOMMU masters and swizzling of
the DMA operations until driver probe time we get rid of a lot of
problems. For example we could use deferred probing if the IOMMU driver
hasn't loaded yet. That in turn would allow IOMMU drivers to be built as
modules rather than built-in. And especially with multi-platform kernels
I think we really want to build as much as possible as modules.

Thierry

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMmZxAAoJEN0jrNd/PrOhy3AQAJMLjmoyFnFLEmfQs5G9ggTw
q2OsCj5JNDvzx5zDQBtpQrwhlhJecz3IEjwUgYhTBwoBvjX20NqrL+2fDdOsjoLZ
A4rETmnyvKQmlVx1rOhxmUpBJgE6A5RGImjI51mP0m8OW8GGehWUHQiqXGf18zVn
4vDZE8/mDhdbMeN7NNp8m0I29hsA+ZBm/Qi9DH06HtcyaYD4k69IiV2guAB9Dy2w
fSsQt7GWBwbTN6vLaXjztvWiOXnWH+mb0f6W/yaSRMDoUIwlET2h4X7Ge5Ig6lqR
ZDDAF6TKUyDHzwH/41UdPynuUY6KZPw1X9Vlwco423O/jt/UE0jdtg+EMhi/wlFo
4Rsjg7S2FF6z0Q3oc3OC2B52XQf479ebAjN89WLng0ztQX7qZoYUS3NXzVmZEKQR
vwBg1JpeyJWvE5e+tRGul2TWtPmi7hL/6WCDnVlFUsTsciF70KF6wMaeV9Q66hH4
cuSwyWDIotrWUxFnezhC0l6Pmn9Cx1twcq8fRY69twAFG7mTuRSYhVbTVzCF4Aqu
iGN8W+1h5s9rPgZQdIGjZRO0Dlqicx4MOt0nky85+WIHdMJ1MT+2Qp2NxXy2B2i/
dzH5O2pfpLIzF+k71cax6Ed3ZkJTivI+llUciTSHKR6R6OTAVyo71NnUTGO4oTT8
Ql2KSqtCruf0RXa9rIP0
=OfCL
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

--===============2252837032028041639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2252837032028041639==--
