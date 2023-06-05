Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A39AD2E
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 18:17:31 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so6424875e87.1
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685989049; x=1688581049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFY7/Ap9BP/qVUi2KRgm9prK3CbMwX1ONqb9mvFE2H0=;
        b=kwZTlBb6mcFiiy0Xf3z/qf+w41PDcMgg4TdE7dI+FRUzOSVlLdhhoBFS3mGaDtZXpt
         nMrYOUrgniPCyotW6LE9zzMDDn1+ib7pHc9ne5USZyr/EPKgJ0nCRg3tA+2/iP/Ty7OH
         mAJsEICd3r6Fu2YqGwnkBY2w0HZv/GgnNSrLjYWDwM1V1CWVviCZ6kVSUaEqMqYWYyc7
         0W9ovs7pf3ZzpraItPqKyi21aW/LwwMupvSO66fzt8iX3Sw3LOeTvn2OhUc6BDxb2ggA
         tSzitISFTWlssUqQeD6EZEG1AZZcnZAlo5t0DGV1j1aUGd1ksZpu8ck3+G0eoVbuX4v0
         8V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685989049; x=1688581049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFY7/Ap9BP/qVUi2KRgm9prK3CbMwX1ONqb9mvFE2H0=;
        b=a+2VSjEpTYxgyiTnEr3f5d+kXoRLGnp3Lh9way7ivRWsHfrEbYL0Gf9JtCF11lco0N
         qNCfkfrVyXVqRn6Wku9of81ZSnmYMXdHM/6VeWdL5eBFlnDQODaLgm3RRhsi2FGMHPGc
         5ye44MU1yBklrxfCP7H0gR5VFcvi/jAGnexFV/uYO/14TZaUechOlvizCsX0NO/03Hs6
         kQ1qRXI4WBuV1YenY1VBk/r9ZGf7S3/7nliGveIe05ChZKWGHEzUSU3aXbo8tS2ewMBH
         LPqwJJLn0LrD8wZvc/9IhxxoOuqdwqoi8C1FYefIhMeFcp+4Pd2HksWk9YYrYT6fo7Bx
         K/5A==
X-Gm-Message-State: AC+VfDz+JQKn2beIesnb2SQZcLtjBDG8npt53G8CTFZXkpnPZq6n8pI4
	l/6uLhW+OC+SqQlp2063qUABOw==
X-Google-Smtp-Source: ACHHUZ5uSGAq0erU++3cRBaabJAWLttE91tU1/Nj62BZ2HRd2s5ZTOFOT/JB12rynh2oUx943hDAxw==
X-Received: by 2002:a05:6512:21c6:b0:4f5:7c5e:d373 with SMTP id d6-20020a05651221c600b004f57c5ed373mr5391358lft.17.1685989049565;
        Mon, 05 Jun 2023 11:17:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id l7-20020ac25547000000b004f6150e08a6sm1133630lfk.288.2023.06.05.11.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 11:17:29 -0700 (PDT)
Message-ID: <d8c9b229-47ab-cedd-3515-4faf3146e6f8@linaro.org>
Date: Mon, 5 Jun 2023 20:17:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: Add QUPv3 UART console node
 for SDX75
Content-Language: en-US
To: Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
 tglx@linutronix.de, maz@kernel.org, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, mani@kernel.org, robimarko@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-9-git-send-email-quic_rohiagar@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1685982557-28326-9-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5.06.2023 18:29, Rohit Agarwal wrote:
> Add the debug uart console node in devicetree.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index f83eef8..47170ae 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -385,6 +385,34 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		qupv3_id_0: geniqup@9c0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0x009c0000 0x0 0x2000>;
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			clock-names = "m-ahb",
> +				      "s-ahb";
> +			iommus = <&apps_smmu 0xe3 0x0>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			uart1: serial@984000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0x0 0x00984000 0x0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
> +				pinctrl-0 = <&qupv3_se1_2uart_tx_active>,
> +					    <&qupv3_se1_2uart_rx_active>;
> +				pinctrl-1 = <&qupv3_se1_2uart_sleep>;
> +				pinctrl-names = "default",
> +						"sleep";
> +				status = "disabled";
> +			};
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
> @@ -413,6 +441,27 @@
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  			wakeup-parent = <&pdc>;
> +
> +			qupv3_se1_2uart_tx_active: qupv3-se1-2uart-tx-active-state {
> +				pins = "gpio12";
> +				function = "qup_se1_l2_mira";
> +				drive-strength= <2>;
> +				bias-disable;
> +			};
You can bunch these two up like this:

qupv3_se1_2uart_active: qup.... {
	tx {
		pins = ...
		foo = ...
	};

	rx {
		pins = ...
		bar = ...
	};
};

Konrad
> +
> +			qupv3_se1_2uart_rx_active: qupv3-se1-2uart-rx-active-state {
> +				pins = "gpio13";
> +				function = "qup_se1_l3_mira";
> +				drive-strength= <2>;
> +				bias-disable;
> +			};
> +
> +			qupv3_se1_2uart_sleep: qupv3-se1-2uart-sleep-state {
> +				pins = "gpio12", "gpio13";
> +				function = "gpio";
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
>  		};
>  
>  		apps_smmu: iommu@15000000 {
