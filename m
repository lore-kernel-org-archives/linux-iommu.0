From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/tegra: smmu: Simplify allocation at once
Date: Mon, 14 May 2012 17:34:15 -0600
Message-ID: <4FB19677.4040702@wwwdotorg.org>
References: <1337022975-23999-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337022975-23999-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/14/2012 01:16 PM, Hiroshi DOYU wrote:
> To simplify the code, alloc necessary data at once.
> 
> Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> This patch requires:
> 
>     [PATCH 1/2] iommu/tegra: smmu: Add device tree support for SMMU
>         http://marc.info/?l=linux-tegra&m=133663641107327&w=2
> 
> Also the above patch requires:
> 
>     [PATCH 1/1] dt: Add general DMA window parser
>         http://marc.info/?l=linux-tegra&m=133671302703840&w=2

I know I've been harping on about dependencies, but you typically only
need to mention them if the dependencies are not already checked into
the branch you expect this patch to be checked into.

> -	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
> +	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
> +		return -ENODEV;

I believe you need to change the asids variable from int to u32 to avoid
a warning here.

Aside from that, the series,
Acked-by: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
