From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCHv7 4/6] arm: dma-mapping: add {map, unmap}_resource for
 iommu ops
Date: Wed, 1 Jun 2016 17:16:06 +0100
Message-ID: <20160601161605.GA19428@n2100.arm.linux.org.uk>
References: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1464794549-6601-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464794549-6601-5-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: hch@infradead.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, arnd@arndb.de, vinod.koul@intel.com, linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com, dan.j.williams@intel.com, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 01, 2016 at 05:22:27PM +0200, Niklas S=F6derlund wrote:
> +static dma_addr_t arm_iommu_map_resource(struct device *dev,
> +		phys_addr_t phys_addr, size_t size,
> +		enum dma_data_direction dir, struct dma_attrs *attrs)
> +{
> +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> +	dma_addr_t dma_addr;
> +	int ret, prot;
> +	phys_addr_t addr =3D phys_addr & PAGE_MASK;
> +	int offset =3D phys_addr & ~PAGE_MASK;
> +	int len =3D PAGE_ALIGN(size + offset);

Shouldn't both of these be unsigned - preferably size_t for len?

> +
> +	dma_addr =3D __alloc_iova(mapping, size);

Is this really correct?  What if size =3D 4095 and offset =3D 10?  Do w=
e
really only need one IOVA page for such a mapping (I count two pages.)
Shouldn't this be "len" ?

> +	if (dma_addr =3D=3D DMA_ERROR_CODE)
> +		return dma_addr;
> +
> +	prot =3D __dma_direction_to_prot(dir) | IOMMU_MMIO;
> +
> +	ret =3D iommu_map(mapping->domain, dma_addr, addr, len, prot);
> +	if (ret < 0)
> +		goto fail;
> +
> +	return dma_addr + offset;
> +fail:
> +	__free_iova(mapping, dma_addr, size);

Shouldn't this be "len" as well?

> +	return DMA_ERROR_CODE;
> +}
> +
> +/**
> + * arm_iommu_unmap_resource - unmap a device DMA resource
> + * @dev: valid struct device pointer
> + * @dma_handle: DMA address to resource
> + * @size: size of resource to map
> + * @dir: DMA transfer direction
> + */
> +static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t =
dma_handle,
> +		size_t size, enum dma_data_direction dir,
> +		struct dma_attrs *attrs)
> +{
> +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> +	dma_addr_t iova =3D dma_handle & PAGE_MASK;
> +	int offset =3D dma_handle & ~PAGE_MASK;
> +	int len =3D PAGE_ALIGN(size + offset);

unsigned/size_t again.

> +
> +	if (!iova)
> +		return;
> +
> +	iommu_unmap(mapping->domain, iova, len);
> +	__free_iova(mapping, iova, len);

Here, you free "len" bytes of iova, which is different from above.

> +}
> +
>  static void arm_iommu_sync_single_for_cpu(struct device *dev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
> @@ -1994,6 +2051,9 @@ struct dma_map_ops iommu_ops =3D {
>  	.unmap_sg		=3D arm_iommu_unmap_sg,
>  	.sync_sg_for_cpu	=3D arm_iommu_sync_sg_for_cpu,
>  	.sync_sg_for_device	=3D arm_iommu_sync_sg_for_device,
> +
> +	.map_resource		=3D arm_iommu_map_resource,
> +	.unmap_resource		=3D arm_iommu_unmap_resource,
>  };
> =20
>  struct dma_map_ops iommu_coherent_ops =3D {
> @@ -2007,6 +2067,9 @@ struct dma_map_ops iommu_coherent_ops =3D {
> =20
>  	.map_sg		=3D arm_coherent_iommu_map_sg,
>  	.unmap_sg	=3D arm_coherent_iommu_unmap_sg,
> +
> +	.map_resource	=3D arm_iommu_map_resource,
> +	.unmap_resource	=3D arm_iommu_unmap_resource,
>  };
> =20
>  /**
> --=20
> 2.8.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
=46TTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
