From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 1/1] dt: Add general DMA window parser
Date: Wed, 18 Apr 2012 21:39:45 +0200
Message-ID: <20120418193945.GA17960@avionic-0098.mockup.avionic-design.de>
References: <201204180731.54064.arnd@arndb.de>
 <20120418.121824.1894043789811063795.hdoyu@nvidia.com>
 <20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
 <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
 <4F8EF99E.3050709@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F8EF99E.3050709-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/18/2012 04:19 AM, Hiroshi Doyu wrote:
>=20
> > Subject: [PATCH 1/1] dt: Add general DMA window parser
> >=20
> > This code was stolen from:
> > 	"arch/microblaze/kernel/prom_parse.c"
> > 	"arch/powerpc/kernel/prom_parse.c"
> >=20
> > Once "ibm," prefix is removed from dts file. This generic one could
> > replace the originals.
>=20
> > +extern void of_parse_dma_window(struct device_node *dn,
> > +		       const void *dma_window_prop, unsigned long *busno,
> > +			       unsigned long *phys, unsigned long *size);
>=20
> At least some other of_*() parsing functions take the property name
> rather than the property pointer, and also take an index into the
> property in order to support multiple entries in it. See for example
> of_parse_phandle and of_get_named_gpio_flags. Should this new API be
> similar? E.g.:
>=20
> extern void of_parse_dma_window(struct device_node *np,
> 			const char *propname, int index,
> 			unsigned long *busno,
> 			unsigned long *phys, unsigned long *size);

In that case the function should return int for proper error handling.

Thierry

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+PGIEACgkQZ+BJyKLjJp/TmwCgqmaeyIo2ApmynI2aLd0x4v6I
DnMAn0zVjr/IijFS1PwjM5ltCt0z46/I
=UQOh
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
