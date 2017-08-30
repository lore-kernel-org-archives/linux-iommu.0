From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/tegra: Add support for struct iommu_device
Date: Wed, 30 Aug 2017 15:22:05 +0100
Message-ID: <c6ee1ce0-7193-be63-c84d-73795c727d26@nvidia.com>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
 <1502317752-8792-2-git-send-email-joro@8bytes.org>
 <f857ad53-66ca-0aa9-947a-f517443d114d@nvidia.com>
 <20170830120902.kqtxh2ls4ob7xpwy@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830120902.kqtxh2ls4ob7xpwy-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 30/08/17 13:09, Joerg Roedel wrote:
> Hi Jon,
> 
> On Wed, Aug 30, 2017 at 12:04:38PM +0100, Jon Hunter wrote:
>> With next-20170829 I am seeing several Tegra boards crashing [0][1] on
>> boot in tegra_smmu_probe() and the bisect is point to this commit. Looks
>> like there maybe a sequence problem between calls to bus_set_iommu() and
>> iommu_device_add_sysfs() which results in a NULL pointer dereference.
> 
> Thanks for the report. Can you please test whether the patch below
> fixes the problem?
> 
> Thanks,
> 
> 	Joerg
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 2802e12e6a54..48ffbe95a663 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -949,10 +949,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>  
>  	tegra_smmu_ahb_enable();
>  
> -	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
> -	if (err < 0)
> -		return ERR_PTR(err);
> -
>  	err = iommu_device_sysfs_add(&smmu->iommu, dev, NULL, dev_name(dev));
>  	if (err)
>  		return ERR_PTR(err);
> @@ -965,6 +961,10 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>  		return ERR_PTR(err);
>  	}
>  
> +	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +

Yes I can confirm that this fixes the crash. I assume that you will fix
the error path for bus_set_iommu() above as I believe now it needs to
call iommu_device_sysfs_remove().

Cheers!
Jon

-- 
nvpublic
