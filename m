From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFCv2 PATCH 34/36] PCI: Make "PRG Response PASID Required"
	handling common
Date: Fri, 6 Oct 2017 13:11:38 -0500
Message-ID: <20171006181138.GD25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
	<20171006133203.22803-35-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171006133203.22803-35-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 06, 2017 at 02:32:01PM +0100, Jean-Philippe Brucker wrote:
> The PASID ECN to the PCIe spec added a bit in the PRI status register that
> allows a Function to declare whether a PRG Response should contain the
> PASID prefix or not.
> 
> Move the helper that accesses it from amd_iommu into the PCI subsystem,
> renaming it to be consistent with the current spec (PRPR - PRG Response
> PASID Required).
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>

Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

I assume this will be merged with the rest of the series, probably via an
IOMMU tree.

> ---
>  drivers/iommu/amd_iommu.c     | 19 +------------------
>  drivers/pci/ats.c             | 17 +++++++++++++++++
>  include/linux/pci-ats.h       |  8 ++++++++
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 51f8215877f5..45036a253d63 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2039,23 +2039,6 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
>  	return ret;
>  }
>  
> -/* FIXME: Move this to PCI code */
> -#define PCI_PRI_TLP_OFF		(1 << 15)
> -
> -static bool pci_pri_tlp_required(struct pci_dev *pdev)
> -{
> -	u16 status;
> -	int pos;
> -
> -	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> -	if (!pos)
> -		return false;
> -
> -	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> -
> -	return (status & PCI_PRI_TLP_OFF) ? true : false;
> -}
> -
>  /*
>   * If a device is not yet associated with a domain, this function
>   * assigns it visible for the hardware
> @@ -2084,7 +2067,7 @@ static int attach_device(struct device *dev,
>  
>  			dev_data->ats.enabled = true;
>  			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
> -			dev_data->pri_tlp     = pci_pri_tlp_required(pdev);
> +			dev_data->pri_tlp     = pci_prg_resp_requires_prefix(pdev);
>  		}
>  	} else if (amd_iommu_iotlb_sup &&
>  		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index ad8ddbbbf245..f95e42df728b 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -389,3 +389,20 @@ int pci_max_pasids(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_max_pasids);
>  #endif /* CONFIG_PCI_PASID */
> +
> +#if defined(CONFIG_PCI_PASID) && defined(CONFIG_PCI_PRI)
> +bool pci_prg_resp_requires_prefix(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return false;
> +
> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> +
> +	return !!(status & PCI_PRI_STATUS_PRPR);
> +}
> +EXPORT_SYMBOL_GPL(pci_prg_resp_requires_prefix);
> +#endif /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 782fb8e0755f..367ea9448441 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -67,5 +67,13 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>  
>  #endif /* CONFIG_PCI_PASID */
>  
> +#if defined(CONFIG_PCI_PASID) && defined(CONFIG_PCI_PRI)
> +bool pci_prg_resp_requires_prefix(struct pci_dev *pdev);
> +#else
> +static inline bool pci_prg_resp_requires_prefix(struct pci_dev *pdev)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
>  
>  #endif /* LINUX_PCI_ATS_H*/
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f8d58045926f..a0eeb16a2bfe 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -862,6 +862,7 @@
>  #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
>  #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
>  #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
> +#define  PCI_PRI_STATUS_PRPR	0x8000	/* PRG Response requires PASID prefix */
>  #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
>  #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
>  #define PCI_EXT_CAP_PRI_SIZEOF	16
> -- 
> 2.13.3
> 
