From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date: Thu, 22 Nov 2018 16:15:22 +0100
Message-ID: <20181122151522.GC24661@ulmo>
References: <20181122133047.24902-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4065445199992401793=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181122133047.24902-1-tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yangtao Li <tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4065445199992401793==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 08:30:47AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv2yAkACgkQ3SOs138+
s6GsyhAAwjLJp+PspBwW5BEnIVlJulbmkaefJnCMpAhYnBKkjTjL3CYzBJt//yT5
tNXqCIwuRpbV6O8e+jig3aWZQRsIY3Md0iSk2OGXf0iF7h03l91rUyKjUDEeNi0G
+MOQk3LyULOZeBb/nL/bJppQyQKPbG7ejC3k/RUmGuF5yt9O+qsythYFLQgYtrON
tRuy2ff6r6gdLa2LWzfkEdHri2Meu3SrTRDeYHf6XblUsN9nRhitm2Em+dlftLYM
WUGOUUsC9qigG+9lZ2Fqwqwac1t52cV5QggTkmR/fnZ0vWNiRDQQctKZZ8gOWQeo
zAaHMa9IJ7s0QBhyHi+DHH1U+8Fn3IuEJRw8ukBRiLjOsJluWljWOgbv9yBZ8xzE
vXYnvRvMBp1vfAwMHUpKj0N/XBJJUpJ9EZipebHcu1nuI9gDpvk2iuTiY/qXOa+U
MiMPwDwa7Su0D+VgrIrTdusVwsK4bJOkgSWSX6pwdFAiyhFA7FXemOcaY4GOSej5
RH7VqfbF60+IjVVvevJaVinGiRiiI4kPMu/HJjwMfYpnk9MF3tdvkQ01Avg7AHpY
Kxs+tVaaCXxszssvv7Xz+Mj6D/TN1qlyxCi6p1ikBFqlJpsPCVWke5xACq0zBZ0V
oT9HE9XBno51EMWo5MxVbsx+Yqmu2qd4v8x3LAdUlZ98PtnHuJU=
=QVqj
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

--===============4065445199992401793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4065445199992401793==--
