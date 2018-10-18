From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/4] iommu/arm-smmu: Workaround for Marvell Armada-AP806
 SoC erratum #582743
Date: Thu, 18 Oct 2018 17:08:40 +0100
Message-ID: <38360fdf-8bc0-9fea-870f-fdb8b6103248@arm.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-3-git-send-email-hannah@marvell.com>
 <8a7eefcf-6a77-8dc1-2ce9-9bb7395a3bb7@arm.com>
 <2e4f2b02-4b02-877d-1f51-c617170398a6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2e4f2b02-4b02-877d-1f51-c617170398a6@marvell.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Hanna Hawa <hannah@marvell.com>, catalin.marinas@arm.com, will.deacon@arm.com, corbet@lwn.net, joro@8bytes.org, robh+dt@kernel.org, gregory.clement@bootlin.com, mark.rutland@arm.com, jason@lakedaemon.net, andrew@lunn.ch, sebastian.hesselbarth@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com, nadavh@marvell.com, omrii@marvell.com, nd@arm.com
List-Id: iommu@lists.linux-foundation.org

On 16/10/18 09:25, Hanna Hawa wrote:
> Hi Robin,
> 
> 
> On 10/15/2018 04:00 PM, Robin Murphy wrote:
>> Hi Hanna,
>>
>> On 15/10/18 13:00, hannah@marvell.com wrote:
>>> From: Hanna Hawa <hannah@marvell.com>
>>>
>>> Due to erratum #582743, the Marvell Armada-AP806 can't access 64bit
>>> to ARM SMMUv2 registers.
>>> This patch split the writeq/readq to two accesses of writel/readl.
>>>
>>> Note that separate writes/reads to 2 is not problem regards to 
>>> atomicity,
>>> because the driver use the readq/writeq while initialize the SMMU, 
>>> report
>>> for SMMU fault, and use spinlock in one case (iova_to_phys).
>>
>> In general, this doesn't work. Here's what the SMMU spec says about
>> SMMU_CBn_TLBIVA, but others are similar:
>>
>> "If SMMU_CBA2Rn.VA64 is one, then AArch64 format is selected. The
>> programmer should use 64 bit accesses to this register. If 32-bit
>> accesses are used then writes to the top 32 bits are ignored and writes
>> to the lower 32 bits are zero extended."
>>
>> If your interconnect won't let 64-bit transactions through, then you
>> can't use AArch64 format at stage 1 at all, since there's no way to
>> invalidate entries with the correct ASID, and you'll have to restrict
>> stage 2 formats to at most 44-bit IOVAs in order for TLBIIPAS2{L} not to
>> invalidate the wrong thing.
> Thanks for your suggestion.
> 
> To restrict the IOVAs i need to add another work-around to the driver to 
> limit the va_size, is that acceptable?

Yeah, constraining AArch64 stage 2 to 44 bits should just be a case of 
adjusting smmu->ipa_size at probe time, but you'd still need to add the 
writel()-based TLBI path to take advantage of it.

How big is the physical memory map on these SoCs? If everything fits 
into 40 bits then I think you could get away with simply hiding the 
SMMU_IDR2.PTFSv8 fields to sidestep the AArch64 formats altogether, and 
everything else should fall out in the wash. Otherwise, you'll have to 
just disable stage 1 support in addition to the stage 2 workaround as 
above.

> What the different in the driver between AARCH32_L & AARCH32_S?

AARCH32_L is the 3-level LPAE format, which gives you 32-bit 
input/40-bit output at stage 1 and 40-bit input/40-bit output at stage 
2. AARCH32_S is the legacy 2-level short-descriptor format which only 
supports stage 1 and is limited to 32-bit output addresses - MMU-500 
does support it, but you probably want to avoid it if possible ;)

Robin.
