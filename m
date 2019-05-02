From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA
 address
Date: Thu, 2 May 2019 12:01:52 +0100
Message-ID: <20190502110152.GA7313@e121166-lin.cambridge.arm.com>
References: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
 <1556732186-21630-3-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556732186-21630-3-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Eric Auger <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, May 01, 2019 at 11:06:25PM +0530, Srinath Mannam wrote:
> dma_ranges field of PCI host bridge structure has resource entries in
> sorted order of address range given through dma-ranges DT property. This
> list is the accessible DMA address range. So that this resource list will
> be processed and reserve IOVA address to the inaccessible address holes in
> the list.
> 
> This method is similar to PCI IO resources address ranges reserving in
> IOMMU for each EP connected to host bridge.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 77aabe6..da94844 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -212,6 +212,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>  	struct resource_entry *window;
>  	unsigned long lo, hi;
> +	phys_addr_t start = 0, end;
>  
>  	resource_list_for_each_entry(window, &bridge->windows) {
>  		if (resource_type(window->res) != IORESOURCE_MEM)
> @@ -221,6 +222,24 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>  		hi = iova_pfn(iovad, window->res->end - window->offset);
>  		reserve_iova(iovad, lo, hi);
>  	}
> +
> +	/* Get reserved DMA windows from host bridge */
> +	resource_list_for_each_entry(window, &bridge->dma_ranges) {

If this list is not sorted it seems to me the logic in this loop is
broken and you can't rely on callers to sort it because it is not a
written requirement and it is not enforced (you know because you
wrote the code but any other developer is not supposed to guess
it).

Can't we rewrite this loop so that it does not rely on list
entries order ?

I won't merge this series unless you sort it, no pun intended.

Lorenzo

> +		end = window->res->start - window->offset;
> +resv_iova:
> +		if (end - start) {
> +			lo = iova_pfn(iovad, start);
> +			hi = iova_pfn(iovad, end);
> +			reserve_iova(iovad, lo, hi);
> +		}
> +		start = window->res->end - window->offset + 1;
> +		/* If window is last entry */
> +		if (window->node.next == &bridge->dma_ranges &&
> +		    end != ~(dma_addr_t)0) {
> +			end = ~(dma_addr_t)0;
> +			goto resv_iova;
> +		}
> +	}
>  }
>  
>  static int iova_reserve_iommu_regions(struct device *dev,
> -- 
> 2.7.4
> 
