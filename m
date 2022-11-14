Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E23FC2
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 11:17:26 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id f7so16776250edc.6
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 03:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8pES7IsZVUbl8+LhDhShwm4arEjrSbe83lTsNM+KPg=;
        b=D5kzxychZ3pxexlom2JaTTTusM/qK3F46+bwz1+x2vE4AF0ViC8ZyMy7rCo4g7biGI
         5YiRYKgDZ4aBz9x5T8VnasUSaW6pNkUZ6WBEE8sifJ4bhLbbGAQqKGkFpqOptApIEWJr
         XrADxeS2yDGw3qA0VCp4EJ+ol06eZMyTlA2pAodHxBwOU30sll8ITTgn5AiiC+PrCm81
         YgIEdN3L1mWnSptDtSz4Hdr0ngrkn9ytLsq+RRiWF0liqfrJSA+NQSN1a5Jjcvwb+wVd
         XfBwmQO3tWA7VInGYLdi4lhr3sj7SToOug7MMN3Yyp5X24CQXNZ0dOREI1f+l6g9mrOG
         Tqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u8pES7IsZVUbl8+LhDhShwm4arEjrSbe83lTsNM+KPg=;
        b=WfnC2M08zugvkcscJ3U28xHJpCF/gLr0aODgy9A4pHsY56odLDQv2YTLt73I5cgOt/
         9llmoPrF80SAQdC7AOSucWwKAoCNt+Vhw4lr2I45CUBIYiiDn57IIMaBFO752BtPpA9N
         Kx+OLdaaG5TkWE1fF3vWMagnut1PYtcMr9/Oi7noZ8uZhRKppcraQ7z9qAf5UaGVrGnV
         HScNWGe+KN58jLcIGcqyP+Xc3ix4kMq9S3A1km3yWRwMHn9gqeSbxuCoN2J/x9uvHcal
         CtZEnV5K97MOVIhlGVU3gSsNEuyfZXBhux+acPDY9ft6YS0Cf4B6UrEvVkhDF1XjyCLj
         0LYA==
X-Gm-Message-State: ANoB5pkT6EO7ki0pyCMKqhTF4OOXidHSa5LkZr9R/RSfsv5h57HT9fKz
	gIUahkTIdfy5JZ6eKtE6m9rt6A==
X-Google-Smtp-Source: AA0mqf7qHDoSYh2IZeKUknP+RpTfX9q5RR3hokssKyLTQg/5n3ZtUd5tXeiCIxPoqFpzolkJiz//Dg==
X-Received: by 2002:a50:cc83:0:b0:461:9183:834b with SMTP id q3-20020a50cc83000000b004619183834bmr10617422edi.196.1668424644385;
        Mon, 14 Nov 2022 03:17:24 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b007ae0fde7a9asm3975901eja.201.2022.11.14.03.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 03:17:23 -0800 (PST)
Message-ID: <a4b160d8-0faa-3f4c-a925-0beaf6ace721@linaro.org>
Date: Mon, 14 Nov 2022 12:17:20 +0100
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
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6fa8e3ea-2113-d930-96bc-3726d53e5bcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
> On 14/11/2022 11:42, Konrad Dybcio wrote:
>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>> (hello Qualcomm). Allow it in bindings.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Changes since v1:
>> - Add minItems
>>
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 9066e6df1ba1..82bc696de662 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -159,7 +159,8 @@ properties:
>>             through the TCU's programming interface.
>>   
>>     power-domains:
>> -    maxItems: 1
>> +    minItems: 0
> It cannot be 0.
>
> minItems: 1
>
> Anyway you still need to restrict it per variant, as I said in previous
> version.

Hm.. I'm not entirely sure what you mean.. Should I add a list of 
compatibles
that are allowed to have 3 power-domains and leave it as it was before 
in the
'else' case?


Konrad

>
> Best regards,
> Krzysztof
>
