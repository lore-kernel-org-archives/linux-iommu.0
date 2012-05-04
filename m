From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Fri, 4 May 2012 11:13:57 +0200
Message-ID: <20120504.121357.1085445784831612281.hdoyu@nvidia.com>
References: <1334588670-15124-1-git-send-email-thierry.reding@avionic-design.de><4FA2CE32.7010406@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FA2CE32.7010406-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Thu, 3 May 2012 20:28:02 +0200
Message-ID: <4FA2CE32.7010406-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>

> On 04/16/2012 09:04 AM, Thierry Reding wrote:
> > This commit adds the device node required to probe NVIDIA Tegra 20 GART
> > hardware from the device tree.
> 
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> 
> > +	gart: gart@7000f000 {
> > +		compatible = "nvidia,tegra20-gart";
> > +		reg = < 0x7000f000 0x00000100    /* controller registers */
> > +		        0x58000000 0x02000000 >; /* GART aperture */
> > +	};
> 
> Thierry, Hiroshi, Olof,
> 
> I have already applied this to Tegra's for inclusion in 3.5, but I'm
> considering dropping it. Further thought/discussions related to adding
> DT to the Tegra SMMU have raised an issue with a similar binding there.
> 
> I'd like to hear peoples' thoughts on all this, and get a resolution,
> before we go ahead with any more GART/SMMU/MC patches.
> 
> The Tegra20 register block at 7000f000 is not (just) the GART, but the
> MC (Memory Controller). This register block contains both general
> MC-related registers, and the GART registers. The situation is identical
> on Tegra30, except that the register block contains both MC and SMMU
> registers.

For the furthur info, GART occupies 1 block within MC register range,
and SMMU occupies 3 blocks. In both Tegra{20,30}, MC driver only uses
MC registers, GART uses GART registers in its own block, and SMMU uses
SMMU registers in its own blocks *exclusively*.

IRQ is handled in MC. They include IOMMU page access fault too, but
MC ISR just prints fault address and other info. IRQ handling
registers belong to MC, and GART/SMMU doesn't have to touch it.

 Tegra20:
 	7000f000-7000f3ff : /mc@7000f000	1KB
 	  7000f024-7000f02f : gart
 
 Tegra30:
 	7000f000-7000f3ff : /mc@7000f000	1KB
 	  7000f010-7000f03b : smmu, register block 1
 	  7000f1f0-7000f1ff : smmu, register block 2
 	  7000f228-7000f283 : smmu, register block 3
 	  ....

GART/SMMU register offsets are defined in TRM from the beginning of
MC(0x7000f000), instead of the beginning of their block(s). I think
that 'ioremap()' is done by unit of 4KB in the end because of MMU
address translation, and it's ok that SMMU/GART ioremap's 4KB from
0x7000f000.

> (Note: MC/Memory-Controller is a different module to the
> EMC/External-Memory-Controller)
> 
> As such, I think this node should be more like:
> 
> mc: mc@7000f000 {
>     compatible = "nvidia,tegra20-mc";
>     reg = <0x7000f000 0x00000100>;
> };
> 
> Then, one of following options can be taken:
> 
> Option 1:
> 
> Just rename the node to "MC", but have a single driver that both does
> whatever MC-related functionality is needed, but also registers as
> either the GART or SMMU driver. This would be the simplest; we'd just
> need to rename a few compatible flags and update the binding
> documentation etc. The only disadvantage is that it merges the plain MC
> and GART/SMMU code into a single driver, but perhaps that's sane since
> the HW merges all that into a single HW module.

>From their functionality POV, MC and IOMMU(GART/SMMU) drivers are
totally independent. Those drivers can be kept independent, except
register offset(0x7000f000) in TRM.

> Option 2:
> 
> We add an explicit child node to MC in order to instantiate the GART
> itself, and have the MC call of_platform_populate() to instantiate it,
> just like a bus driver:
> 
> mc: mc@7000f000 {
>     compatible = "nvidia,tegra20-mc";
>     reg = <0x7000f000 0x00000100>;
> 
>     ranges;
>     #address-cells = <1>;
>     #size-cells = <1>;
> 
>     gart: gart {
>         compatible = "nvidia,tegra20-gart";
>         reg = <0x7000f000 0x00000100   /* controller registers */
>                0x58000000 0x02000000>; /* GART aperture */
>     };
> };
> 
> The question here is: If the MC and GART drivers both need to access
> basically the same register block, they can't both call
> request_mem_region() on the registers, which is rather unfortunate.

Can "request_resource(mc_resource, gart_resource)" or
"insert_resource(mc_resource, gart_resource)" create the following
resource tree?

 Tegra20:
 	7000f000-7000f3ff : /mc@7000f000	1KB
 	  7000f024-7000f02f : gart

gart/smmu may be able to get the parent resources for ioremap()?

+	mc = pdev->dev.parent->of_node;
  or
+	res = platform_get_resource(to_platform_device(pdev->dev.parent), IORESOURCE_MEM, 0);


> Also, there aren't really separate HW modules, so writing the device
> tree as if there were perhaps feels a little wrong.
> 
> Option 3:
> 
> The MC driver knows that its register range includes the GART registers,
> and hence whenever it's probed, it internally causes the GART driver to
> be probed somehow (either by manually registering a platform device to
> do this, or by removing all the regular device probing code from the
> GART driver, and having the MC driver call some pseudo-probe code in the
> GART driver)
> 
> tegra-mc.c:
> 
> tegra_mc_probe()
> {
>     /* All the usual setup for the MC driver itself */
>     mc->regs = ...;
> 
>     /* Instantiate SMMU; passing the already-mapped regs to it */
>     tegra30_smmu_probe(&pdev->dev, mc->regs);
> }
> 
> tegra-smmu.c:
> 
> int tegra30_smmu_probe(struct device *dev, void __iomem *regs)
> 
> This would be just like current tegra30_smmu_probe, except that:
> 
> a) No need to map registers; they're passed in.
> 
> b) The SMMU doesn't have its own struct device, but shares with the
> parent MC controller. In this case, I don't think that's an issue, since
> the "struct smmu_device" is stored globally, so we can use that instead
> of dev_get/set_drvdata().

Option 4:

GART/SMMU only needs MC register range(resource). Their register
blocks are statically exclusively accessed although they are located
within MC register range. GART/SMMU and MC are quite independent from
functionarity/driver POV. So if we can ignore the exact H/W module
connections, what about the following info being provided?

	mc: mc@7000f000 {
		compatible = "nvidia,tegra20-mc";
		reg = <0x7000f000 0x400>;	/* controller registers */
		interrupts = <0 77 0x04>;
	};

	gart: gart {
		compatible = "nvidia,tegra20-gart";
		reg = <0x7000f024 0xc   /* controller registers */
		               ^^^^^^
		       0x58000000 0x02000000>; /* GART aperture */
		mc = &mc;
		^^^^^^^^^ 
	};

GART driver can get MC register range by phandle "mc", and make its
reservation as child of "mc". "GART aperture" just goes straight
because it's also visible to CPU. We could keep those drivers mostly
independent if DT allows this kind of phandle.
