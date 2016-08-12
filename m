From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings support
Date: Fri, 12 Aug 2016 20:46:40 +0530
Message-ID: <000701d1f4ac$8bb4f6e0$a31ee4a0$@codeaurora.org>
References: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org> <CAF6AEGsF5M1sfwaXKW0x=Mu=nQJR-9+xqrtXd=7Vz_+6G_u25A@mail.gmail.com> <CAF6AEGsLGDqRuB97+qN1g7X60A49Wv1HGbAiaeZoxogMmHY9HA@mail.gmail.com> <003a01d1f467$2b180ba0$814822e0$@codeaurora.org> <CAF6AEGsRVULNpSe_s460biNhV0dRaKLv6tf2Y244HEjGVOV3bw@mail.gmail.com> <000001d1f499$fe2caf50$fa860df0$@codeaurora.org> <CAF6AEGuitSWt9dhXrMfBDqAkXzpZObuj6A_8XxL+TVSWnbkwaQ@mail.gmail.com> <000501d1f4a0$325f0dd0$971d2970$@codeaurora.org> <CAF6AEGuagnVu_cxkHB4vjBT_=XSpHyWAkKdB8=++z-FBnvMB3A@mail.gmail.com> <CAF6AEGs=m5qZJhBqBa90RS-1aO1zb3w_U=izF3MjyvMOPGSJ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAF6AEGs=m5qZJhBqBa90RS-1aO1zb3w_U=izF3MjyvMOPGSJ+A@mail.gmail.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Rob Clark' <robdclark@gmail.com>
Cc: devicetree@vger.kernel.org, 'Archit Taneja' <architt@codeaurora.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'linux-arm-msm' <linux-arm-msm@vger.kernel.org>, 'Joerg Roedel' <joro@8bytes.org>, iommu@lists.linux-foundation.org, 'Srinivas Kandagatla' <srinivas.kandagatla@linaro.org>, 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, 'Thierry Reding' <treding@nvidia.com>, 'Robin Murphy' <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi,

>>>
>>>>>>>>> btw, the current state, at least on linaro integration branch, fault
>>>>>>>>> handling doesn't work so well (ie. device never gets resumed).. which
>>>>>>>>> is a bit unfortunate for a gpu (and results in a *lot* of rebooting on
>>>>>>>>> my part when debugging userspace).  I haven't had time yet to compare
>>>>>>>>> to the ancient downstream driver, but not sure if you have any ideas?
>>>>>>>>>
>>>>>>>>> I guess probably disabling stall on fault would help.  But I'm not
>>>>>>>>> even getting the "Fault occurred in context.." prints.  Seeing the
>>>>>>>>> fault iova is pretty useful since that plus gpu cmdstream trace helps
>>>>>>>>> me figure out which texture/etc is being accessed out of bounds.
>>>>>>>>
>>>>>>>>fyi, it looks like it is not getting any fault irq..  it's *possible*
>>>>>>>>that I screwed up the irq #'s when translating from downstream, so you
>>>>>>>>might want to double check that.  I thought I had it right, I assume I
>>>>>>>>would have noticed during piglit runs if fault recovery wasn't working
>>>>>>>>(since the result is that *everything* after the faulting test would
>>>>>>>>have failed since gpu is wedged with no access to memory), but it was
>>>>>>>>long enough ago that I can't claim that definitively.
>>>>>>>>
>>>>>>>>If you need an easy way to trigger a gpu fault, msmtest is a good way,
>>>>>>>>change this line:
>>>>>>>>
>>>>>>>>  https://github.com/freedreno/msmtest/blob/master/msmtest.c#L247
>>>>>>>>
>>>>>>>>from OUT_RELOC() to OUT_RING(ring, 0x00000000) will trigger a fault.
>>>>>>>>
>>>>>>>    So for the irq to be triggered, 'non-secure' irq line has to be
>>>>>>>   populated in DT. There is a 'secure'and 'non-secure' irq lines for these iommus
>>>>>>>   and  non-secure irq number is secure + 1. I tested this by having a 'return 0'
>>>>>>>  from the msm_iommu_map (no mapping), and the faults were getting triggered.
>>>>>>>
>>>>>>>   Can you share me your dts data ?
>>>>>>>
>>>>>>
>>>>>>I think this is what you want:
>>>>>>
>>>>>>https://github.com/freedreno/kernel-msm/blob/integration-linux-qcomlt/arch/arm/boot/dts/qcom-apq8064.dtsi#L2008
>>>>>>
>>>>>>I haven't tested a display fault, so I suppose it is possible that
>>>>>>irq's are working for some iommu instances but not others?
>>>>>
>>>>> So in your DT, for gfx3d, the non-secure line is '70' and not '69' (This is secure) .
>>>>>  Infact only '70' should be populated. The driver sets the irq line based on resource 0.
>>>>>  This applies for all iommu nodes in your DT. (only the second irq line is needed).
>>>>
>>>>ahh, that would explain.
>>>>
>>>>Is it better to remove the extra entry, or should I just swap them
>>>>all?  Ie. might there be some point in the future where the driver
>>>>would want both?
>>>     I feel better to have one. Not sure why the secure irq was added in first
>>>     place in the downstream data and it would setup/handled by the TZ
>>
>> Ok, getting further.. still seems like the gpu is not getting resumed,
>> but at least we are getting a fault interrupt..
>
>
>ok, seems like we need:
>
>-------
>diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>index b09692b..f6f596f 100644
>--- a/drivers/iommu/msm_iommu.c
>+++ b/drivers/iommu/msm_iommu.c
>@@ -628,6 +628,7 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>             pr_err("Interesting registers:\n");
>             print_ctx_regs(iommu->base, i);
>             SET_FSR(iommu->base, i, 0x4000000F);
>+            SET_RESUME(iommu->base, i, 1);
>         }
    ok, ya this is required for disabling the stall.
    I can send a patch to change this.

>     }
>     __disable_clocks(iommu);
>-------
>
>with that it seems like it kinda/mostly recovers, although there is
>still a bit of strangeness..
  hmm ok, can test it and check something particular ?

Regards,
 Sricharan
   
