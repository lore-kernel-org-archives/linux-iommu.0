From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 2/4] iommu/tegra: gart: Fix gart_iommu_unmap()
Date: Fri, 27 Apr 2018 11:43:26 +0200
Message-ID: <20180427094326.GL30388@ulmo>
References: <cover.1523304324.git.digetx@gmail.com>
	<dd25a9ff7bad7c92b345c0c0ce2bf235c4c3b6e8.1523304324.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8465491895501998859=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <dd25a9ff7bad7c92b345c0c0ce2bf235c4c3b6e8.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============8465491895501998859==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 11:07:20PM +0300, Dmitry Osipenko wrote:
> It must return the number of unmapped bytes on success, returning 0 means
> that unmapping failed and in result only one page is unmapped.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri8L0ACgkQ3SOs138+
s6F/EQ//XwtuK53IT2hLJ632ZguS9Dbp77vbd7S36ww8dcafYkeJ+PsaKpetk9BU
whOnWe/elWUTkOtL6wHMerSHa1RoMpNR46cHkjqppPaNaWn5kJfdYIgvZj+GVBjG
7n5tYsZLsbjWlsXZoQu0cb0gcwybZzhrzXAu+tLYzI0p9WJO/dxz/VH1mEMxA6Bj
ykDHT5bSTzukiOlLbMYy+cwajd1lr6fe9UAJMQ8rAb6Zej/MTFpRuS18DeeGRkva
+CLvhX9DGi1Bc+Jt101EJ/SO9Edsg/poZ0ZpT+rYTLQgExJw6vEd4XZWyhiBR2QK
EzglVE+3mZ13mz7QmdWy2xJSn77lGrsA3pbMwv6rNTQ/VsXD0Tf0ljdc8xvL9B2H
UCRfXPICCw/8o8SNrLpZapq+Z12o/3a7a0yAHZFVNEyMB6I0Y6Rs8L+zUf8aY3dm
e1ruuoU23ryISE9de7LwpNAZIyb6y3tie+3XqlhAe8M4PFVDR6uWtXryo60d/6aS
ngEnv2oTqqmA3uE+yJHpHSNIrhNGnpkX02srWeHCIXZBW5HzwnzhlxPbK1jboyQB
qr1a+6rWqJfuSZXK3wT4uCP0YFdDW6Y2tolxxWDdnNKNKJpikgsLWJbg/9h7AquI
ACSNJ/dYE2OpdRGmcK2ymiwRQ/Ge4B94iIRGxB7k8LrgI8AbrAE=
=MkpY
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--

--===============8465491895501998859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8465491895501998859==--
