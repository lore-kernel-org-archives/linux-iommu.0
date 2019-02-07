From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check PRG response
 PASID bit status.
Date: Thu, 7 Feb 2019 14:35:46 -0600
Message-ID: <20190207203546.GL7268@google.com>
References: <cover.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2be716037209f722304e94da6df39aec5a37f236.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2be716037209f722304e94da6df39aec5a37f236.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: joro@8bytes.org, dwmw2@infradead.org, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org


"PCI/ATS: Add pci_pggrp_rsp_need_pasid() interface"

On Thu, Feb 07, 2019 at 10:37:58AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Add a new function to return the status of PRG response PASID
> required bit in PRI status register. This function will be used by

"return the PRG Response PASID Required bit in the Page Request Status
Register".

That's just to make it clear exactly what the name of the bit is.
Without the capitalization, you can't tell where the name itself
begins.

> drivers like IOMMU, if it is required to enforce the PASID required for
> page-group responses.

If I'm reading the spec (PCIe r4.0, sec 10.5.2.3) correctly, when this bit
is set, it means the Function expects a PASID on responses it receives
from the host.  It's not so much that the IOMMU "enforces" anything;
it's just that when this bit is set, the IOMMU must supply the PASID
in its responses to that Function.

s/page-group responses/PRG (Page Request Group) Response Messages/

> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c             | 27 +++++++++++++++++++++++++++
>  include/linux/pci-ats.h       |  5 +++++
>  include/uapi/linux/pci_regs.h |  1 +
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 5b78f3b1b918..666d03332944 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -368,6 +368,33 @@ int pci_pasid_features(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_pasid_features);
>  
> +/**
> + * pci_pggrp_rsp_need_pasid - Return PRG response PASID required bit status.

pci_prg_resp_pasid_required()?

"PRG" seems to be the standard spec terminology, so I think using
"pggrp" muddies the water a little bit.

> + * @pdev: PCI device structure
> + *
> + * Returns positive if PASID is required, 0 otherwise.
> + *
> + * Eventhough the PRG response PASID status is read from PRI status
> + * register, Since this API will mainly be used by PASID users, this
> + * function is defined within #ifdef CONFIG_PCI_PASID instead of
> + * CONFIG_PCI_PRI.

s/Eventhough/Even though/
s/Since/since/

> + *
> + */
> +int pci_pggrp_rsp_need_pasid(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return 0;
> +
> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> +
> +	return status & PCI_PRI_STATUS_PASID;
> +}
> +EXPORT_SYMBOL_GPL(pci_pggrp_rsp_need_pasid);
> +
>  #define PASID_NUMBER_SHIFT	8
>  #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>  /**
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 7c4b8e27268c..ea29c7c64482 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -40,6 +40,7 @@ void pci_disable_pasid(struct pci_dev *pdev);
>  void pci_restore_pasid_state(struct pci_dev *pdev);
>  int pci_pasid_features(struct pci_dev *pdev);
>  int pci_max_pasids(struct pci_dev *pdev);
> +int pci_pggrp_rsp_need_pasid(struct pci_dev *pdev);
>  
>  #else  /* CONFIG_PCI_PASID */
>  
> @@ -66,6 +67,10 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>  	return -EINVAL;
>  }
>  
> +static int pci_pggrp_rsp_need_pasid(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_PCI_PASID */
>  
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e1e9888c85e6..898be572b010 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -880,6 +880,7 @@
>  #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
>  #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
>  #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
> +#define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
>  #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
>  #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
>  #define PCI_EXT_CAP_PRI_SIZEOF	16
> -- 
> 2.20.1
> 
