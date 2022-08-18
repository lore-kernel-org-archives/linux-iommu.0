Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1125C98
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 07:42:39 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id o2so1107628lfb.1
        for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MShj7bLv/0nXMa1+Mpubq1Kb89/01zNVMLHcgTT9z2k=;
        b=YHqqkucWXRjBvTIxJw0qxFunWWDJ3R2dX3GNCnIzdCv4OlisfZbhurbjMi9j1Soj+W
         47ltrVwrnQpn7+p9sFPfXVH3aIbJMWSKa66QQvxao/SVEM68GsP0P26yQ4B+n6o4OpvV
         f0PkBk6GImk/jSuhRcNp4b4p7WqXQcqwqjOMcFVf/vE5ttwif1GAwWHtHzM1RZc3sOyt
         SwEaDTWRR8bQqw2qd3n47Rfe8JZqCQDjf1/f/IEjWhHC5xWtBFKhm7221NfK17rZ+ciA
         YKbCGMQUMzgWdPAExP5QC8S0RIIW6I8/mNGXAe6rbyjMkzyCm6pSOxx0iID28wmeWS+5
         A+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MShj7bLv/0nXMa1+Mpubq1Kb89/01zNVMLHcgTT9z2k=;
        b=fKN0BNxdATwYXL1UGSfLjAqLIUk+ePx2tZHFP+BdcjPUp1m9G1WHWtvr7PJp6AzboP
         qxpSyOxakU3NQScyWFTb4rES0X5RtCE2QlKdj3Fy0Gm/JFg6M1fosC89cO4yfC4NZitB
         wO2Oq66KNq+FkIvxLAZo0Oq84D2MW0wP2B2ZgnnId0jEVAf0Ib6lf8ZNlnp3kRkHPyJs
         cUgB3K5V3aurVl6q6rAc3UmTx3KZKljcRDJp37otroOfp9i5ZW0o82o1CYxKSbeALXSs
         AmUHYbbtgvkaMwukL+xnMwCPAWB63tK70Q1vhj8zmiRnB0at4Riz5r/IFIA/MQYStCCX
         klhQ==
X-Gm-Message-State: ACgBeo13yjU38ijdvHJSk1kI5f/N3LyJQ1TM2U1Q8jKxuLwKL8LxD53P
	5Kh328q3XhJsgoB5OlVVDqi5qA==
X-Google-Smtp-Source: AA6agR7PpZvNHmLb+qevA7oB617jiMAhR6HzQHvikURalXdanu3cXl5ZOPY+cac1GOxiwZ4UbXAsxA==
X-Received: by 2002:a05:6512:ea0:b0:48b:2d45:f254 with SMTP id bi32-20020a0565120ea000b0048b2d45f254mr545086lfb.365.1660808557206;
        Thu, 18 Aug 2022 00:42:37 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id y8-20020a05651c106800b0025e42f8e771sm118132ljm.34.2022.08.18.00.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 00:42:36 -0700 (PDT)
Message-ID: <61c0d3bf-cf1f-77f0-bb47-dec7cde5b488@linaro.org>
Date: Thu, 18 Aug 2022 10:42:34 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: mt8188: Add binding for MM &
 INFRA IOMMU
Content-Language: en-US
To: "Chengci.Xu" <chengci.xu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220804105834.626-1-chengci.xu@mediatek.com>
 <20220804105834.626-2-chengci.xu@mediatek.com>
 <ae06f644-b988-8fc3-fde8-258299f8f2ae@linaro.org>
 <f34db3a295b8c83e03bf79950cc25d39b6f81240.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f34db3a295b8c83e03bf79950cc25d39b6f81240.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/08/2022 10:26, Chengci.Xu wrote:
>>>      then:
>>>        required:
>>> diff --git a/include/dt-bindings/memory/mt8188-memory-port.h
>>>  b/include/dt-bindings/memory/mt8188-memory-port.h
>>> new file mode 100644
>>> index 000000000000..612fd366c3a7
>>> --- /dev/null
>>> +++ b/include/dt-bindings/memory/mt8188-memory-port.h
>>
>> Use vendor prefix in filename, so mediatek,mt8188-memory-port.h
> 
> Is this a new mandatory rules to add a vendor prefix in dt-bindings
> file name? we have never add a vendor prefix before.
> 
> If possible, we'd like not to use vendor prefix for the consistency of
> fliename's format(mtxxxx-memory-port.h).
> Such as "mt8195-memory-port.h" and "mt8186-memory-port.h".

That's a generic rule, although loosely applied. The consistency is
rather to have a vendor prefix everywhere. Why Mediatek should have an
exception?

Best regards,
Krzysztof
