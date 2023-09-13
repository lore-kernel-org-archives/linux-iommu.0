Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58D179B6
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:13:44 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9338e4695so106164461fa.2
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589223; x=1695194023; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMH3vpvCAYv9pjz0vyXayvBqBPROq5/ItNXcUQV0q9E=;
        b=AWuZN4iScr1ZX8sf0AIX4j9XiMo1ns1VWaNLDiyBXiDF8jlUNvs/3YZAMVSI0B673C
         3V4kWyzZU94QoPptPhAPGG8tGkXerW8He/QevqIb3JDXy3T9qcpo7Idf8po+9fnNI70f
         8AcxaBeDylfL0uGDXNfuq1UOU3jiLuykk318vJAJMN7npDjt9dOz/wrAv5XTiKaPItdt
         U/8lp/aGMJ+CoOy/aayJFs1jQQm7lNTZ+Xq5l1dJ6awRHvIu9LUmQ9fT/IpyhaXdoNQ3
         3NCiysZb0doQz+FMypVK0ZtE38wiggDVT40pJRSEBsAhBUw83o5OcCPnUAA1FQ5gVfLt
         WZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589223; x=1695194023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMH3vpvCAYv9pjz0vyXayvBqBPROq5/ItNXcUQV0q9E=;
        b=RSyZeaJkddT5C2exfuOPYkUOaRqJGnM8Sn28EoW6ZI8grGtmiWI09S+4ELCO+26Tl/
         Q7pd/2/xrhDHb4wlhtUxRntlGGfnu7/mUHGgEMwxqkwWAUtvasyBWme9oYq0kmVrFczt
         fOfh4nVsA5+7NftGOj5eONuc6OwYNzp+v6Q7fjrC+pTqSwlSrI7blzEES7JGGJzL2+7C
         /mqIDS82FR0FqNjUmHoF6tPXzz9K1HsxSQLBNF39B2NIXfymM8zg3gRulEMPwPncYgAM
         vLHv8GUL7qrDaJsHlNSRIhil0DCHllymphGTnhpBw4uEDq1ktwEYezRf3xaDDfzkn0OG
         RRDQ==
X-Gm-Message-State: AOJu0YwFdrEZhUfQtHn4aFMgBzZrmBgqgg9DH/Xoa4F6/FsZdDIS3CHC
	3GkdcffCCHPUKk7BMdsd7iTK/Q==
X-Google-Smtp-Source: AGHT+IEaX2HHUaLs3S63J80qFOSmj6sWOrftUpS+R5qC7Xs/FsBZ7EPgP0pGvUeL/9pDbnFuXmPFwA==
X-Received: by 2002:a2e:9e14:0:b0:2bd:1f83:8d4 with SMTP id e20-20020a2e9e14000000b002bd1f8308d4mr1400872ljk.22.1694589223002;
        Wed, 13 Sep 2023 00:13:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ce7-20020a170906b24700b0098f99048053sm8015685ejb.148.2023.09.13.00.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:13:42 -0700 (PDT)
Message-ID: <70b2a9d7-1a3e-25da-3d78-7bfa5d3a1e05@linaro.org>
Date: Wed, 13 Sep 2023 09:13:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: sdm630: Drop RPM bus clocks
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-6-1e506593b1bd@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-6-1e506593b1bd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/2023 15:31, Konrad Dybcio wrote:
> These clocks are now handled from within the icc framework and are
> no longer registered from within the CCF. Remove them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 49 +++++++-----------------------------
>  1 file changed, 9 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index ec6003212c4d..f11d2a07508c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -605,9 +605,6 @@ bimc: interconnect@1008000 {
>  			compatible = "qcom,sdm660-bimc";
>  			reg = <0x01008000 0x78000>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> -				 <&rpmcc RPM_SMD_BIMC_A_CLK>;

Bindings expect here two clocks, so you miss some bindings patches.

>  		};
>  
>  		restart@10ac000 {
> @@ -619,28 +616,17 @@ cnoc: interconnect@1500000 {
>  			compatible = "qcom,sdm660-cnoc";
>  			reg = <0x01500000 0x10000>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> -				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
>  		};
>  
>  		snoc: interconnect@1626000 {
>  			compatible = "qcom,sdm660-snoc";
>  			reg = <0x01626000 0x7090>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus", "bus_a";
> -			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> -				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>  		};
>  
>  		anoc2_smmu: iommu@16c0000 {
>  			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>  			reg = <0x016c0000 0x40000>;
> -
> -			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			assigned-clock-rates = <1000>;
> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
> -			clock-names = "bus";

This is also against bindings. After your patch #4, such bus clock (or
other combinations) is still required.


>  			#global-interrupts = <2>;
>  			#iommu-cells = <1>;
>  
> @@ -685,16 +671,12 @@ a2noc: interconnect@1704000 {
>  			compatible = "qcom,sdm660-a2noc";
>  			reg = <0x01704000 0xc100>;
>  			#interconnect-cells = <1>;
> -			clock-names = "bus",
> -				      "bus_a",
> -				      "ipa",
> +			clock-names = "ipa",

And which bindings does this match?

Best regards,
Krzysztof

