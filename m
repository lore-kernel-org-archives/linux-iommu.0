From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 01/20] iommu/tegra: gart: Remove pr_fmt and clean up
	includes
Date: Mon, 24 Sep 2018 12:02:36 +0200
Message-ID: <20180924100236.GC21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-2-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1596455004870398520=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-2-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1596455004870398520==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:34AM +0300, Dmitry Osipenko wrote:
> Remove unneeded headers inclusion and sort the headers in alphabet order.
> Remove pr_fmt macro since there is no pr_*() in the code and it doesn't
> affect dev_*() functions.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotjwACgkQ3SOs138+
s6EJNQ/8C8OQQcJoWQDwGESE4ytOjiWHDNPhc0XsQEuG8u4DM5HYVyvVz/6JJueu
c4ULiv94xRlnFCUmMfRwx0KhShIcMtXOhYqsFKSfE8Fx8KANrJ9yN+MSVankOXa7
eHZKoa5YWrjdxO8zD0pCLh+GOE+3LCaiPfmdX+Rscx2istC7kVYD1FFqm1G8wyIs
seLgXm6kNU84PP/uAMYb0PqYJ49IT9TuZDoRZXeX8qaGBd7argRj8iDuZeQ9E0uQ
xyUTSh2Ap1WTDBQRiliUN/8G2ASQW/cmCfWACqxjk65t7eiEa6hSuGusLmpQm5t3
YWx7NdbbVD7QwJolk7wgaDZmzYhGtRjV+hHH1YnhrJ6mXXuInGvP45iCbCe8M1m1
XVcXpdf6PxX/QC1rep9NQl0rJ7as2RHlUrVlvb6JH3zCrPDNBeIITP6sG2gI6RYJ
f0Di5EcY2NwzJN7UOseUyM2dtcoqZF7308XB20XN2M+GRlPQ55MP2ihHgeU29AX0
wv4/uR8AVHAJxfRg5gm7cLZoGBiAD/YrcmJDjdwwAZBR7/3vmHCWy1irwmIBFCTZ
K46owmn08oWOST++7DTGQUpvtNLrU2F55Mwo+4noOgslxG9WD7QoV/EEUfZAVaRL
UHZ1IkoHHVRaXQgDHosZo+vakiWd5Vc5Vj2GukC+fnJK1+IdAdE=
=6xDZ
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--===============1596455004870398520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1596455004870398520==--
