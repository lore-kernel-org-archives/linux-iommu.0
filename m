From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Tue, 23 Sep 2014 09:14:01 +0200
Message-ID: <20140923071355.GI30514@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
	<20140922091934.GH1470@ulmo> <20140922174337.GI7936@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8302422256182219736=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140922174337.GI7936-5wv7dgnIgG8@public.gmane.org>
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


--===============8302422256182219736==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aFi3jz1oiPowsTUB"
Content-Disposition: inline


--aFi3jz1oiPowsTUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 06:43:37PM +0100, Will Deacon wrote:
> Hi Thierry,
>=20
> On Mon, Sep 22, 2014 at 10:19:35AM +0100, Thierry Reding wrote:
> > On Fri, Sep 12, 2014 at 05:34:55PM +0100, Will Deacon wrote:
> > [...]
> > > +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base=
, u64 size)
> > > +{
> > > +	struct dma_iommu_mapping *mapping;
> > > +
> > > +	mapping =3D arm_iommu_create_mapping(dev->bus, dma_base, size);
> >=20
> > If I understand correctly this will be called for each device that has
> > an IOMMU master interface and will end up creating a new mapping for
> > each of the devices. Each of these mappings will translate to a domain
> > in the IOMMU API, which in turn is a separate address space.
>=20
> Correct, although that's largely because I've bolted on the existing ARM
> IOMMU code.
>=20
> > How do you envision to support use-cases where a set of devices need to
> > share a single domain? This is needed for example in DRM where SoCs
> > often have a set of hardware blocks (each with its own master interface)
> > that compose the display device. On Tegra for example there are two
> > display controllers that need access to the same IOVA domain so that
> > they can scan out framebuffers.
>=20
> Yup. In this case, the iommu_dma_mapping passed to arch_setup_dma_ops
> contains a domain and an allocator for each IOMMU instance in the system.
> It would then be up to the architecture how it makes use of those, but
> the most obvious thing to do would be to attach devices mastering through
> an IOMMU instance to that per-instance domain.
>=20
> The other use-case is isolation (one domain per device), which I guess
> matches what the ARM code is doing at the moment.

I think there are two cases here. You can have a composite device that
wants to manage a single domain (using its own allocator) for a set of
hardware devices. At the same time a set of devices (think 2D and 3D
engines) could want to use a multiple domains for process separation.
In that case I'd expect a logical DRM device to allocate one domain per
process and then associate the 2D and 3D engines with that same domain
on process switch.

What I proposed a while back was to leave it up to the IOMMU driver to
choose an allocator for the device. Or rather, choose whether to use a
custom allocator or the DMA/IOMMU integration allocator. The way this
worked was to keep a list of devices in the IOMMU driver. Devices in
this list would be added to domain reserved for DMA/IOMMU integration.
Those would typically be devices such as SD/MMC, audio, ... devices that
are in-kernel and need no per-process separation. By default devices
wouldn't be added to a domain, so devices forming a composite DRM device
would be able to manage their own domain.

Thierry

--aFi3jz1oiPowsTUB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUIR2zAAoJEN0jrNd/PrOhPwQP/3ply0aOr0rOC0WaQhdG8ZGs
IbKGmqDPQUGzU091ewIp6nNy8C9/hMMhFNKIITIEKc6XRuF2f4r8CuIE+m/n+2rI
VXFkrDYK/Uj6rc/0YioBqftN5CGUY4X/bWOEppR2YbHdNNML0BbvG81e0EQOuCuL
38zD1ELDKpHXqED724bA9JK0ypkTCm3DkRl/xC9Y5CRchKlcEm1UyDJyEZQh0dYw
GlAt7gp3RDw/xwX+t3VjrWwPpE6lwaPGaSU4CLnNJjfy4ARM5t5ZYdzNb+FX54NO
DoHKUmzIeYk5zZYVK0DJe3HcpCt95PAXtCALtM5n4ZQJ4JYRweZQ7pSxGCW4ramM
o5GDwbPmRqhxz0DXyavgptwLwcSD9t4rlxIje0lHyAlOwJF+GDmaT2zZzzWYypT5
wvnYueKH2JX1t6Ip136kyBjj8R6/Y3AZ80dOim8nRaX7TEMDWVVCILx80+Cl2qhf
1TCsoYPGoGUqt10WEr8+mKru+bIXP5OE/vv8EtYxTOMZ5krZIgu9kkzIdZ5ybN/q
Yjy9b7B4iDTjODjBbvkxCGQWLZXEZ5rSju1e5Zdp9F+lmkMCxqxIHpRxjmxlh2mK
PR4BKvHEvq7YBJLqc8aaoKIXs9nb+T0d2zosBALVLkpb798eqUkPW+D7Qj2uxqpW
SrpM/762KpH386j9+wl2
=IImn
-----END PGP SIGNATURE-----

--aFi3jz1oiPowsTUB--

--===============8302422256182219736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8302422256182219736==--
