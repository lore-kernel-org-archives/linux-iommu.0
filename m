From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 09/21] memory: tegra: Adapt to Tegra20 device-tree
	binding changes
Date: Wed, 12 Dec 2018 11:05:09 +0100
Message-ID: <20181212100509.GF15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
	<20181209202950.31486-10-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2585307149063635147=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181209202950.31486-10-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2585307149063635147==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:38PM +0300, Dmitry Osipenko wrote:
> The tegra20-mc device-tree binding has been changed, GART has been
> squashed into Memory Controller and now the clock property is mandatory
> for Tegra20, the DT compatible has been changed as well. Adapt driver to
> the DT changes.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/memory/tegra/mc.c | 21 ++++++++-------------
>  drivers/memory/tegra/mc.h |  6 ------
>  include/soc/tegra/mc.h    |  2 +-
>  3 files changed, 9 insertions(+), 20 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3VUACgkQ3SOs138+
s6FhWA/+MEvfdkIB2BINTp/t9VcU2fno9yZ3NKsAdnSlQ9cqVzaMDopgDEFuHwwx
L2CLmgslF6g1XGzUHnAF5wdpjWeIuIlokvvti/SLzsd+k97/bS7yTONuXOFVZ7kL
yNrhbvCeGVqFBE0rhHr4plMa3vDabI5AZfFyJ2+feZ3Yg7dMMlb0YIAzNUKOngeM
4+PSdc7uHZCpiL8/cPjgyFiqZ/Y6VZuthtIjaiJIm9h7j5XoCcCqRUnI7AUY9wtY
q/BjYJRE8+HrvQe3sgAIOoP1onmZE0yNc5HsgepTkl7Sc6f2kfSAvFGVPAIC/k4n
n5BoTdfoxHCFjFEpclcAgaRQqFzQYg8FndRRtVbvmQ552cxeoXiV50D0mFGTrgvg
3j9NoN4V3hqNB05QN8GnZiKxAgBMwwsS3YhnnED4X7qtrXbvlRFSEmF84s39RCh7
iAACUo1VPlMIPUNmTdZ0foXwHRwdBOJ5Iv22stknzWZ2rodYzT6IoN8bg4NP9NVF
BPurKINP2AJgXOJgQpHa2+lI5I1sYnkUXhOsqPIKekHkZiTVhpd9M0y0dYhdc1m5
LQRRAtAviLSc/T8CWUK8XIWG4tMT2a0K788sUZhFzHcfKnBxHLgsWYKc5Csmxx/j
5vaqT8KQEgubrJtNmIho8SziQoT9ophUgBWwOI8hyPagjeL6fAY=
=skgE
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--

--===============2585307149063635147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2585307149063635147==--
