Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F423CD
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 07:48:30 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id w5so1104389lfq.5
        for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Gtx/1NtYRUpYFSNfi/ck/6ru5mDdKGyHys400ty/Xyg=;
        b=pA3vT8XbKPIIhMfNE2PsUnmxJJkmWap6JQJqjWxUjeuEtfkhAgrmbdfO6Yu/ZTLP7+
         SI16XaknZ5obeqxRLBGSBSc/1r4y45MRiSyeB6pwmB+cHec/6aTD4/5RxkzzmL0Ot/9z
         ucg0vtkF5wz+5MDMOvy8h//s+2H7ILParQqB74iLotZzx2nxXSbGhZQI24Ixe40Is7v0
         65gvD5eRu1tOo3oAL0u2bfaNj4l7CH9hHkZSIkk5HWj+82cUPcedRrWETKf4N+2+mHdR
         mseUANI8JD0T1a+1+jpxDM6W0m72On92z7wq5nbOpfJsU3BCUQBKBF/iRSe/qQwiJCap
         xc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Gtx/1NtYRUpYFSNfi/ck/6ru5mDdKGyHys400ty/Xyg=;
        b=frOkNlnmw/ALTFYd//6ztyOZAi5ipfO8m1KeSDugRehD/1EKxOxzldlsz0KUbU6QGa
         vBwMiMRsPksDDeA/Bd6Oc7QVMdLUc4WqVbNtKVj8yAFIVoi+n/eqSIY0wznedGJQDVOk
         6Q3n+eiLvNguIdDtNphwY7T2MGpY8CoZR4ilWG2NEqHy5l287BG0sjWLIdfISbdewyC7
         lxdMLah9Z/qJft1iyN0/+tsmv2MGMwvhHioRTN0Y4X2X++z9mKfQ4UVsyHmOR85nrIbu
         LRcTpJlwvSz6XRsYTe0WECQGxM2xID8PU6LEd/eq6vAFdIbVAiLmNSWd0TDEDIIlH0F1
         7w2g==
X-Gm-Message-State: ACgBeo1PNIf5jyREwD+0+hESwJ8gj1XJets5gnjAU/cd2yWnuDckPqSg
	KqzRz3lMQuQ81H6ZMvQ/4cN0mg==
X-Google-Smtp-Source: AA6agR4KTEWECDn55d+h9/m11+vRY/poYCh80L5VL5lneKWL68GDtDsqJbwN9MQNwzUWsQWSiQTv3g==
X-Received: by 2002:a05:6512:201a:b0:48d:1101:cc9b with SMTP id a26-20020a056512201a00b0048d1101cc9bmr644396lfb.152.1660808908249;
        Thu, 18 Aug 2022 00:48:28 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:53ab:2635:d4f2:d6d5? (d15l54z9nf469l8226z-4.rev.dnainternet.fi. [2001:14bb:ae:539c:53ab:2635:d4f2:d6d5])
        by smtp.gmail.com with ESMTPSA id v10-20020a056512348a00b00491203d6cc9sm121513lfr.131.2022.08.18.00.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 00:48:27 -0700 (PDT)
Message-ID: <5a916595-12ee-92e6-d380-84146dd75218@linaro.org>
Date: Thu, 18 Aug 2022 10:48:26 +0300
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
> On Thu, 2022-08-04 at 13:13 +0200, Krzysztof Kozlowski wrote:
>> On 04/08/2022 12:58, Chengci.Xu wrote:
>>> This patch adds descriptions for mt8188 IOMMU which also use ARM
>>> Short-Descriptor translation table format.
>>>
>>
>>
>> Thank you for your patch. There is something to discuss/improve.
> 
> Tkanks for your review.
> 

BTW, none of your emails seem to reach devicetree mailing list:
https://lore.kernel.org/linux-devicetree/20220804105834.626-1-chengci.xu@mediatek.com/
which means they won't pop-up in Rob's Patchwork and won't tested by bot.
https://patchwork.ozlabs.org/project/devicetree-bindings/list/?series=&submitter=84571&state=*&q=&archive=&delegate=

I wonder if this is the same issue as with other Mediatek emails
filtered by spam...

Anyway, you should sort it out, otherwise patches won't get to Rob and I
won't apply them.

Best regards,
Krzysztof
