From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] xhci: Set DMA parameters appropriately
Date: Fri, 13 Oct 2017 10:15:42 +0200
Message-ID: <1cde45f2-cdd5-6210-dc00-49637132b897@samsung.com>
References: <CGME20171011135703epcas1p246932a3a94ed2f137c0187bdab883ad8@epcas1p2.samsung.com>
        <347776be09eb0ca947c1c8ced46ee3ca92d92e28.1507730115.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <347776be09eb0ca947c1c8ced46ee3ca92d92e28.1507730115.git.robin.murphy@arm.com>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 2017-10-11 15:56, Robin Murphy wrote:
> xHCI requires that data buffers do not cross 64KB boundaries (and are
> thus at most 64KB long as well) - whilst xhci_queue_{bulk,isoc}_tx()
> already split their input buffers into individual TRBs as necessary,
> it's still a good idea to advertise the limitations via the standard DMA
> API mechanism, so that most producers like the block layer and the DMA
> mapping implementations can lay things out correctly to begin with.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/usb/host/xhci.c | 4 ++++
>   drivers/usb/host/xhci.h | 3 +++
>   2 files changed, 7 insertions(+)
>
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 74b4500641c2..1e7e1e3d8c48 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4883,6 +4883,10 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>   		dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>   	}
>   
> +	dev->dma_parms = &xhci->dma_parms;
> +	dma_set_max_seg_size(dev, SZ_64K);
> +	dma_set_seg_boundary(dev, SZ_64K - 1);
> +
>   	xhci_dbg(xhci, "Calling HCD init\n");
>   	/* Initialize HCD and host controller data structures. */
>   	retval = xhci_init(hcd);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 7ef69ea0b480..afcae4cc908d 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1767,6 +1767,9 @@ struct xhci_hcd {
>   	struct dma_pool	*small_streams_pool;
>   	struct dma_pool	*medium_streams_pool;
>   
> +	/* DMA alignment restrictions */
> +	struct device_dma_parameters dma_parms;
> +
>   	/* Host controller watchdog timer structures */
>   	unsigned int		xhc_state;
>   

Are you sure that xhci_hcd life time is proper to keep dma_parms? It looks
that when driver gets removed and xhci_hcd is freed, the dma_parms will
point to freed memory. Maybe it would make sense to clear dev->dma_parms
somewhere or definitely change the way dma_parms are allocated?

On the other hand 64K is the default segment size if no dma_parms are
provided, so there is very little value added by this patch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
