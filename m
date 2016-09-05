From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv9 4/6] arm: dma-mapping: add {map,unmap}_resource for iommu ops
Date: Mon, 05 Sep 2016 12:54:09 +0300
Message-ID: <1952161.FNa7jUW08f@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se> <20160810112219.17964-5-niklas.soderlund+renesas@ragnatech.se> <20160823153136.GH2951@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160823153136.GH2951@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, linux@armlinux.org.uk
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, hch@infradead.org, dan.j.williams@intel.com, vinod.koul@intel.com, robin.murphy@arm.com, linus.walleij@linaro.org, arnd@arndb.de
List-Id: iommu@lists.linux-foundation.org

Hello Niklas and Russell,

On Tuesday 23 Aug 2016 17:31:36 Niklas S=F6derlund wrote:
> Hi Russell,
>=20
> If you have the time can you please have a look at this patch? This
> series have been out for some time now and Vinod is willing to take i=
t
> through the dmaengine tree but a ACK is needed on this patch from you=

> first.

I've reviewed and acked all the patches touching the DMA mapping API (1=
/6 to=20
4/6). Russell, if you can find a bit of time to review this one it woul=
d be=20
very appreciated.

> On 2016-08-10 13:22:17 +0200, Niklas S=F6derlund wrote:
> > Add methods to map/unmap device resources addresses for dma_map_ops=
 that
> > are IOMMU aware. This is needed to map a device MMIO register from =
a
> > physical address.
> >=20
> > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnate=
ch.se>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >=20
> >  arch/arm/mm/dma-mapping.c | 63 +++++++++++++++++++++++++++++++++++=
+++++++
> >  1 file changed, 63 insertions(+)
> >=20
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index c6834c0..746eb29 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -2014,6 +2014,63 @@ static void arm_iommu_unmap_page(struct devi=
ce
> > *dev, dma_addr_t handle,>=20
> >  =09__free_iova(mapping, iova, len);
> > =20
> >  }
> >=20
> > +/**
> > + * arm_iommu_map_resource - map a device resource for DMA
> > + * @dev: valid struct device pointer
> > + * @phys_addr: physical address of resource
> > + * @size: size of resource to map
> > + * @dir: DMA transfer direction
> > + */
> > +static dma_addr_t arm_iommu_map_resource(struct device *dev,
> > +=09=09phys_addr_t phys_addr, size_t size,
> > +=09=09enum dma_data_direction dir, unsigned long attrs)
> > +{
> > +=09struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev)=
;
> > +=09dma_addr_t dma_addr;
> > +=09int ret, prot;
> > +=09phys_addr_t addr =3D phys_addr & PAGE_MASK;
> > +=09unsigned int offset =3D phys_addr & ~PAGE_MASK;
> > +=09size_t len =3D PAGE_ALIGN(size + offset);
> > +
> > +=09dma_addr =3D __alloc_iova(mapping, len);
> > +=09if (dma_addr =3D=3D DMA_ERROR_CODE)
> > +=09=09return dma_addr;
> > +
> > +=09prot =3D __dma_direction_to_prot(dir) | IOMMU_MMIO;
> > +
> > +=09ret =3D iommu_map(mapping->domain, dma_addr, addr, len, prot);
> > +=09if (ret < 0)
> > +=09=09goto fail;
> > +
> > +=09return dma_addr + offset;
> > +fail:
> > +=09__free_iova(mapping, dma_addr, len);
> > +=09return DMA_ERROR_CODE;
> > +}
> > +
> > +/**
> > + * arm_iommu_unmap_resource - unmap a device DMA resource
> > + * @dev: valid struct device pointer
> > + * @dma_handle: DMA address to resource
> > + * @size: size of resource to map
> > + * @dir: DMA transfer direction
> > + */
> > +static void arm_iommu_unmap_resource(struct device *dev, dma_addr_=
t
> > dma_handle, +=09=09size_t size, enum dma_data_direction dir,
> > +=09=09unsigned long attrs)
> > +{
> > +=09struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev)=
;
> > +=09dma_addr_t iova =3D dma_handle & PAGE_MASK;
> > +=09unsigned int offset =3D dma_handle & ~PAGE_MASK;
> > +=09size_t len =3D PAGE_ALIGN(size + offset);
> > +
> > +=09if (!iova)
> > +=09=09return;
> > +
> > +=09iommu_unmap(mapping->domain, iova, len);
> > +=09__free_iova(mapping, iova, len);
> > +}
> > +
> >=20
> >  static void arm_iommu_sync_single_for_cpu(struct device *dev,
> > =20
> >  =09=09dma_addr_t handle, size_t size, enum dma_data_direction dir)=

> > =20
> >  {
> >=20
> > @@ -2057,6 +2114,9 @@ struct dma_map_ops iommu_ops =3D {
> >=20
> >  =09.unmap_sg=09=09=3D arm_iommu_unmap_sg,
> >  =09.sync_sg_for_cpu=09=3D arm_iommu_sync_sg_for_cpu,
> >  =09.sync_sg_for_device=09=3D arm_iommu_sync_sg_for_device,
> >=20
> > +
> > +=09.map_resource=09=09=3D arm_iommu_map_resource,
> > +=09.unmap_resource=09=09=3D arm_iommu_unmap_resource,
> >=20
> >  };
> > =20
> >  struct dma_map_ops iommu_coherent_ops =3D {
> >=20
> > @@ -2070,6 +2130,9 @@ struct dma_map_ops iommu_coherent_ops =3D {
> >=20
> >  =09.map_sg=09=09=3D arm_coherent_iommu_map_sg,
> >  =09.unmap_sg=09=3D arm_coherent_iommu_unmap_sg,
> >=20
> > +
> > +=09.map_resource=09=3D arm_iommu_map_resource,
> > +=09.unmap_resource=09=3D arm_iommu_unmap_resource,
> >=20
> >  };
> > =20
> >  /**

--=20
Regards,

Laurent Pinchart
