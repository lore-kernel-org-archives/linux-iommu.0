From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings support
Date: Fri, 12 Aug 2016 12:30:03 +0530
Message-ID: <003a01d1f467$2b180ba0$814822e0$@codeaurora.org>
References: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org> <CAF6AEGsF5M1sfwaXKW0x=Mu=nQJR-9+xqrtXd=7Vz_+6G_u25A@mail.gmail.com> <CAF6AEGsLGDqRuB97+qN1g7X60A49Wv1HGbAiaeZoxogMmHY9HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAF6AEGsLGDqRuB97+qN1g7X60A49Wv1HGbAiaeZoxogMmHY9HA@mail.gmail.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Rob Clark' <robdclark@gmail.com>
Cc: devicetree@vger.kernel.org, 'linux-arm-msm' <linux-arm-msm@vger.kernel.org>, 'Joerg Roedel' <joro@8bytes.org>, iommu@lists.linux-foundation.org, 'Srinivas Kandagatla' <srinivas.kandagatla@linaro.org>, 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, 'Thierry Reding' <treding@nvidia.com>, 'Robin Murphy' <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org, 'Archit Taneja' <architt@codeaurora.org>, 'Arnd Bergmann' <arnd@arndb.de>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

>> btw, the current state, at least on linaro integration branch, fault
>> handling doesn't work so well (ie. device never gets resumed).. which
>> is a bit unfortunate for a gpu (and results in a *lot* of rebooting on
>> my part when debugging userspace).  I haven't had time yet to compare
>> to the ancient downstream driver, but not sure if you have any ideas?
>>
>> I guess probably disabling stall on fault would help.  But I'm not
>> even getting the "Fault occurred in context.." prints.  Seeing the
>> fault iova is pretty useful since that plus gpu cmdstream trace helps
>> me figure out which texture/etc is being accessed out of bounds.
>
>fyi, it looks like it is not getting any fault irq..  it's *possible*
>that I screwed up the irq #'s when translating from downstream, so you
>might want to double check that.  I thought I had it right, I assume I
>would have noticed during piglit runs if fault recovery wasn't working
>(since the result is that *everything* after the faulting test would
>have failed since gpu is wedged with no access to memory), but it was
>long enough ago that I can't claim that definitively.
>
>If you need an easy way to trigger a gpu fault, msmtest is a good way,
>change this line:
>
>  https://github.com/freedreno/msmtest/blob/master/msmtest.c#L247
>
>from OUT_RELOC() to OUT_RING(ring, 0x00000000) will trigger a fault.
>
   So for the irq to be triggered, 'non-secure' irq line has to be
  populated in DT. There is a 'secure'and 'non-secure' irq lines for these iommus
  and  non-secure irq number is secure + 1. I tested this by having a 'return 0'
 from the msm_iommu_map (no mapping), and the faults were getting triggered.

  Can you share me your dts data ?


Regards,
 Sricharan
