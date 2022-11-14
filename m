Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2114C6D
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 13:00:26 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id c1so19128884lfi.7
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2v6dXeivccfrn+WhZzJKqoLRW18Q+k95BcJxS2Nft8=;
        b=rl4Z7TiqBNvWPnhXh20wrOVuEE0wnCeMX6CSjyrdR3T1EEkoA1NKS/aVGWZYFtAZcr
         vLqkdcGuxLaLEfazCkIBb0gwRhCTBZD6F4IBBXheK5Re9GoiZ7Eut6vScYrrLU6W5ZgI
         EJEbQ54BV70qZwc6xuX3tq+j1Yuhtu6kON4IfDpQMB+cxsn9s2fYUW4V1LHvDj1b/eE9
         FCIWE5HsPKK8+Vmfo75AUev7GvEUZxC+HIVVbxw9fGbCgKY30b59b77YmaraD+v+SF+t
         odwE8AjsyIp5yRnRZ8V7oFyVtnOJVBH/941y61HKOBBsU1wLO9iOPs85TX4GnJbOvOnT
         0AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2v6dXeivccfrn+WhZzJKqoLRW18Q+k95BcJxS2Nft8=;
        b=dEgglBiTEyYV86Zp/Vck52HxpCoUm+ZTiPOx+tZ7vLiuS0jmwXmE/2WEWzNhj8yuaa
         NOg5opype/F2WmWlQPLauK5/gySXeeVM8H2gpjpdcXdQtIEa9hkPwLU9E5UHXSQtYF6F
         y+VYImtVknKA/XAGVOxFRwByKyFrCTOdM/e2b0i2dPJyMuDt6G0TBKsb4iMvQz5oOHWV
         gX94uJeO/h5KVmSNLFt9atVcegBz1sUMesDYDfNu7pocCGV3XIfzoVvjkULxXijYAmhX
         dpDSQtCWD3joJcSISKRgdr301THlO5mYjG/y5H3af3yUi/OJ/gRL63sOv9nnQFMhBjPL
         luJg==
X-Gm-Message-State: ANoB5plMkcMXbU/GnzQ4oIvNQPvqaVPSs/hdX3UOhBPnngYIl8DB1iwd
	cDN6+D7Qadm1tsdyv+lBjzxyag==
X-Google-Smtp-Source: AA0mqf6Y/jRSNo3kplGT/QnTrZAPtMxVjojG2hI/OrS5/UtbcwQzGqM++6h36xwYu9aPAcYHLeGkkg==
X-Received: by 2002:ac2:5b9d:0:b0:4a2:19e0:1266 with SMTP id o29-20020ac25b9d000000b004a219e01266mr3679582lfn.264.1668430824179;
        Mon, 14 Nov 2022 05:00:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004948b667d95sm1814784lfg.265.2022.11.14.05.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 05:00:23 -0800 (PST)
Message-ID: <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
Date: Mon, 14 Nov 2022 14:00:22 +0100
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a4b160d8-0faa-3f4c-a925-0beaf6ace721@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2022 12:17, Konrad Dybcio wrote:
> 
> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>>> (hello Qualcomm). Allow it in bindings.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>> Changes since v1:
>>> - Add minItems
>>>
>>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> index 9066e6df1ba1..82bc696de662 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> @@ -159,7 +159,8 @@ properties:
>>>             through the TCU's programming interface.
>>>   
>>>     power-domains:
>>> -    maxItems: 1
>>> +    minItems: 0
>> It cannot be 0.
>>
>> minItems: 1
>>
>> Anyway you still need to restrict it per variant, as I said in previous
>> version.
> 
> Hm.. I'm not entirely sure what you mean.. Should I add a list of 
> compatibles

Yes and limit it to maxItems: 1 for "else".

> that are allowed to have 3 power-domains and leave it as it was before 
> in the
> 'else' case?

Best regards,
Krzysztof

