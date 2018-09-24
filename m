From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 12/20] iommu/tegra: gart: Integrate with Memory
	Controller driver
Date: Mon, 24 Sep 2018 12:23:22 +0200
Message-ID: <20180924102322.GI21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-13-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1780108928371750234=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-13-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============1780108928371750234==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:45AM +0300, Dmitry Osipenko wrote:
> The device-tree binding has been changed. There is no separate GART device
> anymore, it is squashed into the Memory Controller. Integrate GART module
> with the MC in a way it is done for the SMMU of Tegra30+.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/Kconfig      |  1 +
>  drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
>  include/soc/tegra/mc.h     | 27 +++++++++++
>  4 files changed, 93 insertions(+), 74 deletions(-)

I think this could technically have been two patches, but since they'd
have a compile-time dependency either way they need to be applied in the
correct order, so some coordination between IOMMU and Tegra trees is
going to have to happen anyway and might as well just stick this into a
single patch.

Thierry

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluouxoACgkQ3SOs138+
s6FIqRAAv1YXOG+5wSjtW+2I5DBn924yW8YAZ9x/j72Pf+1bNLaZ+o/zLBl82aHC
PVVQMLjOCNSoozNRra27knqbUB/bogRvRQQAyjk01LeQzigTtJx3Gp5I1M+kKrzo
jvDKUm3roJdHvJrAZewWwM5tEe7ODQhZ6dHW3gk9jBDcen8Qc4gacm4wKlb1z4PS
LctjQf5QiYvhx6iPgW1pWRQG79TpHuG6SS1jHfVaw5fSGUDbco6asxqTLwdj6ZBc
fI/k0faAW652NxxoQe7aq11yE41bZu+6oYwWGhT7F/ABwJKdDCBH14Bgwz5Fk5pq
6onUtt42xw1wR9OwjtGv6zlVcZQcsQ7Fn/X2TQ3M/Fu/aY74u/DsLNeeqEZI0xsL
I1+F4R8WCTmAqAOgdq7TeCJGUJRg43IykYYeJ9U6nXFyUhhpafza9uZXx/1f9OpF
ntrM6S+nhRCyccytdYxFq6CKES8O6sPd7ER21a8DqkuIwQoe3/KwovTRoQU5fQrh
0+XTaGTdo6PbWTxkkl7qJNZO+xcqn/ZickKtCZbbIZ334qxd94g7/R1N9VSIGul7
IGmgngRQzQcEhCzK6JWClfWMBKnvuuflY6S60j+0o3WJiC6yJzo4pgpVDWqxRsc7
iAyiVGx0VSzjhciA7VsPT5mwntGloKaUjD4kfO0UzuEeyhjgAt0=
=wIFq
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--

--===============1780108928371750234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1780108928371750234==--
