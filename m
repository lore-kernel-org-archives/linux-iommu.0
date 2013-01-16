From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/6] iommu/tegra: smmu: Pass swgroup info from DT
Date: Wed, 16 Jan 2013 14:07:53 -0700
Message-ID: <50F716A9.9060607@wwwdotorg.org>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com> <1358237848-968-2-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358237848-968-2-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/15/2013 01:17 AM, Hiroshi Doyu wrote:
> Pass available H/W client component(software client group) info from
> DT in bitmap. This info is specific to a certain generation of Tegra
> SoC. With this, Tegra SMMU driver could be identical among Tegra
> generations. This also removes the old way of passing this bit from
> each device pdata, which could configure(enable/disable) each device
> IOMMU'able, but it belongs to a kind of "policy", which can be done by
> kernel/system later. Now DT passes just pure H/W info.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> index 89fb543..de449d0 100644
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> @@ -8,6 +8,46 @@ Required properties:
>  - nvidia,#asids : # of ASIDs
>  - dma-window : IOVA start address and length.
>  - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> +- nvidia,swgroups: Available H/W client component(software client
> +  group) in bitmap in SoC. Those IDs are calculated as below:
> +
> +	  <ID> = (<OFFSET> - MC_SMMU_AFI_ASID_0) / 4;

OK, so I understand the addition to the DT defines which clients exist,
and hence which ASID-selection registers exist. This addition makes
sense to me.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  /*
>   * Per client for address space
> @@ -263,7 +192,6 @@ struct smmu_client {
>  	struct device		*dev;
>  	struct list_head	list;
>  	struct smmu_as		*as;
> -	u32			swgrp;
>  };

What I don't quite understand is that change, but perhaps that's because
I'm not sure what that field meant before, and/or where the
client<->ASID mapping comes from.

Before this patch, did each client use that removed "u32 swgrp" to tell
the SMMU driver which ASID-selection register was used to configure it,
and then the SMMU took the union of all clients to know which
ASID-selection registers existed? If so, then perhaps this change makes
more sense than I thought... But, how does the SMMU driver know which of
the bits in the new nvidia,swgroups property is related to each struct
smmu_client?

Or, did the removed "u32 swgrp" indicate which of the SMMU's ASIDs
should be assigned to the client?

I guess what I'm missing is: How does the SMMU know which ASID to assign
to each client, either before or after this change? Or, does the driver
just assign every client to ASID 0 right now, and there's no provision
for separate ASIDs?
