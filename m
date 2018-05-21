From: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] PCI: Do not enable PASID when End-to-End TLP is not
	supported
Date: Mon, 21 May 2018 09:25:26 -0400
Message-ID: <c8184d48-a343-503a-83a3-707e44961f1a@codeaurora.org>
References: <1526748769-701-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1526748769-701-1-git-send-email-okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

+iommu folks.

On 5/19/2018 12:52 PM, Sinan Kaya wrote:
> A PCIe endpoint carries the process address space identifier (PASID) in
> the TLP prefix as part of the memory read/write transaction. The address
> information in the TLP is relevant only for a given PASID context.
> 
> A translation agent takes PASID value and the address information from the
> TLP to look up the physical address in the system.
> 
> If a bridge drops the TLP prefix, the translation agent can resolve the
> address to an incorrect location and cause data corruption. Prevent
> this condition by requiring End-to-End TLP prefix to be supported on the
> entire data path between the endpoint and the root port.
> 
> Signed-off-by: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/pci/ats.c             | 16 ++++++++++++++++
>  include/uapi/linux/pci_regs.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 89305b5..0bcded5 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -265,7 +265,9 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
>  int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	u16 control, supported;
> +	struct pci_dev *bridge;
>  	int pos;
> +	u32 cap;
>  
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
> @@ -274,6 +276,20 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (!pos)
>  		return -EINVAL;
>  
> +	bridge = pci_upstream_bridge(pdev);
> +	while (bridge) {
> +		if (!pci_find_capability(bridge, PCI_CAP_ID_EXP))
> +			return -EINVAL;
> +
> +		if (pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap))
> +			return -EINVAL;
> +
> +		if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +			return -EINVAL;
> +
> +		bridge = pci_upstream_bridge(bridge);
> +	}
> +
>  	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 103ba79..d91dea5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -634,6 +634,7 @@
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
> +#define PCI_EXP_DEVCAP2_E2ETLP		0x00200000 /* End-to-End TLP Prefix */
>  #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
>  #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
