Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532823A8
	for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 10:44:19 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id r2so30113724wrv.7
        for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDFJAyxdwlXAceDq2HEyYot6ddhmeIhv2ZNqpa+nXCY=;
        b=mejaY73R9K8EQWWiawJO1bS1S6I4yHsgrohDuS2fhH8cueOsSYZi42eZLXw2ZhqfBj
         VIdfM3A2WiHmJi7wglW2fcZkPTPCRHfzFakebE0hzRReQV2L7HsuxA2i34ae1WWZMxEj
         EGS2JQ+ZG+kG2WmARA0PqObGq5tHf7RJAHgYOF2Vbsd95qaBGg6YCWwCGWiaLPq3+q/a
         QJyxBskSEfe06Z1XJm87x5j8m4UP5stOlFmg0xJ/j5aa1rttQdPDMY90q3XVVu0k7kKi
         gYwlkW123cPMsiJAJFT6JbsNlUip9QDE9CrBkKfQwt5TTVbCKBSgTa7kvMIijQLLb+Hw
         RlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDFJAyxdwlXAceDq2HEyYot6ddhmeIhv2ZNqpa+nXCY=;
        b=lCChjT3mic9Np4x1vKb6jb3LfA2xtge2O3/boKh7qpuxUBJDuy1gZBEZwGizJ1GEFh
         NvFnGOu73IO+DzFVghsIWCgMzRlmj3cOK1SSHNsZYAYHd7HqfWCzHcNaxRmvPBu0vb+u
         w6ewDgmtq2+ynyXDMUThqd1ceUmEMUb3UeLGO6cKj8Qo2LvAQ9ByyScOL3OQZW28zxIR
         0+DuuozhZ94xkJYoVVFKo/KBrbR9Xn+L9QeG96BkCqBe8AKXJL+/WgzTyzZNu6Q2DlXC
         KTKAkK6yg1iPOc7nBIBe54xLnkwYPrpsGGVeL6vRDNdQ1yqK4BmiyAqbZOxHp2z9gi2Q
         5SYw==
X-Gm-Message-State: AFqh2kprQPDstcaFIoHD9C7z3gavdW4S5kkpS5mZk7lBrzjP/LfTeSBr
	PCoc6+FzFBuLoOBAyIFs1blmdg==
X-Google-Smtp-Source: AMrXdXtZBBAJRszEFQuiAI8oVhKjjwBpWztQ8LR+hAfpx5+gygc/xT1aXjwWWGgP9vgzwbJyvxRKDQ==
X-Received: by 2002:adf:fa4e:0:b0:2bd:d415:39c with SMTP id y14-20020adffa4e000000b002bdd415039cmr12015109wrr.4.1673952257509;
        Tue, 17 Jan 2023 02:44:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4091000000b0028965dc7c6bsm28121074wrp.73.2023.01.17.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 02:44:17 -0800 (PST)
Message-ID: <3c7e9a5f-24e3-3486-11f8-556428947423@linaro.org>
Date: Tue, 17 Jan 2023 11:44:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Content-Language: en-US
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= <tiffany.lin@mediatek.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
 =?UTF-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
 "kyrie.wu@mediatek.corp-partner.google.com"
 <kyrie.wu@mediatek.corp-partner.google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
 =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= <Chengci.Xu@mediatek.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "joro@8bytes.org"
 <joro@8bytes.org>, =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?=
 <Yunfei.Dong@mediatek.com>, =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?=
 <YF.Wang@mediatek.com>, "nfraprado@collabora.com" <nfraprado@collabora.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= <Mingyuan.Ma@mediatek.com>,
 =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?=
 <Andrew-CT.Chen@mediatek.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>, "will@kernel.org"
 <will@kernel.org>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-2-yong.wu@mediatek.com>
 <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
 <796e7fb8619d114c63580e5c4289c59a57449843.camel@mediatek.com>
 <2e2a0c70-86d2-7ba1-c87c-aaaa9dd460b5@linaro.org>
 <3da13600844b8a6c3b788bdb26faa537d0287173.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3da13600844b8a6c3b788bdb26faa537d0287173.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/01/2023 10:16, Yong Wu (吴勇) wrote:
>>>>>
>>>>> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
>>>>> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
>>>>> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
>>>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>>>>
>>>> There is little point in storing output of get_maintainers.pl
>>>> forever
>>>> in
>>>> the git log. If you need it for some reason, please keep it after
>>>> -
>>>> --.
>>>
>>> I did get the list from get_maintainers.pl. Sorry that I didn't
>>> differentiate.
>>
>> Getting the list from get_maintainers.pl is correct but storing it
>> forever in git log is really unnecessary. It's not useful. It's just
>> automated output, reproducible at any given time.
> 
> This patchset crosses several domains. This patch is about vcodec, the
> next one is about jpeg and the later ones are about iommu.
> The reviewers may be different, thus I use "Cc:" here. is this OK in
> this case? 

I guess we do not talk about the same thing. It does not matter that
reviewers are different. They are all different. Please show me the
direct benefit of storing automated output from a tool in Git log.

> or I should remove this, and put all of them in the cc list
> of the mail.

I gave you the instruction at beginning, some mails ago...

Best regards,
Krzysztof

