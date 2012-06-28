From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 13:12:53 +0200
Message-ID: <20120628111253.GC15137@avionic-0098.mockup.avionic-design.de>
References: <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
 <4FEA6E09.30800@nvidia.com>
 <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
 <4FEA7472.7050201@nvidia.com>
 <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
 <20120627155907.871b2a506374b7db14c202c4@nvidia.com>
 <20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
 <20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
 <20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
 <1340812795.1350.7.camel@antimon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1340812795.1350.7.camel@antimon>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 05:59:55PM +0200, Lucas Stach wrote:
> Am Mittwoch, den 27.06.2012, 16:44 +0200 schrieb Thierry Reding:
> > On Wed, Jun 27, 2012 at 05:29:14PM +0300, Hiroshi Doyu wrote:
> > > On Wed, 27 Jun 2012 16:08:10 +0200
> > > Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > >=20
> > > > * PGP Signed by an unknown key
> > > >=20
> > > > On Wed, Jun 27, 2012 at 03:59:07PM +0300, Hiroshi Doyu wrote:
> > > > > On Wed, 27 Jun 2012 07:14:18 +0200
> > > > > Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > > >=20
> > > > > > > Old Signed by an unknown key
> > > > > >=20
> > > > > > On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> > > > > > > On 06/26/2012 08:32 PM, Mark Zhang wrote:
> > > > > > > >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> > > > > > > >>>>> On Tue, 26 Jun 2012 12:55:13 +0200
> > > > > > > >>>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > > > > > >> ...
> > > > > > > >>>> I'm not sure I understand how information about the carv=
eout would be
> > > > > > > >>>> obtained from the IOMMU API, though.
> > > > > > > >>>
> > > > > > > >>> I think that can be similar with current gart implementat=
ion. Define carveout as:
> > > > > > > >>>
> > > > > > > >>> carveout {
> > > > > > > >>>         compatible =3D "nvidia,tegra20-carveout";
> > > > > > > >>>         size =3D <0x10000000>;
> > > > > > > >>> };
> > > > > > > >>>
> > > > > > > >>> Then create a file such like "tegra-carveout.c" to get th=
ese definitions and
> > > > > > > >> register itself as platform device's iommu instance.
> > > > > > > >>
> > > > > > > >> The carveout isn't a HW object, so it doesn't seem appropr=
iate to define a DT
> > > > > > > >> node to represent it.
> > > > > > > >=20
> > > > > > > > Yes. But I think it's better to export the size of carveout=
 as a configurable item.
> > > > > > > > So we need to define this somewhere. How about define carve=
out as a property of gart?
> > > > > > >=20
> > > > > > > There already exists a way of preventing Linux from using cer=
tain chunks
> > > > > > > of memory; the /memreserve/ syntax. From a brief look at the =
dtc source,
> > > > > > > it looks like /memreserve/ entries can have labels, which imp=
lies that a
> > > > > > > property in the GART node could refer to the /memreserve/ ent=
ry by
> > > > > > > phandle in order to know what memory regions to use.
> > > > > >=20
> > > > > > Wasn't the whole point of using a carveout supposed to be a rep=
lacement
> > > > > > for the GART?
> > > > >=20
> > > > > Mostly agree. IIUC, we use both carveout/gart allocated buffers in
> > > > > android/tegra2.
> > > > >=20
> > > > > >As such I'd think the carveout should rather be a property
> > > > > > of the host1x device.
> > > > >=20
> > > > > Rather than introducing a new property, how about using
> > > > > "coherent_pool=3D??M" in the kernel command line if necessary? I =
think
> > > > > that this carveout size depends on the system usage/load.
> > > >=20
> > > > I was hoping that we could get away with using the CMA and perhaps
> > > > initialize it based on device tree content. I agree that the carveo=
ut
> > > > size depends on the use-case, but I still think it makes sense to
> > > > specify it on a per-board basis.
> > >=20
> > > DRM driver doesn't know if it uses CMA or not, because DRM only uses
> > > DMA API.
> >=20
> > So how is the DRM supposed to allocate buffers? Does it call the
> > dma_alloc_from_contiguous() function to do that? I can see how it is
> > used by arm_dma_ops but how does it end up in the driver?
> >=20
> As I said before the DMA API is not a good fit for graphics drivers.
> Most of the DMA buffers used by graphics cores are long lived and big,
> so we need a special pool to alloc from to avoid eating all contiguous
> address space, as DMA API does not provide shrinker callbacks for
> clients using large amount of memory.

I recall you mentioning TTM as a better alternative several times in the
past. How does it fit in with this? Does it have the capability of using
a predefined chunk of contiguous memory as a pool to allocate from?

One problem that all of these solutions don't address is that not all
devices below host1x are DRM related. At least for the CSI and VI blocks
I expect there to be V4L2 drivers eventually, so what we really need is
to manage allocations outside of the DRM. host1x is the most logical
choice here.

Perhaps we can put host1x code somewhere below drivers/gpu (mm
subdirectory?), drivers/memory or perhaps some other or new location
that could eventually host similar drivers for other SoCs.

Then again, maybe it'd be easier for now to put everything below the
drivers/gpu/drm/tegra directory and cross that bridge when we get to it.

> > > I think that "coherent_pool" can be used only when the amount of
> > > contiguous memory is short in your system. Otherwise even unnecessary.
> > >=20
> > > Could you explain a bit more why you want carveout size on per-board =
basis?
> >=20
> > In the ideal case I would want to not have a carveout size at all.
> > However there may be situations where you need to make sure some driver
> > can allocate a given amount of memory. Having to specify this using a
> > kernel command-line parameter is cumbersome because it may require
> > changes to the bootloader or whatever. So if you know that a particular
> > board always needs 128 MiB of carveout, then it makes sense to specify
> > it on a per-board basis.
>=20
> If we go with CMA, this is a non-issue, as CMA allows to use the contig
> area for normal allocations and only purges them if it really needs the
> space for contig allocs.

CMA certainly sounds like the most simple approach. While it may not be
suited for 3D graphics or multimedia processing later on, I think we
could use it at a starting point to get basic framebuffer and X support
up and running. We can always move to something more advanced like TTM
later.

Thierry

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP7Dw0AAoJEN0jrNd/PrOhT58P/R3xVK9ksqXLT3j6W1Xbt471
QhNMgKjJ5AxdV6qC1thNW+hyxkQwuOdApEHoeForwO7ohkwATXeYNTmCftmicy2y
P19aUhngDbcyT4OkVoFTXYmQYIH+ceDJh/xORUTlwQUG9NCE9s6Y8VER0+1hhNP7
MExvdL8KJG+NJ4aIyXfMpCm76KZHwaYbDHNdAiy977tsNJJqJEQ1yRCeWRcjNmQ3
GP06x5YoBMkrRp1X773BcdiLiZUdwdhSB+fYhFqH+2itIViuK9GFs2yTUDi5LKek
Ji1aWyiZ+NIddNyaN15cbfmcpQwOPbVVWxUlpc4a603tvvXyAPSyIeb87OlyQ21x
8AXUXL1isYNBamZgSehjNZXETptMYYK6/NKYcr96G1Lb3g9FFI9UCSQdm3wVrw2E
t5z/Wcm+kq/xGB2Z0dNguR+Y/4jfgh8un6oGVKAykwJL13e+qz0C03SZPxYoYcjL
SAeKgJkTuI3/AZhnzixgdKj3Lpvws/M13DR0xZhnstc/96NoH0cxIQP0DErVPiGZ
BL0c4uSeqtrf9Zp9CF7TbjApEbglxaRnA6wJHH/6L45Q4OwiXhDO5uW6brgHwMeD
ZTRk7z4XqARCyxIhvDnJmGwRc86Ug+OWwCJRKOdNDpRxAI+PI6icwlETFh8AJKx5
r1kL0FW/9OhYpHmqR210
=FfYZ
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
