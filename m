From: Shuah Khan <shuah.khan@hp.com>
Subject: Re: [PATCH 3.4] iommu/amd: Initialize device table after dma_ops
Date: Thu, 28 Feb 2013 12:52:00 -0700
Message-ID: <1362081120.2822.30.camel@lorien2>
References: <1360205128.2615.14.camel@lorien2>
	 <1361922545.2720.17.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1361922545.2720.17.camel@lorien2>
Sender: stable-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Cc: iommu@lists.linux-foundation.org, stable <stable@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-02-26 at 16:49 -0700, Shuah Khan wrote:
> When dma_ops are initialized the unity mappings are created. The
> init_device_table_dma() function makes sure DMA from all devices is
> blocked by default. This opens a short window in time where DMA to
> unity mapped regions is blocked by the IOMMU. Make sure this does not
> happen by initializing the device table after dma_ops.
> 
> Back-port upstream commit: f528d980c17b8714aedc918ba86e058af914d66b
> 
> Signed-off-by: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
> CC: stable@vger.kernel.org 3.4

Please consider this for 3.5 as well.

-- Shuah
> ---
>  drivers/iommu/amd_iommu_init.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index ef0ae93..b573f80 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1572,8 +1572,6 @@ int __init amd_iommu_init_hardware(void)
>  	if (amd_iommu_pd_alloc_bitmap == NULL)
>  		goto free;
>  
> -	/* init the device table */
> -	init_device_table();
>  
>  	/*
>  	 * let all alias entries point to itself
> @@ -1655,6 +1653,7 @@ out:
>   */
>  static int __init amd_iommu_init(void)
>  {
> +	struct amd_iommu *iommu;
>  	int ret = 0;
>  
>  	ret = amd_iommu_init_hardware();
> @@ -1673,6 +1672,12 @@ static int __init amd_iommu_init(void)
>  	if (ret)
>  		goto free;
>  
> +	/* init the device table */
> +	init_device_table();
> +
> +	for_each_iommu(iommu)
> +		iommu_flush_all_caches(iommu);
> +
>  	amd_iommu_init_api();
>  
>  	x86_platform.iommu_shutdown = disable_iommus;
