From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu: Defer TLB flush in case of unmap
 op
Date: Fri, 13 Oct 2017 20:08:19 +0100
Message-ID: <20171013190819.GE30572@arm.com>
References: <CAFp+6iF=6W_X7Aq=Z4T+HuQT2x4sO+L3wCHuCOu8tQqK2QeTkQ@mail.gmail.com>
 <1504676255-15980-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504676255-15980-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: robin.murphy@arm.com, robdclark@gmail.com, stanimir.varbanov@linaro.org, sboyd@codeaurora.org, sricharan@codeaurora.org, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 06, 2017 at 11:07:35AM +0530, Vivek Gautam wrote:
> We don't want to touch the TLB when smmu is suspended, so
> defer the TLB maintenance until smmu is resumed.
> On resume, we issue arm_smmu_device_reset() to restore the
> configuration and flush the TLBs.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
> 
> Hi Robin,
> 
> This patch comes after the discussion[1] we had about defering the
> physical TLB maintenance for an unmap request if the SMMU is
> suspended. Sorry for the delay in sending the updated version
> of the patch.
> 
> As discussed, this patch now checks the PM state of smmu in
> .tlb_add_flush and .tlb_sync page-table ops and return if smmu
> is suspended. On resume without assuming that the TLBs state is
> preserved, we issue a arm_smmu_device_reset() which is the safest
> thing to do.
> 
> Alternatively, without going into the TLB defer thing, we can simply
> avoid calling pm_runtime_get/put() in case of atomic context, as we
> discussed in the other thread[3]. This will look something like this:
> 
>       static size_t arm_smmu_unmap(struct iommu_domain *domain, ....)
>       {
>       <snip>
> 
>      -       return ops->unmap(ops, iova, size);
>      +       if (!in_atomic())
>      +              pm_runtime_get_sync(smmu_domain->smmu->dev);
>      +       ret = ops->unmap(ops, iova, size);
>      +       if (!in_atomic())
>      +              pm_runtime_put_sync(smmu_domain->smmu->dev);
>      +
>      +       return ret;
>       }
> 
> Let me know which approach should work.
> 
> One other concern that we were discussing was of distributed SMMU
> configuration.
> "Say the GPU and its local TBU are in the same clock domain - if the GPU has
> just gone idle and we've clock-gated it, but "the SMMU" (i.e. the TCU)
> is still active servicing other devices, we will assume we can happily
> unmap GPU buffers and issue TLBIs, but what happens with entries held in
> the unclocked TBU's micro-TLB?"
> 
> In such scenerio, when master is clock gated and TCU is still running:
>  -> If TCU and TBU are in same clock/power domain, then we can still
>     issue TLBIs as long as the smmu is clocked.
>  -> If TCU and TBU are in separate clock/power domains, then we better
>     check the power state for TBUs and defer TLB maintenance if TBUs are
>     clock gated.
>     In such scenerio will it make sense to represent a distributed smmu
>     as TCU device with multiple TBU child devices?

This is one of the cases that *really* worries me, particular if we can
end up freeing parts of the page table before the TLB maintenance has
been completed. Speculative table walks from the TCU could lead to all
sorts of horribly system behaviour, such as deadlock and/or data
corruption so I'm really not happy with this approach.

Will
