From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 16:08:10 +0200
Message-ID: <20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
 <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
 <20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
 <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
 <4FEA6E09.30800@nvidia.com>
 <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
 <4FEA7472.7050201@nvidia.com>
 <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
 <20120627155907.871b2a506374b7db14c202c4@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120627155907.871b2a506374b7db14c202c4-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 03:59:07PM +0300, Hiroshi Doyu wrote:
> On Wed, 27 Jun 2012 07:14:18 +0200
> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
>=20
> > * PGP Signed by an unknown key
> >=20
> > On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> > > On 06/26/2012 08:32 PM, Mark Zhang wrote:
> > > >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> > > >>>>> On Tue, 26 Jun 2012 12:55:13 +0200
> > > >>>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > >> ...
> > > >>>> I'm not sure I understand how information about the carveout wou=
ld be
> > > >>>> obtained from the IOMMU API, though.
> > > >>>
> > > >>> I think that can be similar with current gart implementation. Def=
ine carveout as:
> > > >>>
> > > >>> carveout {
> > > >>>         compatible =3D "nvidia,tegra20-carveout";
> > > >>>         size =3D <0x10000000>;
> > > >>> };
> > > >>>
> > > >>> Then create a file such like "tegra-carveout.c" to get these defi=
nitions and
> > > >> register itself as platform device's iommu instance.
> > > >>
> > > >> The carveout isn't a HW object, so it doesn't seem appropriate to =
define a DT
> > > >> node to represent it.
> > > >=20
> > > > Yes. But I think it's better to export the size of carveout as a co=
nfigurable item.
> > > > So we need to define this somewhere. How about define carveout as a=
 property of gart?
> > >=20
> > > There already exists a way of preventing Linux from using certain chu=
nks
> > > of memory; the /memreserve/ syntax. From a brief look at the dtc sour=
ce,
> > > it looks like /memreserve/ entries can have labels, which implies tha=
t a
> > > property in the GART node could refer to the /memreserve/ entry by
> > > phandle in order to know what memory regions to use.
> >=20
> > Wasn't the whole point of using a carveout supposed to be a replacement
> > for the GART?
>=20
> Mostly agree. IIUC, we use both carveout/gart allocated buffers in
> android/tegra2.
>=20
> >As such I'd think the carveout should rather be a property
> > of the host1x device.
>=20
> Rather than introducing a new property, how about using
> "coherent_pool=3D??M" in the kernel command line if necessary? I think
> that this carveout size depends on the system usage/load.

I was hoping that we could get away with using the CMA and perhaps
initialize it based on device tree content. I agree that the carveout
size depends on the use-case, but I still think it makes sense to
specify it on a per-board basis.

Thierry

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP6xPJAAoJEN0jrNd/PrOhJ3oP/0mw+fMmdGd/2X+zEHYFw28B
TUxZl8giqBaPPpCPQMlZVgPQB10MKiXaR7qOHPu9FQd93n3zOSpD7PPZcpq56nOW
ZF10T6rPbP1a52coRAyhO+qALxpikazNo5E9kcaHnHA7mTF0dbBhvMS0F3U4SBU0
OOaWs7mc+ketFvr4Eff1FIO/OUX83hzQD0OVQeWfDGOnlG752ibJYJ5DDkgHmEby
Ly/NN8heuY/Omw0pF4o98zCGRc/auRZrJjm5Byp1UCquZJcgK+d1qcVto92tfFO7
WqNYrRk6JdX/+Qc5R2uSBl/1ti75ETLJQhf2dfUWck+K9HaJ5U4A6p9AdVrWdTCT
WGsqA6EnRyJimCKIxnZ0Zl/PjnQf0R8u3h6i9EZvJuqHqCFYvzn/VYb0z3iE78+K
LKBjFdU0CbXP+ZTalToRudU8y6OabYXw+AxqBF9ZBW0rRt3cSQohWaltIExhLAbz
jvG7TboNl+YDiwq95odvXw88Fr+zehSp5FQOnFD3zbkMlRlph0Lbx47KrrddOiEJ
FhCLFrs+oh8u75rJR9O3NdeK+nJyWHopOC9ANDEn2GpbNsAgMM3+zwnZ0pGlgMsu
jMaMtCOvL8UhhTiwZwA19wDl1SlWPrfvy5KBiDYBej7oRwnIx/n9bDeIMXT4lGP9
gihbgdHlpftuZXydgjH5
=tHnW
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
