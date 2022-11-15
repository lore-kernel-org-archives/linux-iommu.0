Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E07AD30
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 13:00:55 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id l12so24281379lfp.6
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70m8oznMfX8D7FgeqW5r54t/DO3+ve+HYcPm4xJoTA0=;
        b=U6JGpD/DvPN3NuziaHicc79ZuFNcr/eqNelojIx/IDa1GGtKmFqVrBjq77N+GL3wHp
         O1o+ak6c9oWHABOYhw0nsDcn+TdeVRDMrtApsZYZUwcqCO9hLTqR6/ItndULHTtePSSp
         vKkSVWbr2/gts/blr9SK29JwiSuESPJYHHkLHEXLmHe6goZRVoKiZhpig4dlHku96z4g
         el3catMWVVvYWWOP6zdx6q07xQ4+NTXMF+JatUKRkTvv7CV44qwCLpOrPBH79E10w0cQ
         xZgFONptqcAQErek4N1hQRyeGAhz0MhPnITX4gqZYwzb0Dh/6IfmjhVkFHLvX9j+jsHk
         3GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70m8oznMfX8D7FgeqW5r54t/DO3+ve+HYcPm4xJoTA0=;
        b=Ws1/H/IMKUVTcRckLQyF1JiphU9LbxRcQE19TxKN7bzlWQsfGJRe/MDQjlDpFQnb4n
         CyfN+Md7UqP9OG/hydqcExM7F7MCaR/1+pzSo9lyyAQAJq0eDr6JGp+WHc+zeR4XLae4
         FQFL9zqukIgkZpTMcX//JigPG+8rBrYWTgNPyEeutTKUKVjV/mkPhKv8StW5PBgvMNC/
         ragNqoH2FEBYlF20IBxLcJJ4vd9DTGJX8gNvKueEMKObi21gVXEvoT4rYVsg0Gfe+9CF
         PAYVycl1g31i9Y6mtZXXexiFVwHos5HKN2A3GKB7dqLxddRaCFg7lSrOg9Bv3/DCz+6S
         8iVw==
X-Gm-Message-State: ANoB5pmN/eeXjOv89JIoa/PE/sb2+mQCDR2jc8w2+LcZTNjKQlAgTtPO
	vu4y7Puo7J/WEUvdQX6P6CK4fqyLddbfk6Wm
X-Google-Smtp-Source: AA0mqf4VW9V70EMxLEXPhw/UNHewRxLppRZt48MhrNghBRu8nQxl7mgNcRNC2imT4tWPTJ+YLhrgCA==
X-Received: by 2002:a19:6748:0:b0:4aa:22b8:fa9d with SMTP id e8-20020a196748000000b004aa22b8fa9dmr5507795lfj.491.1668517253498;
        Tue, 15 Nov 2022 05:00:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b00494603953b6sm2204322lfr.6.2022.11.15.05.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:00:52 -0800 (PST)
Message-ID: <4b4ca3ba-8e4d-088e-8b3e-a47ad6ecb965@linaro.org>
Date: Tue, 15 Nov 2022 14:00:50 +0100
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
 <878402e7-7f80-31c7-3a6b-989a6ca29841@linaro.org>
 <f59ddce1-c2e1-4055-3bce-1319c68ddf94@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f59ddce1-c2e1-4055-3bce-1319c68ddf94@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/11/2022 13:54, Konrad Dybcio wrote:
> 
> 
> On 14/11/2022 17:58, Krzysztof Kozlowski wrote:
>> On 14/11/2022 16:53, Konrad Dybcio wrote:
>>>
>>> On 14/11/2022 14:00, Krzysztof Kozlowski wrote:
>>>> On 14/11/2022 12:17, Konrad Dybcio wrote:
>>>>> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>>>>>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>>>>>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>>>>>>> (hello Qualcomm). Allow it in bindings.
>>>>>>>
>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>> ---
>>>>>>> Changes since v1:
>>>>>>> - Add minItems
>>>>>>>
>>>>>>>     Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>> index 9066e6df1ba1..82bc696de662 100644
>>>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>> @@ -159,7 +159,8 @@ properties:
>>>>>>>               through the TCU's programming interface.
>>>>>>>     
>>>>>>>       power-domains:
>>>>>>> -    maxItems: 1
>>>>>>> +    minItems: 0
>>>>>> It cannot be 0.
>>>>>>
>>>>>> minItems: 1
>>>>>>
>>>>>> Anyway you still need to restrict it per variant, as I said in previous
>>>>>> version.
>>>>> Hm.. I'm not entirely sure what you mean.. Should I add a list of
>>>>> compatibles
>>>> Yes and limit it to maxItems: 1 for "else".
>>>
>>> I tried adding:
>>>
>>>
>>>
>>>     - if:
>>>         properties:
>>>           compatible:
>>>             contains:
>>>               enum:
>>>                 - qcom,sm6375-smmu-500
>>>       then:
>>>         properties:
>>>           power-domains:
>>>             minItems: 3
>>>             maxItems: 3
>>>       else:
>>>         properties:
>>>           power-domains:
>>>             maxItems: 1
>>>
>>>
>>> Right under the nvidia reg if-else in the allOf, but dtbs_check throws
>>> errors like:
>>>
>>>
>>> /home/konrad/linux/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb:
>>> iommu@5040000: 'power-domains' does not match any of the regexes:
>>> 'pinctrl-[0-9]+'
>>>
>>>
>>> Any clues as to why?
>>
>> I don't know what code do you have there, but generic pattern is:
>>
>> https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L38
>>
> I tried many things, but I still don't seem to get a hang of it.. Here's 
> my current diff rebased on top of Dmitry's recent cleanups (available at 
> [1])
> 
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml 
> b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 28f5720824cd..55759aebc4a0 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -200,7 +200,7 @@ properties:
>       maxItems: 7
> 
>     power-domains:

As I mentioned before - minItems: 1.

Just like the link I gave you.

> -    maxItems: 1
> +    maxItems: 3
> 
>     nvidia,memory-controller:
>       description: |
> @@ -364,6 +364,26 @@ allOf:
>               - description: interface clock required to access smmu's 
> registers
>                   through the TCU's programming interface.
> 
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,sm6375-smmu-500
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: SNoC MMU TBU RT GDSC
> +            - description: SNoC MMU TBU NRT GDSC
> +            - description: SNoC TURING MMU TBU0 GDSC
> +
> +      required:
> +        - power-domains
> +    else:
> +      properties:
> +        power-domains:
> +          maxItems: 1
> +
>   examples:
>     - |+
>       /* SMMU with stream matching or stream indexing */
> 
> 
> In my eyes, this should work, but I still get errors like:
> 
> /home/konrad/linux/arch/arm64/boot/dts/qcom/sm8250-hdk.dtb: 
> iommu@3da0000: power-domains: [[108, 0]] is too short
> 
> as if the else: path was never taken..

It was, but the top-level property said that minItems=3 (implicitly), so
it is too short.

Best regards,
Krzysztof

