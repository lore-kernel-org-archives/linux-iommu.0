From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 11/26] iommu/amd: deprecate pci_get_bus_and_slot()
Date: Thu, 4 Jan 2018 07:25:55 -0500
Message-ID: <8a5dad82-2886-2a51-28bc-b84ab253c361@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-12-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1513661883-28662-12-git-send-email-okaya@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> Hard-code the domain number as 0 for the AMD IOMMU driver.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/iommu/amd_iommu.c      | 3 ++-
>  drivers/iommu/amd_iommu_init.c | 9 +++++----
>  drivers/iommu/amd_iommu_v2.c   | 3 ++-
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 7d5eb00..821547b 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -527,7 +527,8 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>  	struct iommu_dev_data *dev_data = NULL;
>  	struct pci_dev *pdev;
>  
> -	pdev = pci_get_bus_and_slot(PCI_BUS_NUM(devid), devid & 0xff);
> +	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
> +					   devid & 0xff);
>  	if (pdev)
>  		dev_data = get_dev_data(&pdev->dev);
>  
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6fe2d03..4e4a615 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1697,8 +1697,8 @@ static int iommu_init_pci(struct amd_iommu *iommu)
>  	u32 range, misc, low, high;
>  	int ret;
>  
> -	iommu->dev = pci_get_bus_and_slot(PCI_BUS_NUM(iommu->devid),
> -					  iommu->devid & 0xff);
> +	iommu->dev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(iommu->devid),
> +						 iommu->devid & 0xff);
>  	if (!iommu->dev)
>  		return -ENODEV;
>  
> @@ -1764,8 +1764,9 @@ static int iommu_init_pci(struct amd_iommu *iommu)
>  	if (is_rd890_iommu(iommu->dev)) {
>  		int i, j;
>  
> -		iommu->root_pdev = pci_get_bus_and_slot(iommu->dev->bus->number,
> -				PCI_DEVFN(0, 0));
> +		iommu->root_pdev =
> +			pci_get_domain_bus_and_slot(0, iommu->dev->bus->number,
> +						    PCI_DEVFN(0, 0));
>  
>  		/*
>  		 * Some rd890 systems may not be fully reconfigured by the
> diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
> index 7d94e1d..8696382 100644
> --- a/drivers/iommu/amd_iommu_v2.c
> +++ b/drivers/iommu/amd_iommu_v2.c
> @@ -564,7 +564,8 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
>  	finish      = (iommu_fault->tag >> 9) & 1;
>  
>  	devid = iommu_fault->device_id;
> -	pdev = pci_get_bus_and_slot(PCI_BUS_NUM(devid), devid & 0xff);
> +	pdev = pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(devid),
> +					   devid & 0xff);
>  	if (!pdev)
>  		return -ENODEV;
>  	dev_data = get_dev_data(&pdev->dev);
> 

Any comments from the IOMMU people?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
