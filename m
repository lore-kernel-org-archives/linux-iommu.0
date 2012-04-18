From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Wed, 18 Apr 2012 07:41:40 +0200
Message-ID: <20120418054140.GA17506@avionic-0098.adnet.avionic-design.de>
References: <20120413.143104.1310879848248152784.hdoyu@nvidia.com>
 <4F887DA0.8030103@wwwdotorg.org>
 <20120416.141238.381304581863200083.hdoyu@nvidia.com>
 <201204161534.20089.arnd@arndb.de>
 <20120418081746.995724e27bdc726049cd4965@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120418081746.995724e27bdc726049cd4965-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Hiroshi Doyu wrote:
> On Mon, 16 Apr 2012 17:34:19 +0200
> Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>=20
> > On Monday 16 April 2012, Hiroshi Doyu wrote:
> > > What about using "dma-window" property to specify IOVA range in dtsi =
as below?
> > >=20
> > > arch/powerpc/platforms/cell/iommu.c:
> > >=20
> > > 698 static int __init cell_iommu_get_window(struct device_node *np,
> > > 699                                          unsigned long *base,
> > > 700                                          unsigned long *size)
> > > 701 {
> > > 702         const void *dma_window;
> > > 703         unsigned long index;
> > > 704
> > > 705         /* Use ibm,dma-window if available, else, hard code ! */
> > > 706         dma_window =3D of_get_property(np, "ibm,dma-window", NULL=
);
> > > 707         if (dma_window =3D=3D NULL) {          ^^^^^^^^^^^^^^
> > > 708                 *base =3D 0;
> > > 709                 *size =3D 0x80000000u;
> > > 710                 return -ENODEV;
> > > 711         }
> > > 712
> > > 713         of_parse_dma_window(np, dma_window, &index, base, size);
> > > 714         return 0;
> > > 715 }
> > >=20
> >=20
> > Yes, that's the right way to do it, but I would use the more generic
> > "dma-window" name rather than "ibm,dma-window", which was originally
> > introduced for pseries and for some reason copied into the cell qs2x
> > firmware.
>=20
> Which name is better, "dma-window" or "iova-window"?
> Considering DMA IOMMU mapping API, "dma-window" may sound appropriate to =
me.

But the window isn't necessarily used for DMA transfers. I was going to
propose "aperture", but that doesn't seem quite right since it is a very
GART-specific term. "iova-window" sounds like the best fit for what it
really is.

Thierry

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+OVBQACgkQZ+BJyKLjJp9DOACgnvSXLcXTpgZNdRyJ+12Boy75
MRAAn1fEqtr/4+M5OjJiiED4CQHtujW1
=sxqx
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
