From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 02/20] iommu/tegra: gart: Clean up driver probe errors
	handling
Date: Mon, 24 Sep 2018 12:02:48 +0200
Message-ID: <20180924100248.GD21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-3-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3729783325731287023=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-3-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============3729783325731287023==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:35AM +0300, Dmitry Osipenko wrote:
> Properly clean up allocated resources on the drivers probe failure and
> remove unneeded checks.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotkgACgkQ3SOs138+
s6H+Ig/6AsRUs4KWmrmToJo+c1f02b2It0bq/cQpS4YE4Fb/cuifGolvSB3Afecy
UPZufETrXZWicqUZRaC7CEwqaHq82IRHi3a8KcbTHGz20fg5TTQN+5eD2RDFTUOX
jxbYiwUkAI2gjZM/7FnGBKPxf4FWWNcbLozxedgEU+MzISVmqk6nRxB1oMDI6GEA
vMYnyOTte2LKdZ9AMvzWOSlShZXR1zqtym/F6fs/klhn+bp/E+SQ/09Yq2TDtMNS
jwdU2dKylUyD56+QpJCZkDQCfe3U7FpSIaPWszpKjDy/pVaV9ww+eIzN+02+wgig
GMmBDn8BIiZvDwrDxjuuCx6ZdRTAoz0Umx1elhssVozBVO+EloK5wVfFLpprVmSv
GB/r+pztQzhS2TNnVsFjOKwd0OqTdaHVt5FIFClcZgfKz7m9aeTyaijQeWl9AsRO
bgl5e5/0WFBNIEB01QaZU0ADhB8C9DI5z70Fxo7tPKst1n9UAliomV+nAdIpZOq6
qVJjvBHQivUyDIggDkQ7HbT2SBxViCUDfka3GyRXMb/m8zC+9acz0AUl+tHd68eO
tI+VAI5z0w0O5qYXN2lunhXloiQYGDlLOlTfI1oNXGAi1YRFgImbPMkvy4+mcryx
WUl03xjUHhV2cHMuvT0l8HC7KRxhQCSF8UjFueKo/pe3Dyeb0jI=
=wGqS
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--

--===============3729783325731287023==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3729783325731287023==--
