From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Mon, 1 Sep 2014 10:29:40 +0200
Message-ID: <20140901082939.GC24430@ulmo>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-5-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4206176598626536771=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409327670-3495-5-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4206176598626536771==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 04:54:27PM +0100, Will Deacon wrote:
> The generic IOMMU device-tree bindings can be used to add arbitrary OF
> masters to an IOMMU with a compliant binding.
>=20
> This patch introduces of_iommu_configure, which does exactly that.
>=20
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig    |  2 +-
>  drivers/iommu/of_iommu.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/of_iommu.h |  6 ++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dd5112265cc9..6d13f962f156 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -15,7 +15,7 @@ if IOMMU_SUPPORT
> =20
>  config OF_IOMMU
>         def_bool y
> -       depends on OF
> +       depends on OF && IOMMU_API
> =20
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index f9209666157c..a7d3b3a13b83 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -19,6 +19,7 @@
> =20
>  #include <linux/export.h>
>  #include <linux/limits.h>
> +#include <linux/iommu.h>
>  #include <linux/of.h>
>  #include <linux/of_iommu.h>
> =20
> @@ -90,6 +91,41 @@ int of_get_dma_window(struct device_node *dn, const ch=
ar *prefix, int index,
>  }
>  EXPORT_SYMBOL_GPL(of_get_dma_window);
> =20
> +int of_iommu_configure(struct device *dev)
> +{
> +	struct of_phandle_args iommu_spec;
> +	struct bus_type *bus =3D dev->bus;
> +	const struct iommu_ops *ops =3D bus->iommu_ops;
> +	int ret =3D -EINVAL, idx =3D 0;
> +
> +	if (!iommu_present(bus))
> +		return -ENODEV;
> +
> +	/*
> +	 * We don't currently walk up the tree looking for a parent IOMMU.
> +	 * See the `Notes:' section of
> +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> +	 */
> +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> +					   "#iommu-cells", idx,
> +					   &iommu_spec)) {
> +		void *data =3D of_iommu_get_data(iommu_spec.np);
> +
> +		of_node_put(iommu_spec.np);
> +		if (!ops->add_device_master_ids)
> +			return -ENODEV;
> +
> +		ret =3D ops->add_device_master_ids(dev, iommu_spec.args_count,
> +						 iommu_spec.args, data);
> +		if (ret)
> +			break;

I think this could use a bit more formalization. As I said in another
reply earlier, there's very little standardization in the IOMMU API.
That certainly gives us a lot of flexibility but it also has the
downside that it's difficult to handle these abstractions in the core,
which is really what the core is all about, isn't it?

One method that worked really well for this in the past for other
subsystems is to allow drivers to specify an .of_xlate() function that
takes the controller device and a struct of_phandle_args. It is that
function's responsibility to take the information in an of_phandle_args
structure and use that to create some subsystem specific handle that
represents this information in a way that it can readily be used.

So I think it would really be helpful if IOMMU gained support for
something similar. We could create a struct iommu to represent an
instance of an IOMMU. IOMMU drivers can embed this structure and add
device-specific fields that they need. That way we can easily pass
around instances and upcast in the driver in a type-safe way.

At the same time, a struct iommu_master could provide the basis to
represent a single master interface on an IOMMU. Drivers can again embed
that in driver-specific structures with additional fields required for
the particular IOMMU implementation. .of_xlate() could return such an
IOMMU master for the core to use.

With such structures in place we should be able to eliminate many of the
loops in IOMMU drivers that serve no other purpose than to find the
master context from a struct device * and some parameters. It will also
allow us to keep a central registry of IOMMUs and masters rather than
duplicating that in every driver.

Thierry

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBC5zAAoJEN0jrNd/PrOhuZAP/0u/07oAP/jKYR5/u3IDw33M
uMS/L1LcUunKRNn9S3a5VghG95kT91e16kuY9DIAGnoJgzwas0MMUNcUeffud3bJ
2cXzz3v0fUmIP+oWGul3+vcb6XLZrpKDPmSPRzCSZKqcQm+6lxcih+Slswxgx+0H
yucPAzovPoXUvE370d6Vk4AFiE7AbjyIRkBJ5NTAlP4Fgdigo7jsyTa0emLr5rwD
zcJvWqJZHoqcMEYrfDz1xIhoIc7kj9skcjk5hOu3a4E+FsD+D5IAaIaKtAiDpArT
TypjbJfHFMDp8Cwka/BGrTg+RoZIQPC5G2nTLhlQBhPfItA1RNQoeviUidUbB9uM
IkKPa/eghgZVX/QpBhQ/duz0PwMgd4rZnqwLSik5IFTmL3xtDhZYGjJdBl2Ozbz8
kj/mjXQoNQHNcq6wEJr2wmyxEnTswEZxfOcdjtDSq5aZj1AZLfzI89PFHomhTrXa
rkc6epsPa6M0xvrSr/9xBAcXpiwSJkKOb0Juz0g+6geLaQ4aVenScK75s4ck8W0W
R/xg38zTBTr+Lxr8PL7mzGDxZcqkuKE816QXJQLtBxlejZDkzClqwRa9sBy0FC0z
rMGCrKkiVrXNY/Ne5GFhYIzsJfuPw+sGdyHda2e+pl7+/lZPXc5isMB4+JzGSUDi
r9vy2az4bNRkBt9K756J
=GeNu
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--

--===============4206176598626536771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4206176598626536771==--
