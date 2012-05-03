From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Thu, 03 May 2012 12:28:02 -0600
Message-ID: <4FA2CE32.7010406@wwwdotorg.org>
References: <1334588670-15124-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334588670-15124-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/16/2012 09:04 AM, Thierry Reding wrote:
> This commit adds the device node required to probe NVIDIA Tegra 20 GART
> hardware from the device tree.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	gart: gart@7000f000 {
> +		compatible = "nvidia,tegra20-gart";
> +		reg = < 0x7000f000 0x00000100    /* controller registers */
> +		        0x58000000 0x02000000 >; /* GART aperture */
> +	};

Thierry, Hiroshi, Olof,

I have already applied this to Tegra's for inclusion in 3.5, but I'm
considering dropping it. Further thought/discussions related to adding
DT to the Tegra SMMU have raised an issue with a similar binding there.

I'd like to hear peoples' thoughts on all this, and get a resolution,
before we go ahead with any more GART/SMMU/MC patches.

The Tegra20 register block at 7000f000 is not (just) the GART, but the
MC (Memory Controller). This register block contains both general
MC-related registers, and the GART registers. The situation is identical
on Tegra30, except that the register block contains both MC and SMMU
registers.

(Note: MC/Memory-Controller is a different module to the
EMC/External-Memory-Controller)

As such, I think this node should be more like:

mc: mc@7000f000 {
    compatible = "nvidia,tegra20-mc";
    reg = <0x7000f000 0x00000100>;
};

Then, one of following options can be taken:

Option 1:

Just rename the node to "MC", but have a single driver that both does
whatever MC-related functionality is needed, but also registers as
either the GART or SMMU driver. This would be the simplest; we'd just
need to rename a few compatible flags and update the binding
documentation etc. The only disadvantage is that it merges the plain MC
and GART/SMMU code into a single driver, but perhaps that's sane since
the HW merges all that into a single HW module.

Option 2:

We add an explicit child node to MC in order to instantiate the GART
itself, and have the MC call of_platform_populate() to instantiate it,
just like a bus driver:

mc: mc@7000f000 {
    compatible = "nvidia,tegra20-mc";
    reg = <0x7000f000 0x00000100>;

    ranges;
    #address-cells = <1>;
    #size-cells = <1>;

    gart: gart {
        compatible = "nvidia,tegra20-gart";
        reg = <0x7000f000 0x00000100   /* controller registers */
               0x58000000 0x02000000>; /* GART aperture */
    };
};

The question here is: If the MC and GART drivers both need to access
basically the same register block, they can't both call
request_mem_region() on the registers, which is rather unfortunate.

Also, there aren't really separate HW modules, so writing the device
tree as if there were perhaps feels a little wrong.

Option 3:

The MC driver knows that its register range includes the GART registers,
and hence whenever it's probed, it internally causes the GART driver to
be probed somehow (either by manually registering a platform device to
do this, or by removing all the regular device probing code from the
GART driver, and having the MC driver call some pseudo-probe code in the
GART driver)

tegra-mc.c:

tegra_mc_probe()
{
    /* All the usual setup for the MC driver itself */
    mc->regs = ...;

    /* Instantiate SMMU; passing the already-mapped regs to it */
    tegra30_smmu_probe(&pdev->dev, mc->regs);
}

tegra-smmu.c:

int tegra30_smmu_probe(struct device *dev, void __iomem *regs)

This would be just like current tegra30_smmu_probe, except that:

a) No need to map registers; they're passed in.

b) The SMMU doesn't have its own struct device, but shares with the
parent MC controller. In this case, I don't think that's an issue, since
the "struct smmu_device" is stored globally, so we can use that instead
of dev_get/set_drvdata().
