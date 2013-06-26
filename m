From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 18/23] iommu/tegra: smmu: Workaround PCIe IOMMU'able
Date: Wed, 26 Jun 2013 13:15:37 +0200
Message-ID: <20130626111537.GR27083@manwe>
References: <1372238906-9346-19-git-send-email-hdoyu@nvidia.com>
 <20130626110626.GO27083@manwe>
 <20130626.140906.1216615781918366349.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q8a9NmTVi5AMeZ2v"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130626.140906.1216615781918366349.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--Q8a9NmTVi5AMeZ2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 01:09:06PM +0200, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 13:06:=
27 +0200:
>=20
> > * PGP Signed by an unknown key
> >=20
> > On Wed, Jun 26, 2013 at 12:28:21PM +0300, Hiroshi Doyu wrote:
> > > Make PCIe work as it is. IOMMU support can be implemented later.
> > >=20
> > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  drivers/iommu/tegra-smmu.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >=20
> > Can you provide more information about what the problem is here? Why is
> > PCIe not working when mapped through the IOMMU?
>=20
> I haven't had a code to register PCI device as IOMMU'able as
> ops->add_device() does for platform_devices. I'll add this comment.

Okay, that should be solved then when we merge the PCIe driver. I hope
that can happen soon.

Thierry

--Q8a9NmTVi5AMeZ2v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRys1ZAAoJEN0jrNd/PrOhOSYQAMGzs4dTD/mlJ2q8UWGj5+zN
mhIxG3mpX9yjJDOCmwyB1bN0V+G7x1NmSkWlh5YQoW0WaRBhPoiVwAiIqbttp9k1
ipHCQr5sIKUBoYftWVLS1CKqM6RDjfGTFbv2mR9qoRftH46lrKlU1JzpQRVp7HJo
EO0M28WTtBHxSbJvPL2vkW9LstBYolaRg9lOROSGtC95b7gJIcTFGXxHnobWKEst
h88K7w2I/NagVm4LWiy+CHvqzdocp72XjzztRSwt/PbnpaItLtpK9V5wYG8NkwAp
0mYyjAOfKIk83qtu57Y+EgNMWrrINXSFyONo4plzicRzB4Xr0n1qpASisG+kpkik
jR7nRujPK7KfoQ6ShgHQ3wHFLbNbAKNVcWBf+OO9vdD+TO5Xqlu5k5tePVdbvPg+
iJ2P6I7GsfcZL4i6eW2SaWr/rK0hnyEDHCdCSHUf3GC9WS5Q5x+ETQ64G6S78Jjt
3V9R8xi9pvSLaK76lK/erRyeAofjVppH5HMiqblL69P4EYacQXTk4MtkZPAStoku
/27fQZPc862+8Kw8oCvnlTkqwa7VAdBo70xhY13f1HHGLdDwKdOdg7uEKUguxgZJ
opmamQZffXi7DmtLmaNGMVwQ9+DKfI1nTBYevzl9A/PgHysr8S+fzoFCfMJwkdV4
VOzVVJjYTQq6OL4Plge2
=YrJv
-----END PGP SIGNATURE-----

--Q8a9NmTVi5AMeZ2v--
