From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients"
 from DT
Date: Thu, 31 Oct 2013 13:17:29 -0600
Message-ID: <5272ACC9.6080501@wwwdotorg.org>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com><1382092020-13170-15-git-send-email-hdoyu@nvidia.com><52718BB4.4090007@wwwdotorg.org> <20131031.101808.1830527808656695540.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131031.101808.1830527808656695540.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/31/2013 02:18 AM, Hiroshi Doyu wrote:
> Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:44:04 +0100:
> 
>>> +	host1x {
>>> +		compatible = "nvidia,tegra30-host1x", "simple-bus";
>>> +		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_HC>;
>>> +		....
>>> +		gr3d {
>>> +			compatible = "nvidia,tegra30-gr3d";
>>> +			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_NV
>>> +						       TEGRA_SWGROUP_NV2>;
>>
>> Why one cell for the host1x property, and two cells for the gr3d
>> property; shouldn't they be the same length?
> 
> That can vary. Even a single device node in DT can belong to multiple
> software groups.
> 
>>> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
>>
>>> +static u64 smmu_of_get_memory_client(struct device *dev)
>>
>>> +	np = of_parse_phandle(dev->of_node, propname, 0);
>>> +	if (np != smmu_handle->dev->of_node)
>>> +		return ~0;
>>> +
>>> +	prop = of_get_property(dev->of_node, propname, &bytes);
>>> +	if (!prop || !bytes)
>>> +		return ~0;
>>
>> of_parse_phandle_with_fixed_args() might be a good fit here, or perhaps
>> require a property #smmu-cells in the SMMU node, thus allowing the
>> non-fixed-length of_parse_phandle_with_args() to be used here.
> 
> I once considered of_parse_phandle_with_args() but I couldn't use that
> since "#smmu-cells" needed to be fixed in smmu node, not in client
> node. In this case, the number of argument(number of swgroup IDs)
> varies per client device.

You could fix that by using a bitmask instead of a list. But, inverting
the order of the properties to match the ARM SMMU binding might also
solve this...
