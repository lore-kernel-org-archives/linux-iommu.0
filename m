From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 05/22] ARM: dt: tegra30: iommu: Add "nvidia,
	memory-client"
Date: Tue, 16 Jul 2013 17:14:33 -0600
Message-ID: <51E5D3D9.2090608@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-6-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1373021097-32420-6-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Add "nvidia,memory-client" to identify which swgroup ID a device
> belongs to.

This property also isn't in the documentation.

Again, if client devices are required to have this new property, the DT
isn't backwards-compatible; fail:-(

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi

> +		nvidia,memory-client = <TEGRA_SWGROUP_HC>;

What if there's more than one SMMU in the system, e.g. since there are
multiple different master-capable buses? Including the SMMU phandle in
the property seems like a good idea so that the SMMU driver knows which
devices are affected by it (although a bus structure with affected
devices under the SMMU represented as nodes under the SMMU DT node seems
a slightly more direct way of representing that, although that solution
does only support systems where bus-master transactions flow up the bus
structure in the same way that CPU transactions flow down it).

What about:

nvidia,smmu = <&smmu TEGRA_SWGROUP_HC>;

?

> @@ -69,6 +75,8 @@
>  			reg = <0x54180000 0x00040000>;
>  			clocks = <&tegra_car 24 &tegra_car 98>;
>  			clock-names = "3d", "3d2";
> +			nvidia,memory-client = <TEGRA_SWGROUP_NV
> +						TEGRA_SWGROUP_NV2>;

Oh, if there can be more than one, I suggest adding "s" to the end of
the property name.
