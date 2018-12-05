From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: fix amd_iommu=force_isolation
Date: Wed, 5 Dec 2018 17:09:55 +0100
Message-ID: <20181205160955.p3juusqdxarmo2yc@8bytes.org>
References: <20181204223716.214159-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204223716.214159-1-yuzhao@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Zhao <yuzhao@google.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 04, 2018 at 03:37:16PM -0700, Yu Zhao wrote:
> The parameter is still there but it's ignored. We need to check its
> value before deciding to go into passthrough mode for AMD IOMMU.
> 
> Fixes: aafd8ba0ca74 ("iommu/amd: Implement add_device and remove_device")
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  drivers/iommu/amd_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 1167ff0416cf..3e4219e6cff0 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2195,7 +2195,8 @@ static int amd_iommu_add_device(struct device *dev)
>  
>  	BUG_ON(!dev_data);
>  
> -	if (iommu_pass_through || dev_data->iommu_v2)
> +	if (iommu_pass_through ||
> +	    (!amd_iommu_force_isolation && dev_data->iommu_v2))

This breaks the iommu_v2 use-case, as it needs a direct mapping for the
devices that support it.

I think the force_isolation parameter does not make sense anymore today
and should be removed.


Regards,

	Joerg
