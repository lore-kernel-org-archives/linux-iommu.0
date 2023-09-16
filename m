Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F81103
	for <iommu@lists.linux.dev>; Sat, 16 Sep 2023 20:31:00 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so727208a12.2
        for <iommu@lists.linux.dev>; Sat, 16 Sep 2023 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694896259; x=1695501059; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EL+k7hXUShrLVxaFRObx7bendR710WJmkBqa6SXN9Ds=;
        b=lorC1lOLdfjwQtRsBcDgHVZI5YYcTsyPwBUbf7ux1KZ11056GcYqDrpu9b/rbWr/Ka
         TS3zM2lTHLHWrF60UBnI2U8FpfqC6kD3r2tRFA36a3xOjf5ZKhzT44C7JTUq4MlQNPCT
         mlAs7uDaaEEDZaLYPzwLU9zdRkuEOGe8qPfv96n3W1mIcF3M40Di5Pw6wsBZAuMnwvLe
         f/fAGyx/Zw6rsVLVEgYRvKNAS4WYmljQZkDI88rJzQR1N40E0QTg3tyeD4oaOfZzKSo9
         BLQTNtMZfMzvl6QHvA9flYU0lgK7x1kXgK6jHgjN08CJOLZWIWqMs9YAHkSpsKpJLi3/
         lmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694896259; x=1695501059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EL+k7hXUShrLVxaFRObx7bendR710WJmkBqa6SXN9Ds=;
        b=BmWH52z5SFiR6ZRSFzoH6yivo57cS6X4QUIAZ17bwOR2+nEurPtbZBHXT6IpJsJ8dS
         D7Emtvpi/lDq0RgUzzp+kUyWYHCB8ORiOW7bOJHQMD0rE0JyX6yEHzSa3yfn2mvtC263
         sYCWW1kdkjt7/g2dtg/jbbzQeR/v5OqlnCm6tz0TxQcXhkNMk5ij0SeEBqOJIBjRiJ2p
         Mh1S0M/ThPkBf6BgILmN2fW6yzDArDHqpw++HsT/uXYuxjMFH/eZ/qDTkXSNXQ68cd9J
         Ur1R6zp41FFMTTTnMElAabXs4PM0/8e6Bixq83LhgGKdlanFe6K/b4whhfjN6EWF/uFD
         OfNQ==
X-Gm-Message-State: AOJu0YwIhS6AjrL/KOva5l+hZRvI/rHJcL3NTSD7EkEj9pNo4HPXkRpb
	KRQDtgRODrxiB6uE4gtLUL4NjQ==
X-Google-Smtp-Source: AGHT+IFqKWQZecXMTFwDFX2obiJHXcFY1D7b0lePfOb4l9+gqCiVAiuXCUAe/qvDTJXhP/OKrM5x5A==
X-Received: by 2002:aa7:d142:0:b0:52c:9ce1:f117 with SMTP id r2-20020aa7d142000000b0052c9ce1f117mr3679643edo.40.1694896258889;
        Sat, 16 Sep 2023 13:30:58 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402516400b0052fc0832e08sm3909853ede.1.2023.09.16.13.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 13:30:58 -0700 (PDT)
Message-ID: <40216ed7-22a5-01e6-6863-dff31c9e1ec7@linaro.org>
Date: Sat, 16 Sep 2023 22:30:56 +0200
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
To: Trilok Soni <quic_tsoni@quicinc.com>,
 Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, catalin.marinas@arm.com
Cc: geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
 nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_shashim@quicinc.com,
 quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
 quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2023 04:21, Trilok Soni wrote:

>>>> No, this should be =m and you need to fix your system.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> Hi Krzysztof,
>>> Find new way which can load ko files on SM4450 platform, still need use 
>>> "Y", because of some other modules have dependence to these two config, 
>>> like scm, smmu module drivers, uart shell console cannot be got if set 
>>> to "m".
>>
>> That's what I am asking, which device exactly needs it.
>>
>>>
>>> Also do test for setting these two config to "m" on SM8450 platform, get 
>>> uart shell consle failed if so setting.
>>
>> Yeah, this we know, I did this. I am asking about SM4450.
> 
> Why we have =m requirement when other drivers above are =Y?. Can we confirm
> w/ Georgi? I am not aware that Interconnect drivers needs to be =m only.

There is a requirement of all drivers which can be a module, to be a module.

Best regards,
Krzysztof

