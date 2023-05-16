Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA21FB0
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 01:26:26 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ac88d9edf3so132873451fa.0
        for <iommu@lists.linux.dev>; Mon, 15 May 2023 18:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684200384; x=1686792384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCXuzrQVE7NqQDfgmpBc13d69ZLB2zjvkbjuCp0orcg=;
        b=fo7JEKjFInLMQlPsQc9w3oWP9T2Aj3MwuPxcvyHykOb2kVt4FarGuSfCQP4XU4Xnn5
         x5GH+EB4iUanMe7Bfr7LNvrgKn3WpFmIzLB0BdD7ArHp+OQKi244DylCU+iCmzRRyOvB
         YUaC+Sve3s2lOHw85mHDkjdteeYJfIA3SYA2Vumbsg5KhYoXmqTEoDE8CuRZ6xsS54WD
         s+v/0xEmG/HaXwivV50aKTUSU83U9wFHWwmdPQ1FEwYgtrlzAaWGeKImVizgwaxfRdDG
         qEuPlIASiqDQquTEvvyuZneyvqtcnEODZ6i+p2UFNPdAMbXlyJxkzsz70wwLnYvfKwrz
         IhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200384; x=1686792384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCXuzrQVE7NqQDfgmpBc13d69ZLB2zjvkbjuCp0orcg=;
        b=DGWXRGSswF+XqmyYjCgg3647VKXc6J0VLBQ4O/n7FbLlx+v6fFzZZgE0hMKePfz3ec
         M7Xx9HyT/JlHdbQomw9Wwqt6v/wOwL/IlM/RKl45aKAT1K9+NIidCH6v7iGGDIvNe4u2
         q6w8G/y2iHGFCn5Olrq+M82bUfAw6LGlFVtIkCooFQ62tW3dbDEdliu+wptF0d27Ff+a
         SZoJj/57IG2oQ1w6YJ8QW1BJNrUU1y8R+n/gRnd1CV08qYouxOVH2KqS1M/ijfu/wtl2
         hlv8ZK6V9hvD4wYiF6tj8zbZUaFmlxGHHdKRxgy/mnVgmWJ7aFZWFDILVD2FXMY88C6q
         bkiA==
X-Gm-Message-State: AC+VfDyNwasi6kizJx/tvVfyFBPfd+YzvYsXY3r9at0lriTPfEeMs0c7
	OwdzlBU1KQ0QGsAYalwVIXIRDw==
X-Google-Smtp-Source: ACHHUZ4v2kFHkHVE+gkX96V7S+QQVZsWTNBB9cJxYxR5LY8juK88Lz0HRrauXlwj+MM81B5kOulXgw==
X-Received: by 2002:a2e:2c09:0:b0:2ad:bb53:8b9a with SMTP id s9-20020a2e2c09000000b002adbb538b9amr6041019ljs.20.1684200384228;
        Mon, 15 May 2023 18:26:24 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id h4-20020a2e3a04000000b002adbe01cd69sm1912340lja.9.2023.05.15.18.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:26:23 -0700 (PDT)
Message-ID: <1801db13-aeb7-ba50-6939-d194a9029f18@linaro.org>
Date: Tue, 16 May 2023 03:26:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
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
 <4a563d96-ec59-7db3-d288-1ba3bb9d8eb7@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4a563d96-ec59-7db3-d288-1ba3bb9d8eb7@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7.05.2023 10:20, Krzysztof Kozlowski wrote:
> On 05/05/2023 23:40, Konrad Dybcio wrote:
>> Document the SM6375 MDSS.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>>  1 file changed, 216 insertions(+)
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmcc.h>
>> +    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
>> +    #include <dt-bindings/clock/qcom,sm6375-dispcc.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/power/qcom-rpmpd.h>
>> +
>> +    display-subsystem@5e00000 {
>> +        compatible = "qcom,sm6375-mdss";
>> +        reg = <0x05e00000 0x1000>;
>> +        reg-names = "mdss";
>> +
>> +        power-domains = <&dispcc MDSS_GDSC>;
>> +
>> +        clocks = <&gcc GCC_DISP_AHB_CLK>,
>> +                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
>> +        clock-names = "iface", "ahb", "core";
>> +
>> +        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +
>> +        iommus = <&apps_smmu 0x820 0x2>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges;
>> +
>> +        display-controller@5e01000 {
>> +            compatible = "qcom,sm6375-dpu";
>> +            reg = <0x05e01000 0x8e030>,
>> +                  <0x05eb0000 0x2008>;
>> +            reg-names = "mdp", "vbif";
>> +
>> +            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +                     <&gcc GCC_DISP_HF_AXI_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
>> +                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
>> +                     <&gcc GCC_DISP_THROTTLE_CORE_CLK>;
>> +            clock-names = "iface",
>> +                          "bus",
>> +                          "core",
>> +                          "lut",
>> +                          "rot",
>> +                          "vsync",
>> +                          "throttle";
> 
> Are you sure you have clocks in correct order? I see warnings...
Right, testing *both* the DTs and bindings after making changes sounds
like a good thing to stop forgetting..

Konrad
> 
> Best regards,
> Krzysztof
> 
