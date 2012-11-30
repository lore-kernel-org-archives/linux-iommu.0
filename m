From: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/tegra: smmu: Move bus_set_iommu after probe
 for multi arch
Date: Fri, 30 Nov 2012 13:07:31 +0800
Message-ID: <50B83F13.2010806@gmail.com>
References: <1354110775-11810-1-git-send-email-hdoyu@nvidia.com> <1354110775-11810-3-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354110775-11810-3-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/28/2012 09:52 PM, Hiroshi Doyu wrote:
> For a single image to support multiple SoCs(GART/SMMU).
>

To be honest, I didn't get why we need to move "bus_set_iommu" to probe
func. So could you add more words in the commit message?
Same with tegra-gart.c.

Mark
> Reported-by: Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 46f5712..608185b 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1229,6 +1229,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
>  
>  	smmu_debugfs_create(smmu);
>  	smmu_handle = smmu;
> +	bus_set_iommu(&platform_bus_type, &smmu_iommu_ops);
>  	return 0;
>  }
>  
> @@ -1273,7 +1274,6 @@ static struct platform_driver tegra_smmu_driver = {
>  
>  static int __devinit tegra_smmu_init(void)
>  {
> -	bus_set_iommu(&platform_bus_type, &smmu_iommu_ops);
>  	return platform_driver_register(&tegra_smmu_driver);
>  }
>  
> 
