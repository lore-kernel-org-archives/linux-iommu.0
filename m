From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Add dummy implementations for !IOMMU_IOVA
Date: Wed, 22 Mar 2017 19:07:59 +0100
Message-ID: <20170322180759.GA2113@ulmo.ba.sec>
References: <20170320191128.26474-1-thierry.reding@gmail.com>
 <20170320191128.26474-2-thierry.reding@gmail.com>
 <20170320191431.GF14787@ulmo.ba.sec>
 <20170322145530.GC7315@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170322145530.GC7315-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 03:55:30PM +0100, Joerg Roedel wrote:
> Hi Thierry
>=20
> On Mon, Mar 20, 2017 at 08:14:31PM +0100, Thierry Reding wrote:
> > I've got a series of patches that I'd like to merge for v4.12 that have
> > a build-time dependency on this patch. It would therefore be great to
> > get your Acked-by on this so that I can merge it through the DRM tree
> > with the rest of the patches. I can provide a stable branch with only
> > this patch for you to pull into the IOMMU tree.
>=20
> I applied both patches to my 'core' branch. There is not much in there
> yet besides your patches, so you can easily pull that branch in once it
> is published (later today).

Works for me. Thanks!

Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljSvXwACgkQ3SOs138+
s6EFhA//T5LFaDVujdLOGQsZvFtVo/k/DSxBJ4f6dD/tJ53NANQKXRuAPoGhQ8nk
sJkZlD2NFBehhF3RGTMleZMJGThWOX/mCzL8FGVTTZsLOuL0VzdxCAphSjEWUziw
dyOoFnvb3XMTAAEXqUwadR8oKtld2ESwlC+A9yAvkDeX1of8yFmfCzyDk7sMvnK7
Hi9h9szr51d6Ls+54MveW3SUpJgs/2CBfSAJfBnw0q12iSgw7giAzgCmYbd/uTqB
+Bbh2Gfad4tzicuJDQ90dds+5gryXJnufffdLLWvyc51TB/Y/qJTYrGnUFVokAiX
FfnUZ87aDmEAJca7n6x8FUAQkH1jhUts4N1dD4SdII4P+9hWY60ykhKDBRAD91BK
R/kO4ldwM9RZvFDvewVIXnW/+/eVEj1UIzQtiKfgPb96aXzCazFAwJPjk6+eJOzy
8Dn/XvNzU1xfa9on1NK1rGQ5WfXJNJ3o+IeJnUwTBRvX1CRe+aHyzdHMhVElgxXH
oGjoQCwvDzxgPdcajkVJK0MaahOWRV99Pma13p520UOqRihcqVNUamIUKoaeqAvL
jhu5cPUMR9LhSnnelUgWmGilTFoowbeYdAU27m9OaZ0lDWaJ0mHnl3DcKMsv/ERH
Ev98FJzpjqw8mjhGArEInRg9++9Y+UN6a9OqwSopBhaLiH0Mxaw=
=tvK4
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
