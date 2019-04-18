From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 1/3] PCI: Add dma_ranges window list
Date: Thu, 18 Apr 2019 18:49:23 -0500
Message-ID: <20190418234922.GH126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 12, 2019 at 08:43:33AM +0530, Srinath Mannam wrote:
> Add a dma_ranges field in PCI host bridge structure to hold resource
> entries list of memory regions in sorted order given through dma-ranges
> DT property.
> 
> While initializing IOMMU domain of PCI EPs connected to that host bridge
> This list of resources will be processed and IOVAs for the address holes
> will be reserved.

s/bridge This list/bridge, this list/

> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 3 +++
>  include/linux/pci.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 257b9f6..ce5505f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&bridge->windows);
> +	INIT_LIST_HEAD(&bridge->dma_ranges);
>  	bridge->dev.release = pci_release_host_bridge_dev;
>  
>  	/*
> @@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&bridge->windows);
> +	INIT_LIST_HEAD(&bridge->dma_ranges);
>  	bridge->dev.release = devm_pci_release_host_bridge_dev;
>  
>  	return bridge;
> @@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
>  void pci_free_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	pci_free_resource_list(&bridge->windows);
> +	pci_free_resource_list(&bridge->dma_ranges);
>  
>  	kfree(bridge);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c..016a044 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -487,6 +487,7 @@ struct pci_host_bridge {
>  	void		*sysdata;
>  	int		busnr;
>  	struct list_head windows;	/* resource_entry */
> +	struct list_head dma_ranges;	/* dma ranges resource list */
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> -- 
> 2.7.4
> 
