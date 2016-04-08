From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 2/6] PCI: Move informational printk to
	pci_add_dma_alias()
Date: Fri, 8 Apr 2016 14:19:03 -0600
Message-ID: <20160408141903.30f1ca9d@t450s.home>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20160224194354.7585.30654.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160224194354.7585.30654.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
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

On Wed, 24 Feb 2016 13:43:54 -0600
Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:

> From: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> One of the quirks that adds DMA aliases logs an informational message in
> dmesg.  Move that to pci_add_dma_alias() so all users log the message
> consistently.  No functional change intended (except extra message).
> ---
>  drivers/pci/pci.c    |    2 ++
>  drivers/pci/quirks.c |    6 +-----
>  2 files changed, 3 insertions(+), 5 deletions(-)


Needs a Sign-off, otherwise:

Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7fccc8a..8b0a637 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4580,6 +4580,8 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
>  	dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
>  	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +	dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> +		 PCI_SLOT(devfn), PCI_FUNC(devfn));
>  }
>  
>  bool pci_device_is_present(struct pci_dev *pdev)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index df28dce..cf023ea 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3662,12 +3662,8 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
>  	const struct pci_device_id *id;
>  
>  	id = pci_match_id(fixed_dma_alias_tbl, dev);
> -	if (id) {
> +	if (id)
>  		pci_add_dma_alias(dev, id->driver_data);
> -		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> -			 PCI_SLOT(id->driver_data),
> -			 PCI_FUNC(id->driver_data));
> -	}
>  }
>  
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);
> 
