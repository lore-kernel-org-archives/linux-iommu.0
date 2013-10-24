From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
Date: Thu, 24 Oct 2013 09:58:11 +0100
Message-ID: <20131024085811.A3F2CC4039D@trevor.secretlab.ca>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com> <1382092020-13170-11-git-send-email-hdoyu@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-11-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 18 Oct 2013 13:26:51 +0300, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> This provides the info about which H/W Accelerators are supported on
> Tegra SoC. This info is passed from DT. This is necessary to have the
> unified SMMU driver among Tegra SoCs. Instead of using platform data,
> DT passes "nvidia,swgroups" now. DT is mandatory in Tegra.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> @@ -1200,6 +1193,9 @@ static int tegra_smmu_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
>  		return -ENODEV;
>  
> +	if (of_property_read_u64(dev->of_node, "nvidia,swgroups", &swgroups))
> +		return -ENODEV;
> +

Best practice: A new property has been created here. If the property
isn't present, then it should default to the previous meaning instead of
outright failing. (or make a strong argument that no one is using this
yet and therefore is not breakage).
