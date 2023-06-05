Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71A22623
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 18:21:43 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f3bb61f860so6691441e87.3
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 11:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685989302; x=1688581302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1a7qeHDbY8U7IPws28yR9PE9mlrMDd4/fVGJzd1zHvM=;
        b=z8SoKftSjR2idoohEHt1qJgoL+qs/RzgPtD5hjB312bK/Ve5DM05RPQVtZ9FOHQMcU
         O6SSCsrhyh/NxIFDdrrJyDMNZVGsA44NqGJDGEaKMb/pOlQ8r5ViqAZVtA1/aD7Sfh5t
         3KyRJH1EbcOApoB2zy3YarLWFhlqmRv7Tsrh8W1Skqlo41JZuLrxKLwhyPoiTT/lBvG6
         8leB77mD4q0Kzqk/2xPvKcST32yc2+C+h4DqEou6WCjzMEarMg6VT72qz2xsjp11Fj0S
         gTde9gOCXknyMXcCIoawZzfdIGopZEWhT+8mwuwUqVXVu3iJSjUueVc+lekalGyqgDaP
         4XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685989302; x=1688581302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1a7qeHDbY8U7IPws28yR9PE9mlrMDd4/fVGJzd1zHvM=;
        b=KqOAI5TbIWjFArKTVFz4Jo3jSMgRww3VGELho4q4pHlJmucTDtSOpwdNmnc/6B1Xp0
         78snsNRnldkszgJK+ZdsFQYRVTJ3CuDXxxEOfkraoYJeO3w8UQbJ9xPMUfDK6/rYt0Du
         Er+kVcYhNrVwC5Qzc0TwT595LyjDccJwLQ5n18cKQyvr8jKWy7qoUbqIE+kY8d7Jy4qj
         1UUOYLUcjDSv/WFjbwCmlDeoyGDA1btzklvy2TqasPK6krA16nH5GXSyuxKeitJZkAxl
         8+olmC/xF+FW0t3lBHQTPVzwQxNF9HUvsKYR/RE84FJXnpkbG1hj5kK6p8hCEN7sscTn
         1fGw==
X-Gm-Message-State: AC+VfDx9nHOPmUZpkk/G8mmT/Q+0uyBfM3dLa+02v/qxhbEJs/0SROfi
	gom0zrRpZcPIIVUmiao3WoXF9w==
X-Google-Smtp-Source: ACHHUZ5qrt9YLVbzaIErYVAr2UhMDppB7soLcqjGglnhQYolE5xnJC8GDsd5tEYebLZjxh93rTXGVA==
X-Received: by 2002:a05:6512:21a7:b0:4f3:802c:771f with SMTP id c7-20020a05651221a700b004f3802c771fmr5866467lft.27.1685989301895;
        Mon, 05 Jun 2023 11:21:41 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id m12-20020a19520c000000b004eb12850c40sm1207281lfb.14.2023.06.05.11.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 11:21:41 -0700 (PDT)
Message-ID: <c4f34ad1-bea7-c5cf-dca8-9ededeafa4b4@linaro.org>
Date: Mon, 5 Jun 2023 20:21:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: Add the support of cpufreq on
 SDX75
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
 <1685982557-28326-11-git-send-email-quic_rohiagar@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1685982557-28326-11-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5.06.2023 18:29, Rohit Agarwal wrote:
> Add the support of cpufreq to enable the cpufreq scaling
> on SDX75 SoC. Also add CPU specific information to build
> energy model for EAS.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> index 47170ae..e1887a4 100644
> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
> @@ -47,10 +47,14 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD0>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&L2_0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -64,10 +68,14 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD1>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&L2_100>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -78,10 +86,14 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD2>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&L2_200>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			capacity-dmips-mhz = <1024>;
> +			dynamic-power-coefficient = <100>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -92,10 +104,14 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD3>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&L2_300>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
> +			capacity-dmips-mhz = <1024>;
That sounds a bit bogus.. Thinking about it, it sounds bogus on most
platforms we have support for! I guess SM8250 big cores aren't *really*
equally as powerful..

> +			dynamic-power-coefficient = <100>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> @@ -605,6 +621,20 @@
>  			};
>  
>  		};
> +
> +		cpufreq_hw: cpufreq@17d91000 {
> +			compatible = "qcom,sdx75-cpufreq-epss", "qcom,cpufreq-epss";
> +			reg = <0 0x17d91000 0 0x1000>;
You used 0x0 instead of 0 everywhere else, please do so here as well
to keep things consistent.

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +			reg-names = "freq-domain0";
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GPLL0>;
> +			clock-names = "xo",
> +				      "alternate";
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "dcvsh-irq-0";
> +			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
> +		};
>  	};
>  
>  	timer {
