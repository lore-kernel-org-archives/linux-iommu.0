From: Varun Sethi <Varun.Sethi@freescale.com>
Subject: RE: [PATCH 05/12] iommu/fsl: Convert to iommu_capable() API function
Date: Tue, 9 Sep 2014 18:38:37 +0000
Message-ID: <d7e88d93cf5546a18b0f6c8ef199c577@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
 <1409914384-21191-6-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409914384-21191-6-git-send-email-joro@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Friday, September 05, 2014 4:23 PM
> To: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org; Joerg Roedel; Sethi Varun-B16395
> Subject: [PATCH 05/12] iommu/fsl: Convert to iommu_capable() API function
> 
> From: Joerg Roedel <jroedel@suse.de>
> 
> Cc: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index 61d1daf..f43a80d 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -411,8 +411,7 @@ static phys_addr_t fsl_pamu_iova_to_phys(struct
> iommu_domain *domain,
>  	return get_phys_addr(dma_domain, iova);  }
> 
> -static int fsl_pamu_domain_has_cap(struct iommu_domain *domain,
> -				      unsigned long cap)
> +static bool fsl_pamu_capable(enum iommu_cap cap)
>  {
>  	return cap == IOMMU_CAP_CACHE_COHERENCY;  } @@ -1074,6
> +1073,7 @@ static u32 fsl_pamu_get_windows(struct iommu_domain
> *domain)  }
> 
>  static const struct iommu_ops fsl_pamu_ops = {
> +	.capable	= fsl_pamu_capable,
>  	.domain_init	= fsl_pamu_domain_init,
>  	.domain_destroy = fsl_pamu_domain_destroy,
>  	.attach_dev	= fsl_pamu_attach_device,
> @@ -1083,7 +1083,6 @@ static const struct iommu_ops fsl_pamu_ops = {
>  	.domain_get_windows = fsl_pamu_get_windows,
>  	.domain_set_windows = fsl_pamu_set_windows,
>  	.iova_to_phys	= fsl_pamu_iova_to_phys,
> -	.domain_has_cap = fsl_pamu_domain_has_cap,
>  	.domain_set_attr = fsl_pamu_set_domain_attr,
>  	.domain_get_attr = fsl_pamu_get_domain_attr,
>  	.add_device	= fsl_pamu_add_device,
Acked-by: Varun Sethi <varun.sethi@freescale.com>
