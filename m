Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C808F5D
	for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 00:59:54 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id m6so3120269qkm.4
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLWMEaldl7mwAfibkMQ7f9QF8cCYwWsptPAXuW24IaM=;
        b=GQWsjBoGJUcqsoAAKfGshd5eISh/AnwduwW5D8aypRX7KEwXJ3w0D6o0OgT+l0RRXr
         GAAgtG5CUkJGI8fPQTQJiXbSO5cvaYoHOB+pshLdvXMezLl4y2enQTFHnGTAywwHljKj
         OjDsBu1AxLK1MUqf77CFy0sXBrlK8oRg11+QpsDkXshX+NBYr8M8Rodc3RNeeQexSBKN
         SPKAwpNgsl9Z0k9aaWLtpH/1H88dGThafvAGPC76HOpA6F7wQnazqxMti59Z2E1W+uDB
         0pl8XwQj8qtiHEu5mTxYuuyUgok5l4D1JvlxVzuXlkjIhSLp4pa2Tuq2XCwK+/n/+Spi
         eG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLWMEaldl7mwAfibkMQ7f9QF8cCYwWsptPAXuW24IaM=;
        b=IqRU7OHJ4f2jhRNZirrMAoZf/blTn3WogXrT8HRG/GYfE6L4mcY6flejcvFw98rdTh
         1b3L9d6QrnL6IAgWG33Bf2PlTNBLd17hgciJpPTF7ErbTPb9h79CgXGYzG3yAjISvnWr
         uayZGFmkgVBRIe9uR24vLKdVNrsV2Lpf2455H61ZEa2QlqtBqDx2B51VLmT/K0OnnKrR
         iIvrFq5F0tsAfcdY/rq1TFglF4eZN3gNy0O8WmkRLKD6XAcMZ1JS7pImL1Ciw05Tar16
         aEDaF+FAM23LBKcqeL5/zGHmR2BI6g30n9vCIuI4SoxQZRq8hzR09lcT/ZoNNxoKoS0b
         jHPg==
X-Gm-Message-State: ACrzQf2JjlQysSyi7P73NcQrLhU33WfYKJ0OA6npyY0xs10tIu3AJwXh
	DSgt6LEeejN0o43W5nqGqFn7Sw==
X-Google-Smtp-Source: AMsMyM5ePAEqT1CxZUNaI9lUZ9Iw9tWpO3mKZVYrsZfLArowIXhAP+1rILHZiBcFibxg3mzf8FbaaA==
X-Received: by 2002:a37:b86:0:b0:6ea:3ec9:7994 with SMTP id 128-20020a370b86000000b006ea3ec97994mr15758286qkl.199.1666400393864;
        Fri, 21 Oct 2022 17:59:53 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id l20-20020a05620a28d400b006b8e8c657ccsm10801547qkp.117.2022.10.21.17.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 17:59:53 -0700 (PDT)
Message-ID: <a36ca97e-5e64-54a8-a571-e9b7f6da76e5@linaro.org>
Date: Fri, 21 Oct 2022 20:59:50 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 1/9] dt-bindings: arm-smmu: Add missing Qualcomm SMMU
 compatibles
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
 <20221021165534.2334329-2-dmitry.baryshkov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021165534.2334329-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2022 12:55, Dmitry Baryshkov wrote:
> Add missing compatibles used for Adreno SMMU on sc7280 and sm8450
> platforms and for the Qualcomm v2 SMMU used on SDM630 platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..34ee33a62ba5 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -28,6 +28,7 @@ properties:
>            - enum:
>                - qcom,msm8996-smmu-v2
>                - qcom,msm8998-smmu-v2
> +              - qcom,sdm630-smmu-v2

So qcom,adreno-smmu is not compatible with Adreno? See below.

>            - const: qcom,smmu-v2
>  
>        - description: Qcom SoCs implementing "arm,mmu-500"
> @@ -48,10 +49,20 @@ properties:
>                - qcom,sm8350-smmu-500
>                - qcom,sm8450-smmu-500
>            - const: arm,mmu-500
> +
> +      - description: Qcom Adreno GPUs implementing "arm,smmu-500"
> +        items:
> +          - enum:
> +              - qcom,sc7280-smmu-500
> +              - qcom,sm8250-smmu-500
> +          - const: qcom,adreno-smmu
> +          - const: arm,mmu-500
>        - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
>          items:
>            - enum:
> +              - qcom,msm8996-smmu-v2
>                - qcom,sc7180-smmu-v2
> +              - qcom,sdm630-smmu-v2

This does not look correct. The same compatible should not be present in
two different setups.

If qcom,msm8996-smmu-v2 is compatible with qcom,adreno-smmu, then your
first hunk is not correct.

>                - qcom,sdm845-smmu-v2
>            - const: qcom,adreno-smmu
>            - const: qcom,smmu-v2

Best regards,
Krzysztof

