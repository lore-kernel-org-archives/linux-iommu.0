From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 5/7] iommu/tegra: smmu: Support "mmu-masters" binding
Date: Tue, 12 Nov 2013 17:17:22 -0700
Message-ID: <5282C512.5090900@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
	<1384158718-4756-6-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384158718-4756-6-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> Follow arm,smmu's "mmu-masters" binding.

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

> +- mmu-masters   : A list of phandles to device nodes representing bus
> +                  masters for which the SMMU can provide a translation
> +                  and their corresponding StreamIDs (see example below).
> +                  Each device node linked from this list must have a
> +                  "#stream-id-cells" property, indicating the number of
> +                  StreamIDs(swgroup ID) associated with it, which is defined
> +		  in "include/dt-bindings/memory/tegra-swgroup.h".

Some of those lines are indented with TABs, others with spaces.

> +		mmu-masters = <&host1x TEGRA_SWGROUP_HC>,
> +			      <&mpe TEGRA_SWGROUP_MPE>,
> +			      <&vi TEGRA_SWGROUP_VI>,
> +			      <&epp TEGRA_SWGROUP_EPP>,
> +			      <&isp TEGRA_SWGROUP_ISP>,
> +			      <&gr2d TEGRA_SWGROUP_G2>,
> +			      <&gr3d TEGRA_SWGROUP_NV TEGRA_SWGROUP_NV2>,

So right now, the driver is statically assigning clients to a couple of
specific ASIDs. What if we want to configure that mapping from DT; does
that make sense? Instead of mmu-masters being a list of <phandle
streamid*>, should it be <phandle ASID streamid*> or <phandle (streamid
ASID)*>?




> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  struct smmu_client {
...
> -	u32			hwgrp;
> +	u64			hwgrp;

I think that's used later with for_each_set_bit() etc. Should it be
declared as an explicit bitmap object, or at least an unsigned long to
directly match the bitmap APIs?

Related, what if someone bumps <dt-bindings/memory/tegra-swgroup.h>'s
TEGRA_SWGROUP_MAX to 96 without changing the code?

>  static int smmu_iommu_attach_dev(struct iommu_domain *domain,
>  				 struct device *dev)
...
> -	client = devm_kzalloc(smmu->dev, sizeof(*c), GFP_KERNEL);
> +	client = find_smmu_client(smmu, dev->of_node);
>  	if (!client)
... (deletions of replaced code)
>  		return -EINVAL;

-ENODEV cursorily sounds better? Same in smmu_iommu_add_device().

> @@ -1238,6 +1311,23 @@ static int tegra_smmu_probe(struct platform_device *pdev)

> +	i = 0;
> +	smmu->clients = RB_ROOT;
> +	while (true) {
> +		err = of_parse_phandle_with_args(dev->of_node, "mmu-masters",
> +						 "#stream-id-cells", i, &args);
> +		if (err)
> +			break;

An iterator macro similar to of_property_for_each_u32/string() might be
nicer, which could replace all that with:

of_property_for_each_phandle_with_args(dev->of_node, "mmu-masters",
					"#stream-id-cells") {
