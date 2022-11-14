Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A96FC1
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 15:53:37 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id x21so13745819ljg.10
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFWd2m5XWAIUBukAvtG87ESkORevoEKwbahoShbsHGs=;
        b=gHKpaujIP4yqkPLWSxP/u7oOLFIAUkdMqLmA2+M/QEBY4DUULV8ZWQ2SSHqq/xUBff
         MDdDnV5i+9H4tVU+S0gIms9A5gbbT9D5LNPkzWPLBIvyIud5QSkUDfiRf7T5V/bQbg50
         S8D1lkrwkdYQdzNx0CnkcRG08tvhfCEX/eV03FRz37df8u3eflXTgGKYBavc5XG33NCh
         Sk70zjtPZHMO/yD9ctcTLLx9yaKv3Gb45tf2kUu2zqFgDagTEsi1zZ/Y2ieLgaXbdSdO
         tROJy7mrxMIgPwvFUtuNbxW3Gx+a+Ar1iN8D4W3sDpbawFXw4JYQQsOtxNA7Mn1zoElR
         0hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iFWd2m5XWAIUBukAvtG87ESkORevoEKwbahoShbsHGs=;
        b=oRCsT6h9hGLkM2rJMqlZqHnN6R3fvFwvoiYRT4i6GbCgOzi3j09y1ABWBgbk9GGDlr
         iLxT+Wv+1mSnwsFwX/v55eBoj0JM3ov6XaH1wmDAF1mxA3RJJe8lufjF+/lzz0xkSVYv
         Z+D0xxIs1bfmMrRhAKTLcRhmTCfdU/pbEjpO7ly2L83Yiqi0eocbUldmeks6olX860Sh
         EC5q05FS4wwCkQjIewYhPpQaRPWktA9s9fr5bWlo1s21vzdCBgLcpXsmwXBoZM4kzkx5
         yDQEhNMYtVEXQ0fj9K2m8UwptYIC9cj5IzjbAgNyAMWQiUGrCiLBM/rqoI2GM0bpIIDb
         OeTA==
X-Gm-Message-State: ANoB5plOBk5I+vNi+foTaA20XhCBlkkqEDphY/IGFt2MoyIWfj2I4JIs
	9Ne99NUL/veNSUJOK2XreMiciA==
X-Google-Smtp-Source: AA0mqf7u3FO6mqMqL/O/9MD1mYQ8T/xRPY8vSC+lEwCmp+D+mRgb+hzX8+tpF096sntwINEzwHms9Q==
X-Received: by 2002:a2e:7310:0:b0:277:d86:a36d with SMTP id o16-20020a2e7310000000b002770d86a36dmr4258270ljc.288.1668441215396;
        Mon, 14 Nov 2022 07:53:35 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id h31-20020a0565123c9f00b00498f00420e9sm1857160lfv.194.2022.11.14.07.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 07:53:34 -0800 (PST)
Message-ID: <12578e05-ced9-e5f7-7922-0af2f2159333@linaro.org>
Date: Mon, 14 Nov 2022 16:53:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org
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
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/11/2022 14:00, Krzysztof Kozlowski wrote:
> On 14/11/2022 12:17, Konrad Dybcio wrote:
>> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>>>> (hello Qualcomm). Allow it in bindings.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> Changes since v1:
>>>> - Add minItems
>>>>
>>>>    Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> index 9066e6df1ba1..82bc696de662 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>> @@ -159,7 +159,8 @@ properties:
>>>>              through the TCU's programming interface.
>>>>    
>>>>      power-domains:
>>>> -    maxItems: 1
>>>> +    minItems: 0
>>> It cannot be 0.
>>>
>>> minItems: 1
>>>
>>> Anyway you still need to restrict it per variant, as I said in previous
>>> version.
>> Hm.. I'm not entirely sure what you mean.. Should I add a list of
>> compatibles
> Yes and limit it to maxItems: 1 for "else".

I tried adding:



   - if:
       properties:
         compatible:
           contains:
             enum:
               - qcom,sm6375-smmu-500
     then:
       properties:
         power-domains:
           minItems: 3
           maxItems: 3
     else:
       properties:
         power-domains:
           maxItems: 1


Right under the nvidia reg if-else in the allOf, but dtbs_check throws 
errors like:


/home/konrad/linux/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb: 
iommu@5040000: 'power-domains' does not match any of the regexes: 
'pinctrl-[0-9]+'


Any clues as to why?


Konrad

>
>> that are allowed to have 3 power-domains and leave it as it was before
>> in the
>> 'else' case?
> Best regards,
> Krzysztof
>
