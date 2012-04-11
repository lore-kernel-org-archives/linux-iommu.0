From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/2] iommu/exynos: fix runtime pm support
Date: Wed, 11 Apr 2012 19:18:33 +0400
Message-ID: <4F85A0C9.7050800@mvista.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com> <1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, KyongHo Cho <pullip.cho@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello.

Marek Szyprowski wrote:

> Fix registration to runtime pw and add missing resume callback.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)

> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b8daf7c..eef924d 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
[...]
> @@ -674,11 +673,28 @@ err_alloc:
>  	return ret;
>  }
>  
> +static int exynos_pm_resume(struct device *dev)
> +{
> +	struct sysmmu_drvdata *data;
> +
> +	data = dev_get_drvdata(dev);

    Why not do it right in the initializer?

WBR, Sergei
