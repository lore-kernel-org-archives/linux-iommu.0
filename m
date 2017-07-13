From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Thu, 13 Jul 2017 08:10:22 -0400
Message-ID: <CAF6AEGsfDewRUHLUbFKT1Q+8U2BkmFMHo4ZBSwSGspU3ktUY8g@mail.gmail.com>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-4-git-send-email-vivek.gautam@codeaurora.org>
 <20170712225459.GZ22780@codeaurora.org> <5ee0bacd-e557-a6c4-a897-844fb12ea6ae@codeaurora.org>
 <4dbc938c-ac88-9bd4-cf00-458008ae24c1@codeaurora.org> <CGME20170713115036epcas1p250113e9009dbf92487d258a90fffc66a@epcas1p2.samsung.com>
 <CAF6AEGsFOtsOjt1sLNPSFLEcu-7d1zxCOhTeC+P8e0TDbb1dSA@mail.gmail.com> <939f8745-6f72-522c-1216-70e424740b62@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <939f8745-6f72-522c-1216-70e424740b62@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sricharan R <sricharan@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Archit Taneja <architt@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 13, 2017 at 8:02 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi All,
>
> On 2017-07-13 13:50, Rob Clark wrote:
>>
>> On Thu, Jul 13, 2017 at 1:35 AM, Sricharan R <sricharan@codeaurora.org>
>> wrote:
>>>
>>> On 7/13/2017 10:43 AM, Vivek Gautam wrote:
>>>>
>>>> On 07/13/2017 04:24 AM, Stephen Boyd wrote:
>>>>>
>>>>> On 07/06, Vivek Gautam wrote:
>>>>>>
>>>>>> @@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct iommu_domain
>>>>>> *domain, unsigned long iova,
>>>>>>    static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned
>>>>>> long iova,
>>>>>>                     size_t size)
>>>>>>    {
>>>>>> -    struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>>>>>> +    struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>>> +    struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>>>>>> +    size_t ret;
>>>>>>          if (!ops)
>>>>>>            return 0;
>>>>>>    -    return ops->unmap(ops, iova, size);
>>>>>> +    pm_runtime_get_sync(smmu_domain->smmu->dev);
>>>>>
>>>>> Can these map/unmap ops be called from an atomic context? I seem
>>>>> to recall that being a problem before.
>>>>
>>>> That's something which was dropped in the following patch merged in
>>>> master:
>>>> 523d7423e21b iommu/arm-smmu: Remove io-pgtable spinlock
>>>>
>>>> Looks like we don't  need locks here anymore?
>>>
>>>   Apart from the locking, wonder why a explicit pm_runtime is needed
>>>   from unmap. Somehow looks like some path in the master using that
>>>   should have enabled the pm ?
>>>
>> Yes, there are a bunch of scenarios where unmap can happen with
>> disabled master (but not in atomic context).  On the gpu side we
>> opportunistically keep a buffer mapping until the buffer is freed
>> (which can happen after gpu is disabled).  Likewise, v4l2 won't unmap
>> an exported dmabuf while some other driver holds a reference to it
>> (which can be dropped when the v4l2 device is suspended).
>>
>> Since unmap triggers tbl flush which touches iommu regs, the iommu
>> driver *definitely* needs a pm_runtime_get_sync().
>
>
> Afair unmap might be called from atomic context as well, for example as
> a result of dma_unmap_page(). In exynos IOMMU I simply check the runtime
> PM state of IOMMU device. TLB flush is performed only when IOMMU is in
> active
> state. If it is suspended, I assume that the IOMMU controller's context
> is already lost and its respective power domain might be already turned off,
> so there is no point in touching IOMMU registers.
>

that seems like an interesting approach.. although I wonder if there
can be some race w/ new device memory access once clks are enabled
before tlb flush completes?  That would be rather bad, since this
approach is letting the backing pages of memory be freed before tlb
flush.

BR,
-R
