From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] iommu/rockchip: Remove build dependency on ARM
Date: Wed, 10 May 2017 12:37:56 +0200
Message-ID: <2219350.J3uHR7SeXA@diego>
References: <1494412092-25458-1-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494412092-25458-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, dianders@chromium.org, tfiga@chromium.org, seanpaul@chromium.org, zyw@rock-chips.com, mark.yao@rock-chips.com, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jeffy,

Am Mittwoch, 10. Mai 2017, 18:28:12 CEST schrieb Jeffy Chen:
> This patch removes the build dependency on ARM, so we can build on arm64
> as well.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/iommu/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6ee3a25..cb26f45 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -219,7 +219,6 @@ config OMAP_IOMMU_DEBUG
> 
>  config ROCKCHIP_IOMMU
>  	bool "Rockchip IOMMU Support"
> -	depends on ARM

The previous patch from Simon Xue that was delayed due to the drm
changes needed did a
	depends in ARM || ARM64
instead.

I'm not sure which variant is better and Rockchip is currently not
providing any other cpu architectures, just noting the difference and
letting you and Joerg decide which one to choose :-) .

Enabling the iommu on arm64 looks good to me in any case.


Heiko



>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
>  	select IOMMU_API
>  	select ARM_DMA_USE_IOMMU
