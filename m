From: Cho KyongHo <pullip.cho@samsung.com>
Subject: RE: [PATCH 2/2] iommu/exynos: Follow kernel coding style for
 __sysmmu_enable return type
Date: Fri, 26 Jul 2013 19:46:01 +0900
Message-ID: <003101ce89ed$52317330$f6945990$@samsung.com>
References: <1374766502-14823-1-git-send-email-a.motakis@virtualopensystems.com>
 <1374766502-14823-2-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1374766502-14823-2-git-send-email-a.motakis@virtualopensystems.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Antonios Motakis' <a.motakis@virtualopensystems.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu, 'Joerg Roedel' <joro@8bytes.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Varun Sethi' <Varun.Sethi@freescale.com>, 'open list' <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Antonios Motakis [mailto:a.motakis@virtualopensystems.com]
> Sent: Friday, July 26, 2013 12:35 AM
> 
> On success, the __sysmmu_enable returns 1 instead of 0, which does not
> respect the convention described in Chapter 16 of the Linux kernel coding
> style.
> 
> In fact, this return value is propagated all the way up to
> iommu_attach_device() and iommu_attach_device() in drivers/iommu.c,
> which results into inconsistent behavior of the IOMMU API with Exynos
> systems, compared to other IOMMUs.
> 
> This patch replaces the return value with 0, which makes the Exynos'
> IOMMU driver behavior consistent with that of other IOMMUs.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/exynos-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index c7dd4b5..4ea3abb 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -504,7 +504,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
> 
>  		dev_dbg(data->sysmmu, "Enabled\n");
>  	} else {
> -		ret = (pgtable == data->pgtable) ? 1 : -EBUSY;
> +		ret = (pgtable == data->pgtable) ? 0 : -EBUSY;
> 
Ok.

__sysmmu_enable() must return 1 if it is called with the same page table.
I have fixed it exynos_iommu_attach_device() to always return zero on success
in the next patchset which I will post today.

Thank you.

>  		dev_dbg(data->sysmmu, "already enabled\n");
>  	}
> --
> 1.8.1.2
