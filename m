From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/pci: reserve iova for PCI masters
Date: Thu, 4 May 2017 19:20:19 +0100
Message-ID: <0c9a6b09-139c-df49-cf73-6a3935a6aacd@arm.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
 <1493786795-28153-2-git-send-email-oza.oza@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493786795-28153-2-git-send-email-oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Oza Pawandeep <oza.pawandeep-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/05/17 05:46, Oza Pawandeep wrote:
> this patch reserves the iova for PCI masters.
> ARM64 based SOCs may have scattered memory banks.
> such as iproc based SOC has
> 
> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
> 
> but incoming PCI transcation addressing capability is limited
> by host bridge, for example if max incoming window capability
> is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.
> 
> to address this problem, iommu has to avoid allocating iovas which
> are reserved. which inturn does not allocate iova if it falls into hole.

I don't necessarily disagree with doing this, as we could do with facing
up to the issue of discontiguous DMA ranges in particular (I too have a
platform with this problem), but I'm still not overly keen on pulling DT
specifics into this layer. More than that, though, if we are going to do
it, then we should do it for all devices with a restrictive
"dma-ranges", not just PCI ones.

> Bug: SOC-5216
> Change-Id: Icbfc99a045d730be143fef427098c937b9d46353
> Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-on: http://gerrit-ccxsw.broadcom.net/40760
> Reviewed-by: vpx_checkpatch status <vpx_checkpatch-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: CCXSW <ccxswbuild-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Tested-by: vpx_autobuild status <vpx_autobuild-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Tested-by: vpx_smoketest status <vpx_smoketest-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Tested-by: CCXSW <ccxswbuild-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 48d36ce..08764b0 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -27,6 +27,7 @@
>  #include <linux/iova.h>
>  #include <linux/irq.h>
>  #include <linux/mm.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/scatterlist.h>
>  #include <linux/vmalloc.h>
> @@ -171,8 +172,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>  		struct iova_domain *iovad)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct device_node *np = bridge->dev.parent->of_node;
>  	struct resource_entry *window;
>  	unsigned long lo, hi;
> +	int ret;
> +	dma_addr_t tmp_dma_addr = 0, dma_addr;
> +	LIST_HEAD(res);
>  
>  	resource_list_for_each_entry(window, &bridge->windows) {
>  		if (resource_type(window->res) != IORESOURCE_MEM &&
> @@ -183,6 +188,36 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>  		hi = iova_pfn(iovad, window->res->end - window->offset);
>  		reserve_iova(iovad, lo, hi);
>  	}
> +
> +	/* PCI inbound memory reservation. */
> +	ret = of_pci_get_dma_ranges(np, &res);
> +	if (!ret) {
> +		resource_list_for_each_entry(window, &res) {
> +			struct resource *res_dma = window->res;
> +
> +			dma_addr = res_dma->start - window->offset;
> +			if (tmp_dma_addr > dma_addr) {
> +				pr_warn("PCI: failed to reserve iovas; ranges should be sorted\n");

I don't see anything in the DT spec about the entries having to be
sorted, and it's not exactly impossible to sort a list if you need it so
(and if I'm being really pedantic, one could still trigger this with a
list that *is* sorted, only by different criteria).

Robin.

> +				return;
> +			}
> +			if (tmp_dma_addr != dma_addr) {
> +				lo = iova_pfn(iovad, tmp_dma_addr);
> +				hi = iova_pfn(iovad, dma_addr - 1);
> +				reserve_iova(iovad, lo, hi);
> +			}
> +			tmp_dma_addr = window->res->end - window->offset;
> +		}
> +		/*
> +		 * the last dma-range should honour based on the
> +		 * 32/64-bit dma addresses.
> +		 */
> +		if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
> +			lo = iova_pfn(iovad, tmp_dma_addr);
> +			hi = iova_pfn(iovad,
> +				      DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
> +			reserve_iova(iovad, lo, hi);
> +		}
> +	}
>  }
>  
>  /**
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
