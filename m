From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory
	Controller driver
Date: Thu, 9 Aug 2018 13:17:46 +0200
Message-ID: <20180809111746.GG21639@ulmo>
References: <20180804143003.15817-1-digetx@gmail.com>
	<20180804143003.15817-3-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6151161818083376102=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180804143003.15817-3-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============6151161818083376102==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 04, 2018 at 05:29:57PM +0300, Dmitry Osipenko wrote:
> GART contain registers needed by the Memory Controller driver, provide
> access to the MC driver by utilizing its GART-integration facility.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index a004f6da35f2..f8b653e25914 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -31,6 +31,8 @@
>  #include <linux/iommu.h>
>  #include <linux/of.h>
> =20
> +#include <soc/tegra/mc.h>
> +
>  #include <asm/cacheflush.h>
> =20
>  /* bitmap of the page sizes currently supported */
> @@ -41,6 +43,8 @@
>  #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
>  #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
>  #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
> +#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
> +#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
> =20
>  #define GART_PAGE_SHIFT		12
>  #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
> @@ -63,6 +67,8 @@ struct gart_device {
>  	struct device		*dev;
> =20
>  	struct iommu_device	iommu;		/* IOMMU Core handle */
> +
> +	struct tegra_mc_gart_handle mc_gart_handle;
>  };
> =20
>  struct gart_domain {
> @@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
>  	return 0;
>  }
> =20
> +static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
> +{
> +	struct gart_device *gart =3D container_of(handle, struct gart_device,
> +						mc_gart_handle);
> +	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
> +}
> +
> +static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
> +{
> +	struct gart_device *gart =3D container_of(handle, struct gart_device,
> +						mc_gart_handle);
> +	return readl_relaxed(gart->regs + GART_ERROR_REQ);
> +}
> +
>  static int tegra_gart_probe(struct platform_device *pdev)
>  {
>  	struct gart_device *gart;
> @@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device *p=
dev)
>  	gart->regs =3D gart_regs;
>  	gart->iovmm_base =3D (dma_addr_t)res_remap->start;
>  	gart->page_count =3D (resource_size(res_remap) >> GART_PAGE_SHIFT);
> +	gart->mc_gart_handle.error_addr =3D tegra_gart_error_addr;
> +	gart->mc_gart_handle.error_req =3D tegra_gart_error_req;
> =20
>  	gart->savedata =3D vmalloc(array_size(sizeof(u32), gart->page_count));
>  	if (!gart->savedata) {
> @@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device *p=
dev)
>  	do_gart_setup(gart, NULL);
> =20
>  	gart_handle =3D gart;
> +	tegra_mc_register_gart(&gart->mc_gart_handle);
> =20
>  	return 0;
>  }

I see now why you've did it this way. We have separate devices unlike
with SMMU where it is properly modeled as part of the memory controller.
I think we should consider breaking ABI at this point and properly merge
both the memory controller and GART nodes. There's really no reason why
they should be separate and we're jumping through multiple hoops to do
what we need to do just because a few years back we made a mistake.

I know we're technically not supposed to break the DT ABI, but I think
in this particular case we can make a good case for it. The current DT
bindings are plainly broken, and obviously so. Also, we don't currently
use the GART upstream for anything, so we can't break any existing
systems either.

Thierry

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsItoACgkQ3SOs138+
s6HZlw/7BZMnc6smROHoV6LzKfkC1MQe+wBkDlSsOSENtduUUu5dN4qhZbqmpVST
N1FeQNRuW9UdhZT6gMZ93wCW8NdbF5HmSzYCX89+DBhcpxj61fIPPs1cBVcNFL7G
RNR4Zz/+DO6tThfKrYumIGq7vg3Qu89gzGVL407luzziNMthV8fdWv233rMqxU2P
3fK5ljv52zdqmh2Ayyb9WYF6wR//DzvVDJggHl4NcxRic0e9gxN9IUMVaUiE970n
xxRLhO/rNlMyacOf4YklFhZhovseG2vfd14Qmqci4lLKY68XSTZcZCImKyEAnwxN
T28ddTi7dyo1XuDkE7/E/zec4rABfk24gEe8q79OW5Wc3VhwzzFIIRbJ99pIWu+4
fuk7H4rn2VrDLIttR8mFo5arwztHHBrP80rPop3Jd6oDFVlKWHRwHZw+KyJC6Sar
pS4lHd+iipT+Fiz89NLcuplvwWvtHDIt6aCWmRyMwFaRKziu+2bn4xGh0vUNJQM5
wmyNB00ZDsZFTxFDv1a77nUrJmsxF7nFTteWVTcCEto+0uniGhbEnar+IDn1f0qf
rhMhGYib3LEm74MAG7gOJ8uH4uHU7liKwSrxbnB0DEMAyNQDrDOm2xfbwC16RiPq
VSd3WTnC0/sqGqdDlV2h10iVuaSbcfeJ4mgsLP0WCgzsGgXv+7M=
=s4am
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--

--===============6151161818083376102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6151161818083376102==--
