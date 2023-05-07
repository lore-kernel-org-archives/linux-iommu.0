Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A91C04
	for <iommu@lists.linux.dev>; Sun,  7 May 2023 08:20:41 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9660af2499dso266624666b.0
        for <iommu@lists.linux.dev>; Sun, 07 May 2023 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683447640; x=1686039640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boCU+xSxMYiK4ggeuuLGulnjF6pc3jTc885tMRMvfjE=;
        b=Sx+sVXCayBmfkCFY/ASVa/jlP+pfxJID9GqE233noKlpxuM+5LgkDNXXz2NYFOYun/
         8FChtAmAhUuvSBvjqE6h+mmFPtW3GUpXd5XtR1rQew/Lj+O4O9IKtb16ay2HAfluUMf4
         ebPOn8KSeVN2kBAzO0r2b8TyR18KDOKw4wTPj2E7RCviBLs3Lus2eZ8/qiWkhuErG5Um
         jftrOCBFYl0AZpo/lJZ6exDM+y3YOKmyNh0FCAxheyXwWHWK3jTrjSqmf2rwTXiLzqvc
         sTHYkPaKddnPsPOpgKva/MizH0bLJR9PrjZct7A7zzgtl5gBz/hLHWNHH9KOmHs08jal
         y44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683447640; x=1686039640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boCU+xSxMYiK4ggeuuLGulnjF6pc3jTc885tMRMvfjE=;
        b=OPRcUUZKyDCIuDKR6BkEECpPYqD68/+yA00QS/0cqD0GOb35I5T3iZuJgvkzEo8lf/
         Ixzbgyd+yg6paExky1VuddHje3Ib4zBOXZvDjlZBLhL0zahXpIDlJV9VcfQDomliayyz
         5t6+LFu8j7uIu/L0tqF0KTHmEOK7ZGP+exI3jZ21Gv4xlffHmiCL+sdtbskO0tT7is/0
         Qv/3N4PO98fJeFu31uB7x0e4VQOQ1pei6SeDy9QQ5k3l3coJy0RL6GQShV6aFZKGDJDB
         APb29OQJYolED2Zgekqdto0CjtPVJeld1ipJL8F/iDeEcZfiVME7ej8Qc+gfrXpSiHKb
         8CHw==
X-Gm-Message-State: AC+VfDzD+HQHxIO8NekF/eQiPzUcJvtSBFNpj7cxXyOdZhvd0jIx3ywm
	zsXhRbEJzIhVFtjP+uP6xCpz1A==
X-Google-Smtp-Source: ACHHUZ53kMjs+EfHzqrUSmeU9Q3E0/ZNi4xRtfsZw2slikzelkYYe+A5d4jvZP+RilK7xojyyhHK0w==
X-Received: by 2002:a17:907:7204:b0:94f:2bd0:4780 with SMTP id dr4-20020a170907720400b0094f2bd04780mr5910245ejc.58.1683447640154;
        Sun, 07 May 2023 01:20:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:183b:950f:b4d5:135a? ([2a02:810d:15c0:828:183b:950f:b4d5:135a])
        by smtp.gmail.com with ESMTPSA id lc11-20020a170906f90b00b0096637a19dccsm939236ejb.210.2023.05.07.01.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 01:20:39 -0700 (PDT)
Message-ID: <4a563d96-ec59-7db3-d288-1ba3bb9d8eb7@linaro.org>
Date: Sun, 7 May 2023 10:20:38 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v3-0-9837d6b3516d@linaro.org>
 <20230411-topic-straitlagoon_mdss-v3-5-9837d6b3516d@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v3-5-9837d6b3516d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/05/2023 23:40, Konrad Dybcio wrote:
> Document the SM6375 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>  1 file changed, 216 insertions(+)
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
> +    #include <dt-bindings/clock/qcom,sm6375-dispcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    display-subsystem@5e00000 {
> +        compatible = "qcom,sm6375-mdss";
> +        reg = <0x05e00000 0x1000>;
> +        reg-names = "mdss";
> +
> +        power-domains = <&dispcc MDSS_GDSC>;
> +
> +        clocks = <&gcc GCC_DISP_AHB_CLK>,
> +                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +        clock-names = "iface", "ahb", "core";
> +
> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        iommus = <&apps_smmu 0x820 0x2>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        display-controller@5e01000 {
> +            compatible = "qcom,sm6375-dpu";
> +            reg = <0x05e01000 0x8e030>,
> +                  <0x05eb0000 0x2008>;
> +            reg-names = "mdp", "vbif";
> +
> +            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                     <&gcc GCC_DISP_HF_AXI_CLK>,
> +                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
> +                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
> +                     <&gcc GCC_DISP_THROTTLE_CORE_CLK>;
> +            clock-names = "iface",
> +                          "bus",
> +                          "core",
> +                          "lut",
> +                          "rot",
> +                          "vsync",
> +                          "throttle";

Are you sure you have clocks in correct order? I see warnings...

Best regards,
Krzysztof

