From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
Date: Mon, 24 Sep 2018 12:13:54 +0200
Message-ID: <20180924101354.GH21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-12-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-12-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
> There is no need to match device with the DT node since it was already
> matched, use of_device_get_match_data() helper to get the match-data.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index 5454ffe5b2e0..cdc33f93cf7c 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -11,8 +11,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/platform_device.h>

It's better not to remove these two because the code still uses
functions declared in them. If ever we were going to remove code using
linux/of_device.h and then remove the linux/of_device.h include, we'd
break the build and have to reintroduce the includes.

The same would happen if linux/of_device.h were ever to stop including
linux/platform_device.h or linux/of.h. That may sound unlikely, but it
has happened in the past with other includes. It can also happen that
some restructuring takes place in some headers that is not so obvious
and then things can still start falling apart miles away.

Thierry

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluouOIACgkQ3SOs138+
s6Gytg/+Ndah+5wwzzGFfwm+SNSWKxw4eueN/zWNhErt5qC9Q7Nli7pqMy4fYrBs
LTiZd4Xlr/g5UztazLUbbSM0Dl6QFCKZktGlhmf/P5qh/Kaq0dGZm0aHAeaeaoFO
PnHtGxBrwjf8SOR5XGXnfVrG+yqqh8EXtDWrrn0GoiNkd7Rmg7q9S/f4nc4XVjIZ
jHe7oiqRce0fmCOui0nGcfDDkQRDlbLCd6EC+jp3XmWIm2Uh9cYi+HljtlTBlM09
R+tSXfbev4WT1BbqYjGEojXM5MF8/4RkM5zheCKitoJ7laLx9G6cGQKHwNjtD5I9
byNR9lJDB+G/3WFdk0GgVEQaopN5lRVgSZdm0ESv2qJ8WTWt3Rr8wY/vRf3NA0Mu
+wYC1gIRT/H0Ipil6no6m3kveRc9Rvnw4t/APmM/hkzs4FC596z5s622eqwl7uaj
xJI7IQfHiOFGQ7zfYk+2l7JQcyD6j6htGQ1kGUkmXcRlZwHNzQ+XIiEBIoRh58RP
gQlNgBU+wM4ESeFRFmrSzQSh85RWT6PTSs05Ydaqq8LVdLVXc1exbk/+JsSbSVzb
DuXOifJSkFw2N62kZJ3t7vNqWrfdo5uZuOXOMQ31UAjx1uqSH1S/msQzpEESyR8l
UQn0zfTjcczs5uvqYUonUhVjESZ3RoqxAohWg+Ru+6DtV6HBEmg=
=quUM
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--
