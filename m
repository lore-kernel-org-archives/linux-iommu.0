From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCHv9 6/6] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Mon, 05 Sep 2016 12:52:44 +0300
Message-ID: <6358234.jyTvyVnNF0@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se> <20160810112219.17964-7-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160810112219.17964-7-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk, hch@infradead.org, dan.j.williams@intel.com, vinod.koul@intel.com, robin.murphy@arm.com, linus.walleij@linaro.org, arnd@arndb.de
List-Id: iommu@lists.linux-foundation.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 Aug 2016 13:22:19 Niklas S=F6derlund wrote:
> Enable slave transfers to a device behind a IPMMU by mapping the slav=
e
> addresses using the dma-mapping API.
>=20
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
.se>
> ---
> drivers/dma/sh/rcar-dmac.c | 82 +++++++++++++++++++++++++++++++++++++=
+-----
> 1 file changed, 74 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index cf983a9..22a5e40 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -128,6 +128,18 @@ struct rcar_dmac_chan_slave {
>  };
>=20
>  /*
> + * struct rcar_dmac_chan_map - Map of slave device phys to dma addre=
ss
> + * @addr: slave dma address
> + * @dir: direction of mapping
> + * @slave: slave configuration that is mapped
> + */
> +struct rcar_dmac_chan_map {
> +=09dma_addr_t addr;
> +=09enum dma_data_direction dir;
> +=09struct rcar_dmac_chan_slave slave;
> +};
> +
> +/*
>   * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
>   * @chan: base DMA channel object
>   * @iomem: channel I/O memory base
> @@ -152,6 +164,7 @@ struct rcar_dmac_chan {
>=20
>  =09struct rcar_dmac_chan_slave src;
>  =09struct rcar_dmac_chan_slave dst;
> +=09struct rcar_dmac_chan_map map;
>  =09int mid_rid;
>=20
>  =09spinlock_t lock;
> @@ -1029,13 +1042,65 @@ rcar_dmac_prep_dma_memcpy(struct dma_chan *ch=
an,
> dma_addr_t dma_dest, DMA_MEM_TO_MEM, flags, false);
>  }
>=20
> +static int rcar_dmac_map_slave_addr(struct dma_chan *chan,
> +=09=09=09=09    enum dma_transfer_direction dir)
> +{
> +=09struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> +=09struct rcar_dmac_chan_map *map =3D &rchan->map;
> +=09phys_addr_t dev_addr;
> +=09size_t dev_size;
> +=09enum dma_data_direction dev_dir;
> +
> +=09if (dir =3D=3D DMA_DEV_TO_MEM) {
> +=09=09dev_addr =3D rchan->src.slave_addr;
> +=09=09dev_size =3D rchan->src.xfer_size;
> +=09=09dev_dir =3D DMA_TO_DEVICE;

Shouldn't this be DMA_FROM_DEVICE, and DMA_TO_DEVICE below ?

> +=09} else {
> +=09=09dev_addr =3D rchan->dst.slave_addr;
> +=09=09dev_size =3D rchan->dst.xfer_size;
> +=09=09dev_dir =3D DMA_FROM_DEVICE;
> +=09}
> +
> +=09/* Reuse current map if possible. */
> +=09if (dev_addr =3D=3D map->slave.slave_addr &&
> +=09    dev_size =3D=3D map->slave.xfer_size &&
> +=09    dev_dir =3D=3D map->dir)
> +=09=09return 0;
> +
> +=09/* Remove old mapping if present. */
> +=09if (map->slave.xfer_size)
> +=09=09dma_unmap_resource(chan->device->dev, map->addr,
> +=09=09=09=09   map->slave.xfer_size, map->dir, 0);

Unless I'm mistaken the resource will not be unmapped when freeing chan=
nel=20
resources, will it ?

> +=09map->slave.xfer_size =3D 0;
> +
> +=09/* Create new slave address map. */
> +=09map->addr =3D dma_map_resource(chan->device->dev, dev_addr, dev_s=
ize,
> +=09=09=09=09     dev_dir, 0);
> +
> +=09if (dma_mapping_error(chan->device->dev, map->addr)) {
> +=09=09dev_err(chan->device->dev,
> +=09=09=09"chan%u: failed to map %zx@%pap", rchan->index,
> +=09=09=09dev_size, &dev_addr);
> +=09=09return -EIO;
> +=09}
> +
> +=09dev_dbg(chan->device->dev, "chan%u: map %zx@%pap to %pad dir: %s\=
n",
> +=09=09rchan->index, dev_size, &dev_addr, &map->addr,
> +=09=09dev_dir =3D=3D DMA_TO_DEVICE ? "DMA_TO_DEVICE" :=20
"DMA_FROM_DEVICE");
> +
> +=09map->slave.slave_addr =3D dev_addr;
> +=09map->slave.xfer_size =3D dev_size;
> +=09map->dir =3D dev_dir;
> +
> +=09return 0;
> +}
> +
>  static struct dma_async_tx_descriptor *
>  rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *s=
gl,
>  =09=09=09unsigned int sg_len, enum dma_transfer_direction dir,
>  =09=09=09unsigned long flags, void *context)
>  {
>  =09struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> -=09dma_addr_t dev_addr;
>=20
>  =09/* Someone calling slave DMA on a generic channel? */
>  =09if (rchan->mid_rid < 0 || !sg_len) {
> @@ -1045,9 +1110,10 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan,=
 struct
> scatterlist *sgl, return NULL;
>  =09}
>=20
> -=09dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
> -=09=09 ? rchan->src.slave_addr : rchan->dst.slave_addr;
> -=09return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
> +=09if (rcar_dmac_map_slave_addr(chan, dir))
> +=09=09return NULL;
> +
> +=09return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.addr=
,
>  =09=09=09=09      dir, flags, false);
>  }
>=20
> @@ -1061,7 +1127,6 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan=
,
> dma_addr_t buf_addr, struct rcar_dmac_chan *rchan =3D
> to_rcar_dmac_chan(chan);
>  =09struct dma_async_tx_descriptor *desc;
>  =09struct scatterlist *sgl;
> -=09dma_addr_t dev_addr;
>  =09unsigned int sg_len;
>  =09unsigned int i;
>=20
> @@ -1073,6 +1138,9 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan=
,
> dma_addr_t buf_addr, return NULL;
>  =09}
>=20
> +=09if (rcar_dmac_map_slave_addr(chan, dir))
> +=09=09return NULL;
> +
>  =09sg_len =3D buf_len / period_len;
>  =09if (sg_len > RCAR_DMAC_MAX_SG_LEN) {
>  =09=09dev_err(chan->device->dev,
> @@ -1100,9 +1168,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan=
,
> dma_addr_t buf_addr, sg_dma_len(&sgl[i]) =3D period_len;
>  =09}
>=20
> -=09dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
> -=09=09 ? rchan->src.slave_addr : rchan->dst.slave_addr;
> -=09desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
> +=09desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.ad=
dr,
>  =09=09=09=09      dir, flags, true);
>=20
>  =09kfree(sgl);

--=20
Regards,

Laurent Pinchart
