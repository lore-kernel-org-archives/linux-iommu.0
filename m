From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v2 1/1] iommu/tegra: smmu: Support variable MMIO ranges/blocks
Date: Tue, 29 Jan 2013 18:40:07 +0100
Message-ID: <20130129.194007.2143867447969494923.hdoyu@nvidia.com>
References: <50FD752A.6060706@wwwdotorg.org><1359448450-24894-1-git-send-email-hdoyu@nvidia.com><510800F7.7020507@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <510800F7.7020507-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote @ Tue, 29 Jan 2013 18:03:51 +0100:

> > +	/* Same as "mc" 1st regiter block start address */
> > +	smmu->regbase = (void __iomem *)((u32)smmu->regs[0] & ~PAGE_MASK);
> 
> I'm not sure if it's relevant how these register ranges are related to
> the MC registers, given this is the SMMU driver?

All SMMU register offsets are against MC[0]'s start address and SMMU
register blocks are interleaved as below. The 1st SMMU register block
SMMU[0]'s offset is always 0x10.

Address Register block
-----------------------
000-010	MC[0]
010-03c	SMMU[0]
03c-1f0	MC[1]
1f0-200	SMMU[1]
200-228	MC[2]
228-284	SMMU[2]
284-...	MC[3]

If the above assumption is not acceptable, alternatively we need to
access MC's node to get the 1st MC register block start address, for
example, via embedded in MC's phandle in smmu entry.

	Modified arch/arm/boot/dts/tegra30.dtsi
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c5db29d..e9fb9ef 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -397,7 +397,7 @@
 		reg = <0x7000e400 0x400>;
 	};
 
-	memory-controller {
+	mc: memory-controller {
 		compatible = "nvidia,tegra30-mc";
 		reg = <0x7000f000 0x010
 		       0x7000f03c 0x1b4
@@ -414,6 +414,7 @@
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
 		nvidia,ahb = <&ahb>;
+		nvidia.mc = <&mc>;
 	};
 
 	ahub {

I may think that above may be a bit too much since we know that the
1st SMMU offset(0x10) and also that the MC register is aligned with
page boundary, and the following works actually.

	smmu->regbase = (void __iomem *)((u32)smmu->regs[0] & ~PAGE_MASK);

I don't think that the existing SMMU/MC register offsets will change so easily.
