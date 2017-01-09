From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCHv9 6/6] dmaengine: rcar-dmac: add iommu support for slave
	transfers
Date: Mon, 9 Jan 2017 16:42:20 +0100
Message-ID: <20170109154220.GH29854@bigcity.dyn.berto.se>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
	<20160810112219.17964-7-niklas.soderlund+renesas@ragnatech.se>
	<6358234.jyTvyVnNF0@avalon> <26490346.qhNpbOL6eO@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <26490346.qhNpbOL6eO@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On 2017-01-02 01:08:04 +0200, Laurent Pinchart wrote:
> Hi Niklas,
> =

> On Monday 05 Sep 2016 12:52:44 Laurent Pinchart wrote:
> > On Wednesday 10 Aug 2016 13:22:19 Niklas S=F6derlund wrote:
> > > Enable slave transfers to a device behind a IPMMU by mapping the slave
> > > addresses using the dma-mapping API.
> > > =

> > > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
.se>
> > > ---
> > > drivers/dma/sh/rcar-dmac.c | 82 ++++++++++++++++++++++++++++++++++++-=
----
> > > 1 file changed, 74 insertions(+), 8 deletions(-)
> > > =

> > > diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> > > index cf983a9..22a5e40 100644
> > > --- a/drivers/dma/sh/rcar-dmac.c
> > > +++ b/drivers/dma/sh/rcar-dmac.c
> =

> [snip]
> =

> > > +static int rcar_dmac_map_slave_addr(struct dma_chan *chan,
> > > +				    enum dma_transfer_direction dir)
> > > +{
> > > +	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> > > +	struct rcar_dmac_chan_map *map =3D &rchan->map;
> > > +	phys_addr_t dev_addr;
> > > +	size_t dev_size;
> > > +	enum dma_data_direction dev_dir;
> > > +
> > > +	if (dir =3D=3D DMA_DEV_TO_MEM) {
> > > +		dev_addr =3D rchan->src.slave_addr;
> > > +		dev_size =3D rchan->src.xfer_size;
> > > +		dev_dir =3D DMA_TO_DEVICE;
> > =

> > Shouldn't this be DMA_FROM_DEVICE, and DMA_TO_DEVICE below ?
> =

> This comment can be ignored (thank you Robin for the explanation), but ...
> =

> > > +	} else {
> > > +		dev_addr =3D rchan->dst.slave_addr;
> > > +		dev_size =3D rchan->dst.xfer_size;
> > > +		dev_dir =3D DMA_FROM_DEVICE;
> > > +	}
> > > +
> > > +	/* Reuse current map if possible. */
> > > +	if (dev_addr =3D=3D map->slave.slave_addr &&
> > > +	    dev_size =3D=3D map->slave.xfer_size &&
> > > +	    dev_dir =3D=3D map->dir)
> > > +		return 0;
> > > +
> > > +	/* Remove old mapping if present. */
> > > +	if (map->slave.xfer_size)
> > > +		dma_unmap_resource(chan->device->dev, map->addr,
> > > +				   map->slave.xfer_size, map->dir, 0);
> > =

> > Unless I'm mistaken the resource will not be unmapped when freeing chan=
nel
> > resources, will it ?
> =

> I believe this one still needs to be addressed.

I believe you are correct, I will look in to it and hopefully submit a =

patch to address it. Thanks for brining it up.

> =

> > > +	map->slave.xfer_size =3D 0;
> > > +
> > > +	/* Create new slave address map. */
> > > +	map->addr =3D dma_map_resource(chan->device->dev, dev_addr, dev_siz=
e,
> > > +				     dev_dir, 0);
> > > +
> > > +	if (dma_mapping_error(chan->device->dev, map->addr)) {
> > > +		dev_err(chan->device->dev,
> > > +			"chan%u: failed to map %zx@%pap", rchan->index,
> > > +			dev_size, &dev_addr);
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	dev_dbg(chan->device->dev, "chan%u: map %zx@%pap to %pad dir: %s\n",
> > > +		rchan->index, dev_size, &dev_addr, &map->addr,
> > =

> > > +		dev_dir =3D=3D DMA_TO_DEVICE ? "DMA_TO_DEVICE" :
> > "DMA_FROM_DEVICE");
> > =

> > > +
> > > +	map->slave.slave_addr =3D dev_addr;
> > > +	map->slave.xfer_size =3D dev_size;
> > > +	map->dir =3D dev_dir;
> > > +
> > > +	return 0;
> > > +}
> =

> [snip]
> =

> -- =

> Regards,
> =

> Laurent Pinchart
> =


-- =

Regards,
Niklas S=F6derlund
