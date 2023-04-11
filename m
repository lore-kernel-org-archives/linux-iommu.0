Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969968C0D
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 13:16:24 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id e11so10303786lfc.10
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681218982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcUTTOUcMW0dZnIqgtsXXko3U+fcNkeoSkY3ZJOPmXE=;
        b=LYUd4gN0uvXVwbiLe+XaMSfZYrd+SwcY14tzEW5bLYbnCvbOjB/IB4sP6F1LfgFC7q
         BSefua8JuXbOq7EDzM3b9LBcTQGaMqZAjneiOHp8G/rdIR43GAt4B6ZchiceXSFwWa07
         xv+hX5RZbZpq5DoIIPl9x5aHvqBhYh1TbFKpe0gKwjKLVQcy+A+Yp6MCFft43Xuzk53a
         8TBiENf2cer2zEgRynfAzy+gC6VszB9hwZCbV6aJjdGuQcA9Z1XfpgeNHciFodlwRcBr
         HHzjrhwHuXKETo6CNUblAQs9jRzsoD8XM6zqjI7vlCIFUY2AqEi0T1Lx3sRC3Bk1szZ0
         /eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcUTTOUcMW0dZnIqgtsXXko3U+fcNkeoSkY3ZJOPmXE=;
        b=4FFDBbWLPEggKtwplsMQZv8q39aZ8crqmiojYoK9fsvlC89lheo470hSX0z33ux9x+
         uBnD042589oqmpEM6zelkpCru3IUA2EI6PorzOuhXztJPV6f8OyIWrOv94gnhg5v2CGl
         XcCihf+Bt4lLJSLMm8FFKd+iL8QMP3crUKPB5LnoiQ/1/9Kak9UMCjv/T/gNHfHmse/e
         fN3Zi2hlvAAvnc7PECAkfXfgKgYuli6a/ogxMVm3P3N68IDGqtPATtt/4DjVuJT+o9/8
         JKuwylDjC+sWghmhn9yq93A4G+qYo1orxJ8PDtIQX71TrL76orQa/s/gE353l/+Xyd5b
         J2LA==
X-Gm-Message-State: AAQBX9eV7gOYeXwwsQnStaJtifpBtSIbOqKPbFperv5LMOYMX8WxYQnu
	PIqJG6ypKrigMkR4ChVHy/HSWw==
X-Google-Smtp-Source: AKy350blhLpXLllc5IUc17Ff5DabLr3YrfUjg7JsGcKpnIEbMfXx9pu1SF8NEN24gpwptlidkj7IFg==
X-Received: by 2002:ac2:414a:0:b0:4d5:978e:8bcf with SMTP id c10-20020ac2414a000000b004d5978e8bcfmr3481121lfi.33.1681218982568;
        Tue, 11 Apr 2023 06:16:22 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id r26-20020ac252ba000000b004eb09820adbsm2557794lfm.105.2023.04.11.06.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:16:22 -0700 (PDT)
Message-ID: <6c75d434-bb5d-278f-a125-d096fd6b387d@linaro.org>
Date: Tue, 11 Apr 2023 15:16:15 +0200
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
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230411125910.401075-1-brgl@bgdev.pl>
 <20230411125910.401075-8-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411125910.401075-8-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11.04.2023 14:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the Adreno GPU IOMMU for sa8775p-based platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 191b510b5a1a..11f3d80dd869 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -605,6 +606,42 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,sa8775p-smmu-500", "qcom,adreno-smmu",
> +				     "arm,mmu-500";
Err.. does it even boot like this? You dropped the qcom,smmu-500 compatible
which means it's getting bound to the generic SMMU driver (without
QC quirks). If that was a mistake, you should have had all 4

"qcom,sa8775p-smmu-500", qcom,adreno-smmu, "qcom,smmu-500", "arm,mmu-500"

Without falling into the qc-specific codepaths, the Adreno compat does
nothing.

Konrad
> +			reg = <0x0 0x03da0000 0x0 0x20000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +			dma-coherent;
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_HUB_AON_CLK>;
> +			clock-names = "gcc_gpu_memnoc_gfx_clk",
> +				      "gcc_gpu_snoc_dvm_gfx_clk",
> +				      "gpu_cc_ahb_clk",
> +				      "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +				      "gpu_cc_cx_gmu_clk",
> +				      "gpu_cc_hub_cx_int_clk",
> +				      "gpu_cc_hub_aon_clk";
> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x30000>,
