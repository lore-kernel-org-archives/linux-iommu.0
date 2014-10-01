From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Wed, 1 Oct 2014 10:46:10 +0200
Message-ID: <20141001084549.GE18463@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
	<20140922091934.GH1470@ulmo> <20140922174337.GI7936@arm.com>
	<20140923071355.GI30514@ulmo> <20140924163338.GF16244@arm.com>
	<20140925064022.GC12423@ulmo> <20140930160035.GM2548@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2931713264405298162=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140930160035.GM2548-5wv7dgnIgG8@public.gmane.org>
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


--===============2931713264405298162==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 05:00:35PM +0100, Will Deacon wrote:
> On Thu, Sep 25, 2014 at 07:40:23AM +0100, Thierry Reding wrote:
[...]
> > So I think what we're going to need is a way to prevent the default
> > attachment to DMA/IOMMU. Or alternatively not associate devices with
> > IOMMU domains by default but let drivers explicitly make the decision.
>=20
> Which drivers and how would they know what to do? I think you might be
> jumping the gun a bit here, given where mainline is with using the IOMMU
> for anything at all.

I don't think I am. I've been working on patches to enable IOMMU on
Tegra, with the specific use-case that we want to use it to allow
physically non-contiguous framebuffers to be used for scan out.

In order to do so the DRM driver allocates an IOMMU domain and adds both
display controllers to it. When a framebuffer is created or imported
=66rom DMA-BUF, it gets mapped into this domain and both display
controllers can use the IOVA address as the framebuffer base address.

Given that a device can only be attached to a single domain at a time
this will cause breakage when the ARM glue code starts automatically
attaching the display controllers to a default domain.

> > > > What I proposed a while back was to leave it up to the IOMMU driver=
 to
> > > > choose an allocator for the device. Or rather, choose whether to us=
e a
> > > > custom allocator or the DMA/IOMMU integration allocator. The way th=
is
> > > > worked was to keep a list of devices in the IOMMU driver. Devices in
> > > > this list would be added to domain reserved for DMA/IOMMU integrati=
on.
> > > > Those would typically be devices such as SD/MMC, audio, ... devices=
 that
> > > > are in-kernel and need no per-process separation. By default devices
> > > > wouldn't be added to a domain, so devices forming a composite DRM d=
evice
> > > > would be able to manage their own domain.
> > >=20
> > > I'd live to have as little of this as possible in the IOMMU drivers, =
as we
> > > should leave those to deal with the IOMMU hardware and not domain
> > > management. Having subsystems manage their own dma ops is an extensio=
n to
> > > the dma-mapping API.
> >=20
> > It's not an extension, really. It's more that both need to be able to
> > coexist. For some devices you may want to create an IOMMU domain and
> > hook it up with the DMA mapping functions, for others you don't and
> > handle mapping to IOVA space explicitly.
>=20
> I think it's an extension in the sense that mainline doesn't currently do
> what you want, regardless of this patch series.

It's interesting since you're now the second person to say this. Can you
please elaborate why you think that's the case?

I do have local patches that allow precisely this use-case to work
without changes to the IOMMU core or requiring any extra ARM-specific
glue.

There's a fair bit of jumping through hoops, because for example you
don't know what IOMMU instance a domain belongs to at .domain_init()
time, so I have to defer most of the actual domain initalization until a
device is actually attached to it, but I digress.

> > Doing so would leave a large number of address spaces available for
> > things like a GPU driver to keep per-process address spaces for
> > isolation.
> >=20
> > I don't see how we'd be able to do that with the approach that you
> > propose in this series since it assumes that each device will be
> > associated with a separate domain.
>=20
> No, that's an artifact of the existing code on ARM. My series adds a list=
 of
> domains to each device, but those domains are per-IOMMU instance and can
> appear in multiple lists.

So you're saying the end result will be that there's a single domain per
IOMMU device that will be associated with all devices that have a master
interface to it?

Thierry

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUK79QAAoJEN0jrNd/PrOh+g8P/3Qq96LZiJx1T+0IUYASpfiJ
Bs24A3U0KL4ejbU4/msQFPULpUYoDaU2RBQWH1BxA37tuDYgcCkmoSssjrBLJiQl
tdqjHpRBXAXsdCLG0qUh4tVy6lKpc1qp9xvVDQqyN0NEpVNtp/jD/w7+U5Poa/PG
KsX9+zNz/H4dBd7vAQgfCjPNriMKv7WbOw1lAwmGxsCzYEjAuHU/tKR85fTIPI8p
QoSBAIh7xfSi5oS1aQ7U9RtS5JCKRE7dNv733sW74m1AWLrBj7B6u9gxIHLrwetn
u3J3FZv6yOFxPflz/uc9oJGQogs4GGc3pMyrgyxkxfXnU1VT9PYB4F3B4pPESIy0
5wDRsoPLni977grdvW9IEgH1zIXqRpGhb+bOmgZ2Uv+cAWq1tsHYhYsqUPcmDz2o
F05Fr1gVBfGwPosoEYhAuTjDP2IjVwFqcHbC9dkSHFCb8djHVkmmvd6uJSNF5/rg
bLW8Mv3xNZqXoCSTIkArSwP8yWuScOlmTQe5ILF8npkuvZAOk7h5YkN2JOsDY2CN
lw/1ZBpROJAIoJQolTsQM3aAuATsrZddKB3kZ+FjvM/55oo07LTDNqLeIVTi8wjB
x8PuCf9DjfOv0BLyo5DwGDcoAeXitEa6eB339Ttg4o4TBULKLRBRMmQKPnn9G3op
rZGukrY3QPF/iaJyBeU7
=q/L1
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--

--===============2931713264405298162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2931713264405298162==--
