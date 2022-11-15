Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9B139E
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:04:42 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id y14so36727339ejd.9
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9LeILXvw8L9LoEFMAR3miqDBARgsMFwg1ZrW9AFkIk=;
        b=jDUHta9jtUjIl9jrU1sLbM7rBYUjPsoylRiLOMdRDqi+BOGmx5u4eRb4/HiKseL232
         FhDu1k2nLxoNlP9n1hhtq+KMOjVaGWvccm/svuCSmvRH2z3U8+kMNhT66an9lZ2FJGLW
         XjdMDFy6f7z2DlD/9Ja/5sivV+usDEtyPrpQrwbw3fSooNkoCXYRT+Quorpz88oWxstO
         sBLsQHVlZGVFhavpiQp+62kfjGo4Xy6ryCZrRXuVk+pJNABdCXIP3CBLxdwGuO/Oc5IE
         VHvIILZmgni9Dz+v1wQQDpV3JLR30W2HIgyCU3k2dbg0eaCx//UWVXCeuyU7UQv0CrOc
         e/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d9LeILXvw8L9LoEFMAR3miqDBARgsMFwg1ZrW9AFkIk=;
        b=GVXJ7xpPQTA37z81h0aa8c63tVQbVEUCmNuUnmybaGi4XQ2RcV/ACKKPaX8GegX7Zq
         +yfHbTk/aJa2EzdIkRPl6qrMQIIcHSEdIGC5eEKAGhTVY2elnLAS/W7s7Kn8p0vnSEq5
         7CN2hanvWvD2+JJJdJRzy9p7OAu3tFJksV5mOcoP82xbE9VQl5W/wWamZWbu3edpblQJ
         1+k97vU9nAmBTfAoqlo8T3x9AaWcOQI6scvQinDXTasx+2a57rkJQ5jHOYe3knQSx59N
         Eee0oFjxTxsjUqVGS8yzMG7IE6PLPjTasMrrHaeI45MnfXZBZmmtPGwL3tfhcQqIVuyH
         5gaw==
X-Gm-Message-State: ANoB5pnIfVHZ3z8Vm6swXsnrK7/pS60A3E3wTI2R6B8+vrmfnZO0umJg
	azKGhY0OXzobVeurwb8+JvLykg==
X-Google-Smtp-Source: AA0mqf6KK9noe2qvxHfnjBSUJjx6KLuYgdcHS4UDhN/VuQX/gbwFigj+4fke8gGB5rAnslfFsSRCZg==
X-Received: by 2002:a17:907:8e92:b0:7ad:a34f:1efe with SMTP id tx18-20020a1709078e9200b007ada34f1efemr14115723ejc.350.1668524681034;
        Tue, 15 Nov 2022 07:04:41 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906728300b007a559542fcfsm5571581ejl.70.2022.11.15.07.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:04:40 -0800 (PST)
Message-ID: <03a8c0e4-bc5c-1447-e3b6-a26f2f221862@linaro.org>
Date: Tue, 15 Nov 2022 16:04:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
To: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org
Cc: patches@linaro.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
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
 <4b4ca3ba-8e4d-088e-8b3e-a47ad6ecb965@linaro.org>
 <cff269c8-f944-9277-9df8-653522efbba0@linaro.org>
 <4a9083fc-81ba-f5ca-5df7-cd04becb1dce@arm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4a9083fc-81ba-f5ca-5df7-cd04becb1dce@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/11/2022 14:43, Robin Murphy wrote:
> On 2022-11-15 13:06, Konrad Dybcio wrote:
>>
>>
>> On 15/11/2022 14:00, Krzysztof Kozlowski wrote:
>>> On 15/11/2022 13:54, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 14/11/2022 17:58, Krzysztof Kozlowski wrote:
>>>>> On 14/11/2022 16:53, Konrad Dybcio wrote:
>>>>>>
>>>>>> On 14/11/2022 14:00, Krzysztof Kozlowski wrote:
>>>>>>> On 14/11/2022 12:17, Konrad Dybcio wrote:
>>>>>>>> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>>>>>>>>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>>>>>>>>> Some SMMUs require that a vote is held on as much as 3 
>>>>>>>>>> separate PDs
>>>>>>>>>> (hello Qualcomm). Allow it in bindings.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>>>>> ---
>>>>>>>>>> Changes since v1:
>>>>>>>>>> - Add minItems
>>>>>>>>>>
>>>>>>>>>>      Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 
>>>>>>>>>> ++-
>>>>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git 
>>>>>>>>>> a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml 
>>>>>>>>>> b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>>>>> index 9066e6df1ba1..82bc696de662 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>>>>>> @@ -159,7 +159,8 @@ properties:
>>>>>>>>>>                through the TCU's programming interface.
>>>>>>>>>>        power-domains:
>>>>>>>>>> -    maxItems: 1
>>>>>>>>>> +    minItems: 0
>>>>>>>>> It cannot be 0.
>>>>>>>>>
>>>>>>>>> minItems: 1
>>>>>>>>>
>>>>>>>>> Anyway you still need to restrict it per variant, as I said in 
>>>>>>>>> previous
>>>>>>>>> version.
>>>>>>>> Hm.. I'm not entirely sure what you mean.. Should I add a list of
>>>>>>>> compatibles
>>>>>>> Yes and limit it to maxItems: 1 for "else".
>>>>>>
>>>>>> I tried adding:
>>>>>>
>>>>>>
>>>>>>
>>>>>>      - if:
>>>>>>          properties:
>>>>>>            compatible:
>>>>>>              contains:
>>>>>>                enum:
>>>>>>                  - qcom,sm6375-smmu-500
>>>>>>        then:
>>>>>>          properties:
>>>>>>            power-domains:
>>>>>>              minItems: 3
>>>>>>              maxItems: 3
>>>>>>        else:
>>>>>>          properties:
>>>>>>            power-domains:
>>>>>>              maxItems: 1
>>>>>>
>>>>>>
>>>>>> Right under the nvidia reg if-else in the allOf, but dtbs_check 
>>>>>> throws
>>>>>> errors like:
>>>>>>
>>>>>>
>>>>>> /home/konrad/linux/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb:
>>>>>> iommu@5040000: 'power-domains' does not match any of the regexes:
>>>>>> 'pinctrl-[0-9]+'
>>>>>>
>>>>>>
>>>>>> Any clues as to why?
>>>>>
>>>>> I don't know what code do you have there, but generic pattern is:
>>>>>
>>>>> https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L38
>>>>>
>>>> I tried many things, but I still don't seem to get a hang of it.. 
>>>> Here's
>>>> my current diff rebased on top of Dmitry's recent cleanups 
>>>> (available at
>>>> [1])
>>>>
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> index 28f5720824cd..55759aebc4a0 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> @@ -200,7 +200,7 @@ properties:
>>>>        maxItems: 7
>>>>
>>>>      power-domains:
>>>
>>> As I mentioned before - minItems: 1.
>> But not all SMMUs require a power domain :/
> 
> Right, so it's not a required property. However if it *is* present, then 
> it needs to reference at least one power domain, because having an empty 
> property, i.e.:
> 
>      power-domains = <>;
> 
> or
>      power-domains;
> 
> makes no sense whatsoever.
> 
> Thanks,
> Robin.
OHHHH!

That was the missing piece that made it click for me!
Thanks Krzysztof, Robin for guiding me through this.

Konrad
> 
>>
>>>
>>> Just like the link I gave you.
>>>
>>>> -    maxItems: 1
>>>> +    maxItems: 3
>>>>
>>>>      nvidia,memory-controller:
>>>>        description: |
>>>> @@ -364,6 +364,26 @@ allOf:
>>>>                - description: interface clock required to access smmu's
>>>> registers
>>>>                    through the TCU's programming interface.
>>>>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: qcom,sm6375-smmu-500
>>>> +    then:
>>>> +      properties:
>>>> +        power-domains:
>>>> +          items:
>>>> +            - description: SNoC MMU TBU RT GDSC
>>>> +            - description: SNoC MMU TBU NRT GDSC
>>>> +            - description: SNoC TURING MMU TBU0 GDSC
>>>> +
>>>> +      required:
>>>> +        - power-domains
>>>> +    else:
>>>> +      properties:
>>>> +        power-domains:
>>>> +          maxItems: 1
>>>> +
>>>>    examples:
>>>>      - |+
>>>>        /* SMMU with stream matching or stream indexing */
>>>>
>>>>
>>>> In my eyes, this should work, but I still get errors like:
>>>>
>>>> /home/konrad/linux/arch/arm64/boot/dts/qcom/sm8250-hdk.dtb:
>>>> iommu@3da0000: power-domains: [[108, 0]] is too short
>>>>
>>>> as if the else: path was never taken..
>>>
>>> It was, but the top-level property said that minItems=3 (implicitly), so
>>> it is too short.
>> So the top-level properties take precedence over the ones that come 
>> from the if-then-else?? Ugh.
>>
>> Konrad
>>>
>>> Best regards,
>>> Krzysztof
>>>
