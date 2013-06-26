From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 17/23] iommu/tegra: smmu: Use swgroups instead of pdata
Date: Wed, 26 Jun 2013 13:05:10 +0200
Message-ID: <20130626110509.GN27083@manwe>
References: <1372238906-9346-18-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wmhq21yAGFMoSpeN"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-18-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--wmhq21yAGFMoSpeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:28:20PM +0300, Hiroshi Doyu wrote:
> Instead of using platfrom data, DT passes "nvidia,swgroups".
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Could this patch not be squashed into the previous one? Moving from
using the swgroups from DT and replacing platform data seems to be the
same logical change.

Thierry

--wmhq21yAGFMoSpeN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysrlAAoJEN0jrNd/PrOhjn4P/RFJa5fmPnNnnPxui65txwv2
+U8hUA50N/2Rb8u731dUzhHJ64YqAe8qlBcRgxUeFx792J+aPjVDMj8rqBouDrL8
r/3VO/b6alQD5v75HGpnJ4hilTPHxYJrjsEnlJrHU0fK0h4szGphYKCrKwNa1K30
DsyKLenlEtYbc//VlNAlvuqIUfr0TwEzAJlKL4c0xAJA7uOmX79jFhXXf0wC1YY+
GxdoTGlbCjtHi7Y1/jHFJk5+3Pk+7qgghKNs/tlapPHlQcyN3gqf33sfdVv82Qf3
surccsw+Eq94vBWbIRtdRx76g6zkLD7RY9VIXb4yrsdw1aofnW0QBH2HDXRnPI+9
akfb+uQJvb/P0YdzQSpJSkqkoTU+a4DhzZIlKFHEVcfys7QfFS5N0v0E2D+EZw7j
CNXVsW6YOwDj1QM5CCq+vi6C88rNSNS8w3OzfvALssiufbDPutJoGzQimTOYBw4p
+nKCdKLTjGb7x1KYPSQV+G/DXU3xpOmW+kJX5cooenLLfa76aIVV3fhIJKi5dkqq
6Dg8Y9LOJvEOss5lEG/21MD03GQkZQKazKJo2uQATWy4XtKmXSHcGTb5YYtwGpl5
TpY6xKOJZb1Ap1a64A8pE3Uz+sNvyUswjTRGPiekaBEyAehr/cwvSHaDQXh16HyT
Gxi4L73YqsIqucMQVSD6
=vUwt
-----END PGP SIGNATURE-----

--wmhq21yAGFMoSpeN--
