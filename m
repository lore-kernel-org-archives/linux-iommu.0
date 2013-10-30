From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from
 DT
Date: Wed, 30 Oct 2013 16:33:32 -0600
Message-ID: <5271893C.6000507@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com> <1382092020-13170-11-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-11-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/18/2013 04:26 AM, Hiroshi Doyu wrote:
> This provides the info about which H/W Accelerators are supported on
> Tegra SoC. This info is passed from DT. This is necessary to have the
> unified SMMU driver among Tegra SoCs. Instead of using platform data,
> DT passes "nvidia,swgroups" now. DT is mandatory in Tegra.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> index 89fb543..6a844b3 100644
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> @@ -8,6 +8,11 @@ Required properties:
>  - nvidia,#asids : # of ASIDs
>  - dma-window : IOVA start address and length.
>  - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> +- nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
> +  Each bit represents one swgroup. The assignments may be found in header
> +  file <dt-bindings/memory/tegra-swgroup.h>. Its max is 64. 2 cells

That file doesn't exist at this point in the series. I think you should
create a patch up-front that adds that header, and modifies the binding
document, all in one go, and separate from any driver code changes.
Separate DT/driver patches were IIRC agreed to be preferablte at the
recent ARM workshop.

> +  are required. This unique ID info can be used to calculate
> +  MC_SMMU_<SWGROUP name>_ASID_0 offset and HOTRESET bit.

I'm afraid I still don't quite understand what a swgroup is.

IIUC, the HW works like this based on comments in a previous patch:

Each bus-master attached to the MMU passes a "memory client ID" along
with the transaction. Some devices can generate transactions with
different "memory client IDs". There is a mapping inside the SMMU from
"memory client ID" to "address space ID". (I don't know what form that
mapping takes; can you point out where it's set up?). Each "address
space ID" has its own set of page tables. Is "swgroup" simply another
name for "memory client ID"? If so, it'd be good to use just one term
consistently.

Assuming "swgroup" is "memory client ID", why can't the driver just
create a list/... of known swgroups at runtime, based on the swgroup
values that each device uses, which would presumably be either
hard-coded in the client device's driver, or represented in the DT smmu
property's "iommu specifier" value.

> @@ -380,12 +383,10 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
>  	if (!on)
>  		map = smmu_client_hwgrp(c);
>  
> -	for_each_set_bit(i, &map, HWGRP_COUNT) {
> +	for_each_set_bit(i, bitmap, sizeof(map) * BITS_PER_BYTE) {
>  		offs = HWGRP_ASID_REG(i);
>  		val = smmu_read(smmu, offs);
>  		if (on) {
> -			if (WARN_ON(val & mask))
> -				goto err_hw_busy;
>  			val |= mask;
>  		} else {
>  			WARN_ON((val & mask) == mask);
> @@ -396,15 +397,6 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
>  	FLUSH_SMMU_REGS(smmu);
>  	c->hwgrp = map;
>  	return 0;
> -
> -err_hw_busy:
> -	for_each_set_bit(i, &map, HWGRP_COUNT) {
> -		offs = HWGRP_ASID_REG(i);
> -		val = smmu_read(smmu, offs);
> -		val &= ~mask;
> -		smmu_write(smmu, val, offs);
> -	}
> -	return -EBUSY;
>  }

I must admit to having zero idea what that part of the patch is doing
semantically. Some form of explanation in the commit description would
be useful.
