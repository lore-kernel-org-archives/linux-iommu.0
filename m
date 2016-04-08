From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 1/6] PCI: Add pci_add_dma_alias() to abstract
	implementation
Date: Fri, 8 Apr 2016 14:18:57 -0600
Message-ID: <20160408141857.2dbcc8dd@t450s.home>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160224194345.7585.20639.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160224194345.7585.20639.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 24 Feb 2016 13:43:45 -0600
Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:

> From: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Add a pci_add_dma_alias() interface to encapsulate the details of adding an
> alias.  No functional change intended.
> ---
>  drivers/pci/pci.c    |   14 ++++++++++++++
>  drivers/pci/pci.h    |    2 ++
>  drivers/pci/quirks.c |   19 +++++++------------
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 602eb42..7fccc8a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4568,6 +4568,20 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +/**
> + * pci_add_dma_alias - Add a DMA devfn alias for a device
> + * @dev: the PCI device for which alias is added
> + * @devfn: alias slot and function
> + *
> + * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> + * It should be called early, preferably as PCI fixup header quirk.
> + */
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +{
> +	dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);

This should be:

dev->dma_alias_devfn = devfn;

It was silently fixed in 3/6.  Also needs a Sign-off.  With those
changes:

Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


> +	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +}
> +
>  bool pci_device_is_present(struct pci_dev *pdev)
>  {
>  	u32 v;
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9a1660f..c5dc8dc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -335,4 +335,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  }
>  #endif
>  
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0575a1e..df28dce 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3581,10 +3581,8 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  
>  static void quirk_dma_func0_alias(struct pci_dev *dev)
>  {
> -	if (PCI_FUNC(dev->devfn) != 0) {
> -		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
> -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> -	}
> +	if (PCI_FUNC(dev->devfn) != 0)
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
>  }
>  
>  /*
> @@ -3597,10 +3595,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
>  
>  static void quirk_dma_func1_alias(struct pci_dev *dev)
>  {
> -	if (PCI_FUNC(dev->devfn) != 1) {
> -		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 1);
> -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> -	}
> +	if (PCI_FUNC(dev->devfn) != 1)
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
>  }
>  
>  /*
> @@ -3667,11 +3663,10 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
>  
>  	id = pci_match_id(fixed_dma_alias_tbl, dev);
>  	if (id) {
> -		dev->dma_alias_devfn = id->driver_data;
> -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +		pci_add_dma_alias(dev, id->driver_data);
>  		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> -			 PCI_SLOT(dev->dma_alias_devfn),
> -			 PCI_FUNC(dev->dma_alias_devfn));
> +			 PCI_SLOT(id->driver_data),
> +			 PCI_FUNC(id->driver_data));
>  	}
>  }
>  
> 
