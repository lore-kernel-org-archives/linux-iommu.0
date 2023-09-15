Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C7028FD
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 09:10:19 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9a9d82d73f9so233765766b.3
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769018; x=1695373818; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mYurZD8ziFDRqchUnDGZKwBbS/2WFyHG5fbkvlBT2g=;
        b=dYDmjfAR15rGQBp0pMXOfCZVh8WU0Fl3euC1EaQ7qOzQUCY8jchdhsaQ7FDo6MdVKc
         QE0/i1c0qEmIvKHObwFzeoYVGMiIILnrwp4gnUhhZ47icyJmhjldU/oOAzjrlCsaYBWZ
         dxNU7SpapLJ0n5JHObpUemvZxHguXXgf2bRkTzcmsgj4ONjknQBwxbFnNK98ZR/pgkdy
         Kf68C4jihw4P4Eq9umYThAMGwWS12AXmifg2VCcDZBxXbqEwOtAXdrFf2keAw7Ki+rKD
         DWEGSD8PMI7bjs6csnDTSbBjDTuVPm87MRQNQo+CHeJ1kkytJxLOhU78XimEATraWshB
         GtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769018; x=1695373818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mYurZD8ziFDRqchUnDGZKwBbS/2WFyHG5fbkvlBT2g=;
        b=Ksuahj4M9DqhSBgtQIa8pfWoGf/ACTvJ8wKrgAwFLa5pQgt1mFZbAOqmBUhlTj1R23
         LlYYd6UO27Gm/45i8Yzt7ZpQsbKHb6LMItz4pVCmKiJRu06xuBZOZZy3cBoVlAiIE/Fn
         t1N9NnlhnXLQvEknQYedowpE8zynY7OhyXmOjO4mCE+oHoZOkW+Cij9Rqfwu+3QTKIkH
         wm+vf2GxJzv3GwCq6Ik4Uu1VB7xToFWlAjLe5pBhFbCuNi6NeGl2LY4Cw9maovGi7PAL
         eFX9qd1dftBdeL4yP/CuSiGvMq5XSgtNbz+yDBvCvd3Ss0V+hxw4vm8vvxGnIxk41nbC
         pa6g==
X-Gm-Message-State: AOJu0YxYtlHfHPdc9S9AdSEBsIc1DPt3xeLUx++xZD0DiDWUVloD9RN1
	XAGMOwKZTEQeKKzihRFBdTBCtQ==
X-Google-Smtp-Source: AGHT+IHiXgvnk9181h78AWvJiNP0aier6ytGOVVosZgBZ7n55wGrwTWePBUH316xtZO8twLna74yjA==
X-Received: by 2002:a17:906:54:b0:9ad:78b7:29ef with SMTP id 20-20020a170906005400b009ad78b729efmr787901ejg.57.1694769018446;
        Fri, 15 Sep 2023 02:10:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b009a9fbeb15f2sm2120791ejb.62.2023.09.15.02.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 02:10:17 -0700 (PDT)
Message-ID: <f932d000-e328-3267-33ad-f3555a6689fb@linaro.org>
Date: Fri, 15 Sep 2023 11:10:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450
 SoC
To: Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, catalin.marinas@arm.com
Cc: geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
 nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
 quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
 quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-3-quic_tengfan@quicinc.com>
 <5a386be4-facc-8aef-aad7-da6508aa0505@linaro.org>
 <c993ecc1-771e-4061-bd10-d3dea1254389@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c993ecc1-771e-4061-bd10-d3dea1254389@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2023 10:52, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 3:11 PM, Krzysztof Kozlowski 写道:
>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>> Add the SoC specific compatible for SM4450 implementing arm,mmu-500.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> index cf29ab10501c..b57751c8ad90 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> @@ -47,6 +47,7 @@ properties:
>>>                 - qcom,sdx55-smmu-500
>>>                 - qcom,sdx65-smmu-500
>>>                 - qcom,sdx75-smmu-500
>>> +              - qcom,sm4450-smmu-500
>>>                 - qcom,sm6115-smmu-500
>>>                 - qcom,sm6125-smmu-500
>>>                 - qcom,sm6350-smmu-500
>>> @@ -70,6 +71,7 @@ properties:
>>>                 - qcom,sc8180x-smmu-500
>>>                 - qcom,sc8280xp-smmu-500
>>>                 - qcom,sdm845-smmu-500
>>> +              - qcom,sm4450-smmu-500
>>
>> Isn't there comment just few lines above your edit? Comment saying DON'T?
>>
>>
>> Best regards,
>> Krzysztof
>>
> Hi Kraysztof
> I seems haven't understand your comments totaly.
> I want to confirm that if you think only need "qcom,smmu-500" and 
> "arm,mmu-500" compitbale name, needn't specific compitable name for each 
> platform?


No, please read the comment. It tells you explicitly what to do - which
compatible add where.

Best regards,
Krzysztof

