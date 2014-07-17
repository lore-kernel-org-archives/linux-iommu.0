From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] iommu-api: Add map_range/unmap_range functions
Date: Thu, 17 Jul 2014 10:21:41 +0200
Message-ID: <20140717082138.GC18640@ulmo>
References: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org>
	<1405558917-7597-2-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0144191934460539752=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1405558917-7597-2-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0144191934460539752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2014 at 06:01:57PM -0700, Olav Haugan wrote:
> Mapping and unmapping are more often than not in the critical path.
> map_range and unmap_range allows SMMU driver implementations to optimize

s/SMMU/IOMMU/

> the process of mapping and unmapping buffers into the SMMU page tables.

s/SMMU/IOMMU/

> Instead of mapping one physical address, do TLB operation (expensive),
> mapping, do TLB operation, mapping, do TLB operation the driver can map
> a scatter-gatherlist of physically contiguous pages into one virtual
> address space and then at the end do one TLB operation.

I find the above hard to read. Maybe:

Instead of mapping a buffer one page at a time and requiring potentially
expensive TLB operations for each page, this function allows the driver
to map all pages in one go and defer TLB maintenance until after all
pages have been mapped.

?

> Additionally, the mapping operation would be faster in general since
> clients does not have to keep calling map API over and over again for
> each physically contiguous chunk of memory that needs to be mapped to a
> virtually contiguous region.
>=20
> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++=
+++
>  include/linux/iommu.h | 25 +++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1698360..a0eebb7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1089,6 +1089,54 @@ size_t iommu_unmap(struct iommu_domain *domain, un=
signed long iova, size_t size)
>  EXPORT_SYMBOL_GPL(iommu_unmap);
> =20
> =20
> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,

Maybe iova should be dma_addr_t? Or at least unsigned long? And perhaps
iommu_map_sg() would be more consistent with the equivalent function in
struct dma_ops?

> +		    struct scatterlist *sg, unsigned int len, int opt)

The length argument seems to be the size of the mapping. Again, the
struct dma_ops function uses this argument to denote the number of
entries in the scatterlist.

opt is somewhat opaque. Perhaps this should be turned into unsigned long
flags? Although given that there aren't any users yet it's difficult to
say what's best here. Perhaps the addition of this argument should be
postponed until there are actual users?

> +{
> +	s32 ret =3D 0;

Should be int to match the function's return type.

> +	u32 offset =3D 0;
> +	u32 start_iova =3D iova;

These should match the type of iova. Also, what's the point of
start_iova if we can simply keep iova constant and use offset where
necessary?

> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	if (unlikely(domain->ops->map_range =3D=3D NULL)) {
> +		while (offset < len) {

Maybe this should use for_each_sg()?

> +			phys_addr_t phys =3D page_to_phys(sg_page(sg));
> +			u32 page_len =3D PAGE_ALIGN(sg->offset + sg->length);

Shouldn't this alignment be left to iommu_map() to handle? It has code
to deal with that already.

> +			ret =3D iommu_map(domain, iova, phys, page_len, opt);

This conflates the new opt argument with iommu_map()'s prot argument.
Maybe those two should rather be split?

> +			if (ret)
> +				goto fail;
> +
> +			iova +=3D page_len;
> +			offset +=3D page_len;
> +			if (offset < len)
> +				sg =3D sg_next(sg);
> +		}
> +	} else {
> +		ret =3D domain->ops->map_range(domain, iova, sg, len, opt);
> +	}

Perhaps rather than check for a ->map_range implementation everytime a
better option may be to export this generic implementation so that
drivers can set it in their iommu_ops if they don't implement it? So the
contents of the if () block could become a new function:

	int iommu_map_range_generic(...)
	{
		...
	}
	EXPORT_SYMBOL(iommu_map_range_generic);

And drivers would do this:

	static const struct iommu_ops driver_iommu_ops =3D {
		...
		.map_range =3D iommu_map_range_generic,
		...
	};

> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
> +		      unsigned int len, int opt)

Some comments regarding function name and argument types as for
iommu_map_range().

> +static inline int iommu_map_range(struct iommu_domain *domain,
> +				  unsigned int iova, struct scatterlist *sg,
> +				  unsigned int len, int opt)
> +{
> +	return -ENODEV;

I know other IOMMU API dummies already use this error code, but I find
it to be a little confusing. The dummies are used when the IOMMU API is
disabled via Kconfig, so -ENOSYS (Function not implemented) seems like a
more useful error.

Thierry

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx4eSAAoJEN0jrNd/PrOhNasP/Aj1X4qr6Pu2PZzqIeVGpTcs
Mi5kwP2zZvge2fx+g5vFDktc1+VPsofDr+xWbAIsJBgS4tmoxNb7U+NVAZQZtvt/
m8jcIO56nWLfAlPaedcraXGNncmuDScu7ORa69SeF5avrFiSX/coDTph30IUNUCE
2/2mHavvIRi6b1RSzyQJoPcf1Zi8cqmIacQwKVSYNolePweDaloR9OUCtMc0UqJi
tkmFmGteWc7mrADfvcEhghUuUiOaREA9g/UWvLjS9LNbY40w2SDmOX8f0paLDAWa
SLsNy2Zkuczerp9R2s1qHuiROQX2Q3S5kir7PL1a0u3Ca8aAe2pvS8jlS/OI3+OK
uS+lwUCBxaJiGm7xHaLt6LAoCNnRd5ZK2Asz4B+elgmDTNuseNgtvvIzCjk7Pvqi
t5NWnSIzL94qEwFlqaIWLjG3yukJ3Xw2E7zWYCehLoC5QgNyogMeDpCZLZyDHQOd
RLxeEddCJdLfaiBWPurq1Gq1nqcT9J3RP4aTJ9kliyv8iczqO8ySWaoOl//aB6n9
x80MpiUWvEJuugdkSZX6X1CH9q6kxZILo6YlvM48p+qT/cicH8QuvknmzGnFDv4v
q6Vz6XZwiKlNkob7NkYIV7EOw7AdyJmkozFd6m2h5a9WoLXeqVwq//DKDbCjXcoP
ZuSDbCDm0qnyt5rkzcYE
=UDkJ
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--

--===============0144191934460539752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0144191934460539752==--
