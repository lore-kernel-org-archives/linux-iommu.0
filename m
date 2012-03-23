From: "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v2] intel-iommu: Add device info into list before doing
 context mapping
Date: Fri, 23 Mar 2012 02:54:43 +0000
Message-ID: <403610A45A2B5242BD291EDAE8B37D300FCF3733@SHSMSX102.ccr.corp.intel.com>
References: <BC00F5384FCFC9499AF06F92E8B78A9E28907BAB30@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <BC00F5384FCFC9499AF06F92E8B78A9E28907BAB30@shsmsx502.ccr.corp.intel.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "dwmw2@infradead.org" <dwmw2@infradead.org>, Chris Wright <chrisw@sous-sol.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Xiantao" <xiantao.zhang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi, David

Any other comments for this patch? Or can you check-in it in your iommu tree?

Thanks,
-Xudong

> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> Behalf Of Hao, Xudong
> Sent: Thursday, December 22, 2011 5:18 PM
> To: Chris Wright
> Cc: dwmw2@infradead.org; iommu@lists.linux-foundation.org;
> linux-kernel@vger.kernel.org; Zhang, Xiantao; kvm@vger.kernel.org
> Subject: [PATCH v2] intel-iommu: Add device info into list before doing context
> mapping
> 
> Add device info into list before do context mapping, because device info will be
> used by iommu_enable_dev_iotlb function, in this function, pci_enable_ats
> would not be called without this patch.
> 
> Signed-off-by: Xudong Hao <xudong.hao@intel.com>
> Signed-off-by: Xiantao Zhang <xiantao.zhang@intel.com>
> Acked-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  drivers/iommu/intel-iommu.c |   17 +++++++++++------
>  1 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
> bdc447f..ccf347f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2267,12 +2267,6 @@ static int domain_add_dev_info(struct
> dmar_domain *domain,
>  	if (!info)
>  		return -ENOMEM;
> 
> -	ret = domain_context_mapping(domain, pdev, translation);
> -	if (ret) {
> -		free_devinfo_mem(info);
> -		return ret;
> -	}
> -
>  	info->segment = pci_domain_nr(pdev->bus);
>  	info->bus = pdev->bus->number;
>  	info->devfn = pdev->devfn;
> @@ -2285,6 +2279,17 @@ static int domain_add_dev_info(struct
> dmar_domain *domain,
>  	pdev->dev.archdata.iommu = info;
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> 
> +	ret = domain_context_mapping(domain, pdev, translation);
> +	if (ret) {
> +		spin_lock_irqsave(&device_domain_lock, flags);
> +		list_del(&info->link);
> +		list_del(&info->global);
> +		pdev->dev.archdata.iommu = NULL;
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		free_devinfo_mem(info);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
> 
> --
> 1.6.0.rc1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in the body of a
> message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
