From: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Subject: Re: [PATCH 05/25] MIPS: Octeon: refactor swiotlb code
Date: Wed, 30 May 2018 16:25:52 -0700
Message-ID: <20180530232552.4rqnoo3652mabrqq@pburton-laptop>
References: <20180525092111.18516-1-hch@lst.de>
	<20180525092111.18516-6-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180525092111.18516-6-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiaxun Yang <jiaxun.yang-nEvAom26CKtBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tom Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

For patches 1-4:

  Reviewed-by: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>

Comment below for this patch though.

On Fri, May 25, 2018 at 11:20:51AM +0200, Christoph Hellwig wrote:
> diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
> index e5d00c79bd26..1e68636c9137 100644
> --- a/arch/mips/cavium-octeon/dma-octeon.c
> +++ b/arch/mips/cavium-octeon/dma-octeon.c
> @@ -23,10 +23,16 @@
>  #include <asm/octeon/octeon.h>
>  
>  #ifdef CONFIG_PCI
> +#include <linux/pci.h>
>  #include <asm/octeon/pci-octeon.h>
>  #include <asm/octeon/cvmx-npi-defs.h>
>  #include <asm/octeon/cvmx-pci-defs.h>
>  
> +struct octeon_dma_map_ops {
> +	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
> +	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
> +};
> +
>  static dma_addr_t octeon_hole_phys_to_dma(phys_addr_t paddr)
>  {
>  	if (paddr >= CVMX_PCIE_BAR1_PHYS_BASE && paddr < (CVMX_PCIE_BAR1_PHYS_BASE + CVMX_PCIE_BAR1_PHYS_SIZE))
> @@ -43,6 +49,11 @@ static phys_addr_t octeon_hole_dma_to_phys(dma_addr_t daddr)
>  		return daddr;
>  }
>  
> +static const struct octeon_dma_map_ops octeon_gen2_ops = {
> +	.phys_to_dma	= octeon_hole_phys_to_dma,
> +	.dma_to_phys	= octeon_hole_dma_to_phys,
> +};

These are pointers to functions of the wrong type, right? phys_to_dma &
dma_to_phys have the struct device * argument but the octeon_hole_*
functions do not. I'd expect we either need to restore the
octeon_gen2_* wrappers that you remove below or change the definition of
the octeon_hole_* functions.

Thanks,
    Paul

>  static dma_addr_t octeon_gen1_phys_to_dma(struct device *dev, phys_addr_t paddr)
>  {
>  	if (paddr >= 0x410000000ull && paddr < 0x420000000ull)
> @@ -60,15 +71,10 @@ static phys_addr_t octeon_gen1_dma_to_phys(struct device *dev, dma_addr_t daddr)
>  	return daddr;
>  }
>  
> -static dma_addr_t octeon_gen2_phys_to_dma(struct device *dev, phys_addr_t paddr)
> -{
> -	return octeon_hole_phys_to_dma(paddr);
> -}
> -
> -static phys_addr_t octeon_gen2_dma_to_phys(struct device *dev, dma_addr_t daddr)
> -{
> -	return octeon_hole_dma_to_phys(daddr);
> -}
