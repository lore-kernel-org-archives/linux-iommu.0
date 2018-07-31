From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] PCI: call dma_debug_add_bus for pci_bus_type in common code
Date: Tue, 31 Jul 2018 19:34:18 +1000
Message-ID: <87sh3zhhph.fsf@concordia.ellerman.id.au>
References: <20180730073842.16092-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730073842.16092-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Christoph Hellwig <hch@lst.de> writes:

> There is nothing arch specific about PCI or dma-debug, so move this
> call to common code just after registering the bus type.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
