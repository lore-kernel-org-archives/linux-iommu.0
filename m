From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 1/3] iommu/tegra-smmu: Fix invalid ASID bits on
	Tegra30/114
Date: Wed, 3 Apr 2019 10:41:42 +0200
Message-ID: <20190403084142.GA5238@ulmo>
References: <20190306225009.3391-1-digetx@gmail.com>
	<20190306225009.3391-2-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0719603429282449123=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190306225009.3391-2-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============0719603429282449123==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:50:07AM +0300, Dmitry Osipenko wrote:
> Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
> the TLB_FLUSH register differs from later Tegra generations that have 128
> ASID's.
>=20
> In a result the PTE's are now flushed correctly from TLB and this fixes
> problems with graphics (randomly failing tests) on Tegra30.
>=20
> Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 5182c7d6171e..8d30653cd13a 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -102,7 +102,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu,=
 unsigned long offset)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
>  #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
> -#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)

Given that the same operation is repeated three times below, it might
have been worth to fold the conditional into the macro. That'd require
the macro to take an smmu parameter, but would otherwise leave the
individual instances shorter.

But either way, the fix is good, so:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykcb4ACgkQ3SOs138+
s6HhKA/+IpRuLcBkUwgiebKV4hTvqFg1deczqWWrMafxSFjSuPWer+yFU9nlgZ0X
4h3FnxqTNu+Am7oDc1mLuHFw4ylmxprSoXrrpW1QR8PYk8fbfeMKrs4jN4wdLKXz
qK5zTkL7U5t89vmbRu52J1vN/zeulAigPhCnhGNquCGWQ8Rf6so6/ZEpQ2PY4dee
IlRGRQbLUFYuW1+eQ5YjO/8u+7Fe8qMYmnabkdMiq/aSG4NrDZSC5r67eoD6j+JJ
C/t/fhKz6NccAkpE9YmfVNQk+cFeqqzoyOXRY5MuJ/0mPDr71Xfk8HzAOjicxK7M
ZssbwXqhPqQ9TuZNvBZM4mYZzPvDkWk5dTuLGxe3gGM7qMdiGJsOX0h/xEmdWtpt
Q1qhqjLEXACVl3Fu38Roc/TIUJlSsDuPmrxArqhS7JV6SUXIkAi3amCTrlfkqUMt
W7fDQMH2Lt+r/tmyiIM7Z34aQVbi9jC6ORY8gy2GScNGirvKJDTtd7Ygk5fveMll
BCHCM3ULuYqTzLwVrUkDCfMko6eIdzrvjMQc7v88cWvMBaTR1Z5HZVHeYirrHdd6
QM5m/wU+XmBOLriUVyDukZWNnhZ523bw2TM6KlhNaM6IKxz7lIZhMLBITKmhvNPH
AP/e3KF6AqcT0Gk2f2F6xFFM3hFV3bQZHuP10fxMAkfhvwGh/9E=
=nX1U
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

--===============0719603429282449123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0719603429282449123==--
