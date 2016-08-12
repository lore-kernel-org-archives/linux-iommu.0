From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 2/2] iommu/msm: wire up fault handling
Date: Fri, 12 Aug 2016 12:39:31 -0400
Message-ID: <CAF6AEGvLmdNmwbwUzPuEymfTkBGQz2oA2139oo5KV3B3W7X5Jg@mail.gmail.com>
References: <1471015747-569-1-git-send-email-robdclark@gmail.com>
 <1471015747-569-2-git-send-email-robdclark@gmail.com> <001201d1f4b5$04810fc0$0d832f40$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <001201d1f4b5$04810fc0$0d832f40$@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan <sricharan@codeaurora.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 12, 2016 at 12:17 PM, Sricharan <sricharan@codeaurora.org> wrote:
> Hi,
>
>>When things go wrong on the gpu, we can get *thousands* of faults.  With
>>so many pr_err() prints, which were slowing down resuming the iommu,
>>drm/msm would think the GPU had actually hung and reset it.
>>
>>Wire up the fault reporting, so instead we get a small ratelimited print
>>of the fault address from drm/msm's fault handler instead.
>>
>>Signed-off-by: Rob Clark <robdclark@gmail.com>
>>---
>> drivers/iommu/msm_iommu.c | 16 +++++++++++-----
>> drivers/iommu/msm_iommu.h |  3 +++
>> 2 files changed, 14 insertions(+), 5 deletions(-)
>>
>>diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>>index f6f596f..1110b72 100644
>>--- a/drivers/iommu/msm_iommu.c
>>+++ b/drivers/iommu/msm_iommu.c
>>@@ -411,6 +411,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>                       }
>>                       __disable_clocks(iommu);
>>                       list_add(&iommu->dom_node, &priv->list_attached);
>>+                      iommu->domain = domain;
>>               }
>>       }
>>
>>@@ -614,8 +615,8 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>>               goto fail;
>>       }
>>
>>-      pr_err("Unexpected IOMMU page fault!\n");
>>-      pr_err("base = %08x\n", (unsigned int)iommu->base);
>>+      pr_debug("Unexpected IOMMU page fault!\n");
>
>               So was just thinking if its better to have only this as a ratelimited print,
>               for global faults ?, otherwise

it is possibly a good idea to ratelimit the pr_err prints that get
printed when there is not a fault handler installed..  although in the
case there is a handler, I don't think we should print anything.  (At
least not unless DEBUG is defined.)

If we can actually resume the faulting memory transaction, then we
could use this to implement virtual memory for the GPU, like the HMM
stuff.. in order to use malloc'd memory with the gpu without having to
pin..

(I know we can resume future memory transactions, but not sure if we
can update iommu page tables and resume the transaction that triggered
the fault..)

BR,
-R

>                 Reviewed-by: sricharan@codeaurora.org
>
> Regards,
>  Sricharan
>
>
>
