Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF442F38
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 09:11:03 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-501bd164fbfso3113356e87.0
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769062; x=1695373862; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqTeh00riXaBjNescHiFGhXjL1S5jjpClV66tpjmVfI=;
        b=K5DR0b8VZP9k6Yt6ITgi7Lc0USN52SbGhYaE1NpdU93YxQMgupMce60vkLBnTiyz0a
         ma/skZpBhjtzvyTdOzt73jlncKm/T6aZQWbaWkbqb5iD+I64ouh252uOGGyOcNKDzGLs
         FEpL9c4QUFFfeANngDn40SXZO4trqVKxFqHXYnGk/uuczvGw9OR7bJq+nbblQ1wPe+xl
         zopORkRoKCGsfC6HFi9Z+JQFwG5M7X4u6vVboDS0+/yjqCcCYeklaOl+PUOx1w9b8cMU
         2SaiDX8Zh/6F+rcMqAcDjPr6HNuzkc0/OS0YTBulipYfXzJ+p+cQodIKwYJyC34RUGrR
         7kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769062; x=1695373862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqTeh00riXaBjNescHiFGhXjL1S5jjpClV66tpjmVfI=;
        b=UtEnGlTW9Y/K7bl0swEocB/q7DQsKHqmhykOsd9X5mQD327Xv+tR6eavv9/5laNssy
         EJGcjaOevgxUXQ7sxmeChsQ+z/bioUq/DClxM3YV6bRUpWtuhgZb0Z15FUkYr0RyoTYl
         UCsKI3a3CCsHQaXqG//pqXKsDruCd+dS+z5WIABQtWR8SBXKXo4gbxwO5aA01BMW2XQa
         zxVQHmC7Dj6jgDcZX80u4acTs/ppyAkCXp2L6SRBAU9ncevJA8yYNcWygjTFbbOSUyq+
         Q4MyooTt5BSezk+uYF0S3QnD+0KBB3SvNkrZ9XVsY6LfvZUwKlH1RvOO25g6ks6XI9Sc
         x8cA==
X-Gm-Message-State: AOJu0YxMbZBd5Uq8Oi03vyY8UPnoM3D5TVZzvsE2Z93+yllv+u47uQqh
	7ZZw01ODsiFt9UMK0DlC0u3Whrn8DSPjeOuERvw=
X-Google-Smtp-Source: AGHT+IHo7+SxnYzd0/bI0C3S/ETu/ji64wJvleV9efcp2lx53ggD6d7oaLyfrVGa7I3B7WTP908rSQ==
X-Received: by 2002:a2e:8ec1:0:b0:2bf:cbff:7017 with SMTP id e1-20020a2e8ec1000000b002bfcbff7017mr1089791ljl.11.1694769062001;
        Fri, 15 Sep 2023 02:11:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id oq14-20020a170906cc8e00b0099e12a49c8fsm2142599ejb.173.2023.09.15.02.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 02:11:01 -0700 (PDT)
Message-ID: <e026878f-9303-4cae-bcab-7ee69e32db2d@linaro.org>
Date: Fri, 15 Sep 2023 11:10:57 +0200
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
Content-Language: en-US
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
 <2c42d2b6-a838-4d8e-99f1-c08b0c8e4457@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2c42d2b6-a838-4d8e-99f1-c08b0c8e4457@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2023 09:15, Tengfei Fan wrote:
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
> yes, I saw this "DON'T" comment, but if I remove "qcom,sm4450-smmu-500" 
> from sm4450.dtsi and this arm,smmu.yaml, will get DT check warning about 

Why would you remove it?

> this, this warning cannot be find after add "qcom,sm4450-smmu-500" from 
> sm4450.dtsi and this arm,smmu.yaml, so update this patch again.

What does the comment say? Why are you adding it to the enum which asks
- do not add to this enum, but add to other above and below?


Best regards,
Krzysztof

