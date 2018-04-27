From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Date: Fri, 27 Apr 2018 12:02:02 +0200
Message-ID: <20180427100202.GO30388@ulmo>
References: <cover.1523304324.git.digetx@gmail.com>
	<f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6585031252560701921=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============6585031252560701921==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLaBmHMi4cq+C/u4"
Content-Disposition: inline


--yLaBmHMi4cq+C/u4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 11:07:22PM +0300, Dmitry Osipenko wrote:
> Currently GART writes one page entry at a time. More optimal would be to
> aggregate the writes and flush BUS buffer in the end, this gives map/unmap
> 10-40% (depending on size of mapping) performance boost compared to a
> flushing after each entry update.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 63 +++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 48 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 4a0607669d34..9f59f5f17661 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -36,7 +36,7 @@
>  #define GART_APERTURE_SIZE	SZ_32M
> =20
>  /* bitmap of the page sizes currently supported */
> -#define GART_IOMMU_PGSIZES	(SZ_4K)
> +#define GART_IOMMU_PGSIZES	GENMASK(24, 12)

That doesn't look right. The GART really only supports 4 KiB pages. You
seem to be "emulating" more page sizes here in order to improve mapping
performance. That seems wrong to me. I'm wondering if this couldn't be
improved by a similar factor by simply moving the flushing into an
implementation of ->iotlb_sync().

That said, it seems like ->iotlb_sync() is only used for unmapping, but
I don't see a reason why iommu_map() wouldn't need to call it as well
after going through several calls to ->map(). It seems to me like a
driver that implements ->iotlb_sync() would want to use it to optimize
for both the mapping and unmapping cases.

Joerg, I've gone over the git log and header files and I see no mention
of why the TLB flush interface isn't used for mapping. Do you recall any
special reasons why the same shouldn't be applied for mapping? Would you
accept any patches doing this?

Thierry

> =20
>  #define GART_REG_BASE		0x24
>  #define GART_CONFIG		(0x24 - GART_REG_BASE)
> @@ -269,25 +269,21 @@ static void gart_iommu_domain_free(struct iommu_dom=
ain *domain)
>  	kfree(gart_domain);
>  }
> =20
> -static int gart_iommu_map(struct iommu_domain *domain, unsigned long iov=
a,
> -			  phys_addr_t pa, size_t bytes, int prot)
> +static int gart_iommu_map_page(struct gart_device *gart,
> +			       unsigned long iova,
> +			       phys_addr_t pa)
>  {
> -	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> -	struct gart_device *gart =3D gart_domain->gart;
>  	unsigned long flags;
>  	unsigned long pfn;
>  	unsigned long pte;
> =20
> -	if (!gart_iova_range_valid(gart, iova, bytes))
> -		return -EINVAL;
> -
> -	spin_lock_irqsave(&gart->pte_lock, flags);
>  	pfn =3D __phys_to_pfn(pa);
>  	if (!pfn_valid(pfn)) {
>  		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
> -		spin_unlock_irqrestore(&gart->pte_lock, flags);
>  		return -EINVAL;
>  	}
> +
> +	spin_lock_irqsave(&gart->pte_lock, flags);
>  	if (gart_debug) {
>  		pte =3D gart_read_pte(gart, iova);
>  		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
> @@ -297,8 +293,41 @@ static int gart_iommu_map(struct iommu_domain *domai=
n, unsigned long iova,
>  		}
>  	}
>  	gart_set_pte(gart, iova, GART_PTE(pfn));
> +	spin_unlock_irqrestore(&gart->pte_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int gart_iommu_map(struct iommu_domain *domain, unsigned long iov=
a,
> +			  phys_addr_t pa, size_t bytes, int prot)
> +{
> +	struct gart_domain *gart_domain =3D to_gart_domain(domain);
> +	struct gart_device *gart =3D gart_domain->gart;
> +	size_t mapped;
> +	int ret =3D -1;
> +
> +	if (!gart_iova_range_valid(gart, iova, bytes))
> +		return -EINVAL;
> +
> +	for (mapped =3D 0; mapped < bytes; mapped +=3D GART_PAGE_SIZE) {
> +		ret =3D gart_iommu_map_page(gart, iova + mapped, pa + mapped);
> +		if (ret)
> +			break;
> +	}
> +
>  	FLUSH_GART_REGS(gart);
> +	return ret;
> +}
> +
> +static int gart_iommu_unmap_page(struct gart_device *gart,
> +				 unsigned long iova)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gart->pte_lock, flags);
> +	gart_set_pte(gart, iova, 0);
>  	spin_unlock_irqrestore(&gart->pte_lock, flags);
> +
>  	return 0;
>  }
> =20
> @@ -307,16 +336,20 @@ static size_t gart_iommu_unmap(struct iommu_domain =
*domain, unsigned long iova,
>  {
>  	struct gart_domain *gart_domain =3D to_gart_domain(domain);
>  	struct gart_device *gart =3D gart_domain->gart;
> -	unsigned long flags;
> +	size_t unmapped;
> +	int ret;
> =20
>  	if (!gart_iova_range_valid(gart, iova, bytes))
>  		return 0;
> =20
> -	spin_lock_irqsave(&gart->pte_lock, flags);
> -	gart_set_pte(gart, iova, 0);
> +	for (unmapped =3D 0; unmapped < bytes; unmapped +=3D GART_PAGE_SIZE) {
> +		ret =3D gart_iommu_unmap_page(gart, iova + unmapped);
> +		if (ret)
> +			break;
> +	}
> +
>  	FLUSH_GART_REGS(gart);
> -	spin_unlock_irqrestore(&gart->pte_lock, flags);
> -	return bytes;
> +	return unmapped;
>  }
> =20
>  static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
> --=20
> 2.16.3
>=20

--yLaBmHMi4cq+C/u4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri9RgACgkQ3SOs138+
s6FwgQ//VzhKbUAsibuqNDwdDVBZsdgH09Z3ihrgoQnMBwMrH2CjZgqJREIa+oAw
I5Haqt9MnaqLCgjSc/dlXqGvcj8SMojukSTs/ppVUjN1F7YlEC0TboPVgqenzMwf
dKvBy2r1gwilzA2Qizo32pG0zZo6oIHZT5fKAY2SAJRELR02pbQdOxS/z0xkzsL0
n+bndQqlVohRHTEW2kTyCRVbOZYRzKg1bLaAJIbRIlp38CFzVkyDoh8JzF+sHkc9
kNkuuKg6LNFHc3fgGZgJ4GMHOGDIpWZeSXxtknYiVg/akd+lTsmOrTmquy7Teq5D
toXe4c+rQOU22s4+hgiobM6BY6wsKMQ17Hm+s09Wq5GaKkfLGgz3ntXK2NjpbZlr
D2op9aiuyaPiy0wByVQ0LuaXawQfxSwcc2Mo4pGC4hNxbc569sEB7Ln1WRrKRhUj
ryUdr0EwhX+e7MxRottyRjzKRC+hS2v4rj8LaBTqLiiBlEh7AaD4c9zDbNXdZrw0
EybmI1cQ3qNkvMFpKKLsK7QAMxRarNcnBO2gucHMKFutSsn20Lsugy+qPTTxHweo
9Yv+hzhz+T3ND/M29oLQMk0u8UcFiRJ5jgq37ii0Wu/WMnb6uhSJIdI4vQdcOdXr
liu3eT6NmAqnI3bXTuG4Udc3O2/GniHHBCZ3ZSoCgP3p6F9t/Cc=
=10mg
-----END PGP SIGNATURE-----

--yLaBmHMi4cq+C/u4--

--===============6585031252560701921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6585031252560701921==--
