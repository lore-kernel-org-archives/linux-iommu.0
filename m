From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 7/6] iommu/tegra: smmu: Add dependency on ARCH_TEGRA_114_SOC
Date: Wed, 16 Jan 2013 14:18:55 -0700
Message-ID: <50F7193F.3090905@wwwdotorg.org>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com> <1358256149-28700-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358256149-28700-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/15/2013 06:22 AM, Hiroshi Doyu wrote:
> TEGRA_IOMMU_SMMU depends on ARCH_TEGRA_114_SOC too.

> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig

>  config TEGRA_IOMMU_SMMU
>  	bool "Tegra SMMU IOMMU Support"
> -	depends on ARCH_TEGRA_3x_SOC && TEGRA_AHB
> +	depends on (ARCH_TEGRA_114_SOC || ARCH_TEGRA_3x_SOC) && TEGRA_AHB

I think instead of listing out each SoC version individually, just
depend on ARCH_TEGRA. This will mean the SMMU driver can be enabled in a
Tegra20-only kernel, but that's not a big deal, and it means we won't
have to keep editing this Kconfig entry every time we add a new chip.
