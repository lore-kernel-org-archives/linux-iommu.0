Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752353D8C
	for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 14:09:01 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id eh3so6646442edb.11
        for <iommu@lists.linux.dev>; Tue, 14 Mar 2023 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678802939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzJAUCZ6cxLrmbrtWQpROUkZsp4GEMuB07PexleiZ+w=;
        b=XWYGpCXsXZSlzHoyVy0l5aiph3FOO2/v3CYmo3g2Q6Y8p9WODnROgeWPRB5msTBbwo
         7l3tqUWOjzgqts93xe51UgHj5V8paUByMG2sa5LGco51hN5okT/iWqxklrtCwG1riHhc
         3MB+mkutYvDHWdjhcPs3ly350WIiGXC3lDrE7poc+bBNajIbhM+sJ8hiWZW808Omn0lU
         P6F7w1GsdIwRxU/8jTii8fyE/wvXgit0oCCGkjYGf+ha0qAJnVSnubn3Jd6Fi27kI8DL
         rPsX+XA/nChlURMKCHsIUW/eLGf782bfXH+Iot8jOvHbbOkTi0jqXfSITCHp4OgMWKha
         dkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678802939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzJAUCZ6cxLrmbrtWQpROUkZsp4GEMuB07PexleiZ+w=;
        b=tLHOGH8ylTF89dcsqD7TdA4/iTZOn8pc2O5cxxwwWIJQ7Gwzyeq4+QIkdqiR7U4fft
         NE16JmsOMbVfHeYspgC9D2t3CaKBfQDAT9sry47f0y0Jd64sbcMpdFzv6+bFfYcLAR0u
         mI/Pg2H+dtmoRQsJXHF7mkTIB4yOCHUNPI7tJJni0DRV99i9TcDPvUwnF5gcIArj6qyE
         w3m4aD3xXC5k7XwSWKervEK7MlL8X1c2TwRorfNFqTjV3Fld5/7Ys0NiZiPIlLnRdF/p
         xnhuLU5p0BjfVInp/CUM5kL/FDJ/UQglVj95RI1j9LfROFbOwSjzax6J93/gW7ShjBBX
         ngeA==
X-Gm-Message-State: AO0yUKXnNBSeS4/ey6reH6bTWvewYJ8uSRpR2vUdQChpg7bIRZRlfmMr
	XEfIVOxTybfK08BrwHw+I43BUQ==
X-Google-Smtp-Source: AK7set9aDeRx5ilJ6vQTpGKrxu3nveAK78en09LF2SpzRa5pCE4uh4jYbgWXGNpLBKydzg7vdbhePQ==
X-Received: by 2002:a05:6402:692:b0:4fb:892c:9ec7 with SMTP id f18-20020a056402069200b004fb892c9ec7mr8065848edy.18.1678802939660;
        Tue, 14 Mar 2023 07:08:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b004fce9ff4830sm1079104edb.88.2023.03.14.07.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 07:08:59 -0700 (PDT)
Message-ID: <d3e49808-368d-f92a-b710-6d359fc6b7c2@linaro.org>
Date: Tue, 14 Mar 2023 15:08:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 1/7] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?=
 <Jianjiao.Zeng@mediatek.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= <Chengci.Xu@mediatek.com>,
 =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= <Mingyuan.Ma@mediatek.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>, "will@kernel.org"
 <will@kernel.org>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-2-yong.wu@mediatek.com>
 <388e2274-d46a-68a4-3e85-5bd597085041@linaro.org>
 <aba29e7fd9a461f2d94c83cf2c7496521433847d.camel@mediatek.com>
 <4ac7e2e0-9b19-c911-7297-3510e55d6cfd@linaro.org>
 <43989ca5ffa67be0a21874dbdbdf38872f16378e.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <43989ca5ffa67be0a21874dbdbdf38872f16378e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2023 11:14, Yong Wu (吴勇) wrote:
> On Tue, 2023-03-14 at 07:46 +0100, Krzysztof Kozlowski wrote:
>> On 14/03/2023 03:41, Yong Wu (吴勇) wrote:
>>> Hi Krzysztof,
>>>
>>> Thanks very much for your help review.
>>>
>>> On Wed, 2023-03-08 at 11:35 +0100, Krzysztof Kozlowski wrote:
>>>> On 07/03/2023 09:05, Yong Wu wrote:
>>>>> From: "Chengci.Xu" <chengci.xu@mediatek.com>
>>>>>
>>>>> Add descriptions for mt8188 IOMMU which also use ARM Short-
>>>>> Descriptor
>>>>> translation table format.
>>>>>
>>>>> In mt8188, there are two smi-common HW and IOMMU, one is for
>>>>> vdo(video
>>>>> output), the other is for vpp(video processing pipe). They
>>>>> connects
>>>>> with different smi-larbs, then some setting(larbid_remap) is
>>>>> different.
>>>>> Differentiate them with the compatible string.
>>>>>
>>>>> Something like this:
>>>>>
>>>>>   IOMMU(VDO)          IOMMU(VPP)
>>>>>       |                   |
>>>>> SMI_COMMON_VDO      SMI_COMMON_VPP
>>>>>
>>>>> ---------------     ----------------
>>>>>   |     |    ...      |     |    ...
>>>>> larb0 larb2  ...    larb1 larb3  ...
>>>>>
>>>>> We also have an IOMMU that is for infra master like PCIe.
>>>>> And infra master don't have the larb and ports.
>>>>>
>>>>> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
>>>>> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Indeed, I missed broken checkpatch/DCO chain.
>>>
>>> Just confirm what this means.
>>>
>>> Do you mean MAINTAINERS need to be updated since we add a prefix
>>> "mediatek," for the header file?
>>
>> No it means, run checkpatch.
> 
> 
> "WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does
> MAINTAINERS need updating?"
>   
>  This is the only warning when I run checkpatch. I will update the
> MAINTAINERS in next version. Please tell me if I missed other parts.

Hm, I guess you are right. Your Signed-off-by is missing.

Best regards,
Krzysztof

