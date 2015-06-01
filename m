From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 4/7] DMA-API: Add dma_(un)map_resource() documentation
Date: Mon, 1 Jun 2015 17:25:28 -0400
Message-ID: <20150601212528.GC7354@konrad-lan.dumpdata.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
	<1431973504-5903-5-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431973504-5903-5-git-send-email-wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 18, 2015 at 01:25:01PM -0500, wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:
> From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Add references to both the general API documentation as well as the HOWTO.
> 
> Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/DMA-API-HOWTO.txt | 39 +++++++++++++++++++++++++++++++++++++--
>  Documentation/DMA-API.txt       | 36 +++++++++++++++++++++++++++++++-----
>  2 files changed, 68 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
> index 0f7afb2..89bd730 100644
> --- a/Documentation/DMA-API-HOWTO.txt
> +++ b/Documentation/DMA-API-HOWTO.txt
> @@ -138,6 +138,10 @@ What about block I/O and networking buffers?  The block I/O and
>  networking subsystems make sure that the buffers they use are valid
>  for you to DMA from/to.
>  
> +In some systems, it may also be possible to DMA to and/or from a peer
> +device's MMIO region, as described by a 'struct resource'. This is
> +referred to as a peer-to-peer mapping.
> +
>  			DMA addressing limitations
>  
>  Does your device have any DMA addressing limitations?  For example, is
> @@ -648,6 +652,35 @@ Every dma_map_{single,sg}() call should have its dma_unmap_{single,sg}()
>  counterpart, because the bus address space is a shared resource and
>  you could render the machine unusable by consuming all bus addresses.
>  
> +Peer-to-peer DMA mappings can be obtained using dma_map_resource() to map
> +another device's MMIO region for the given device:
> +
> +	struct resource *peer_mmio_res = &other_dev->resource[0];
> +	dma_addr_t dma_handle = dma_map_resource(dev, peer_mmio_res,
> +						 offset, size, direction);
> +	if (dma_handle == 0 || dma_mapping_error(dev, dma_handle))

Don't check for 0. That can be a valid value.

> +	{
> +		/*
> +		 * If dma_handle == 0, dma_map_resource() is not
> +		 * implemented, and peer-to-peer transactions will not
> +		 * work.

Perhaps we should just have an dma_can_map_resource function instead
to check for this?
