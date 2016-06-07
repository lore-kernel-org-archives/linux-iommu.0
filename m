From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv8 6/6] dmaengine: rcar-dmac: add iommu support for slave transfers
Date: Tue,  7 Jun 2016 09:54:13 +0200
Message-ID: <1465286053-27258-7-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1465286053-27258-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1465286053-27258-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, linux@armlinux.org.uk
Cc: hch@infradead.org, dan.j.williams@intel.com, vinod.koul@intel.com, robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org, arnd@arndb.de, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
List-Id: iommu@lists.linux-foundation.org

Enable slave transfers to a device behind a IPMMU by mapping the slave
addresses using the dma-mapping API.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
---
 drivers/dma/sh/rcar-dmac.c | 82 ++++++++++++++++++++++++++++++++++++++=
+++-----
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index b0c3bb2..8592598 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -128,6 +128,18 @@ struct rcar_dmac_chan_slave {
 };
=20
 /*
+ * struct rcar_dmac_chan_map - Map of slave device phys to dma address
+ * @addr: slave dma address
+ * @dir: direction of mapping
+ * @slave: slave configuration that is mapped
+ */
+struct rcar_dmac_chan_map {
+	dma_addr_t addr;
+	enum dma_data_direction dir;
+	struct rcar_dmac_chan_slave slave;
+};
+
+/*
  * struct rcar_dmac_chan - R-Car Gen2 DMA Controller Channel
  * @chan: base DMA channel object
  * @iomem: channel I/O memory base
@@ -152,6 +164,7 @@ struct rcar_dmac_chan {
=20
 	struct rcar_dmac_chan_slave src;
 	struct rcar_dmac_chan_slave dst;
+	struct rcar_dmac_chan_map map;
 	int mid_rid;
=20
 	spinlock_t lock;
@@ -1027,13 +1040,65 @@ rcar_dmac_prep_dma_memcpy(struct dma_chan *chan=
, dma_addr_t dma_dest,
 				      DMA_MEM_TO_MEM, flags, false);
 }
=20
+static int rcar_dmac_map_slave_addr(struct dma_chan *chan,
+				    enum dma_transfer_direction dir)
+{
+	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
+	struct rcar_dmac_chan_map *map =3D &rchan->map;
+	phys_addr_t dev_addr;
+	size_t dev_size;
+	enum dma_data_direction dev_dir;
+
+	if (dir =3D=3D DMA_DEV_TO_MEM) {
+		dev_addr =3D rchan->src.slave_addr;
+		dev_size =3D rchan->src.xfer_size;
+		dev_dir =3D DMA_TO_DEVICE;
+	} else {
+		dev_addr =3D rchan->dst.slave_addr;
+		dev_size =3D rchan->dst.xfer_size;
+		dev_dir =3D DMA_FROM_DEVICE;
+	}
+
+	/* Reuse current map if possible. */
+	if (dev_addr =3D=3D map->slave.slave_addr &&
+	    dev_size =3D=3D map->slave.xfer_size &&
+	    dev_dir =3D=3D map->dir)
+		return 0;
+
+	/* Remove old mapping if present. */
+	if (map->slave.xfer_size)
+		dma_unmap_resource(chan->device->dev, map->addr,
+				   map->slave.xfer_size, map->dir, NULL);
+	map->slave.xfer_size =3D 0;
+
+	/* Create new slave address map. */
+	map->addr =3D dma_map_resource(chan->device->dev, dev_addr, dev_size,
+				     dev_dir, NULL);
+
+	if (dma_mapping_error(chan->device->dev, map->addr)) {
+		dev_err(chan->device->dev,
+			"chan%u: failed to map %zx@%pap", rchan->index,
+			dev_size, &dev_addr);
+		return -EIO;
+	}
+
+	dev_dbg(chan->device->dev, "chan%u: map %zx@%pap to %pad dir: %s\n",
+		rchan->index, dev_size, &dev_addr, &map->addr,
+		dev_dir =3D=3D DMA_TO_DEVICE ? "DMA_TO_DEVICE" : "DMA_FROM_DEVICE");
+
+	map->slave.slave_addr =3D dev_addr;
+	map->slave.xfer_size =3D dev_size;
+	map->dir =3D dev_dir;
+
+	return 0;
+}
+
 static struct dma_async_tx_descriptor *
 rcar_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl=
,
 			unsigned int sg_len, enum dma_transfer_direction dir,
 			unsigned long flags, void *context)
 {
 	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
-	dma_addr_t dev_addr;
=20
 	/* Someone calling slave DMA on a generic channel? */
 	if (rchan->mid_rid < 0 || !sg_len) {
@@ -1043,9 +1108,10 @@ rcar_dmac_prep_slave_sg(struct dma_chan *chan, s=
truct scatterlist *sgl,
 		return NULL;
 	}
=20
-	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
-		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
-	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
+	if (rcar_dmac_map_slave_addr(chan, dir))
+		return NULL;
+
+	return rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.addr,
 				      dir, flags, false);
 }
=20
@@ -1059,7 +1125,6 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, =
dma_addr_t buf_addr,
 	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
 	struct dma_async_tx_descriptor *desc;
 	struct scatterlist *sgl;
-	dma_addr_t dev_addr;
 	unsigned int sg_len;
 	unsigned int i;
=20
@@ -1071,6 +1136,9 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, =
dma_addr_t buf_addr,
 		return NULL;
 	}
=20
+	if (rcar_dmac_map_slave_addr(chan, dir))
+		return NULL;
+
 	sg_len =3D buf_len / period_len;
 	if (sg_len > RCAR_DMAC_MAX_SG_LEN) {
 		dev_err(chan->device->dev,
@@ -1098,9 +1166,7 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, =
dma_addr_t buf_addr,
 		sg_dma_len(&sgl[i]) =3D period_len;
 	}
=20
-	dev_addr =3D dir =3D=3D DMA_DEV_TO_MEM
-		 ? rchan->src.slave_addr : rchan->dst.slave_addr;
-	desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, dev_addr,
+	desc =3D rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->map.addr,
 				      dir, flags, true);
=20
 	kfree(sgl);
--=20
2.8.2
