From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 7/9] iommu: tegra-gart: make it explicitly non-modular
Date: Tue, 27 Nov 2018 15:18:03 +0100
Message-ID: <20181127141803.GA10560@ulmo>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-8-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543271498-28966-8-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:31:36PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>=20
> drivers/iommu/Kconfig:config TEGRA_IOMMU_GART
> drivers/iommu/Kconfig:  bool "Tegra GART IOMMU Support"
>=20
> ...meaning that it currently is not being built as a module by anyone.
>=20
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>=20
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>=20
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
>=20
> We replace module.h with moduleparam.h since the file does actually
> declare some module_param() and the easiest way to keep back
> compatibility with existing use cases is to leave it as-is for now.
>=20
> The init function was missing an __init annotation, so it was added.
>=20
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>=20
> Cc: Hiroshi Doyu <hdoyu@nvidia.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/iommu/tegra-gart.c | 37 +++++++------------------------------
>  1 file changed, 7 insertions(+), 30 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv9UhcACgkQ3SOs138+
s6GgbBAAi/Mxc51OVKQqQum9GKCX2Bb6gfyB7EOoy5OfWgk1dXPUKhy6EhLZIaxk
2lpqJVfEikiOd5RdozVEspvrOqCKAGUuXNev7VEIy0daSNIM/VUJ6fSFCJRZEV+w
cFbj7Z/q44r+Gx9/F7vBl2miQhn9dvFhhJZjsT62uePD79C1r9o4OJch2kQAGB6O
aomSkBgzYz+iig3bD42H1JJERz1JrnKkbCXw3bKvRU4YG74hkM0NlWgUWxxCCsM/
59awkEkdId0jWuF7Cn7Iwfvs34p42vVhK5unMAIhO9YEZ3IWgNIhrkKnkWAIdhlU
VqbgJaKmdGqMjIZsGxWPwFnoNuHSV3LDxt0mCkhr6ZMIFuimJMy317vf0ETrhMSW
C4HUVScW6t/H/FXegQ8XfuRm6qZGnwmgT8MH0Oi2RW51iOA3eADP7HqCdUQ11uN6
K2LFAAbncjTJHdzUhECU9x1vWgzrXhUsufhj9Bc8DwwKN2+6zB+dsvJ7qA5SKUEU
PaOGRAz2M0+C6D65xiBsy0GpG3iH3SgMAXJ/bKC37UUV8AHH7z7DmoJUNYVOszCD
1Ai4TBSOmHgFUzszni4NOrcV/buCNOqLz2qspAHT64YK0ewgJDKuforGo7TV1q2G
epfhNiFXDV5CYbNa+lZH/gwz2KO646KyrPKidGtOj0PPhk/FA7U=
=9Dwj
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
