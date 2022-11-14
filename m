Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40484748D
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 16:58:24 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id a29so20274997lfj.9
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 08:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky6pMQvRONZVOpXOzzVJ/Yrj7b7SsY3DwGhKO3TyKDI=;
        b=KiwHvFvs5FTx2Ns2wjm8nyJt/2QGsG7J1I7jBrEP8ulyplTvam57JpsemWKsa4IANV
         Vh9WZTRlIH/pQdxw9+Y63655uGk6pKeomGl0pLOIV5DTbBEjyBlj+xxpETDp3Ot9qeS3
         E0eEDnFkvnEoPylvCbwCzAhla68kLvZ0rFnVbGK8zWDKHONgsuGP5pv92+CXcS2SNYLz
         heNYKB6k7A5WLTVqhcORRCNueXz/CsoDcgBEaV1WFDWgxZ5sO0JnKHkgMO3F9q8RSIcY
         BDFFVO80RKSWQT35AYbyX3yoYGNVydUCTIfKu3yVFOh/jy6s6Dr2foCqWpyk4NSaTqvH
         9MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky6pMQvRONZVOpXOzzVJ/Yrj7b7SsY3DwGhKO3TyKDI=;
        b=zq8EK0Kp+UKfP0ijEdrU4Fcd9EYze5Pg/hw/aGstxb6R1ZO2e+wwt76cK441nvX95E
         N4rRNB1BRGX3B8Hb10Bn588ml0keo0sghKfN/DQV7HsBXPJReetW4Be6etpkJXwc48rE
         QL8o9GAlFxu0inAa32BqNuo9ABq015c0L+3Ywjwm+6ZXcz7BW2rt4yuIT/ILeJo8a0hg
         l4c4DtokbXsrqWaheoi4c6w3x/qrJcf5RcDH5pSP1LgRfvdQSPl4JzWO2XQBSQH6GKtX
         j3N9aqd6nEC/k0dR+b1cwUnOiLPVfOUgjASRv9X5WBzfa8/KBN97zw9XEqsJKeg+NRSj
         qi7Q==
X-Gm-Message-State: ANoB5pmW1YC7a8vJ6s656054gsp+SaRVg09t28hs0iJjYDGa4I/ux2En
	yq9APcmNLentRsiyNU0uuGmQjQ==
X-Google-Smtp-Source: AA0mqf7/d/ExzMhN+Xf9uSDjhga3dRHbNfCb1ccpBEzobEMejcOy7EpBl3YlBur6KVu73zCB44OYgg==
X-Received: by 2002:a05:6512:718:b0:4b1:b7d0:21e4 with SMTP id b24-20020a056512071800b004b1b7d021e4mr4701191lfs.72.1668445102292;
        Mon, 14 Nov 2022 08:58:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi39-20020a0565120ea700b004a91df49508sm1897033lfb.177.2022.11.14.08.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:58:21 -0800 (PST)
Message-ID: <878402e7-7f80-31c7-3a6b-989a6ca29841@linaro.org>
Date: Mon, 14 Nov 2022 17:58:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org
Cc: patches@linaro.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
 <20221114104222.36329-2-konrad.dybcio@linaro.org>
 <6fa8e3ea-2113-d930-96bc-3726d53e5bcd@linaro.org>
 <a4b160d8-0faa-3f4c-a925-0beaf6ace721@linaro.org>
 <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
 <12578e05-ced9-e5f7-7922-0af2f2159333@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12578e05-ced9-e5f7-7922-0af2f2159333@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/11/2022 16:53, Konrad Dybcio wrote:
> 
> On 14/11/2022 14:00, Krzysztof Kozlowski wrote:
>> On 14/11/2022 12:17, Konrad Dybcio wrote:
>>> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>>>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>>>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>>>>> (hello Qualcomm). Allow it in bindings.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>> Changes since v1:
>>>>> - Add minItems
>>>>>
>>>>>    Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>> index 9066e6df1ba1..82bc696de662 100644
>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>> @@ -159,7 +159,8 @@ properties:
>>>>>              through the TCU's programming interface.
>>>>>    
>>>>>      power-domains:
>>>>> -    maxItems: 1
>>>>> +    minItems: 0
>>>> It cannot be 0.
>>>>
>>>> minItems: 1
>>>>
>>>> Anyway you still need to restrict it per variant, as I said in previous
>>>> version.
>>> Hm.. I'm not entirely sure what you mean.. Should I add a list of
>>> compatibles
>> Yes and limit it to maxItems: 1 for "else".
> 
> I tried adding:
> 
> 
> 
>    - if:
>        properties:
>          compatible:
>            contains:
>              enum:
>                - qcom,sm6375-smmu-500
>      then:
>        properties:
>          power-domains:
>            minItems: 3
>            maxItems: 3
>      else:
>        properties:
>          power-domains:
>            maxItems: 1
> 
> 
> Right under the nvidia reg if-else in the allOf, but dtbs_check throws 
> errors like:
> 
> 
> /home/konrad/linux/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb: 
> iommu@5040000: 'power-domains' does not match any of the regexes: 
> 'pinctrl-[0-9]+'
> 
> 
> Any clues as to why?

I don't know what code do you have there, but generic pattern is:

https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L38

Best regards,
Krzysztof

