Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C26370
	for <iommu@lists.linux.dev>; Fri, 17 Mar 2023 08:32:34 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id er8so5633320edb.0
        for <iommu@lists.linux.dev>; Fri, 17 Mar 2023 01:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679041952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDOcNIcbSN9Lk2htsV80EHwrNf4UOCNV6ZaL1McyWuk=;
        b=Nb0YDCUjo8OyvolKZu7uS9pixhnVmAjS/JIK0BCtKNVk1/oMea0jrQd3l/lFz6bVCR
         USIyJRSbW3jZp8FOUyQrA+revcu9mDP2Gj82GWbNeC8+Syck8Y8va4gbH2ni+Y80SYaB
         wxZC/laPoSIONRF9xS3gye6DieykFm/d/QeR1Cw9Q3qSmG2znVuLWufS7iZlhuoVeqTM
         xYrRKzIq1JBntBrTw73UYZQ7rSc2HusEYilpAYzIPc8CJjEpkul1g0ctguduBCb144kf
         QzN71abPTQv/RaiIIdaIK2ySfGwINZfJzFD5FMzCKD/1k7mmENVlYtkB71ke8LSKmAc0
         2DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDOcNIcbSN9Lk2htsV80EHwrNf4UOCNV6ZaL1McyWuk=;
        b=UQl+ScRdwhmzOfip4PN946ETNWqM/zDH6wkk5WM5rh5k+23tdlQ6S1HRa7M5m/qHAj
         c0eeT8ELKOgw/JeK7r0WuCHJh9J5tsdffUOMlpTIEtenu1z6BhFfv5VNEE69hL60qoGd
         UPhv/Pa4g8Iq3lFu92GDBflUwsHTm9oDDkvnkHltotToc6U+LO9T2piK45grUwxH5AQ+
         MzPJ6Q1RvoRtMC1NUeqzRrVRYmaIGcruCq/o3hSAft1o6v6ME53QqDQQEBieVgAYG8LT
         W1xhH7Yn1MhhKhHFmYnB19COE1rH94UGbFTyl9aM4dfsjMqlkkF61Fjts0tvFC2gYcr/
         IUGg==
X-Gm-Message-State: AO0yUKUfOOgvQ+JIm97f+O3+KTDH0gNCW5A5AxRssgx3TxeLahWFqvy+
	3x+xI1TbqCQ6ZEOsHkzaDe+7uA==
X-Google-Smtp-Source: AK7set/64No4okniI9+o2EC5df5JYtg/Ur5By37PIJVSfElLEiA0wNITxxOCYNOCOgrpQmgmHOSDJg==
X-Received: by 2002:a17:907:3fa6:b0:878:7189:a457 with SMTP id hr38-20020a1709073fa600b008787189a457mr16572865ejc.51.1679041952687;
        Fri, 17 Mar 2023 01:32:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id mj4-20020a170906af8400b008ca8b62cda6sm699999ejb.177.2023.03.17.01.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:32:32 -0700 (PDT)
Message-ID: <0edf6829-3a23-7a75-a225-d69222ae2788@linaro.org>
Date: Fri, 17 Mar 2023 09:32:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
 <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
 <f09e93e1-235a-ea0a-902d-4f41a8c90ee5@linaro.org>
 <d260b390-f6f2-493a-071c-f88c36582881@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d260b390-f6f2-493a-071c-f88c36582881@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/03/2023 22:59, Konrad Dybcio wrote:
> 
> 
> On 16.03.2023 20:29, Krzysztof Kozlowski wrote:
>> On 15/03/2023 11:52, Konrad Dybcio wrote:
>>> Both of these SoCs have a Qualcomm MMU500 implementation of SMMU
>>> in front of their GPUs that expect 3 clocks. Both of them also have
>>> an APPS SMMU that expects no clocks. Remove qcom,sm61[12]5-smmu-500
>>> from the "no clocks" list (intentionally 'breaking' the schema checks
>>> of APPS SMMU, as now it *can* accept clocks - with the current
>>> structure of this file it would have taken a wastefully-long time to
>>> sort this out properly..) and add necessary yaml to describe the
>>> clocks required by the GPU SMMUs.
>>
>>
>>> +      properties:
>>> +        compatible:
>>> +          items:
>>> +            - enum:
>>> +                - qcom,sm6115-smmu-500
>>> +                - qcom,sm6125-smmu-500
>>> +            - const: qcom,adreno-smmu
>>> +            - const: qcom,smmu-500
>>> +            - const: arm,mmu-500
>>
>> If you drop the hunk later (from allOf:if), then what clocks do you
>> expect for non-GPU SMMU?
> Both 6115 and 6125 require no clocks under the APPS (non-GPU) SMMU.
> However, the list below uses a `contains:` which means I'd have
> to add a whole another hunk like
> 
> 	- items:
>             - enum:
>                 - qcom,sm6115-smmu-500
>                 - qcom,sm6125-smmu-500
>             - const: qcom,smmu-500
>             - const: arm,mmu-500
> 
> and add another level of indentation to the previous one
> 
> I figured skipping that was less messy (I think we discussed this
> once as well), but if you prefer to keep it strict, I can.

Nah, ok, it's fine.

Best regards,
Krzysztof

