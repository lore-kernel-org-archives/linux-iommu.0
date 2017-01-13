From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 5/5] ARM: dts: mt2701: add iommu/smi dtsi node for
 mt2701
Date: Fri, 13 Jan 2017 15:54:20 +0100
Message-ID: <5a45da57-9262-b1ff-1c6a-c5c211c1bfd4@gmail.com>
References: <1465379461-14757-1-git-send-email-honghui.zhang@mediatek.com>
 <1465379461-14757-6-git-send-email-honghui.zhang@mediatek.com>
 <09eaf7a5-2b18-1ea6-5699-2e968c6b79a4@gmail.com>
 <51441f39-e5b5-2cce-63ab-47bd3cf298b3@gmail.com>
 <1467595950.8420.2.camel@mtksdaap41> <577A1794.5040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <577A1794.5040509-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 04/07/16 10:00, Matthias Brugger wrote:
>
>
> On 04/07/16 03:32, Honghui Zhang wrote:
>> On Sun, 2016-07-03 at 21:12 +0200, Matthias Brugger wrote:
>>>
>>> On 07/03/2016 08:24 AM, Matthias Brugger wrote:
>>>>
>>>>
>>>> On 06/08/2016 11:51 AM, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
>>>>> From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>>>>
>>>>> Add the dtsi node of iommu and smi for mt2701.
>>>>>
>>>>> Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>>>>> ---
>>>>>   arch/arm/boot/dts/mt2701.dtsi | 51
>>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>>   1 file changed, 51 insertions(+)
>>>>>
>>>>
>>>> Applied,
>>>
>>> Please resend the patch including the infracfg and mmsys node.
>>>
>>
>> Hi, Matthias,
>>
>> Please hold this one.
>> This one is based on CCF "arm: dts: mt2701: Add clock controller device
>> nodes"[1] and power domain patch "Mediatek MT2701 SCPSYS power domain
>> support v7"[2],
>> But these two patchset are still being reviewed now.
>>
>> Do you think it's better that I send this one later after ccf and power
>> domain patch got merged? I will send this patch later if it's OK with
>> you.
>>
>
> Sounds good.

Applied now to v4.10-next/dts32

Thanks.

>
> Thanks a lot,
> Matthias
>
>> Thanks.
>> [1] https://patchwork.kernel.org/patch/9109081
>> [2]
>> http://lists.infradead.org/pipermail/linux-mediatek/2016-May/005429.html
>>
>>> Regards,
>>> Matthias
>>>
>>>>
>>>> Thanks.
>>>>
>>>>> diff --git a/arch/arm/boot/dts/mt2701.dtsi
>>>>> b/arch/arm/boot/dts/mt2701.dtsi
>>>>> index 42d5a37..363de0d 100644
>>>>> --- a/arch/arm/boot/dts/mt2701.dtsi
>>>>> +++ b/arch/arm/boot/dts/mt2701.dtsi
>>>>> @@ -16,6 +16,7 @@
>>>>>   #include <dt-bindings/power/mt2701-power.h>
>>>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +#include <dt-bindings/memory/mt2701-larb-port.h>
>>>>>   #include "skeleton64.dtsi"
>>>>>   #include "mt2701-pinfunc.h"
>>>>>
>>>>> @@ -160,6 +161,16 @@
>>>>>           clock-names = "system-clk", "rtc-clk";
>>>>>       };
>>>>>
>>>>> +    smi_common: smi@1000c000 {
>>>>> +        compatible = "mediatek,mt2701-smi-common";
>>>>> +        reg = <0 0x1000c000 0 0x1000>;
>>>>> +        clocks = <&infracfg CLK_INFRA_SMI>,
>>>>> +             <&mmsys CLK_MM_SMI_COMMON>,
>>>>> +             <&infracfg CLK_INFRA_SMI>;
>>>>> +        clock-names = "apb", "smi", "async";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>>>>> +    };
>>>>> +
>>>>>       sysirq: interrupt-controller@10200100 {
>>>>>           compatible = "mediatek,mt2701-sysirq",
>>>>>                    "mediatek,mt6577-sysirq";
>>>>> @@ -169,6 +180,16 @@
>>>>>           reg = <0 0x10200100 0 0x1c>;
>>>>>       };
>>>>>
>>>>> +    iommu: mmsys_iommu@10205000 {
>>>>> +        compatible = "mediatek,mt2701-m4u";
>>>>> +        reg = <0 0x10205000 0 0x1000>;
>>>>> +        interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>;
>>>>> +        clocks = <&infracfg CLK_INFRA_M4U>;
>>>>> +        clock-names = "bclk";
>>>>> +        mediatek,larbs = <&larb0 &larb1 &larb2>;
>>>>> +        #iommu-cells = <1>;
>>>>> +    };
>>>>> +
>>>>>       apmixedsys: syscon@10209000 {
>>>>>           compatible = "mediatek,mt2701-apmixedsys", "syscon";
>>>>>           reg = <0 0x10209000 0 0x1000>;
>>>>> @@ -234,6 +255,16 @@
>>>>>           status = "disabled";
>>>>>       };
>>>>>
>>>>> +    larb0: larb@14010000 {
>>>>> +        compatible = "mediatek,mt2701-smi-larb";
>>>>> +        reg = <0 0x14010000 0 0x1000>;
>>>>> +        mediatek,smi = <&smi_common>;
>>>>> +        clocks = <&mmsys CLK_MM_SMI_LARB0>,
>>>>> +             <&mmsys CLK_MM_SMI_LARB0>;
>>>>> +        clock-names = "apb", "smi";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
>>>>> +    };
>>>>> +
>>>>>       imgsys: syscon@15000000 {
>>>>>           compatible = "mediatek,mt2701-imgsys", "syscon";
>>>>>           reg = <0 0x15000000 0 0x1000>;
>>>>> @@ -241,6 +272,16 @@
>>>>>           status = "disabled";
>>>>>       };
>>>>>
>>>>> +    larb2: larb@15001000 {
>>>>> +        compatible = "mediatek,mt2701-smi-larb";
>>>>> +        reg = <0 0x15001000 0 0x1000>;
>>>>> +        mediatek,smi = <&smi_common>;
>>>>> +        clocks = <&imgsys CLK_IMG_SMI_COMM>,
>>>>> +             <&imgsys CLK_IMG_SMI_COMM>;
>>>>> +        clock-names = "apb", "smi";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
>>>>> +    };
>>>>> +
>>>>>       vdecsys: syscon@16000000 {
>>>>>           compatible = "mediatek,mt2701-vdecsys", "syscon";
>>>>>           reg = <0 0x16000000 0 0x1000>;
>>>>> @@ -248,6 +289,16 @@
>>>>>           status = "disabled";
>>>>>       };
>>>>>
>>>>> +    larb1: larb@16010000 {
>>>>> +        compatible = "mediatek,mt2701-smi-larb";
>>>>> +        reg = <0 0x16010000 0 0x1000>;
>>>>> +        mediatek,smi = <&smi_common>;
>>>>> +        clocks = <&vdecsys CLK_VDEC_CKGEN>,
>>>>> +             <&vdecsys CLK_VDEC_LARB>;
>>>>> +        clock-names = "apb", "smi";
>>>>> +        power-domains = <&scpsys MT2701_POWER_DOMAIN_VDEC>;
>>>>> +    };
>>>>> +
>>>>>       hifsys: syscon@1a000000 {
>>>>>           compatible = "mediatek,mt2701-hifsys", "syscon";
>>>>>           reg = <0 0x1a000000 0 0x1000>;
>>>>>
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
