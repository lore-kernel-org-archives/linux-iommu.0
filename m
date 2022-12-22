Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1925CAD
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 14:03:25 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id bp15so2827070lfb.13
        for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvJdINC/9JcCcgeCv3yG5/7YU5iZR/sqTBuMXQlWi2Y=;
        b=BOh1/lUMgSDBzFeBtXG/1PSPJBF+ORZ/32EGsxM/FvL9KaW8hRCFLi29Sqbp3Kp4cL
         vHDqaOsp4oz7pW3ohi/bpU+TryP0N3zYlJTfpVm7CZ0E/n0qloc3KOF9U0NAVsw+KA1D
         tXeN6cYMQWAH3aN1U2V3xvRZvyHWtg0KeSx14VLMoZ3j+b8HBpco5ikMFYXdRe3U32Po
         sg3GNEvZZ1F1FUkvDeVPwKrBIqFeg3r10lFvKnDf7dr9B84Tox1BPyh3j7Zv/lH14+RJ
         nFzA/ZV1/BES7ktsKYOj8g558tPuuywEa6xlTP48G3dmr3L/m8RxqflIIPEH1LoY4W1r
         KJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvJdINC/9JcCcgeCv3yG5/7YU5iZR/sqTBuMXQlWi2Y=;
        b=6Bo0WPE5j67aSNZOve6/5rd4Q3iqcPc/3yGtLkKux4yVYM1s/2Llzi5gmZR8zParST
         mQIO5/OKsXInat4RdlSsR9j+BIc1k6iIxjvkFjmEqftVJDUjUGR/OsmYHgPNi6XU1zaP
         Hg4O0JMeTO+oRsnNOQSJpE8BWDAmEUl0Mx2D3sMIgQDQWwWzQsoDm88ylI/bK9Coj19k
         mNfKu47YxAR8UAtLuOfRFAmEAeEzOR81zLf4EUceSn07x41HZF1ZOX2aiIT7sAF5YGTa
         BhCo5FZE/6HNkRG6fUQWylc0NNAzT3mmxUphH10iQadLjKY4N9CXkbM2aOIqjLX1HxpV
         p+6w==
X-Gm-Message-State: AFqh2kpvnpu9L8pb58VVj3cFfKIDXetbluXyHorRzI4GR/rCIAM6jSV2
	pB29UDxxtyGLn4RJU6ZF3rJE+Q==
X-Google-Smtp-Source: AMrXdXtM8rE5nZ0g+wD8FJnu/zjwcsgb68xKvqAbYq3B/PJFQEdJKuF1xj4WlzrScoiAiW4OaQlheQ==
X-Received: by 2002:a05:6512:16a8:b0:4b5:a70f:8efc with SMTP id bu40-20020a05651216a800b004b5a70f8efcmr2753244lfb.64.1671717803160;
        Thu, 22 Dec 2022 06:03:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s14-20020a05651c200e00b0027a17f86998sm52749ljo.127.2022.12.22.06.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:03:22 -0800 (PST)
Message-ID: <5025ab98-ecd2-2fa1-adbc-15b4fd6e85b3@linaro.org>
Date: Thu, 22 Dec 2022 15:03:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
 <20221222101611.nwt5arux2hcvvtvf@SoMainline.org>
 <bff48e91-3cdc-a052-9573-3c4271f88e5a@linaro.org>
 <20221222133305.txcla3kk6lrqk7sc@SoMainline.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222133305.txcla3kk6lrqk7sc@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2022 14:33, Marijn Suijten wrote:
> On 2022-12-22 11:36:16, Krzysztof Kozlowski wrote:
>> On 22/12/2022 11:16, Marijn Suijten wrote:
>>> Is this missing a cc to linux-arm-msm?
>>
>> No, it is not (or maybe but then fix MAINTAINERS). The policy is to use
>> get_maintainers.pl to CC people.
> 
> Yes, that is the question: is it in MANTAINERS and if not, why not?

You can check by yourself if it is there.

Why not? I don't know. Could be that no one ever added it there.

> 
>>> On 2022-12-22 10:23:55, Krzysztof Kozlowski wrote:
>>>> Disallow clocks for variants other than:
>>>> 1. SMMUs with platform-specific compatibles which list explicit clocks
>>>>    and clock-names,
>>>> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>>>>    variable clocks on different implementations.
>>>>
>>>> This requires such variants with platform-specific compatible, to
>>>> explicitly list the clocks or omit them, making the binding more
>>>> constraint.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>
>>> But...
>>>
>>>> ---
>>>>
>>>> Cc: Marijn Suijten <marijn.suijten@somainline.org>
>>>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> index 895ec8418465..0d88395e43ad 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> @@ -367,6 +367,34 @@ allOf:
>>>>              - description: interface clock required to access smmu's registers
>>>>                  through the TCU's programming interface.
>>>>  
>>>> +  # Disallow clocks for all other platforms with specific compatibles
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - cavium,smmu-v2
>>>> +              - marvell,ap806-smmu-500
>>>> +              - nvidia,smmu-500
>>>> +              - qcom,qcm2290-smmu-500
>>>> +              - qcom,qdu1000-smmu-500
>>>> +              - qcom,sc7180-smmu-500
>>>
>>> Hmm, sc7280 has two SMMUs.  The one for Adreno has clocks and a PD, the
>>
>> sc7280 is not here, so what is the mistake you see?
> 
> sc7280 has two IOMMU nodes.  One with clocks (should not be in this
> list), the other doesn't have clocks (should be in this list).
> 
> How do you want to address that?

No, because it is the same compatible.

Best regards,
Krzysztof

