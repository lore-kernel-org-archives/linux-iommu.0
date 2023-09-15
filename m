Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096FDDAD
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 09:16:29 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-501bd7711e8so3165461e87.1
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769388; x=1695374188; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUXWbJ4ry0MjQqU+b2Xypq/860rfFXK7seyaFzZwQFo=;
        b=ZjZdyjNkA6/Yltbbkj/cssGeVfHyyeh2FXRSTEtueJaeGvh35YMnosPmkyFYu6bphc
         31PCV6y7ayRAvO6ODC1AFRipe2KCGJEQ67SyjE7c5NdaRnWPy8vQoN/GVhFYeVx1EYkd
         rgmTn5q1kNdJOEyX8xiI8CtT24olQyj+GMfLOCLpIaO9OGRAQIgY+E3rpk/rL617mqzb
         ZF4CmkAVmYxaeZW/2eZ5uo8/2ODeFoBrsvAyKPIP35sgqD38FRN2nsSJCyhUuIePriS7
         B8XVUjY33AkpVkxPVJHldk7gbN2hqihqOzSoncQEPJU6hgXn8C5aMb/0xqzHIYdtg9/C
         mJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769388; x=1695374188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUXWbJ4ry0MjQqU+b2Xypq/860rfFXK7seyaFzZwQFo=;
        b=s8Kw9YNUVCy0YN691rw3LAu72eGl1K7ZA1jWqB8hn9sRNv/vmbmrNmiq1KPI6rlf3T
         OtspKT9ddUprGnRnW1z+Xikemq6icHAXqkXFE9fj5BeBaw9h6rMm4LofZJkDu1rA0mUV
         6te/eq0V3H96jdceUDHQ89cAPpZnJ2GfXTbGCJekzPbz71wz+5okfldw0WyRJpKiBLgu
         mmbirR8CMWpHd/lS8bFvW66b23clZ0Q0DCSsZHzndgV6LVnGF98ojR1usPHokEb4Im9x
         B337vE0Q7s8yYqw+oAVhWj9xE0O+fZWjupTGyiQVEuXaANlvyfk4j5VtC7Myc6v4Zbi7
         D89g==
X-Gm-Message-State: AOJu0YxBd1kkoixDGJeIigUccAWWjU8NL+CbUbJZGIhEzen+lB4Eb9WJ
	lt2Ob4C4Rv8tyPx32OGRLp/TJw==
X-Google-Smtp-Source: AGHT+IE0fPOgfbwzN3nitu1bZBFLNeMRYlfmhRr9TZwIrF9MGbKkf7r6lClZC0oOg77Z8EEuFoXdSQ==
X-Received: by 2002:a05:6512:3d02:b0:501:bbbb:de1e with SMTP id d2-20020a0565123d0200b00501bbbbde1emr1233195lfv.6.1694769387852;
        Fri, 15 Sep 2023 02:16:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003fc16ee2864sm4070589wml.48.2023.09.15.02.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 02:16:27 -0700 (PDT)
Message-ID: <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
Date: Fri, 15 Sep 2023 11:16:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
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
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2023 11:12, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>>> support the Qualcomm SM4450 platform to boot to uart shell.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   arch/arm64/configs/defconfig | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index ec59174b14db..e91993de865e 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>>   CONFIG_PINCTRL_SDM660=y
>>>   CONFIG_PINCTRL_SDM670=y
>>>   CONFIG_PINCTRL_SDM845=y
>>> +CONFIG_PINCTRL_SM4450=y
>>>   CONFIG_PINCTRL_SM6115=y
>>>   CONFIG_PINCTRL_SM6125=y
>>>   CONFIG_PINCTRL_SM6350=y
>>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>   CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>   CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>   CONFIG_INTERCONNECT_QCOM_SDM845=y
>>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>>
>> Why it cannot be =m?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> Because system haven't capacity of loading ko files at this time on 
> SM4450 platform, so setting to "Y".

Hm? System has this capability. All systems have. What is so different
on SM4450 comparing to everything else we have here?

No, this should be =m and you need to fix your system.

Best regards,
Krzysztof

