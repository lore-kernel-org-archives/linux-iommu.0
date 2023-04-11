Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C009457
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 19:50:49 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id a23so12371007lfk.4
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681242648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOaG+PaHenUckG/HmcCcVyiFAGvfVYsjP1gKXvLt2sQ=;
        b=J0q5NPXG+H8BAby7O6g2YcHLXCo4+0dRypQpWSlXYUf+22+ThYj80nRh2c8dF1kJML
         IUa0sk0CdVDCwCUwM3S/6+gTywNXhZC/4AwMpUmlHvRq5oPuPgDYBdVtlinYO3yzCGVn
         x9XpoURBuY/TWj5m22OI30xpNyADp6YqQCRN/dHpSbTO4m81KLIFTcUyuw4mQZ6b6kmU
         b0O6+rbhEiOOcFRCwK90/mcG1eGnNpNudTmjtASHmMj+CQozJbHSdF0z6OZdJpjAMiqe
         LxmhynN6wwyo6HiW8+5PoEyg74eUy6t5F88TaRf31eSIgtCg5EERBaplLTAKffnhViYn
         52nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681242648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOaG+PaHenUckG/HmcCcVyiFAGvfVYsjP1gKXvLt2sQ=;
        b=Mf3oE2Ohgbb5q+xOMCE8gkbRtXCDF3O3gLc2G8fA4XLwxxHzao4G13UKIOR+dZRxaE
         jDH5ww/RIFcALUfg+gZP/0w3VOlRoUkxQYDzqwdWJ5i5HHkpms63iZO+D68YjbtENWD4
         HGXRETeEHjFepdZKRdfBiR5+G+uwBpO0CvVgbmBpFH3SEqMhH6f1AUiBOnxTrMKDjzRy
         qn8UrsKzLBGwkFVp5UjaXtOSZclmkfV/ylQUdzAluG+uJqTQx5Uf0tegTazAarYeKF/R
         InemyB9D2lSQnTRMLNB+HgaoxRZm0xWBnu8rXgNQ1vTDfrGbbjTnif6tCkgSVyVuqAnT
         Y0uA==
X-Gm-Message-State: AAQBX9fUd1o5aAXQSMBaJRe3y/SsS4WKFBV0x0dxgdsd6Bg48AySUonq
	nTrM4FHqGXHCVRnBkTD2kNlNeA==
X-Google-Smtp-Source: AKy350aYtghLr2w5tKRLDF4OjwB0D514YZIPVY+ttfl5WYaiNDwkx4YnlL0vMDYjUsFepxoQsC4mCw==
X-Received: by 2002:a05:6512:3b2a:b0:4d8:86c1:477d with SMTP id f42-20020a0565123b2a00b004d886c1477dmr98465lfv.18.1681242647825;
        Tue, 11 Apr 2023 12:50:47 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id b7-20020ac24107000000b004e9b307d2c8sm2656277lfi.238.2023.04.11.12.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:50:47 -0700 (PDT)
Message-ID: <923fb538-a28a-2172-569f-b58349157d49@linaro.org>
Date: Tue, 11 Apr 2023 21:50:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sa8775p: add the GPU IOMMU node
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230411125910.401075-1-brgl@bgdev.pl>
 <20230411125910.401075-8-brgl@bgdev.pl>
 <6c75d434-bb5d-278f-a125-d096fd6b387d@linaro.org>
 <CAMRc=MdLckYzUjDQzbNUaaviuABEDXcs0ctW6+-3fZiCbvfYQA@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAMRc=MdLckYzUjDQzbNUaaviuABEDXcs0ctW6+-3fZiCbvfYQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11.04.2023 16:41, Bartosz Golaszewski wrote:
> On Tue, Apr 11, 2023 at 3:16 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 11.04.2023 14:59, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add the Adreno GPU IOMMU for sa8775p-based platforms.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 37 +++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> index 191b510b5a1a..11f3d80dd869 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> @@ -7,6 +7,7 @@
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/clock/qcom,rpmh.h>
>>>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>>> +#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>>>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> @@ -605,6 +606,42 @@ gpucc: clock-controller@3d90000 {
>>>                       #power-domain-cells = <1>;
>>>               };
>>>
>>> +             adreno_smmu: iommu@3da0000 {
>>> +                     compatible = "qcom,sa8775p-smmu-500", "qcom,adreno-smmu",
>>> +                                  "arm,mmu-500";
>> Err.. does it even boot like this? You dropped the qcom,smmu-500 compatible
>> which means it's getting bound to the generic SMMU driver (without
>> QC quirks). If that was a mistake, you should have had all 4
>>
>> "qcom,sa8775p-smmu-500", qcom,adreno-smmu, "qcom,smmu-500", "arm,mmu-500"
>>
>> Without falling into the qc-specific codepaths, the Adreno compat does
>> nothing.
>>
> 
> I did that initially, then noticed dtbs_check fails because the
> existing adreno GPUs implementing "arm,smmu-500" expect three
> compatibles like in this commit. I did that and the driver still
> probed the same so I assumed all's good. You're right of course, the
> adreno impl is not being assigned without "qcom,smmu-500". Are the
> bindings wrong in this case and should it be something like the
> following?
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index d966dc65ce10..cd1b052a7242 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -84,6 +84,7 @@ properties:
>                - qcom,sm8150-smmu-500
>                - qcom,sm8250-smmu-500
>            - const: qcom,adreno-smmu
> +          - const: qcom,smmu-500
>            - const: arm,mmu-500
>        - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
>          items:
> 
> Bartosz
Check

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-joerg/arm-smmu/bindings&id=5c3686616b1840b3143b227eb58fb1c1621d204e

Konrad
> 
>> Konrad
>>> +                     reg = <0x0 0x03da0000 0x0 0x20000>;
>>> +                     #iommu-cells = <2>;
>>> +                     #global-interrupts = <2>;
>>> +                     dma-coherent;
>>> +                     power-domains = <&gpucc GPU_CC_CX_GDSC>;
>>> +                     clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
>>> +                              <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
>>> +                              <&gpucc GPU_CC_AHB_CLK>,
>>> +                              <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
>>> +                              <&gpucc GPU_CC_CX_GMU_CLK>,
>>> +                              <&gpucc GPU_CC_HUB_CX_INT_CLK>,
>>> +                              <&gpucc GPU_CC_HUB_AON_CLK>;
>>> +                     clock-names = "gcc_gpu_memnoc_gfx_clk",
>>> +                                   "gcc_gpu_snoc_dvm_gfx_clk",
>>> +                                   "gpu_cc_ahb_clk",
>>> +                                   "gpu_cc_hlos1_vote_gpu_smmu_clk",
>>> +                                   "gpu_cc_cx_gmu_clk",
>>> +                                   "gpu_cc_hub_cx_int_clk",
>>> +                                   "gpu_cc_hub_aon_clk";
>>> +                     interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
>>> +             };
>>> +
>>>               pdc: interrupt-controller@b220000 {
>>>                       compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>>>                       reg = <0x0 0x0b220000 0x0 0x30000>,
