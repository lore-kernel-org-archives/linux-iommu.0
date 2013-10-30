From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients"
 from DT
Date: Wed, 30 Oct 2013 16:44:04 -0600
Message-ID: <52718BB4.4090007@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com> <1382092020-13170-15-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-15-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/18/2013 04:26 AM, Hiroshi Doyu wrote:
> This provides the info about which swgroups a device belongs to. This
> info is passed from DT. This is necessary for the unified SMMU driver

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

> @@ -13,9 +13,12 @@ Required properties:
>    file <dt-bindings/memory/tegra-swgroup.h>. Its max is 64. 2 cells
>    are required. This unique ID info can be used to calculate
>    MC_SMMU_<SWGROUP name>_ASID_0 offset and HOTRESET bit.
> +- nvidia,memory-clients: phandle to a smmu device which a device is
> +  attached to and indicates which swgroups a device belongs to(SWGROUP ID).
> +  SWGROUP ID is from 0 to 63, and a device can belong to multiple SWGROUPS.

You added that to a list of properties that are required for the SMMU
node. However, judging by the example below, this property should be
added to the SMMU client nodes. Please keep the two lists separate, for
example:

Required properties for SMMU node:
...

Required properties for SMMU client nodes:
...

> +	host1x {
> +		compatible = "nvidia,tegra30-host1x", "simple-bus";
> +		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_HC>;
> +		....
> +		gr3d {
> +			compatible = "nvidia,tegra30-gr3d";
> +			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_NV
> +						       TEGRA_SWGROUP_NV2>;

Why one cell for the host1x property, and two cells for the gr3d
property; shouldn't they be the same length?

Bikeshedding a bit, but "nvidia,smmu" seems like it'd be a better
property name, since the property is really about defining which other
node is the SMMU that affects the device, and the SWGROUP IDs are just
part of the SMMU specifier that goes along with the phandle.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +static u64 smmu_of_get_memory_client(struct device *dev)

> +	np = of_parse_phandle(dev->of_node, propname, 0);
> +	if (np != smmu_handle->dev->of_node)
> +		return ~0;
> +
> +	prop = of_get_property(dev->of_node, propname, &bytes);
> +	if (!prop || !bytes)
> +		return ~0;

of_parse_phandle_with_fixed_args() might be a good fit here, or perhaps
require a property #smmu-cells in the SMMU node, thus allowing the
non-fixed-length of_parse_phandle_with_args() to be used here.

> +	for (i = 1; i < bytes / sizeof(u32); i++, prop++)
> +		swgroup |= 1ULL << be32_to_cpup(prop);

Don't you need to shift swgroup too? I thought the two cells in DT were
LSB and MSB, yet here you're ORing both cells into the LSBs.
