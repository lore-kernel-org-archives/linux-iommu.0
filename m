From: Konrad Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 04/13] DMA-API: Introduce dma_(un)map_peer_resource
Date: Tue, 18 Aug 2015 16:26:09 -0700 (PDT)
Message-ID: <2dd0ce48-fb6e-4003-90ee-33827ebfc7c1@default>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: corbet-T1hC0tSOHrs@public.gmane.org, jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


> +#ifdef CONFIG_HAS_DMA_P2P
> +static inline dma_peer_addr_t dma_map_peer_resource_attrs(struct
> device *dev,
> +							  struct device *peer,
> +							  struct resource *res,
> +							  size_t offset,
> +							  size_t size,
> +							  enum dma_data_direction dir,
> +							  struct dma_attrs *attrs)
> +{
> +	struct dma_map_ops *ops = get_dma_ops(dev);
> +	dma_peer_addr_t addr;
> +
> +	BUG_ON(!valid_dma_direction(dir));
> +	BUG_ON(ops->map_peer_resource == NULL);
> +	addr = ops->map_peer_resource(dev, peer, res, offset, size, dir,
> +				      attrs);
> +	debug_dma_map_peer_resource(dev, peer, res, offset, size, dir,
> addr);
> +
> +	return addr;
> +

With those 'BUG_ON' you need to make sure that every dma_map_ops has
this implemented. That means the calgary_dma_ops, gart_dma_ops, swiotlb_dma_ops,
and xen_swiotlb_dma_ops MUST have something implemented.

Please keep in mind that on one can do 'iommu=soft swiotbl=force' on the
command line which will force the IOMMUs to be ignored and only the
SWIOTLB code will be used.
