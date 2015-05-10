From: Cho KyongHo <pullip.cho@samsung.com>
Subject: Re: [PATCH v6 12/25] iommu: exynos: add support for runtime_pm
Date: Sun, 10 May 2015 22:38:11 +0900
Message-ID: <20150510223811.e9ea24574e67a6a55b0b1cd4@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-13-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1430727380-10912-13-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 04 May 2015 10:16:07 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> This patch fixes support for runtime power management for SYSMMU
> controllers, so they are enabled when master device is attached.
> 

You should later think that this style of runtime PM support
will increase the leakage current because some devices may
enable System MMUs during they are not working.
If a device driver of a master device attaches its iommu domain
in probe, its local power will be never gated.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 598660c87410..734107ec78fa 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -702,6 +702,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
>  		return -ENODEV;
>  
>  	list_for_each_entry(data, &owner->clients, owner_node) {
> +		pm_runtime_get_sync(data->sysmmu);
>  		ret = __sysmmu_enable(data, pagetable, domain);
>  		if (ret >= 0) {
>  			data->master = dev;
> @@ -743,6 +744,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
>  				data->master = NULL;
>  				list_del_init(&data->domain_node);
>  			}
> +			pm_runtime_put(data->sysmmu);
>  			found = true;
>  		}
>  	}
> -- 
> 1.9.2
> 


-- 
samsung.com <pullip.cho@samsung.com>
