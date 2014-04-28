From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH v12 18/31] iommu/exynos: allow having multiple System
 MMUs for a master H/W
Date: Mon, 28 Apr 2014 16:08:14 +0530
Message-ID: <535E2F96.908@linaro.org>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com> <1398584283-22846-19-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1398584283-22846-19-git-send-email-shaik.ameer@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Shaik Ameer Basha <shaik.ameer@samsung.com>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, prathyush.k@samsung.com, grundler@chromium.org, joro@8bytes.org, tomasz.figa@gmail.com, joshi@samsung.com, sachin.kamat@linaro.org, s.nawrocki@samsung.com, Varun.Sethi@freescale.com, a.motakis@virtualopensystems.com, pullip.cho@samsung.com, t.figa@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

On 04/27/2014 01:07 PM, Shaik Ameer Basha wrote:
> From: Cho KyongHo <pullip.cho@samsung.com>
> 
> Some master device descriptor like fimc-is which is an abstraction
> of very complex H/W may have multiple System MMUs. For those devices,
> the design of the link between System MMU and its master H/W is needed
> to be reconsidered.
> 
> A link structure, sysmmu_list_data is introduced that provides a link
> to master H/W and that has a pointer to the device descriptor of a
> System MMU. Given a device descriptor of a master H/W, it is possible
> to traverse all System MMUs that must be controlled along with the
> master H/W.
> 
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>

Since you are posting the patches, you should also add your
Signed-of-by.

> ---
>  drivers/iommu/exynos-iommu.c |  545 ++++++++++++++++++++++++++----------------
>  1 file changed, 335 insertions(+), 210 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index fefedec3..c2e6365 100755
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c

[ ... ]

>  static int sysmmu_pm_genpd_save_state(struct device *dev)
> @@ -1215,7 +1349,7 @@ static int sysmmu_pm_genpd_save_state(struct device *dev)
>  		ret = cb(dev);
>  
>  	if (ret == 0)
> -		sysmmu_save_state(client->sysmmu);
> +		sysmmu_save_state(dev);
>  

client is now unused, remove the variable.

>  	return ret;
>  }
> @@ -1238,13 +1372,13 @@ static int sysmmu_pm_genpd_restore_state(struct device *dev)
>  	if (!cb && dev->driver && dev->driver->pm)
>  		cb = dev->driver->pm->runtime_resume;
>  
> -	sysmmu_restore_state(client->sysmmu);
> +	sysmmu_restore_state(dev);
>  
>  	if (cb)
>  		ret = cb(dev);
>  
>  	if (ret)
> -		sysmmu_save_state(client->sysmmu);
> +		sysmmu_restore_state(dev);
>  

client is now unused, remove the variable.


-- 
Tushar Behera
