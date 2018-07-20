From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
Date: Fri, 20 Jul 2018 13:56:18 +0530
Message-ID: <CAFp+6iGg=6Hhxj9-995ZzP=_09Y3kZoXthcyNpUqikHsn97uyg@mail.gmail.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-2-vivek.gautam@codeaurora.org> <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brown <david.brown@linaro.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

On Fri, Jul 20, 2018 at 4:38 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Jul 19, 2018 at 11:54 AM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>
>> Add device node for arm,mmu-500 available on sdm845.
>> This MMU-500 with single TCU and multiple TBU architecture
>> is shared among all the peripherals except gpu on sdm845.
>>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>>  2 files changed, 77 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> index 6d651f314193..13b50dff440f 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>> @@ -58,3 +58,7 @@
>>                 bias-pull-up;
>>         };
>>  };
>> +
>> +&apps_smmu {
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 00722b533a92..70ca18ae6cb3 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -980,6 +980,79 @@
>>                         cell-index = <0>;
>>                 };
>>
>> +               apps_smmu: arm,smmu@15000000 {
>
> iommu@...

Thanks for the review.
Sure, will modify this.

>
>> +                       compatible = "arm,mmu-500";
>
> Really unmodified by QCom? Would be better to have SoC specific compatible.

Yes, at this point we are able to use the driver as is on 845.
But, will add a SoC specific compatible as suggested to make bindings
future proof.

Best regards
Vivek

>
> Rob
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
