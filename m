From: Oza Oza via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: RE: [RFC PATCH] iommu/dma: check pci host bridge dma_mask for IOVA
	allocation
Date: Wed, 15 Mar 2017 14:38:15 +0530
Message-ID: <74299555a97ff1ee38ef014333f2e4a1@mail.gmail.com>
References: <1489481327-2862-1-git-send-email-oza.oza@broadcom.com>
	<e24a46f0-bd25-8fff-d19e-cafd615d7c37@arm.com>
	545868358a73cbc5bd1911eb64b3bdc6@mail.gmail.com
Reply-To: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: 545868358a73cbc5bd1911eb64b3bdc6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

I tried applying

[1]:http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1306545.ht
ml
[3]:http://www.spinics.net/lists/arm-kernel/msg566947.html

Because of 3 its crashing on our platform. (with SDHCI running with iommu
both enabled and disabled)

[   19.925018] PC is at sdhci_send_command+0x648/0xb30
[   19.930048] LR is at sdhci_send_command+0x588/0xb30
[   19.935078] pc : [<ffff0000085c9cb0>] lr : [<ffff0000085c9bf0>] pstate:
a00001c5
[   19.942707] sp : ffff80097ff1ede0
[   19.946123] x29: ffff80097ff1ede0 x28: 0000000000000000
[   19.951623] x27: 0000000000000001 x26: ffff000008923ca8
[   19.957124] x25: ffff8009750dc0d8 x24: ffff8009750dacc0
[   19.962625] x23: 0000000000418958 x22: 0000000000000003
[   19.968125] x21: ffff8009750dc118 x20: ffff8009750dc198
[   19.973626] x19: ffff8009750dac00 x18: 0000000000000400
[   19.979126] x17: 0000000000000000 x16: 0000000000000000
[   19.984627] x15: ffff8009764e4880 x14: ffff800976811548
[   19.990128] x13: 0000000000000008 x12: ffff7e0025ff9580
[   19.995628] x11: ffff800976d28080 x10: 0000000000000840
[   20.001129] x9 : 0000000000000040 x8 : ffff800976801020
[   20.006629] x7 : 00000009ffffd000 x6 : ffff000008441358
[   20.012130] x5 : 0000000000000000 x4 : 0000000000000000
[   20.017631] x3 : ffff800976465080 x2 : 0000000000000000
[   20.023130] x1 : ffff7e0025ce7802 x0 : 00000000ffffffe4
[   20.028630]
[   20.030165] ---[ end trace cd394f1ca2a1b19b ]---
[   20.034925] Call trace:
[   20.037446] Exception stack(0xffff80097ff1ec10 to 0xffff80097ff1ed40)
[   20.044089] ec00:                                   ffff8009750dac00
0001000000000000
[   20.052165] ec20: ffff80097ff1ede0 ffff0000085c9cb0 0000000000000000
0000000000000001
[   20.060242] ec40: ffff80097ff1ec90 ffff0000084402b4 ffff800976421000
ffff800976465040
[   20.068318] ec60: ffff800976465040 00000000ffff0000 ffff80097659c850
ffff80097653d810
[   20.076393] ec80: 0000000000000001 ffff800973cb9300 ffff80097ff1ecb0
ffff000008440324
[   20.084470] eca0: ffff800976421000 00000000000001c0 00000000ffffffe4
ffff7e0025ce7802
[   20.092547] ecc0: 0000000000000000 ffff800976465080 0000000000000000
0000000000000000
[   20.100623] ece0: ffff000008441358 00000009ffffd000 ffff800976801020
0000000000000040
[   20.108699] ed00: 0000000000000840 ffff800976d28080 ffff7e0025ff9580
0000000000000008
[   20.116776] ed20: ffff800976811548 ffff8009764e4880 0000000000000000
0000000000000000
[   20.124853] [<ffff0000085c9cb0>] sdhci_send_command+0x648/0xb30
[   20.130959] [<ffff0000085cb020>] sdhci_irq+0x9e8/0xa20
[   20.136259] [<ffff0000080e2be4>] __handle_irq_event_percpu+0x9c/0x128
[   20.142901] [<ffff0000080e2c8c>] handle_irq_event_percpu+0x1c/0x58
[   20.149275] [<ffff0000080e2d10>] handle_irq_event+0x48/0x78
[   20.155022] [<ffff0000080e6610>] handle_fasteoi_irq+0xb8/0x1a0
[   20.161036] [<ffff0000080e1ce4>] generic_handle_irq+0x24/0x38
[   20.166962] [<ffff0000080e2354>] __handle_domain_irq+0x5c/0xb8
[   20.172977] [<ffff0000080815cc>] gic_handle_irq+0xbc/0x168

Regards,
Oza.
-----Original Message-----
From: Oza Oza [mailto:oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org]
Sent: Tuesday, March 14, 2017 5:16 PM
To: 'Robin Murphy'; 'Joerg Roedel'
Cc: 'iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org'; 'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org';
'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org';
'bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org'; 'arnd-r2nGTMty4D4@public.gmane.org'; 'Nikita
Yushchenko'
Subject: RE: [RFC PATCH] iommu/dma: check pci host bridge dma_mask for
IOVA allocation

My responses inline:

-----Original Message-----
From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
Sent: Tuesday, March 14, 2017 4:27 PM
To: Oza Pawandeep; Joerg Roedel
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; arnd-r2nGTMty4D4@public.gmane.org; Nikita Yushchenko
Subject: Re: [RFC PATCH] iommu/dma: check pci host bridge dma_mask for
IOVA allocation

On 14/03/17 08:48, Oza Pawandeep wrote:
> It is possible that PCI device supports 64-bit DMA addressing, and
> thus it's driver sets device's dma_mask to DMA_BIT_MASK(64), however
> PCI host bridge may have limitations on the inbound transaction
> addressing. As an example, consider NVME SSD device connected to
> iproc-PCIe controller.

Aw heck, not another one :(

> Currently, the IOMMU DMA ops only considers PCI device dma_mask when
> allocating an IOVA. This is particularly problematic on
> ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to PA for
> in-bound transactions only after PCI Host has forwarded these
> transactions on SOC IO bus. This means on such ARM/ARM64 SOCs the IOVA
> of in-bound transactions has to honor the addressing restrictions of
> the PCI Host.

Depending on whether this most closely matches the R-Car situation[1] or
the X-Gene situation[2], this may not address the real problem at all (if
the non-IOMMU case is also affected). Either way it also fails to help
non-PCI devices which can face the exact same problem.

I am not fully aware of R-car and X-gene situation, but for iproc based
SOCs, our pcie host floats addresses in higher order dma_mask is set.

> This patch tries to solve above described IOVA allocation problem by:
> 1. Adding iommu_get_dma_mask() to get dma_mask of any device 2. For
> PCI device, iommu_get_dma_mask() compare dma_mask of PCI device and
> corresponding PCI Host dma_mask (if set).
> 3. Use iommu_get_dma_mask() in IOMMU DMA ops implementation instead of
> dma_get_mask()

Sorry, but NAK to this approach - not only is the implementation rather
ugly, and incomplete as above, but the fact that it starts with a clear
description of the underlying problem and then goes on to bodge around it
down the line instead of actually fixing it is the kicker.

:)
that is why this is RFC patch, and I had something similar in mind to go
and poke around which you have provided.. [1] and [3].
Let me try this on our platform, and see if that solves the issue.

I've got a simple arm64 patch for proper DMA mask inheritance based on the
various discussions at [1] which I will try to clean up and send out for
4.12 if nobody else sends anything soon, but it does depend on getting [3]
merged first to avoid regressing certain platforms.

Robin.

[1]:http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1306545.ht
ml
[2]:http://www.spinics.net/lists/arm-kernel/msg552422.html
[3]:http://www.spinics.net/lists/arm-kernel/msg566947.html



> Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/dma-iommu.c | 44
> ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 48d36ce..e93e536 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -108,6 +108,42 @@ int iommu_get_dma_cookie(struct iommu_domain
> *domain)  }  EXPORT_SYMBOL(iommu_get_dma_cookie);
>
> +static u64 __iommu_dma_mask(struct device *dev, bool is_coherent) {
> +#ifdef CONFIG_PCI
> +	u64 pci_hb_dma_mask;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_host_bridge *br =
pci_find_host_bridge(pdev->bus);
> +
> +		if ((!is_coherent) && !(br->dev.dma_mask))
> +			goto default_dev_dma_mask;
> +
> +		/* pci host bridge dma-mask. */
> +		pci_hb_dma_mask = (!is_coherent) ? *br->dev.dma_mask :
> +				   br->dev.coherent_dma_mask;
> +
> +		if (pci_hb_dma_mask && ((pci_hb_dma_mask) <
(*dev->dma_mask)))
> +			return pci_hb_dma_mask;
> +	}
> +default_dev_dma_mask:
> +#endif
> +	return (!is_coherent) ? dma_get_mask(dev) :
> +		dev->coherent_dma_mask;
> +}
> +
> +static u64 __iommu_dma_get_coherent_mask(struct device *dev) {
> +	return __iommu_dma_mask(dev, true);
> +}
> +
> +static u64 __iommu_dma_get_mask(struct device *dev) {
> +	return __iommu_dma_mask(dev, false); }
> +
> +
>  /**
>   * iommu_get_msi_cookie - Acquire just MSI remapping resources
>   * @domain: IOMMU domain to prepare
> @@ -461,7 +497,7 @@ struct page **iommu_dma_alloc(struct device *dev,
size_t size, gfp_t gfp,
>  	if (!pages)
>  		return NULL;
>
> -	iova = __alloc_iova(domain, size, dev->coherent_dma_mask, dev);
> +	iova = __alloc_iova(domain, size,
> +__iommu_dma_get_coherent_mask(dev), dev);
>  	if (!iova)
>  		goto out_free_pages;
>
> @@ -532,7 +568,7 @@ static dma_addr_t __iommu_dma_map(struct device
*dev, phys_addr_t phys,
>  	struct iova_domain *iovad = cookie_iovad(domain);
>  	size_t iova_off = iova_offset(iovad, phys);
>  	size_t len = iova_align(iovad, size + iova_off);
> -	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev),
dev);
> +	struct iova *iova = __alloc_iova(domain, len,
> +__iommu_dma_get_mask(dev), dev);
>
>  	if (!iova)
>  		return DMA_ERROR_CODE;
> @@ -690,7 +726,7 @@ int iommu_dma_map_sg(struct device *dev, struct
scatterlist *sg,
>  		prev = s;
>  	}
>
> -	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
> +	iova = __alloc_iova(domain, iova_len, __iommu_dma_get_mask(dev),
> +dev);
>  	if (!iova)
>  		goto out_restore_sg;
>
> @@ -760,7 +796,7 @@ static struct iommu_dma_msi_page
> *iommu_dma_get_msi_page(struct device *dev,
>
>  	msi_page->phys = msi_addr;
>  	if (iovad) {
> -		iova = __alloc_iova(domain, size, dma_get_mask(dev), dev);
> +		iova = __alloc_iova(domain, size,
__iommu_dma_get_mask(dev), dev);
>  		if (!iova)
>  			goto out_free_page;
>  		msi_page->iova = iova_dma_addr(iovad, iova);
>
