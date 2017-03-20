From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Add dummy implementations for !IOMMU_IOVA
Date: Mon, 20 Mar 2017 20:14:31 +0100
Message-ID: <20170320191431.GF14787@ulmo.ba.sec>
References: <20170320191128.26474-1-thierry.reding@gmail.com>
	<20170320191128.26474-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3666498291623314969=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170320191128.26474-2-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3666498291623314969==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline


--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 08:11:28PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Currently, building code which uses the API guarded by the IOMMU_IOVA
> will fail to link if IOMMU_IOVA is not enabled. Often this code will be
> using the API provided by the IOMMU_API Kconfig symbol, but support for
> this can be optional, with code falling back to contiguous memory. This
> commit implements dummy functions for the IOVA API so that it can be
> compiled out.
>=20
> With both IOMMU_API and IOMMU_IOVA optional, code can now be built with
> or without support for IOMMU without having to resort to #ifdefs in the
> user code.
>=20
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  include/linux/iova.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 91 insertions(+)

Hi Joerg,

I've got a series of patches that I'd like to merge for v4.12 that have
a build-time dependency on this patch. It would therefore be great to
get your Acked-by on this so that I can merge it through the DRM tree
with the rest of the patches. I can provide a stable branch with only
this patch for you to pull into the IOMMU tree.

Thierry

> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index f27bb2c62fca..548982ad5f2f 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -82,6 +82,7 @@ static inline unsigned long iova_pfn(struct iova_domain=
 *iovad, dma_addr_t iova)
>  	return iova >> iova_shift(iovad);
>  }
> =20
> +#ifdef CONFIG_IOMMU_IOVA
>  int iova_cache_get(void);
>  void iova_cache_put(void);
> =20
> @@ -106,5 +107,95 @@ void put_iova_domain(struct iova_domain *iovad);
>  struct iova *split_and_remove_iova(struct iova_domain *iovad,
>  	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
>  void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
> +#else
> +static inline int iova_cache_get(void)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void iova_cache_put(void)
> +{
> +}
> +
> +static inline struct iova *alloc_iova_mem(void)
> +{
> +	return NULL;
> +}
> +
> +static inline void free_iova_mem(struct iova *iova)
> +{
> +}
> +
> +static inline void free_iova(struct iova_domain *iovad, unsigned long pf=
n)
> +{
> +}
> +
> +static inline void __free_iova(struct iova_domain *iovad, struct iova *i=
ova)
> +{
> +}
> +
> +static inline struct iova *alloc_iova(struct iova_domain *iovad,
> +				      unsigned long size,
> +				      unsigned long limit_pfn,
> +				      bool size_aligned)
> +{
> +	return NULL;
> +}
> +
> +static inline void free_iova_fast(struct iova_domain *iovad,
> +				  unsigned long pfn,
> +				  unsigned long size)
> +{
> +}
> +
> +static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
> +					    unsigned long size,
> +					    unsigned long limit_pfn)
> +{
> +	return 0;
> +}
> +
> +static inline struct iova *reserve_iova(struct iova_domain *iovad,
> +					unsigned long pfn_lo,
> +					unsigned long pfn_hi)
> +{
> +	return NULL;
> +}
> +
> +static inline void copy_reserved_iova(struct iova_domain *from,
> +				      struct iova_domain *to)
> +{
> +}
> +
> +static inline void init_iova_domain(struct iova_domain *iovad,
> +				    unsigned long granule,
> +				    unsigned long start_pfn,
> +				    unsigned long pfn_32bit)
> +{
> +}
> +
> +static inline struct iova *find_iova(struct iova_domain *iovad,
> +				     unsigned long pfn)
> +{
> +	return NULL;
> +}
> +
> +static inline void put_iova_domain(struct iova_domain *iovad)
> +{
> +}
> +
> +static inline struct iova *split_and_remove_iova(struct iova_domain *iov=
ad,
> +						 struct iova *iova,
> +						 unsigned long pfn_lo,
> +						 unsigned long pfn_hi)
> +{
> +	return NULL;
> +}
> +
> +static inline void free_cpu_cached_iovas(unsigned int cpu,
> +					 struct iova_domain *iovad)
> +{
> +}
> +#endif
> =20
>  #endif
> --=20
> 2.12.0
>=20

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljQKhMACgkQ3SOs138+
s6GzrQ/+NZ4Tgq066fcahHvQms3mghDVWh7Ul+Cv9Y5pw4hk6Q8Wr49hA1WjEXjP
U/feSFmVa7Ywxb6rDwe4SVVjHcz0Yf7NgtlLt7z4s5r3II76a1yp61MbLp4MdH8/
xD9ZsdctNgL3VDVOOd8DwCHyouS597b2lUTCzVBpP6XTmIaQWl6sP0SQ8sDJJGFR
3qAD6QT8eB6OjV2l2QPdiHL9tJjJ24ujANxOqLXJz1qtdf3z2EyWjMJ7Xbu8+k1d
xceV1c0KkfEWjr9WG9sX5KsxJTZQJCgtIsXkj11GfrkNuuhy12K5e2su5GKCr05J
xngQTyBWE4FlPNlw5rCbATI1t0Oan+L4Q20VK8jroZBlSy1Ez+exAOIpxaWUxgCK
ViicaWqTBamnNCKQq4+wIr5gdqfQBjmmI4PHSc+6/IMx9qAyvTKjXd1cwW5hr0b/
jg08dMi7P2qoSEDR6UqZwkiV7hJEsRxvBv0otqaoWbs43udORVM185Fe47AXfbh+
yYL8hJmzhD+nDaCbtLQbOawCOvunp+O77XeOVkRYMghFkW2vlYsEEZIdnc1dnnT8
DtcfP0RvWmbkRTQkxC54gp+DWUYKB3xUwpP5SEw3rRuvOLxl6R7+LkFu0bnZVAdy
tnKdnz6dstlFsG573ZSTBH7p3puZEV8Twt8006qr+pW2K2lUcAs=
=rMj5
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--

--===============3666498291623314969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3666498291623314969==--
