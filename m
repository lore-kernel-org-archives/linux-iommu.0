From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common
	code
Date: Mon, 30 Jul 2018 16:17:13 -0500
Message-ID: <20180730211713.GA45322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730073842.16092-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180730073842.16092-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[+cc Joerg]

On Mon, Jul 30, 2018 at 09:38:42AM +0200, Christoph Hellwig wrote:
> There is nothing arch specific about PCI or dma-debug, so move this
> call to common code just after registering the bus type.

I assume that previously, even if the user set CONFIG_DMA_API_DEBUG=y
we only got PCI DMA debug on powerpc, sh, and x86.  And after this
patch, we'll get PCI DMA debug on *all* arches?

If that's true, I'll add a comment to that effect to the commitlog
since that new functionality might be of interest to other arches.

> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/powerpc/kernel/dma.c | 3 ---
>  arch/sh/drivers/pci/pci.c | 2 --
>  arch/x86/kernel/pci-dma.c | 3 ---
>  drivers/pci/pci-driver.c  | 2 +-
>  4 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index 155170d70324..dbfc7056d7df 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -357,9 +357,6 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>  
>  static int __init dma_init(void)
>  {
> -#ifdef CONFIG_PCI
> -	dma_debug_add_bus(&pci_bus_type);
> -#endif
>  #ifdef CONFIG_IBMVIO
>  	dma_debug_add_bus(&vio_bus_type);
>  #endif
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index e5b7437ab4af..8256626bc53c 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -160,8 +160,6 @@ static int __init pcibios_init(void)
>  	for (hose = hose_head; hose; hose = hose->next)
>  		pcibios_scanbus(hose);
>  
> -	dma_debug_add_bus(&pci_bus_type);
> -
>  	pci_initialized = 1;
>  
>  	return 0;
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index ab5d9dd668d2..43f58632f123 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -155,9 +155,6 @@ static int __init pci_iommu_init(void)
>  {
>  	struct iommu_table_entry *p;
>  
> -#ifdef CONFIG_PCI
> -	dma_debug_add_bus(&pci_bus_type);
> -#endif
>  	x86_init.iommu.iommu_init();
>  
>  	for (p = __iommu_table; p < __iommu_table_end; p++) {
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 6792292b5fc7..bef17c3fca67 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1668,7 +1668,7 @@ static int __init pci_driver_init(void)
>  	if (ret)
>  		return ret;
>  #endif
> -
> +	dma_debug_add_bus(&pci_bus_type);
>  	return 0;
>  }
>  postcore_initcall(pci_driver_init);
> -- 
> 2.18.0
> 
