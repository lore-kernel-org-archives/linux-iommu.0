From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCHv9 4/6] arm: dma-mapping: add {map,unmap}_resource for
	iommu ops
Date: Tue, 23 Aug 2016 17:31:36 +0200
Message-ID: <20160823153136.GH2951@bigcity.dyn.berto.se>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
	<20160810112219.17964-5-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160810112219.17964-5-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Russell,

If you have the time can you please have a look at this patch? This =

series have been out for some time now and Vinod is willing to take it =

through the dmaengine tree but a ACK is needed on this patch from you =

first.

On 2016-08-10 13:22:17 +0200, Niklas S=F6derlund wrote:
> Add methods to map/unmap device resources addresses for dma_map_ops that
> are IOMMU aware. This is needed to map a device MMIO register from a
> physical address.
> =

> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  arch/arm/mm/dma-mapping.c | 63 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 63 insertions(+)
> =

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c6834c0..746eb29 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2014,6 +2014,63 @@ static void arm_iommu_unmap_page(struct device *de=
v, dma_addr_t handle,
>  	__free_iova(mapping, iova, len);
>  }
>  =

> +/**
> + * arm_iommu_map_resource - map a device resource for DMA
> + * @dev: valid struct device pointer
> + * @phys_addr: physical address of resource
> + * @size: size of resource to map
> + * @dir: DMA transfer direction
> + */
> +static dma_addr_t arm_iommu_map_resource(struct device *dev,
> +		phys_addr_t phys_addr, size_t size,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> +	dma_addr_t dma_addr;
> +	int ret, prot;
> +	phys_addr_t addr =3D phys_addr & PAGE_MASK;
> +	unsigned int offset =3D phys_addr & ~PAGE_MASK;
> +	size_t len =3D PAGE_ALIGN(size + offset);
> +
> +	dma_addr =3D __alloc_iova(mapping, len);
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
> +	__free_iova(mapping, dma_addr, len);
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
> +static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dma_=
handle,
> +		size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> +	dma_addr_t iova =3D dma_handle & PAGE_MASK;
> +	unsigned int offset =3D dma_handle & ~PAGE_MASK;
> +	size_t len =3D PAGE_ALIGN(size + offset);
> +
> +	if (!iova)
> +		return;
> +
> +	iommu_unmap(mapping->domain, iova, len);
> +	__free_iova(mapping, iova, len);
> +}
> +
>  static void arm_iommu_sync_single_for_cpu(struct device *dev,
>  		dma_addr_t handle, size_t size, enum dma_data_direction dir)
>  {
> @@ -2057,6 +2114,9 @@ struct dma_map_ops iommu_ops =3D {
>  	.unmap_sg		=3D arm_iommu_unmap_sg,
>  	.sync_sg_for_cpu	=3D arm_iommu_sync_sg_for_cpu,
>  	.sync_sg_for_device	=3D arm_iommu_sync_sg_for_device,
> +
> +	.map_resource		=3D arm_iommu_map_resource,
> +	.unmap_resource		=3D arm_iommu_unmap_resource,
>  };
>  =

>  struct dma_map_ops iommu_coherent_ops =3D {
> @@ -2070,6 +2130,9 @@ struct dma_map_ops iommu_coherent_ops =3D {
>  =

>  	.map_sg		=3D arm_coherent_iommu_map_sg,
>  	.unmap_sg	=3D arm_coherent_iommu_unmap_sg,
> +
> +	.map_resource	=3D arm_iommu_map_resource,
> +	.unmap_resource	=3D arm_iommu_unmap_resource,
>  };
>  =

>  /**
> -- =

> 2.9.2
> =


-- =

Regards,
Niklas S=F6derlund
