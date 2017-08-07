From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
Date: Mon, 7 Aug 2017 08:29:59 -0400
Message-ID: <CAF6AEGsw2=nERuJ8UCBr_kTBS0TigaA9LL1Hxw3JmNiu4oycOA@mail.gmail.com>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-4-git-send-email-vivek.gautam@codeaurora.org>
 <20170712225459.GZ22780@codeaurora.org> <5ee0bacd-e557-a6c4-a897-844fb12ea6ae@codeaurora.org>
 <4dbc938c-ac88-9bd4-cf00-458008ae24c1@codeaurora.org> <CAF6AEGsFOtsOjt1sLNPSFLEcu-7d1zxCOhTeC+P8e0TDbb1dSA@mail.gmail.com>
 <CAFp+6iH-WR4gNExaOBfnwy7GG7DXrjdytPvnMHNmo64YQZdQWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iH-WR4gNExaOBfnwy7GG7DXrjdytPvnMHNmo64YQZdQWQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Archit Taneja <architt@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 7, 2017 at 4:27 AM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> On Thu, Jul 13, 2017 at 5:20 PM, Rob Clark <robdclark@gmail.com> wrote:
>> On Thu, Jul 13, 2017 at 1:35 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>>> Hi Vivek,
>>>
>>> On 7/13/2017 10:43 AM, Vivek Gautam wrote:
>>>> Hi Stephen,
>>>>
>>>>
>>>> On 07/13/2017 04:24 AM, Stephen Boyd wrote:
>>>>> On 07/06, Vivek Gautam wrote:
>>>>>> @@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
>>>>>>   static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>>>>>>                    size_t size)
>>>>>>   {
>>>>>> -    struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>>>>>> +    struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>>>>> +    struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>>>>>> +    size_t ret;
>>>>>>         if (!ops)
>>>>>>           return 0;
>>>>>>   -    return ops->unmap(ops, iova, size);
>>>>>> +    pm_runtime_get_sync(smmu_domain->smmu->dev);
>>>>> Can these map/unmap ops be called from an atomic context? I seem
>>>>> to recall that being a problem before.
>>>>
>>>> That's something which was dropped in the following patch merged in master:
>>>> 523d7423e21b iommu/arm-smmu: Remove io-pgtable spinlock
>>>>
>>>> Looks like we don't  need locks here anymore?
>>>
>>>  Apart from the locking, wonder why a explicit pm_runtime is needed
>>>  from unmap. Somehow looks like some path in the master using that
>>>  should have enabled the pm ?
>>>
>>
>> Yes, there are a bunch of scenarios where unmap can happen with
>> disabled master (but not in atomic context).
>
> I would like to understand whether there is a situation where an unmap is
> called in atomic context without an enabled master?
>
> Let's say we have the case where all the unmap calls in atomic context happen
> only from the master's context (in which case the device link should
> take care of
> the pm state of smmu), and the only unmap that happen in non-atomic context
> is the one with master disabled. In such a case doesn it make sense to
> distinguish
> the atomic/non-atomic context and add pm_runtime_get_sync()/put_sync() only
> for the non-atomic context since that would be the one with master disabled.
>

At least drm/msm needs to hold obj->lock (a mutex) in unmap, so it
won't unmap anything in atomic ctx (but it can unmap w/ master
disabled).  I can't really comment about other non-gpu drivers.  It
seems like a reasonable constraint that either master is enabled or
not in atomic ctx.

Currently we actually wrap unmap w/ pm_runtime_get/put_sync(), but I'd
like to drop that to avoid powering up the gpu.

BR,
-R
