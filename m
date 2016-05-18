From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V4 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Wed, 18 May 2016 17:37:40 +0530
Message-ID: <002c01d1b0fd$e4f3c350$aedb49f0$@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org> <1463381341-30498-7-git-send-email-sricharan@codeaurora.org> <3070591.xyl7SB8DB7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <3070591.xyl7SB8DB7@wuerfel>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, robdclark@gmail.com, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

>> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>> index f7b4c11..1240a5a 100644
>> --- a/drivers/iommu/msm_iommu.c
>> +++ b/drivers/iommu/msm_iommu.c
>> @@ -124,6 +124,7 @@ static void msm_iommu_reset(void __iomem *base, int ncb)
>>                 SET_TLBLKCR(base, ctx, 0);
>>                 SET_CONTEXTIDR(base, ctx, 0);
>>         }
>> +       mb(); /* sync */
>>  }
>>
>>  static void __flush_iotlb(void *cookie)
>> @@ -143,6 +144,7 @@ static void __flush_iotlb(void *cookie)
>>
>>                 __disable_clocks(iommu);
>>         }
>> +       mb(); /* sync */
>>  fail:
>>         return;
>>  }
>
>These comments are completely useless. What is the specific race
>that you are protecting against, and why are the implicit barriers
>not sufficient here? Please find a better way to document what
>is going on.
>

The reason for doing this was, when the tlb maintenance ops are called
by  io-pgtable functions, it expects that the tlb_range ops is complete
only after the tlb_sync callback is called. Previously we were using
writel and the sync in that case was dummy. Also previously every register
configuration write was done using writel,  which was an overkill. So now
we do all the writes with writel_relaxed  and a barrier in the end. I will
change the documentation for this.

>> diff --git a/drivers/iommu/msm_iommu_hw-8xxx.h b/drivers/iommu/msm_iommu_hw-8xxx.h
>> index 84ba5739..161036c 100644
>> --- a/drivers/iommu/msm_iommu_hw-8xxx.h
>> +++ b/drivers/iommu/msm_iommu_hw-8xxx.h
>> @@ -24,10 +24,10 @@
>>  #define GET_CTX_REG(reg, base, ctx) \
>>                                 (readl((base) + (reg) + ((ctx) << CTX_SHIFT)))
>>
>> -#define SET_GLOBAL_REG(reg, base, val) writel((val), ((base) + (reg)))
>> +#define SET_GLOBAL_REG(reg, base, val) writel_relaxed((val), ((base) + (reg)))
>>
>>  #define SET_CTX_REG(reg, base, ctx, val) \
>> -                       writel((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
>> +               writel_relaxed((val), ((base) + (reg) + ((ctx) << CTX_SHIFT)))
>>
>>  /* Wrappers for numbered registers */
>>  #define SET_GLOBAL_REG_N(b, n, r, v) SET_GLOBAL_REG(b, ((r) + (n << 2)), (v))
>> @@ -48,7 +48,8 @@
>>  #define SET_FIELD(addr, mask, shift, v) \
>>  do { \
>>         int t = readl(addr); \
>> -       writel((t & ~((mask) << (shift))) + (((v) & (mask)) << (shift)), addr);\
>> +       writel_relaxed((t & ~((mask) << (shift))) + \
>> +                      (((v) & (mask)) << (shift)), addr);\
>>  } while (0)
>
>No, please add a new macro for the relaxed accessors and then add comments
>in the places where those are used, to document why you can take shortcuts
>in those places.

Ok, will add a new accessor for this and comment them.

Regards,
 Sricharan
