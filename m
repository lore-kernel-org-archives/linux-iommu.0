From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 16/20 v2] iommu/amd: Optimize map_sg and unmap_sg
Date: Tue, 12 Jul 2016 16:34:16 +0100
Message-ID: <57850DF8.9040507@arm.com>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
 <1467978311-28322-17-git-send-email-joro@8bytes.org>
 <5784D597.4010703@arm.com> <20160712133042.GG12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160712133042.GG12639@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Vincent.Wan@amd.com, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 12/07/16 14:30, Joerg Roedel wrote:
> On Tue, Jul 12, 2016 at 12:33:43PM +0100, Robin Murphy wrote:
>>> +	for_each_sg(sglist, s, nelems, i)
>>> +		npages +=3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
>>
>> This fails to account for the segment boundary mask[1]. Given a typi=
cal
>> sglist from the block layer where the boundary mask is 64K, the firs=
t
>> segment is 8k long, and subsequent segments are 64K long, those
>> subsequent segments will end up with misaligned addresses which cert=
ain
>> hardware may object to.
>=20
> Yeah, right. It doesn't matter much on x86, as the smallest
> boundary-mask I have seen is 4G, but to be correct it should be
> accounted in. How does the attached patch look?

The boundary masks for block devices are tricky to track down through s=
o
many layers of indirection in the common frameworks, but there are a lo=
t
of 64K ones there. After some more impromptu digging into the subject
I've finally satisfied my curiosity - it seems this restriction stems
from the ATA DMA PRD table format, so it could perhaps still be a real
concern for anyone using some crusty old PCI IDE card in their modern
system.

>>
>>> +	address =3D dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
>>
>> Since a typical dma_map_sg() call is likely to involve >128K worth o=
f
>> data, I wonder if it's worth going directly to a slow-path IOVA
>> allocation...
>=20
> Well, the allocator is the bottle-neck, so I try not to call it for
> every sg-element. The global locks have been removed, but more
> allocations/deallocations also mean that the per-cpu free-lists fill =
up
> quicker and that we have to flush the IOTLBs more often, which costs
> performance.

Indeed, I wasn't suggesting making more than one call, just that
alloc_iova_fast() is quite likely to have to fall back to alloc_iova()
here, so there may be some mileage in going directly to the latter, wit=
h
the benefit of then being able to rely on find_iova() later (since you
know for sure you allocated out of the tree rather than the caches). My
hunch is that dma_map_sg() tends to be called for bulk data transfer
(block devices, DRM, etc.) so is probably a less contended path compare=
d
to the network layer hammering dma_map_single().

>=20
>> [1]:http://article.gmane.org/gmane.linux.kernel.iommu/10553 - almost=
 the
>> 1-year anniversary of you making much the same comment to me :D
>=20
> Touch=E9 ;-)
>=20
> Here is the updated patch:
>=20
> From 88e1cc6c8e854a2bf55f972ddc5082a44760abe2 Mon Sep 17 00:00:00 200=
1
> From: Joerg Roedel <jroedel@suse.de>
> Date: Wed, 6 Jul 2016 17:20:54 +0200
> Subject: [PATCH 1/5] iommu/amd: Optimize map_sg and unmap_sg
>=20
> Optimize these functions so that they need only one call
> into the address alloctor. This also saves a couple of
> io-tlb flushes in the unmap_sg path.
>=20
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd_iommu.c | 112 +++++++++++++++++++++++++++++++++++-=
----------
>  1 file changed, 86 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 2cd382e..203c50c 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2395,50 +2395,110 @@ static void unmap_page(struct device *dev, d=
ma_addr_t dma_addr, size_t size,
>  	__unmap_single(domain->priv, dma_addr, size, dir);
>  }
> =20
> +static int sg_num_pages(struct device *dev,
> +			struct scatterlist *sglist,
> +			int nelems)
> +{
> +	unsigned long mask, boundary_size;
> +	struct scatterlist *s;
> +	int i, npages =3D 0;
> +
> +	mask          =3D dma_get_seg_boundary(dev);
> +	boundary_size =3D mask + 1 ? ALIGN(mask + 1, PAGE_SIZE) >> PAGE_SHI=
=46T :
> +				   1UL << (BITS_PER_LONG - PAGE_SHIFT);

(mask >> PAGE_SHIFT) + 1 ?

> +
> +	for_each_sg(sglist, s, nelems, i) {
> +		int p, n;
> +
> +		s->dma_address =3D npages << PAGE_SHIFT;
> +		p =3D npages % boundary_size;
> +		n =3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE);
> +		if (p + n > boundary_size)
> +			npages +=3D boundary_size - p;
> +		npages +=3D n;
> +	}
> +
> +	return npages;
> +}

Otherwise, this seems OK to me (as far as you value the judgement of
someone who took at least 3 tries to come up with a correct
implementation themselves...)

> +
>  /*
>   * The exported map_sg function for dma_ops (handles scatter-gather
>   * lists).
>   */
>  static int map_sg(struct device *dev, struct scatterlist *sglist,
> -		  int nelems, enum dma_data_direction dir,
> +		  int nelems, enum dma_data_direction direction,
>  		  struct dma_attrs *attrs)
>  {
> +	int mapped_pages =3D 0, npages =3D 0, prot =3D 0, i;
>  	struct protection_domain *domain;
> -	int i;
> +	struct dma_ops_domain *dma_dom;
>  	struct scatterlist *s;
> -	phys_addr_t paddr;
> -	int mapped_elems =3D 0;
> +	unsigned long address;
>  	u64 dma_mask;
> =20
>  	domain =3D get_domain(dev);
>  	if (IS_ERR(domain))
>  		return 0;
> =20
> +	dma_dom  =3D domain->priv;
>  	dma_mask =3D *dev->dma_mask;
> =20
> +	npages =3D sg_num_pages(dev, sglist, nelems);
> +
> +	address =3D dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
> +	if (address =3D=3D DMA_ERROR_CODE)
> +		goto out_err;
> +
> +	prot =3D dir2prot(direction);
> +
> +	/* Map all sg entries */
>  	for_each_sg(sglist, s, nelems, i) {
> -		paddr =3D sg_phys(s);
> +		int j, pages =3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE)=
;
> +
> +		for (j =3D 0; j < pages; ++j) {
> +			unsigned long bus_addr, phys_addr;
> +			int ret;
> =20
> -		s->dma_address =3D __map_single(dev, domain->priv,
> -					      paddr, s->length, dir, dma_mask);
> +			bus_addr  =3D address + s->dma_address + (j << PAGE_SHIFT);
> +			phys_addr =3D (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
> +			ret =3D iommu_map_page(domain, bus_addr, phys_addr, PAGE_SIZE, pr=
ot, GFP_ATOMIC);
> +			if (ret)
> +				goto out_unmap;
> =20
> -		if (s->dma_address) {
> -			s->dma_length =3D s->length;
> -			mapped_elems++;
> -		} else
> -			goto unmap;
> +			mapped_pages +=3D 1;
> +		}
>  	}
> =20
> -	return mapped_elems;
> +	/* Everything is mapped - write the right values into s->dma_addres=
s */
> +	for_each_sg(sglist, s, nelems, i) {
> +		s->dma_address +=3D address + s->offset;
> +		s->dma_length   =3D s->length;
> +	}
> +
> +	return nelems;
> +
> +out_unmap:
> +	pr_err("%s: IOMMU mapping error in map_sg (io-pages: %d)\n",
> +	       dev_name(dev), npages);
> +
> +	for_each_sg(sglist, s, nelems, i) {
> +		int j, pages =3D iommu_num_pages(sg_phys(s), s->length, PAGE_SIZE)=
;
> +
> +		for (j =3D 0; j < pages; ++j) {
> +			unsigned long bus_addr;
> =20
> -unmap:
> -	for_each_sg(sglist, s, mapped_elems, i) {
> -		if (s->dma_address)
> -			__unmap_single(domain->priv, s->dma_address,
> -				       s->dma_length, dir);
> -		s->dma_address =3D s->dma_length =3D 0;
> +			bus_addr  =3D address + s->dma_address + (j << PAGE_SHIFT);
> +			iommu_unmap_page(domain, bus_addr, PAGE_SIZE);
> +
> +			if (--mapped_pages)
> +				goto out_free_iova;
> +		}
>  	}
> =20
> +out_free_iova:
> +	free_iova_fast(&dma_dom->iovad, address, npages);
> +
> +out_err:
>  	return 0;
>  }
> =20
> @@ -2451,18 +2511,18 @@ static void unmap_sg(struct device *dev, stru=
ct scatterlist *sglist,
>  		     struct dma_attrs *attrs)
>  {
>  	struct protection_domain *domain;
> -	struct scatterlist *s;
> -	int i;
> +	unsigned long startaddr;
> +	int npages =3D 2;
> =20
>  	domain =3D get_domain(dev);
>  	if (IS_ERR(domain))
>  		return;
> =20
> -	for_each_sg(sglist, s, nelems, i) {
> -		__unmap_single(domain->priv, s->dma_address,
> -			       s->dma_length, dir);
> -		s->dma_address =3D s->dma_length =3D 0;
> -	}
> +	startaddr =3D sg_dma_address(sglist) & PAGE_MASK;
> +	dma_dom   =3D domain->priv;

This line seems to be here by mistake (I guess patch 20 removes it
again, but it's a brief bisection-breaker).

Robin.

> +	npages    =3D sg_num_pages(dev, sglist, nelems);
> +
> +	__unmap_single(domain->priv, startaddr, npages << PAGE_SHIFT, dir);
>  }
> =20
>  /*
>=20
