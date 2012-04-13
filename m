From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Fri, 13 Apr 2012 14:15:10 +0200
Message-ID: <20120413121510.GD11605@avionic-0098.mockup.avionic-design.de>
References: <20120413.132205.1766846402066131036.hdoyu@nvidia.com>
 <20120413110331.GA11605@avionic-0098.mockup.avionic-design.de>
 <20120413.143104.1310879848248152784.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120413.143104.1310879848248152784.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Hiroshi Doyu wrote:
> Thierry Reding wrote:
> > * Hiroshi Doyu wrote:
> > > +	smmu: smmu@7000f000 {
> > > +		compatible =3D "nvidia,tegra30-smmu";
> > > +		reg =3D < 0x7000f000 0x400	/* controller registers */
> > > +			0x6000c000 0x150	/* AHB Arbitration registers */
> > > +			0x00001000 0x3ffff000 >;/* Virtual address space range
> > > +						 * Exclude the 1st & last page
> > > +						 */
> > > +		interrupts =3D < 0 13 0x40 >;
> > > +	};
> > >  };
> >=20
> > Why is the virtual address space range limited to 1 GiB? What is the re=
ason
> > for the exclusion of the first and last pages?
>=20
> It's because physical RAM is located 2-4GB, and we may want to use
> those area 1-1(V=3D=3DP) mapping in some cases. This could be extended
> with larger RAM without 1-1 mapping theoretically. So far 1GB seems to
> be enough.

I'm thinking that this would be better off in a separate property so that
it's easier for boards to override it.

> The 1st page for AVP vector, and the last one is required by another
> H/W entity.

I would expect such peculiarities to be handled by the driver internally.
That way users wouldn't have to know or care about these kind of details.
If it can't be handled by the driver then at least it should be mentioned
explicitly in the binding documentation.

Thierry

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+IGM4ACgkQZ+BJyKLjJp+C2gCeOtlvbUu0bZNTLdZz4g5IHH03
ScQAnRBKFM0xpBIbRGWamS7kdX5eg2Gp
=hUR+
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
