From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
Date: Fri, 04 May 2012 11:24:45 -0600
Message-ID: <4FA410DD.3090105@wwwdotorg.org>
References: <1334588670-15124-1-git-send-email-thierry.reding@avionic-design.de><4FA2CE32.7010406@wwwdotorg.org> <20120504.121357.1085445784831612281.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120504.121357.1085445784831612281.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org" <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "joerg.roedel-5C7GfCeVMHo@public.gmane.org" <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org" <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 05/04/2012 03:13 AM, Hiroshi Doyu wrote:
> From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> Subject: Re: [PATCH v2] ARM: dt: tegra20: Add GART device
> Date: Thu, 3 May 2012 20:28:02 +0200
> Message-ID: <4FA2CE32.7010406-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
> 
>> On 04/16/2012 09:04 AM, Thierry Reding wrote:
>>> This commit adds the device node required to probe NVIDIA Tegra 20 GART
>>> hardware from the device tree.
>>
>>> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
>>
>>> +	gart: gart@7000f000 {
>>> +		compatible = "nvidia,tegra20-gart";
>>> +		reg = < 0x7000f000 0x00000100    /* controller registers */
>>> +		        0x58000000 0x02000000 >; /* GART aperture */
>>> +	};
>>
>> Thierry, Hiroshi, Olof,
>>
>> I have already applied this to Tegra's for inclusion in 3.5, but I'm
>> considering dropping it. Further thought/discussions related to adding
>> DT to the Tegra SMMU have raised an issue with a similar binding there.
>>
>> I'd like to hear peoples' thoughts on all this, and get a resolution,
>> before we go ahead with any more GART/SMMU/MC patches.
>>
>> The Tegra20 register block at 7000f000 is not (just) the GART, but the
>> MC (Memory Controller). This register block contains both general
>> MC-related registers, and the GART registers. The situation is identical
>> on Tegra30, except that the register block contains both MC and SMMU
>> registers.
> 
> For the furthur info, GART occupies 1 block within MC register range,
> and SMMU occupies 3 blocks. In both Tegra{20,30}, MC driver only uses
> MC registers, GART uses GART registers in its own block, and SMMU uses
> SMMU registers in its own blocks *exclusively*.
> 
> IRQ is handled in MC. They include IOMMU page access fault too, but
> MC ISR just prints fault address and other info. IRQ handling
> registers belong to MC, and GART/SMMU doesn't have to touch it.
> 
>  Tegra20:
>  	7000f000-7000f3ff : /mc@7000f000	1KB
>  	  7000f024-7000f02f : gart
>  
>  Tegra30:
>  	7000f000-7000f3ff : /mc@7000f000	1KB
>  	  7000f010-7000f03b : smmu, register block 1
>  	  7000f1f0-7000f1ff : smmu, register block 2
>  	  7000f228-7000f283 : smmu, register block 3
>  	  ....

True, it appears that each register is logically part of MC or GART/SMMU
functionality. In that case, chunks of registers can be assigned to
specific drivers. However, the memory map is rather interleaved:

Tegra20:

00c-01c: MC
024-034: GART
03c-270: MC

Tegra30:

010-038: SMMU
050-220: MC
228-280: SMMU
29c-36c: MC

Perhaps the simplest way is to represent those chunks as separate reg
entries:

    mc@7000f010 {
        compatible = "nvidia,tegra30-mc";
        reg = <0x7000f010 0x1d4 0x70000228 0xd4>;
    };

    smmu@0x70000050 {
        compatible = "nvidia,tegra30-smmu";
        reg = <0x70000010 0x2c 0x70000228 0x5c>;
    };

This could all be hidden inside e.g. smmu_read():

static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
{
	BUG_ON(offs < 0x10);
	if (offs < 0x40)
        	return readl(smmu->regsa + offs - 0x10);
	BUG_ON(offs < 0x228);
	if (offs < 0x370)
        	return readl(smmu->regsb + offs - 0x228);
	BUG();
}

This would optimize out, since most likely "offs" would be a #define for
the register address.

Then there would be no need for the DT nodes or devices/drivers to
interact at all.

We should really talk to our HW engineers and make sure that future
chips don't get even more interleaved register maps - either make sure
the current layout is perpetuated exactly, or fix it to make them
entirely separate. Can you please start an internal thread with them on
this topic, Hiroshi?

>> Option 2:
>>
>> We add an explicit child node to MC in order to instantiate the GART
>> itself, and have the MC call of_platform_populate() to instantiate it,
>> just like a bus driver:
>>
>> mc: mc@7000f000 {
>>     compatible = "nvidia,tegra20-mc";
>>     reg = <0x7000f000 0x00000100>;
>>
>>     ranges;
>>     #address-cells = <1>;
>>     #size-cells = <1>;
>>
>>     gart: gart {
>>         compatible = "nvidia,tegra20-gart";
>>         reg = <0x7000f000 0x00000100   /* controller registers */
>>                0x58000000 0x02000000>; /* GART aperture */
>>     };
>> };
>>
>> The question here is: If the MC and GART drivers both need to access
>> basically the same register block, they can't both call
>> request_mem_region() on the registers, which is rather unfortunate.
> 
> Can "request_resource(mc_resource, gart_resource)" or
> "insert_resource(mc_resource, gart_resource)" create the following
> resource tree?
> 
>  Tegra20:
>  	7000f000-7000f3ff : /mc@7000f000	1KB
>  	  7000f024-7000f02f : gart
> 
> gart/smmu may be able to get the parent resources for ioremap()?
> 
> +	mc = pdev->dev.parent->of_node;
>   or
> +	res = platform_get_resource(to_platform_device(pdev->dev.parent), IORESOURCE_MEM, 0);

I'd certainly rather avoid drivers reaching into other devices to get
register windows, unless this is more explicitly managed by passing the
data from one device to another via an API for this purpose. The code
above feels quite fragile/dangerous.
