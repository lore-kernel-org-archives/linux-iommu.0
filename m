From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dt: tegra114: Add SMMU entry
Date: Wed, 16 Jan 2013 14:17:56 -0700
Message-ID: <50F71904.5070600@wwwdotorg.org>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
	<1358237848-968-6-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1358237848-968-6-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/15/2013 01:17 AM, Hiroshi Doyu wrote:
> Add SMMU entry.

> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi

> +	smmu {
> +		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
> +		reg = <0x7000f010 0x02c
> +		       0x7000f1f0 0x010
> +		       0x7000f228 0x074>;

Oh, so the only change here relative to Tegra30 is that the final memory
range is larger; the others don't move around at all. Is that all that
patch 4/6 is trying to cope with? If so, I'd suggest simplifying that
patch a bunch; perhaps just remove the final if() check in each function
and make all accesses with (offs > 0x200) go to smmu->regs[2]?

You can always add checks to probe() that memory range 0 and 1 have the
expected size such that the code in smmu_{read,write} will work as expected.
