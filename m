From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
 work well when smmu is enabled
Date: Mon, 8 Apr 2019 10:31:47 +0800
Message-ID: <5CAAB293.3080600@huawei.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
 <20190404153031.GE27558@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404153031.GE27558@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 2019/4/4 23:30, Will Deacon wrote:
> Hi Zhen Lei,
> 
> On Mon, Mar 18, 2019 at 09:12:41PM +0800, Zhen Lei wrote:
>> v1 --> v2:
>> 1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
>> (Report abort to device, no event recorded) to suppress the event messages
>> caused by the unexpected devices.
>> 2. rewrite the patch description.
> 
> This issue came up a while back:
> 
> https://lore.kernel.org/linux-pci/20180302103032.GB19323@arm.com/
> 
> and I'd still prefer to solve it using the disable_bypass logic which we
> already have. Something along the lines of the diff below?

Yes, my patches also use disable_bypass=1(set ste.config=0b000). If
SMMU_IDR0.ST_LEVEL=0(Linear Stream table supported), then all STE entries
are allocated and initialized(set ste.config=0b000). But if SMMU_IDR0.ST_LEVEL=1
(2-level Stream Table), we only allocated and initialized the first level tables,
but leave level 2 tables dynamic allocated. That means, C_BAD_STREAMID(eventid=0x2)
will be reported, if an unexpeted device access memory without reinitialized in
kdump kernel. So my patches allocated a dummy level 2 table(STE table), and make
all level 1 table entries pointer to it in advance. That means abort all unexpected
devices memory access base this dummy STE table. When an expected device(need to be
used in kdump kernel) attached, we will allocate a new level 2 table(STE table)
accordingly, but keep others still pointer to the dummy STE table.


> 
> We're relying on the DMA API not subsequently requesting a passthrough
> domain, but it should only do that if you've configured your crashkernel
> to do so.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index d3880010c6cf..91b8f3b2ee25 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2454,13 +2454,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
>  	if (reg & CR0_SMMUEN) {
> -		if (is_kdump_kernel()) {
> -			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
> -			arm_smmu_device_disable(smmu);
> -			return -EBUSY;
> -		}
> -
>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
> +		WARN_ON(is_kdump_kernel() && !disable_bypass);
> +		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
>  	}
>  
>  	ret = arm_smmu_device_disable(smmu);
> 
> .
> 

-- 
Thanks!
BestRegards
