From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dt: tegra20: Add GART device
Date: Sat, 14 Apr 2012 10:30:59 +0200
Message-ID: <20120414083059.GB12281@avionic-0098.mockup.avionic-design.de>
References: <1334322489-837-1-git-send-email-thierry.reding@avionic-design.de>
 <1334322489-837-3-git-send-email-thierry.reding@avionic-design.de>
 <4F8880E6.5070301@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F8880E6.5070301-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/13/2012 07:08 AM, Thierry Reding wrote:
> > This commit adds the device node required to probe NVIDIA Tegra 20 GART
> > hardware from the device tree.
>=20
> > diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-teg=
ra/board-dt-tegra20.c
>=20
> > +	OF_DEV_AUXDATA("nvidia,tegra20-gart", TEGRA_MC_BASE, "tegra-gart", NU=
LL),
>=20
> That's only needed if lookup tables (e.g. for clocks) require that the
> device have a specific name. I don't believe the GART is mentioned in
> any such lookup tables, so I think you can drop that change.

I'll remove that hunk.

Thierry

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+JNcMACgkQZ+BJyKLjJp9k/ACeMrpovTOOuYWoxWhsRjoNM84N
fqwAoJ+nybOHztIdz/Gc6h3ZITbFg2wB
=rkUD
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
