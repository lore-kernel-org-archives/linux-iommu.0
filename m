From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCHv9 6/6] dmaengine: rcar-dmac: add iommu support for slave
	transfers
Date: Mon, 5 Sep 2016 11:37:58 +0100
Message-ID: <b32caf39-e51b-af09-aa39-974cb8467893@arm.com>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
	<20160810112219.17964-7-niklas.soderlund+renesas@ragnatech.se>
	<6358234.jyTvyVnNF0@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6358234.jyTvyVnNF0@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On 05/09/16 10:52, Laurent Pinchart wrote:
> Hi Niklas,
> =

> Thank you for the patch.
> =

> On Wednesday 10 Aug 2016 13:22:19 Niklas S=F6derlund wrote:
>> Enable slave transfers to a device behind a IPMMU by mapping the slave
>> addresses using the dma-mapping API.
>>
>> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
>> ---
>> drivers/dma/sh/rcar-dmac.c | 82 ++++++++++++++++++++++++++++++++++++++--=
---
>> 1 file changed, 74 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
>> index cf983a9..22a5e40 100644
>> --- a/drivers/dma/sh/rcar-dmac.c
>> +++ b/drivers/dma/sh/rcar-dmac.c
>> @@ -128,6 +128,18 @@ struct rcar_dmac_chan_slave {
>>  };
>>
>>  /*
>> + * struct rcar_dmac_chan_map - Map of slave device phys to dma address
>> + * @addr: slave dma address
>> + * @dir: direction of mapping
>> + * @slave: slave configuration that is mapped
>> + */
>> +struct rcar_dmac_chan_map {
>> +	dma_addr_t addr;
>> +	enum dma_data_direction dir;
>> +	struct rcar_dmac_chan_slave slave;
>> +};
>> +
>> +/*
>>   * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
>>   * @chan: base DMA channel object
>>   * @iomem: channel I/O memory base
>> @@ -152,6 +164,7 @@ struct rcar_dmac_chan {
>>
>>  	struct rcar_dmac_chan_slave src;
>>  	struct rcar_dmac_chan_slave dst;
>> +	struct rcar_dmac_chan_map map;
>>  	int mid_rid;
>>
>>  	spinlock_t lock;
>> @@ -1029,13 +1042,65 @@ rcar_dmac_prep_dma_memcpy(struct dma_chan *chan,
>> dma_addr_t dma_dest, DMA_MEM_TO_MEM, flags, false);
>>  }
>>
>> +static int rcar_dmac_map_slave_addr(struct dma_chan *chan,
>> +				    enum dma_transfer_direction dir)
>> +{
>> +	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
>> +	struct rcar_dmac_chan_map *map =3D &rchan->map;
>> +	phys_addr_t dev_addr;
>> +	size_t dev_size;
>> +	enum dma_data_direction dev_dir;
>> +
>> +	if (dir =3D=3D DMA_DEV_TO_MEM) {
>> +		dev_addr =3D rchan->src.slave_addr;
>> +		dev_size =3D rchan->src.xfer_size;
>> +		dev_dir =3D DMA_TO_DEVICE;
> =

> Shouldn't this be DMA_FROM_DEVICE, and DMA_TO_DEVICE below ?

No, this is in fact correct (double-checking against the equivalent I
wrote for the ARM PL330 based on this - I should resurrect those patches...)

The "DEV" in the dmaengine direction is the peripheral FIFO, whereas the
"DEVICE" in the DMA API direction is the DMA engine itself, thus for the
DEV_TO_MEM transaction, the mapping of the "DEV" end needs to allow data
transfer "from" the address being mapped "to" the DMA engine.

Yes, it's hideously confusing.

Robin.

>> +	} else {
>> +		dev_addr =3D rchan->dst.slave_addr;
>> +		dev_size =3D rchan->dst.xfer_size;
>> +		dev_dir =3D DMA_FROM_DEVICE;
>> +	}
>> +
>> +	/* Reuse current map if possible. */
>> +	if (dev_addr =3D=3D map->slave.slave_addr &&
>> +	    dev_size =3D=3D map->slave.xfer_size &&
>> +	    dev_dir =3D=3D map->dir)
>> +		return 0;
>> +
>> +	/* Remove old mapping if present. */
>> +	if (map->slave.xfer_size)
>> +		dma_unmap_resource(chan->device->dev, map->addr,
>> +				   map->slave.xfer_size, map->dir, 0);
> =

> Unless I'm mistaken the resource will not be unmapped when freeing channe=
l =

> resources, will it ?
> =

>> +	map->slave.xfer_size =3D 0;
>> +
>> +	/* Create new slave address map. */
>> +	map->addr =3D dma_map_resource(chan->device->dev, dev_addr, dev_size,
>> +				     dev_dir, 0);
>> +
>> +	if (dma_mapping_error(chan->device->dev, map->addr)) {
>> +		dev_err(chan->device->dev,
>> +			"chan%u: failed to map %zx@%pap", rchan->index,
>> +			dev_size, &dev_addr);
>> +		return -EIO;
>> +	}
>> +
>> +	dev_dbg(chan->device->dev, "chan%u: map %zx@%pap to %pad dir: %s\n",
>> +		rchan->index, dev_size, &dev_addr, &map->addr,
>> +		dev_dir =3D=3D DMA_TO_DEVICE ? "DMA_TO_DEVICE" : =

> "DMA_FROM_DEVICE");
>> +
>> +	map->slave.slave_addr =3D dev_addr;
>> +	map->slave.xfer_size =3D dev_size;
>> +	map->dir =3D dev_dir;
>> +
>> +	return 0;
>> +}
>> +
>>  static struct dma_async_tx_descriptor *
>>  rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>>  			unsigned int sg_len, enum dma_transfer_direction dir,
>>  			unsigned long flags, void *context)
>>  {
>>  	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
>> -	dma_addr_t dev_addr;
>>
>>  	/* Someone calling slave DMA on a generic channel? */
>>  	if (rchan->mid_rid < 0 || !sg_len) {
>> @@ -1045,9 +1110,10 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, st=
ruct
>> scatterlist *sgl, return NULL;
>>  	}
>>
>> -	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
>> -		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
>> -	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
>> +	if (rcar_dmac_map_slave_addr(chan, dir))
>> +		return NULL;
>> +
>> +	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.addr,
>>  				      dir, flags, false);
>>  }
>>
>> @@ -1061,7 +1127,6 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
>> dma_addr_t buf_addr, struct rcar_dmac_chan *rchan =3D
>> to_rcar_dmac_chan(chan);
>>  	struct dma_async_tx_descriptor *desc;
>>  	struct scatterlist *sgl;
>> -	dma_addr_t dev_addr;
>>  	unsigned int sg_len;
>>  	unsigned int i;
>>
>> @@ -1073,6 +1138,9 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
>> dma_addr_t buf_addr, return NULL;
>>  	}
>>
>> +	if (rcar_dmac_map_slave_addr(chan, dir))
>> +		return NULL;
>> +
>>  	sg_len =3D buf_len / period_len;
>>  	if (sg_len > RCAR_DMAC_MAX_SG_LEN) {
>>  		dev_err(chan->device->dev,
>> @@ -1100,9 +1168,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
>> dma_addr_t buf_addr, sg_dma_len(&sgl[i]) =3D period_len;
>>  	}
>>
>> -	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
>> -		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
>> -	desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
>> +	desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.addr,
>>  				      dir, flags, true);
>>
>>  	kfree(sgl);
> =
