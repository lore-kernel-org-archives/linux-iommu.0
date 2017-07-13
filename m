From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH V4 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu, 13 Jul 2017 09:27:44 +0530
Message-ID: <a370a10d-a526-373d-e23c-366090e22718@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-3-git-send-email-vivek.gautam@codeaurora.org>
 <20170712225821.GB22780@codeaurora.org>
 <20170712230152.GC22780@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170712230152.GC22780@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, m.szyprowski@samsung.com, robdclark@gmail.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org, stanimir.varbanov@linaro.org, architt@codeaurora.org, linux-arm-kernel@lists.infradead.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: iommu@lists.linux-foundation.org



On 07/13/2017 04:31 AM, Stephen Boyd wrote:
> On 07/12, Stephen Boyd wrote:
>> On 07/06, Vivek Gautam wrote:
>>> From: Sricharan R <sricharan@codeaurora.org>
>>>
>>> The smmu needs to be functional only when the respective
>>> master's using it are active. The device_link feature
>>> helps to track such functional dependencies, so that the
>>> iommu gets powered when the master device enables itself
>>> using pm_runtime. So by adapting the smmu driver for
>>> runtime pm, above said dependency can be addressed.
>>>
>>> This patch adds the pm runtime/sleep callbacks to the
>>> driver and also the functions to parse the smmu clocks
>>> from DT and enable them in resume/suspend.
>>>
>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>>> [vivek: Clock rework to loop over clock names data]
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> ---
>> General comment, we have a bulk clk API now, but I guess we
>> failed to add the clk_bulk_prepare_enable() API that could be
>> used here. Perhaps you can add that API and then use it here to
>> reduce lines of code.

Sure, will use the bulk clock APIs to handle the clocks.

Best regards
Vivek

>>
> Bjorn just sent a patch for that API an hour ago.
>

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
