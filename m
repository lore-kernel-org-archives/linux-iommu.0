From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 09/20] memory: tegra: Adapt to Tegra20 device-tree
	binding changes
Date: Mon, 24 Sep 2018 12:02:05 +0200
Message-ID: <20180924100205.GB21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-10-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0603119324159186098=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-10-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============0603119324159186098==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:42AM +0300, Dmitry Osipenko wrote:
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
>=20
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index e56862495f36..1b4ceefd82f9 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -51,7 +51,7 @@
> =20
>  static const struct of_device_id tegra_mc_of_match[] =3D {
>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
> -	{ .compatible =3D "nvidia,tegra20-mc", .data =3D &tegra20_mc_soc },
> +	{ .compatible =3D "nvidia,tegra20-mc-gart", .data =3D &tegra20_mc_soc },

Technically we now regress because we no longer support the older device
tree bindings. I know that it doesn't really matter because this driver
doesn't really do much interesting yet other than reporting memory
access violations, but if that's enough to warrant a change of the
compatible string, then I think we also need to preserve compatibility
in the code.

That said, I think compatibility would be easier to preserve if we stuck
with the old compatible string and used a "reg-names" property to
specify which version of the binding we're referring to.

For example, we could have:

	memory-controller@7000f000 {
		compatible =3D "nvidia,tegra20-mc";
		reg =3D <0x7000f000 0x024
		       0x7000f03c 0x3c4>;
		...
	};

for the old binding and:

	memory-controller@7000f000 {
		compatible =3D "nvidia,tegra20-mc";
		reg =3D <0x7000f000 0x00000400>,
		      <0x58000000 0x02000000>;
		reg-names =3D "mc", "gart";
		...
	};

for the new binding. The driver can then easily check for the existence
of the reg-names property and take the legacy or new code paths.

Thierry

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluoth0ACgkQ3SOs138+
s6FNNA//dbYek11QhDjPony5xuLxPAcxmAJxl9zWStnLA4kW4ZqBhelXXhMNPqjc
wAQLVVXtXXghdg66hGIHvqj/Ug+1e2tnlTm+avZPC+Dx55ISdEf6kiAURFbmsvHu
U37RtpfKaCicRlR1iJPmgAEnngxzcZscmf7TodrgHnMeTUj4I3aV+bbxnVMcDZ53
yNG2fgpThvF27FKhW96lA2iA6sJAF5uCJi+kgqrCA+JBB2nPf4eH7RrF1p2etb8i
YtCZ4zmZClXnA7E3X1uKkx/zl1TIL1luPE8L3WC6kah48R68KdPwCW4svEETcV8G
5WDLfyUi6hzeEkSp+sv7S2VF9ld/UYvMcO5ZDdAcNrxPy7HBjmptCeA9+COdvlBj
PsngAZBLbaqQInS4evmMrJPnYGcp3tP8Okmx6Ca9MuQJjh1d+lPv9C3QCylrR9Xy
RPcT6szOFiPbmGmExTEYmIvfoNq+s8vhnmR9LVpBlQ8pgN+PWNGr8qzBHaseRWWO
LCCNzuT/bZuHc7gDKDacytquDejpRf6nvay/0wpkQ20Km/Etjp2EL4IGO+XfYcBJ
hpdIyN5sNIqGP8Jlb0mnWJtuL4wQjbsOAjpYQdVZBulmtN2+1xzaqoCSfcc5uoHq
1dVZ8bL//k3mWYlmTXIRigflHeMokvx6MSxtioTramG3rQVPUmM=
=1ysw
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--

--===============0603119324159186098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0603119324159186098==--
