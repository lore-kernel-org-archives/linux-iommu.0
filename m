Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7BDDB7
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 11:29:21 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-403012f27e3so23096765e9.3
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694777360; x=1695382160; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOKPrQtwKxSzhyF/0RrIr5RFzt3C+vCUzllNvO9L9aU=;
        b=qkYJFltQffod+qOcFhEMaOZl/3et05AUbnp32dQlQtnBZmt1bCw/zRkD7ZMYgXBPwu
         b6Tt/hUCYsJcQkjfcyVVIZ82xmWlQfvxdG0POvuey/WNrcxmCAgpiiNdnSkWK3psSDFw
         rJcoqW8vLEQAqVS+AJDTgXgM1sBD2PCo4tsCLpdNMRf1XemoVNJS4i+aL0yKoM2nXRB3
         f7hWr8t/EIAc3StPZItobHbK/ddhEjNgYZWFPhsLqpAFdU9Heh/NIt3HoYq5HDW9CfsA
         g/y+jtbLh1mXO+RXA2a5alZVIJkpd5VhBUTnjTA5gmy0dUVCRDUOufQr+fF0toYsnsit
         2prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777360; x=1695382160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOKPrQtwKxSzhyF/0RrIr5RFzt3C+vCUzllNvO9L9aU=;
        b=k9GadSMi91hkpyw/YNCIvWndFlpvOGvuJmrX8ZDA/DM1JnVEwIInIv0m7b69N4mMJ5
         MaOMWB8ZOBvGiA8h8pmul95eyq97NMmxZtx9FqhQtZbO9KNJehoQY00jZ9SMpoM7CnpB
         lN78dI31cnvI2ySNYxSZ/+J/ha6gZfKyvXFzqP3ddIt49ihK52ZqApWkO5xuH/ZE8LsS
         EZW5Po5yaM4fEongsPQ/as5wCHqBONn4TD/vDvJtPkb9RxDREp2Ss7FgMv4n9fx+bIwt
         YNzYWCgysQhPrUs5649TFkW1pgY/IuIxR2u9hj80+X5Ap73zjGGeKZe7w5DRSGdnjNui
         RXIw==
X-Gm-Message-State: AOJu0Yzo0AWYA4hVg7/wrQBDXmCmXqpnIAD5DD67Bo9zXERbdn6g3h3i
	7ktZyq9HwxJMo6ZpehenYNBwqQ==
X-Google-Smtp-Source: AGHT+IEr38/mWh5mpLtWDFh75MFd/hOiBed0DnDtLaMt/qeG5SkPrc/bmhTeLtAB2RW6MNldvvzfpA==
X-Received: by 2002:a1c:721a:0:b0:3fc:1a6:7764 with SMTP id n26-20020a1c721a000000b003fc01a67764mr1374584wmc.16.1694777359704;
        Fri, 15 Sep 2023 04:29:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bcb8a000000b003fed7fa6c00sm7338300wmi.7.2023.09.15.04.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:29:18 -0700 (PDT)
Message-ID: <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
Date: Fri, 15 Sep 2023 13:29:16 +0200
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
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/09/2023 13:18, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 5:16 PM, Krzysztof Kozlowski 写道:
>> On 15/09/2023 11:12, Tengfei Fan wrote:
>>>
>>>
>>> 在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
>>>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>>>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>>>>> support the Qualcomm SM4450 platform to boot to uart shell.
>>>>>
>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/configs/defconfig | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index ec59174b14db..e91993de865e 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>>>>    CONFIG_PINCTRL_SDM660=y
>>>>>    CONFIG_PINCTRL_SDM670=y
>>>>>    CONFIG_PINCTRL_SDM845=y
>>>>> +CONFIG_PINCTRL_SM4450=y
>>>>>    CONFIG_PINCTRL_SM6115=y
>>>>>    CONFIG_PINCTRL_SM6125=y
>>>>>    CONFIG_PINCTRL_SM6350=y
>>>>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>>>    CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>>>    CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>>>    CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>>>>
>>>> Why it cannot be =m?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hi Krzysztof,
>>> Because system haven't capacity of loading ko files at this time on
>>> SM4450 platform, so setting to "Y".
>>
>> Hm? System has this capability. All systems have. What is so different
>> on SM4450 comparing to everything else we have here?
>>
>> No, this should be =m and you need to fix your system.
>>
>> Best regards,
>> Krzysztof
>>
> Hi Krzysztof,
> Find new way which can load ko files on SM4450 platform, still need use 
> "Y", because of some other modules have dependence to these two config, 
> like scm, smmu module drivers, uart shell console cannot be got if set 
> to "m".

That's what I am asking, which device exactly needs it.

> 
> Also do test for setting these two config to "m" on SM8450 platform, get 
> uart shell consle failed if so setting.

Yeah, this we know, I did this. I am asking about SM4450.

Best regards,
Krzysztof

