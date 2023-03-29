Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540707B
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 11:32:02 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id e9so445505ljq.4
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680089520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+DmZREGJLvaG78XJWbtpreueoMcEnxDx6Pkz53TmMI=;
        b=HBGugAGCH0yFGhYG/IU6OtOsjloJCctl2WSqcVIi4FVXDRDmRXKgXpFd/o5uub0NlM
         TEcIdA0+m1OLMdYGUeG/Vm4YRYD+GP7YsBCSmdURJ8cvkSGJEec9M0qHEAfyrYL0iM5l
         5Ra88t81JFGoQElR1kPZWszDrF6VfW1wiz6GHv3VDzbtUvo18jrBF9gw7SIZcfvJkLoI
         PSHWQLIKEqN538/iuldEzqxpP31Ty4REom33rt8oOEMg7t18TsE0r1sqA+g8IQAJrf+N
         DlM3Iit9oDWTBLeIUuFC1HyzodoZeUDju2yBGviTF8ZQ/SgAjSjc6D9v+5yTlvjNKX47
         QIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680089520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+DmZREGJLvaG78XJWbtpreueoMcEnxDx6Pkz53TmMI=;
        b=5vgT8ym9gjpcMrc1e9aEI3/qVyBS5mpgeCJ2RvrcgkFuAt3MYDDIo1Yo7CRCkjFvBz
         /BTYF2zgKnZ6duwCyXW8oUlWg7xKOZa8QIdFldmNJW9CD4FSQnW65Qz0e2lAL1GE9GUn
         0y0rOokkwdq1eeZbMcPJsbWOya7kS6+sbwvmh8FVJ2+BsXYztPBtvyfAOMyQ4e7/DEDQ
         RQO1lZE96s9QmM9T1gZfb+rZZ6enDj7ts420N4mCR9T7yvTEPtXNNooXAq0gPxHSEhiV
         CnvQwPKuXPxdugVfzLLyjAYRm55CaBHymikL6e/xU2iUiVXCxnXjfAmPXcethcYfQXiA
         zhUA==
X-Gm-Message-State: AAQBX9eSynCgG05F2UVJNh+oi2QSsAV5JfDwoYWzWoCl9rmKqDMEwYBP
	Jx19jeMjoeoZpFNjnKybrAz/Ug==
X-Google-Smtp-Source: AKy350YE88S5jvIQZVnuVpOQq2nScq3LFKtzJGssAQyWtRjo20ViDGBKbgJ3z8i5HVZH0KqvlDK8+A==
X-Received: by 2002:a2e:b162:0:b0:299:d0b5:cdce with SMTP id a2-20020a2eb162000000b00299d0b5cdcemr6524373ljm.44.1680089520380;
        Wed, 29 Mar 2023 04:32:00 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id y26-20020a2e321a000000b002934febffe4sm5454811ljy.128.2023.03.29.04.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:32:00 -0700 (PDT)
Message-ID: <ab09d5eb-b303-bfa4-4f35-283ab30ffed2@linaro.org>
Date: Wed, 29 Mar 2023 13:31:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sa8775p: add the GPU clock
 controller node
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-7-brgl@bgdev.pl>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230328193632.226095-7-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.03.2023 21:36, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the GPUCC node for sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 9ab630c7d81b..4c45ad1cc7ff 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -591,6 +591,18 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		gpucc: clock-controller@3d90000 {
> +			compatible = "qcom,sa8775p-gpucc";
> +			reg = <0x0 0x03d90000 0x0 0xa000>;
> +			clocks = <&gcc GCC_GPU_CFG_AHB_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_GPU_GPLL0_CLK_SRC>,
> +				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
Without the first clock, as pointed out in the clk review:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

(that also makes it compatible with the generic gpucc bindings!)

Konrad
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x30000>,
