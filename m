From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 07/19] iommu/tegra: smmu: Create default IOVA maps
Date: Wed, 30 Oct 2013 16:18:30 -0600
Message-ID: <527185B6.1070608@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com> <1382092020-13170-8-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-8-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/18/2013 04:26 AM, Hiroshi Doyu wrote:
> Create default IOVA maps at boot-up which can be attached to devices.

What's the content of those default maps? I assume no RAM is mapped,
judging by the code. If so, perhaps s/default/default empty/ in the
patch description?

> @@ -1236,7 +1261,7 @@ static int tegra_smmu_probe(struct platform_device *pdev)
>  	smmu_debugfs_create(smmu);
>  	smmu_handle = smmu;
>  	bus_set_iommu(&platform_bus_type, &smmu_iommu_ops);
> -	return 0;
> +	return tegra_smmu_create_default_map(smmu);
>  }

If tegra_smmu_create_default_map() fails, don't you need to unwind e.g.
bus_set_iommu(), and any other setup that happened before?
