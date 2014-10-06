From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 6 Oct 2014 15:05:38 +0200
Message-ID: <20141006130537.GB26921@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<20141003150850.GA32451@arm.com> <20141006095249.GA25202@ulmo>
	<2912965.b2dYoMRt61@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5560166590195848530=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2912965.b2dYoMRt61@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============5560166590195848530==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 01:50:40PM +0300, Laurent Pinchart wrote:
> Hi Thierry and Will,
>=20
> On Monday 06 October 2014 11:52:50 Thierry Reding wrote:
> > On Fri, Oct 03, 2014 at 04:08:50PM +0100, Will Deacon wrote:
> > > On Wed, Oct 01, 2014 at 09:46:10AM +0100, Thierry Reding wrote:
> > >> On Tue, Sep 30, 2014 at 05:00:35PM +0100, Will Deacon wrote:
> > >>> On Thu, Sep 25, 2014 at 07:40:23AM +0100, Thierry Reding wrote:
> > >> [...]
> > >>=20
> > >>>> So I think what we're going to need is a way to prevent the default
> > >>>> attachment to DMA/IOMMU. Or alternatively not associate devices wi=
th
> > >>>> IOMMU domains by default but let drivers explicitly make the
> > >>>> decision.
> > >>>=20
> > >>> Which drivers and how would they know what to do? I think you might=
 be
> > >>> jumping the gun a bit here, given where mainline is with using the
> > >>> IOMMU for anything at all.
> > >>=20
> > >> I don't think I am. I've been working on patches to enable IOMMU on
> > >> Tegra, with the specific use-case that we want to use it to allow
> > >> physically non-contiguous framebuffers to be used for scan out.
> > >>=20
> > >> In order to do so the DRM driver allocates an IOMMU domain and adds =
both
> > >> display controllers to it. When a framebuffer is created or imported
> > >> from DMA-BUF, it gets mapped into this domain and both display
> > >> controllers can use the IOVA address as the framebuffer base address.
> > >=20
> > > Does that mean you manually swizzle the dma_map_ops for the device in=
 the
> > > DRM driver?
> >=20
> > No. It means we use the IOMMU API directly instead of the DMA mapping
> > API.
>=20
> Is there a reason why you can't use the DMA mapping API for this, assumin=
g of=20
> course that it would provide a way to attach both display controllers to =
the=20
> same domain ? Do you need to have explicit control over the VA at which t=
he=20
> buffers are mapped ?

I suppose I could use the DMA mapping API at least for the display parts
if both controllers could be attached to the same domain. However when
we get to the 2D and 3D parts we will probably want to switch the IOMMU
domain depending on the userspace context to prevent applications from
stepping on each other's toes.

And no, I don't need to have explicit control over which VA the buffers
get mapped to.

> > >> Given that a device can only be attached to a single domain at a time
> > >> this will cause breakage when the ARM glue code starts automatically
> > >> attaching the display controllers to a default domain.
> > >=20
> > > Why couldn't you just re-use the domain already allocated by the DMA
> > > mapping API?
> >=20
> > Because I don't see how you'd get access to it. And provided that we
> > could do that it would also mean that there'd be at least two domains
> > (one for each display controller) and we'd need to decide on using a
> > single one of them. Which one do we choose? And what about the unused
> > one? If there's no way to detach it we loose a precious resource.
>=20
> This would also be an issue for my Renesas IOMMU (ipmmu-vmsa) use cases. =
The=20
> IOMMU supports up to four domains (each of them having its own hardware T=
LB)=20
> and shares them between all the bus masters connected to the IOMMU. The=
=20
> connections between bus master and TLBs are configurable. I thus can't li=
ve=20
> with one domain being created per device.

I suppose one could fake this behind the curtains by making several
domains correspond to the same TLB (it sounds like pretty much the same
concept as an address space on Tegra). But that's just really nasty in
my opinion.

> > >>>>>> What I proposed a while back was to leave it up to the IOMMU
> > >>>>>> driver to choose an allocator for the device. Or rather, choose
> > >>>>>> whether to use a custom allocator or the DMA/IOMMU integration
> > >>>>>> allocator. The way this worked was to keep a list of devices in
> > >>>>>> the IOMMU driver. Devices in this list would be added to domain
> > >>>>>> reserved for DMA/IOMMU integration. Those would typically be
> > >>>>>> devices such as SD/MMC, audio, ... devices that are in-kernel
> > >>>>>> and need no per-process separation. By default devices wouldn't
> > >>>>>> be added to a domain, so devices forming a composite DRM device
> > >>>>>> would be able to manage their own domain.
>=20
> The problem with your solution is that it requires knowledge of all bus m=
aster=20
> devices in the IOMMU driver. That's not where that knowledge belongs, as =
it's=20
> a property of a particular SoC integration, not of the IOMMU itself.

Right. It will work nicely on Tegra where the IOMMU is closely tied to
the memory controller and therefore does in fact know about all of the
masters. It won't work for something more generic like the ARM SMMU
where the SoC integration really isn't a property of the IOMMU itself.

So Marek's proposal to mark drivers that don't need or want the DMA API
integration sounds like a pretty good alternative to me.

> > > Yes, that's the plan. Having thought about it some more (after your
> > > comments), subsystems can still call of_dma_deconfigure if they want =
to do
> > > their own IOMMU domain management. That may well be useful for things=
 like
> > > VFIO, for example.
> >=20
> > I think it's really weird to set up some complicated data structures at
> > early boot without knowing that they'll ever be used and then require
> > drivers to undo that if they decide not to use it.
> >=20
> > As mentioned in an earlier reply I don't see why we need to set this all
> > up that early in the boot in the first place. It only becomes important
> > right before a driver's .probe() is called because the device can't
> > perform any DMA-related operations before that point in time.
> >=20
> > Now if we postpone initialization of the IOMMU masters and swizzling of
> > the DMA operations until driver probe time we get rid of a lot of
> > problems. For example we could use deferred probing if the IOMMU driver
> > hasn't loaded yet. That in turn would allow IOMMU drivers to be built as
> > modules rather than built-in. And especially with multi-platform kernels
> > I think we really want to build as much as possible as modules.
>=20
> For what it's worth, given that I have no code to show, I was about to tr=
y=20
> implementing that when Will sent his patch set. My idea was to use a bus=
=20
> notifier in the IOMMU core to defer probing of devices for which the IOMM=
U=20
> isn't available yet based on the DT iommus property.

I already implemented something like that as part of an RFC that I sent
a while back[0] and specifically [1]. One variant of that had been
posted earlier by Hiroshi and it hooked nicely into the core so that it
would all happen transparently to the drivers. That earlier variant had
been NAK'ed because "we don't want that in the core", and my later
attempt was discussed a little and then ignored.

Thierry

[0]: https://lkml.org/lkml/2014/6/26/470
[1]: https://lkml.org/lkml/2014/6/26/476

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUMpOhAAoJEN0jrNd/PrOhwF4P/RDsnoBviJwbv/tyRuafGsb/
hUCMZU1UAexxdzjo26Fg1yA8nlNzZKVIw0ehMCtFRR1BAtEBX8fvyhP/UQlBGBHz
ULPKeTaC0xbum9WT5G9GIKRl+R0n5cRZLOyNmB7EKXSeCgxuv2x+Xn79ykFgg7H8
i77hnCAYcMwkaYNra7enat3OYNSiu2J7mRBs54AOPXFbs5gjgB0VpFQn7AJYvjBv
zqS5sZDfX9rmbjE0G1WC9ZmtQQgM1w10GZoRZoRcq1+DEgiE3LcPpVk1AL7bNyZT
ZPiAwJ64y4SQqlrfLOwW05k/uLN5OC344Qi1NvI4WMdsmbxfIj8MRzK00cCwfeow
LZIhvnNorD91IJeatA5XaqQSE+vY6jivoeeFNbchZDtmjcF7QTXv3wkCL8k8bLXQ
hAwwm5qVKmKl8IkmZyzU+0ljKfrOQdujvemlCb/uuRzPFzmZmgVR6BQIFGblEZvn
o1QMvhBrYIYc21D2Q0fo0nzE9JPbJ0pWTBrp7d83aN6TYozOV78idhH1mI9N4xxB
LuLev0Z/0t0nbgvDtgZLna8z2dSdt/exuYiu//LehphfLHHwQrTjzVDwHR0roKAg
HBAW9k2Q0El89WAdNoPjcps1fRKeAedoWBu/06N+Ck5utbno5vhPmmU9K6zWooAo
X/L7Ac9NftwyaVYpSsRJ
=sLkT
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--

--===============5560166590195848530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5560166590195848530==--
