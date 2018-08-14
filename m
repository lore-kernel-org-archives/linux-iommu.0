From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
Date: Tue, 14 Aug 2018 17:54:50 +0530
Message-ID: <ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814114009.GF28664@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180814114009.GF28664@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: joro@8bytes.org, andy.gross@linaro.org, robin.murphy@arm.com, bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org, mark.rutland@arm.com, david.brown@linaro.org, tfiga@chromium.org, swboyd@chromium.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robdclark@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Will,


On 8/14/2018 5:10 PM, Will Deacon wrote:
> Hi Vivek,
>
> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
>> Qcom's implementation of arm,mmu-500 on sdm845 has a functional/performance
>> errata [1] because of which the TCU cache look ups are stalled during
>> invalidation cycle. This is mitigated by serializing all the invalidation
>> requests coming to the smmu.
> How does this implementation differ from the one supported by qcom_iommu.c?
> I notice you're adding firmware hooks here, which we avoided by having the
> extra driver. Please help me understand which devices exist, how they
> differ, and which drivers are intended to support them!

IIRC, the qcom_iommu driver was intended to support the static context 
bank - SID
mapping, and is very specific to the smmu-v2 version present on msm8916 soc.
However, this is the qcom's mmu-500 implementation specific errata. 
qcom_iommu
will not be able to support mmu-500 configurations.
Rob Clark can add more.
Let you know what you suggest.

>
> Also -- you didn't CC all the maintainers for the firmware bits, so adding
> Andy here for that, and Rob for the previous question.

I added Andy to the series, would you want me to add Rob H also?

Best regards
Vivek

>
> Thanks,
>
> Will
