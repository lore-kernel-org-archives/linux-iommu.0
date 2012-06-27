From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 16:44:14 +0200
Message-ID: <20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
References: <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
	<20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
	<23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
	<4FEA6E09.30800@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
	<4FEA7472.7050201@nvidia.com>
	<20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
	<20120627155907.871b2a506374b7db14c202c4@nvidia.com>
	<20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
	<20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8953374950568745894=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120627172914.30a2ccfd1344161ca7724722-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============8953374950568745894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 05:29:14PM +0300, Hiroshi Doyu wrote:
> On Wed, 27 Jun 2012 16:08:10 +0200
> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
>=20
> > * PGP Signed by an unknown key
> >=20
> > On Wed, Jun 27, 2012 at 03:59:07PM +0300, Hiroshi Doyu wrote:
> > > On Wed, 27 Jun 2012 07:14:18 +0200
> > > Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > >=20
> > > > > Old Signed by an unknown key
> > > >=20
> > > > On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> > > > > On 06/26/2012 08:32 PM, Mark Zhang wrote:
> > > > > >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> > > > > >>>>> On Tue, 26 Jun 2012 12:55:13 +0200
> > > > > >>>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > > > >> ...
> > > > > >>>> I'm not sure I understand how information about the carveout=
 would be
> > > > > >>>> obtained from the IOMMU API, though.
> > > > > >>>
> > > > > >>> I think that can be similar with current gart implementation.=
 Define carveout as:
> > > > > >>>
> > > > > >>> carveout {
> > > > > >>>         compatible =3D "nvidia,tegra20-carveout";
> > > > > >>>         size =3D <0x10000000>;
> > > > > >>> };
> > > > > >>>
> > > > > >>> Then create a file such like "tegra-carveout.c" to get these =
definitions and
> > > > > >> register itself as platform device's iommu instance.
> > > > > >>
> > > > > >> The carveout isn't a HW object, so it doesn't seem appropriate=
 to define a DT
> > > > > >> node to represent it.
> > > > > >=20
> > > > > > Yes. But I think it's better to export the size of carveout as =
a configurable item.
> > > > > > So we need to define this somewhere. How about define carveout =
as a property of gart?
> > > > >=20
> > > > > There already exists a way of preventing Linux from using certain=
 chunks
> > > > > of memory; the /memreserve/ syntax. From a brief look at the dtc =
source,
> > > > > it looks like /memreserve/ entries can have labels, which implies=
 that a
> > > > > property in the GART node could refer to the /memreserve/ entry by
> > > > > phandle in order to know what memory regions to use.
> > > >=20
> > > > Wasn't the whole point of using a carveout supposed to be a replace=
ment
> > > > for the GART?
> > >=20
> > > Mostly agree. IIUC, we use both carveout/gart allocated buffers in
> > > android/tegra2.
> > >=20
> > > >As such I'd think the carveout should rather be a property
> > > > of the host1x device.
> > >=20
> > > Rather than introducing a new property, how about using
> > > "coherent_pool=3D??M" in the kernel command line if necessary? I think
> > > that this carveout size depends on the system usage/load.
> >=20
> > I was hoping that we could get away with using the CMA and perhaps
> > initialize it based on device tree content. I agree that the carveout
> > size depends on the use-case, but I still think it makes sense to
> > specify it on a per-board basis.
>=20
> DRM driver doesn't know if it uses CMA or not, because DRM only uses
> DMA API.

So how is the DRM supposed to allocate buffers? Does it call the
dma_alloc_from_contiguous() function to do that? I can see how it is
used by arm_dma_ops but how does it end up in the driver?

> I think that "coherent_pool" can be used only when the amount of
> contiguous memory is short in your system. Otherwise even unnecessary.
>=20
> Could you explain a bit more why you want carveout size on per-board basi=
s?

In the ideal case I would want to not have a carveout size at all.
However there may be situations where you need to make sure some driver
can allocate a given amount of memory. Having to specify this using a
kernel command-line parameter is cumbersome because it may require
changes to the bootloader or whatever. So if you know that a particular
board always needs 128 MiB of carveout, then it makes sense to specify
it on a per-board basis.

Thierry

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP6xw+AAoJEN0jrNd/PrOhPOsP/AraLTe+WKLPpm4EsoJ5ScTH
ZrICyamedR3fkqCbNVlGtIy7BC5r48Ye9Da3uWRr+8Uji0WQ5BRAY8wyPu/uONEu
v1y0m5rT+q+VdU6HwOWLrFWXByDNm6qzwNoqDczp0Jh1+LuQb3VRkknmFzeBwefJ
s00aXSdVC7nAn6WRDFTnwoAKZr3HrIHo0dZavjm32SbED4c0cnRxtg+H2aoHwddU
351yPjAUsliZkB8mL0taM4WheUPko5qQGoWMYAj2vA8RKRnP5xpDvrZOHG9jDIwZ
lcs9qGX/sVVKtNBODHwmqwGTgFxB2aegJ8pT8w7KtYp4w3YzPk5kQhqN/Yia+ZBM
HZ5iYbeuFMZ6o7hYgXos8+fNI8E6cLzAJrOjajU2Dtfgh0aVir4FFzEABU0td3OV
ir2qbFnRfWp8/0jYW90qjv7r1zzTbBzTrgHDd/5Q8kCLPe7afINSSNJ5/sYrRGEW
RZ5nQ8bHX1ko9YWR8wK2gWmH/5teDBHr/5aaZsBoJGYziq3p8jWcrRF9Rm77xHkX
n8BLqsEsQZjdXd2ePtaikgRP0FdrkVF7dCJp+SVtboWtvbeZrP+n6+3yIrKHzwX5
RCsL9z+QwKrFieT3WMev7xpdqEAf5MQYAIbzdLfsnIKsKnjHj4sHbBd/VdcrMbI/
P2RvqUzp3VkJl+2DIX1K
=3DD+
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

--===============8953374950568745894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8953374950568745894==--
