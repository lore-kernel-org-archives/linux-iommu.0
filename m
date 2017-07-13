From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Thu, 13 Jul 2017 10:50:45 +0100
Message-ID: <a8fcaac6-98f8-6cf0-486f-7fa0f216f665@arm.com>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-4-git-send-email-vivek.gautam@codeaurora.org>
 <20170712225459.GZ22780@codeaurora.org>
 <5ee0bacd-e557-a6c4-a897-844fb12ea6ae@codeaurora.org>
 <20170713064843.GX22780@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170713064843.GX22780@codeaurora.org>
Content-Language: en-GB
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, m.szyprowski@samsung.com, robdclark@gmail.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org, stanimir.varbanov@linaro.org, architt@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 13/07/17 07:48, Stephen Boyd wrote:
> On 07/13, Vivek Gautam wrote:
>> Hi Stephen,
>>
>>
>> On 07/13/2017 04:24 AM, Stephen Boyd wrote:
>>> On 07/06, Vivek Gautam wrote:
>>>> @@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>>>>  static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>>>>  			     size_t size)
>>>>  {
>>>> -	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>>>> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>>>> +	size_t ret;
>>>>  	if (!ops)
>>>>  		return 0;
>>>> -	return ops->unmap(ops, iova, size);
>>>> +	pm_runtime_get_sync(smmu_domain->smmu->dev);
>>> Can these map/unmap ops be called from an atomic context? I seem
>>> to recall that being a problem before.
>>
>> That's something which was dropped in the following patch merged in master:
>> 523d7423e21b iommu/arm-smmu: Remove io-pgtable spinlock
>>
>> Looks like we don't  need locks here anymore?
>>
> 
> While removing the spinlock around the map/unmap path may be one
> thing, I'm not sure that's all of them. Is there a path from an
> atomic DMA allocation (GFP_ATOMIC sort of thing) mapped into an
> IOMMU for a device that can eventually get down to here and
> attempt to turn a clk on?

Yes, in the DMA path map/unmap will frequently be called from IRQ
handlers (think e.g. network packets). The whole point of removing the
lock was to allow multiple maps/unmaps to execute in parallel (since we
know they will be safely operating on different areas of the pagetable).
AFAICS this change is going to largely reintroduce that bottleneck via
dev->power_lock, which is anything but what we want :(

Robin.
