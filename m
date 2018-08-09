From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/8] memory: tegra: Provide facility for integration
	with the GART driver
Date: Thu, 9 Aug 2018 13:10:08 +0200
Message-ID: <20180809111008.GF21639@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com>
	<20180804143003.15817-2-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1831655672355625438=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180804143003.15817-2-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1831655672355625438==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2018 at 05:29:56PM +0300, Dmitry Osipenko wrote:
> In order to report clients name and access direction on GART's page fault,
> MC driver need to access GART registers. Add facility that provides access
> to the GART.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/memory/tegra/mc.c | 26 +++++++++++++++++++++++---
>  include/soc/tegra/mc.h    | 13 +++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index e56862495f36..4940d72b5263 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -72,6 +72,8 @@ static const struct of_device_id tegra_mc_of_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
> =20
> +static struct tegra_mc_gart_handle *gart_handle;
> +

Why the global variable? Can't this be part of struct tegra_mc? We
already do a very similar thing with the Tegra SMMU integration, why
invent something completely different? Can't we stick to a similar
mechanism?

Given that struct tegra_smmu is opaque at the memory controller level,
we could even go and store the GART related data in the same pointer.

How about the registration code goes into a struct tegra_gart_probe()
function that is called from tegra_mc_probe() right after the SMMU
block:

	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
		mc->smmu =3D tegra_smmu_probe(...);
		...
	}

	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART)) {
		mc->smmu =3D tegra_gart_probe(...);
		...
	}

?

Thierry

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsIRAACgkQ3SOs138+
s6EOag/+KWyfIYwlunu77wU6xbe78ZNj4WUCSKcxoA4GExTvqLDNvtjmcxGHxeuh
1LSf4obEVQZLqCECC0Ie0u24NTosHH+Dm3bjoiXbDPN07JFSBj8PDVdtHoI1+cA/
H7AqwOhOezhKWdisxNf3mP+aRPLrjqAZQ1IDdK/b0xHlSJA6d97L39nA/h8wKhM8
4vqm+HD/kJlLAT7gbMQ4J4NVw0amivAeHqI/xSk+MJoghrliR4t9xnOCkJKGsbjH
BxyaXE1A4HxURPKB1t+LOgOWSgfGY5eeO+CC2Ll2sVG8mfHAKQj3bAr5XXd9Ggl6
vINQ6xeK0JFJfzw1YKP7bC12DzTU0LWE8KUtdmdND3To0vUj53AjSKX5u0og0jui
eZIRPva3Om4tGefl2vqraG7DmkJZB02y2l4CqGfJvjZfs8JCeUyxzXAXN47U+gXv
V8lgCnbUZi/NguOnErGuF3RGjsWbm5t9e2sS2ncSNSpD256iKmHJwdP/myrUX3AL
GmeG8aeDkk8mqE2zXWBr2agNs/0n95WVdZTTAdW+goVJkkQ62vqUzxyor1Tmw6GP
664aTF3YssY6/pvJcQeOcdyyZNuRSUg8R1qy0MPBh0v99iagVVRVqJP4cyzuHjcQ
NCfu9WcqGhTYF84r632VjAr8KVPOY83zQOE5gSiqmD0iRmV3n8A=
=IZWX
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--

--===============1831655672355625438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1831655672355625438==--
