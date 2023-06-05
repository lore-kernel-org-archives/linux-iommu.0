Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C07FAD2E
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 18:16:17 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f62d93f38aso1356738e87.0
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685988976; x=1688580976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QLpda+QQ8b89rCwG+J9qO0y/+RXWL9mYS3FL+ITT7BY=;
        b=OgPJHcb1a2w7KPLiDNxkmD+SDYdUtPN4TqkNx9Zvm+mhJXa7Q+U2njuzvz4lzE6AAB
         Hi/8kjMaPtnEmcdjC8iJy6MO1ZuUGlLxCKlLeIt7HTAZ5DHNlA3MKoOhAdbA4EP1/x2U
         mTTZRejIgbyatx19cmNUJ/noghE5jqiRy2kEYW1kPmd+GeBgu1MjIRxdSchFeNI4pFsF
         6tedIEThroq/L7RN/ZoQkckB1Zk0d9oayt0Y6LBsmKzexkfDXq0YolAm05ny80vs6cRJ
         LYWjapvLMuTaMfwkctGSQi7gXcP5Hzctd+3V6+NONJLSiIe2Tu/q50NrNLg5jNLVRyxu
         Sxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685988976; x=1688580976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLpda+QQ8b89rCwG+J9qO0y/+RXWL9mYS3FL+ITT7BY=;
        b=TtqiWf8wln/du9oyqWu4IyvGh25AdNhysp+0AsLKFG/3Fl7WHBKdydZ5nDxS5exRfY
         /9iDjGsJJvcVVu2wRefj71yNESrC3qVAJLX+OeOu6imwmPnhGDfDdwJprZMaa8qS7i4q
         6Zl9kOhFfrlH2TWUb059lplI2r6r1M+bJuLFZbcImQFczAXJSx9Y4cAhCHgdzzZ+4DbF
         d3g1sGr7YoT6bwvVpKJ6wCoujMUEnRaqoqMXVCQudChcK1h12d05s5OjZESbJR1LWJKu
         IjYZ0ghaeDzrrSi6AnIb/+FBbvIA6d5CqRcXZD2hFhA94/kg6m28oOCW9U4Ede7y1+aX
         r5Gw==
X-Gm-Message-State: AC+VfDzhPQB8RbC8m+jVNsOVoqVEKimQ8bkq3AhQujG6ny0QPxlmufkR
	4el/n53jyWUc2aGpbaJLIk0jOQ==
X-Google-Smtp-Source: ACHHUZ6jH5xwYsteOXpy/gybvQuT/6/EJ/bOB8yLbDzWA44J/KTUSDiIayxsnTjhxwsYtUlp2UCpzA==
X-Received: by 2002:ac2:55b8:0:b0:4f6:259d:3d40 with SMTP id y24-20020ac255b8000000b004f6259d3d40mr2360866lfg.2.1685988976032;
        Mon, 05 Jun 2023 11:16:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id x12-20020ac25dcc000000b004f0049433adsm1198709lfq.307.2023.06.05.11.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 11:16:14 -0700 (PDT)
Message-ID: <0bfc0e59-b48b-bddb-244a-0e56d1ec4be8@linaro.org>
Date: Mon, 5 Jun 2023 20:16:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 07/10] arm64: dts: qcom: Add support for GCC and RPMHCC
 for SDX75
Content-Language: en-US
To: Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
 tglx@linutronix.de, maz@kernel.org, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, mani@kernel.org, robimarko@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Imran Shaik <quic_imrashai@quicinc.com>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-8-git-send-email-quic_rohiagar@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1685982557-28326-8-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5.06.2023 18:29, Rohit Agarwal wrote:
> From: Imran Shaik <quic_imrashai@quicinc.com>
> 
> Add support for GCC and RPMHCC clock nodes for SDX75 platform.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index 3d1646b..f83eef8 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sdx75-gcc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
> @@ -22,7 +23,21 @@
>  		reg = <0 0x80000000 0 0>;
>  	};
>  
> -	clocks { };
> +	clocks {
> +		xo_board: xo_board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <76800000>;
> +			clock-output-names = "xo_board";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			clock-output-names = "sleep_clk";
> +			#clock-cells = <0>;
> +		};
> +	};
>  
>  	cpus {
>  		#address-cells = <2>;
> @@ -358,6 +373,18 @@
>  		ranges = <0 0 0 0 0x10 0>;
>  		dma-ranges = <0 0 0 0 0x10 0>;
>  
> +		gcc: clock-controller@80000 {
> +			compatible = "qcom,sdx75-gcc";
> +			reg = <0x0 0x0080000 0x0 0x1f7400>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&sleep_clk>;
> +			clock-names = "bi_tcxo",
> +				      "sleep_clk";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
> @@ -520,6 +547,14 @@
>  			apps_bcm_voter: bcm_voter {
>  				compatible = "qcom,bcm-voter";
>  			};
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sdx75-rpmh-clk";
> +				clocks = <&xo_board>;
> +				clock-names = "xo";
> +				#clock-cells = <1>;
> +			};
> +
>  		};
>  	};
>  
