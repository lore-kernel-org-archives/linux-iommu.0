From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH] iommu/arm-smmu: Defer TLB flush in case of unmap op
Date: Mon, 7 Aug 2017 13:14:50 +0530
Message-ID: <CAFp+6iF=6W_X7Aq=Z4T+HuQT2x4sO+L3wCHuCOu8tQqK2QeTkQ@mail.gmail.com>
References: <CAFp+6iFfu2-qrDDim7fzKKLqMcSVMmOr7esqBZ-xEeLTOOTNLA@mail.gmail.com>
 <1501667598-16404-1-git-send-email-vivek.gautam@codeaurora.org>
 <35aeb7dd-4fe6-3175-2252-41c3c54873a9@arm.com> <d9cdeeee-36a9-40d4-457e-b1a865c3b83f@codeaurora.org>
 <fd13c041-7dd8-140b-1d02-36ff2bc3a633@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <fd13c041-7dd8-140b-1d02-36ff2bc3a633@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rob Clark <robdclark@gmail.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, robh+dt <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Sricharan R <sricharan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,


On Fri, Aug 4, 2017 at 10:34 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 03/08/17 06:35, Vivek Gautam wrote:
>> Hi Robin,
>>
>>
>>
>> On 08/02/2017 05:47 PM, Robin Murphy wrote:
>>> On 02/08/17 10:53, Vivek Gautam wrote:
>>>> We don't want to touch the TLB when smmu is suspended.
>>>> Defer it until resume.
>>>>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> ---
>>>>
>>>> Hi all,
>>>>
>>>> Here's the small patch in response of suggestion to defer tlb operations
>>>> when smmu is in suspend state.
>>>> The patch stores the TLB requests in 'unmap' when the smmu device is
>>>> suspended. On resume, it checks all the pending TLB requests, and
>>>> performs the unmap over those.
>>>>
>>>> Right now, I have applied the patch on top of the pm runtime series.
>>>> Let me know what you think of the change. It will also be helpful if
>>>> somebody can please test a valid use case with this.
>>> The patch itself doesn't make much sense to me, but more crucially it's
>>> definitely broken in concept. We can't return from arm_smmu_unmap()
>>> without having actually unmapped anything, because that leaves the page
>>> tables out of sync with what the caller expects - they may immmediately
>>> reuse that IOVA to map something else for a different device and hit an
>>> unexpected failure from io-pgtable when the PTE turns out to be
>>> non-empty.
>>
>> To understand things bit more,
>> once we don't *unmap* in arm_smmu_unmap(), and leave the TLBs as is,
>> the next mapping can happen only with the *knowledge* of smmu, i.e.,
>> smmu should be active at that time.
>> If that's true then, the _runtime()_resume() method will take care of
>> invalidating the TLBs when we call arm_smmu_unmap() from _runtime_resume().
>> Is my understanding correct here?
>
> What I mean is that it's OK for arm_smmu_unmap() to defer the physical
> TLB maintenance for an unmap request if the SMMU is suspended, but it
> *must* still update the pagetable so that the given address is logically
> unmapped before returning. In other words, the place to make decisions
> based on the SMMU PM state would be in the .tlb_add_flush and .tlb_sync
> callbacks, rather than at the top level.

Okay, i understand it better now.
.tlb_add_flush and .tlb_sync callbacks should be the right place.

>
>>> However, if in general suspend *might* power-gate any part of the SMMU,
>>> then I don't think we have any guarantee of what state any TLBs could be
>>> in upon resume. Therefore any individual invalidations we skip while
>>> suspended are probably moot, since resume would almost certainly have to
>>> invalidate everything to get back to a safe state anyway.
>>
>> Right, in case when the suspend power-gates the SMMU, then
>> the TLB context is lost anyways. So resume path can freshly start.
>> This is something that exynos does at present.
>
> Yes, in general I don't think we can assume any SMMU state is preserved,
> so the only safe option would be for .runtime_resume to do the same
> thing as .resume, which does at least make things nice and simple.

Let me try to find out more about the state of TLBs. As far as the
programmable registers are concerned, qcom platforms have retention
enabled for them. So they don't loose state after SMMU power down.

>
>>> Conversely though, the situation that still concerns me is whether this
>>> can work at all for a distributed SMMU if things *don't* lose state. Say
>>> the GPU and its local TBU are in the same clock domain - if the GPU has
>>> just gone idle and we've clock-gated it, but "the SMMU" (i.e. the TCU)
>>> is still active servicing other devices, we will assume we can happily
>>> unmap GPU buffers and issue TLBIs, but what happens with entries held in
>>> the unclocked TBU's micro-TLB?
>>
>> We know of platforms we have that have shared TCU and multiple TBUs.
>> Each TBU is available in its own power domain, not in master's power
>> domain.
>> In such cases we may want to runtime_get() the TBUs, so that unmap()
>> call with
>> master clock gated gets through.
>>
>> Can we have a situation where the TBU and master are in the same power
>> domain, and the unmap is called when the master is not runtime active?
>> How will such a situation be handled?
>
> Having thought about it a bit more, I think the
> unmap-after-master-suspended case is only one facet of the problem - if
> we can power down individual TBUs/micro-TLBs without suspending the rest
> of the SMMU, do we also have any guarantee that such TLBs don't power
> back on full of valid-looking random junk?
>
> I'm starting to think the only way to be generally safe would be to
> globally invalidate all TLBs after any *master* is resumed, and I'm not
> even sure that's feasible :/
>
> Robin.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


regards
Vivek

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
