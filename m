From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv9 3/6] dma-mapping: add dma_{map,unmap}_resource
Date: Mon, 05 Sep 2016 12:46:43 +0300
Message-ID: <2244107.fHLLTnqJPB@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
	<20160810112219.17964-4-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160810112219.17964-4-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 Aug 2016 13:22:16 Niklas S=F6derlund wrote:
> Map/Unmap a device MMIO resource from a physical address. If no dma_map_o=
ps
> method is available the operation is a no-op.
> =

> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  Documentation/DMA-API.txt   | 22 +++++++++++++++++-----
>  include/linux/dma-mapping.h | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 5 deletions(-)
> =

> diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
> index 1d26eeb6..6b20128 100644
> --- a/Documentation/DMA-API.txt
> +++ b/Documentation/DMA-API.txt
> @@ -277,14 +277,26 @@ and <size> parameters are provided to do partial pa=
ge
> mapping, it is recommended that you never use these unless you really know
> what the cache width is.
> =

> +dma_addr_t
> +dma_map_resource(struct device *dev, phys_addr_t phys_addr, size_t size,
> +		 enum dma_data_direction dir, unsigned long attrs)
> +
> +void
> +dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
> +		   enum dma_data_direction dir, unsigned long attrs)
> +
> +API for mapping and unmapping for MMIO resources. All the notes and
> +warnings for the other mapping APIs apply here. The API should only be
> +used to map device MMIO resources, mapping of RAM is not permitted.
> +
>  int
>  dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> =

> -In some circumstances dma_map_single() and dma_map_page() will fail to
> create -a mapping. A driver can check for these errors by testing the
> returned -DMA address with dma_mapping_error(). A non-zero return value
> means the mapping -could not be created and the driver should take
> appropriate action (e.g. -reduce current DMA mapping usage or delay and t=
ry
> again later).
> +In some circumstances dma_map_single(), dma_map_page() and
> dma_map_resource() +will fail to create a mapping. A driver can check for
> these errors by testing +the returned DMA address with dma_mapping_error(=
).
> A non-zero return value +means the mapping could not be created and the
> driver should take appropriate +action (e.g. reduce current DMA mapping
> usage or delay and try again later).
> =

>  	int
>  	dma_map_sg(struct device *dev, struct scatterlist *sg,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e3bd27f..9a07882 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -264,6 +264,42 @@ static inline void dma_unmap_page(struct device *dev,
> dma_addr_t addr, debug_dma_unmap_page(dev, addr, size, dir, false);
>  }
> =

> +static inline dma_addr_t dma_map_resource(struct device *dev,
> +					  phys_addr_t phys_addr,
> +					  size_t size,
> +					  enum dma_data_direction dir,
> +					  unsigned long attrs)
> +{
> +	struct dma_map_ops *ops =3D get_dma_ops(dev);
> +	unsigned long pfn =3D __phys_to_pfn(phys_addr);
> +	dma_addr_t addr;
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +
> +	/* Don't allow RAM to be mapped */
> +	BUG_ON(pfn_valid(pfn));
> +
> +	addr =3D phys_addr;
> +	if (ops->map_resource)
> +		addr =3D ops->map_resource(dev, phys_addr, size, dir, attrs);
> +
> +	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
> +
> +	return addr;
> +}
> +
> +static inline void dma_unmap_resource(struct device *dev, dma_addr_t add=
r,
> +				      size_t size, enum dma_data_direction =

dir,
> +				      unsigned long attrs)
> +{
> +	struct dma_map_ops *ops =3D get_dma_ops(dev);
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +	if (ops->unmap_resource)
> +		ops->unmap_resource(dev, addr, size, dir, attrs);
> +	debug_dma_unmap_resource(dev, addr, size, dir);
> +}
> +
>  static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t
> addr, size_t size,
>  					   enum dma_data_direction dir)

-- =

Regards,

Laurent Pinchart
