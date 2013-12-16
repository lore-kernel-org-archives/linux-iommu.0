From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/6] iommu/tegra124: smmu: optionaly AHB enables SMMU
Date: Mon, 16 Dec 2013 13:37:35 -0700
Message-ID: <52AF648F.70608@wwwdotorg.org>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com> <1386246319-17851-2-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386246319-17851-2-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/05/2013 05:25 AM, Hiroshi Doyu wrote:
> SMMU used to depend on AHB bus. AHB driver needs to be populated and
> AHB_XBAR_CTRL_SMMU_INIT_DONE bit needs to be set earliear than SMMU
> being populated. Later Tegra SoC (>= T124) doesn't need AHB to enable
> SMMU on AHB_XBAR_CTRL for AHB_XBAR_CTRL_SMMU_INIT_DONE any more. This
> setting bit is now optional, depending on DT passing ahb phandle or
> not.

This patch should happen after 1/3, and the "platform data" should
indicate whether tegra_ahb_enable_smmu() needs to be called, so that on
Tegra30...

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> @@ -1284,9 +1287,6 @@ static int tegra_smmu_probe(struct platform_device *pdev)

>  	smmu->ahb = of_parse_phandle(dev->of_node, "nvidia,ahb", 0);
> -	if (!smmu->ahb)
> -		return -ENODEV;

... that error-checking is still in place, yet on Tegra124,
of_parse_phandle() isn't even called.
