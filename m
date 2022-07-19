Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322F10E9
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 08:50:33 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id d12so23574607lfq.12
        for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3pxJNE6gYc8cb6d4rkA2eV3Aswi0lfTlAlrCacdvP2w=;
        b=ijFr0es238AtzUmBFcdhNq9P7S2bQTfENXLr/NSqt5rREGLk235GS2OEVXk806dVZu
         LZhIf326MJ344Gx/3K/y1+Q6E/BWtau/4SA8q6hRckQA2KZEcTBciFBoUT+zTJN3gZaw
         bFBVZKNsc1osyAVPJRoYq8QtRgh72fYlykSBxstzpzgPawA/NqvgBZs+xrpGXLRWJhjT
         9SD45XZSuqB7Vs8eD2J9dcHuuZZpQhFfY+3HxlEDezCy6d74cAfqv7KzmJjpiPVDUPtG
         V1426Zg579DI0aFdtzg9S6F1fJK5ZFHyrAIZvjtii2W5Ch4dtUqAJY9efj+r6HtPk7BL
         k65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3pxJNE6gYc8cb6d4rkA2eV3Aswi0lfTlAlrCacdvP2w=;
        b=glO9nX4q6ibkB3d5/qM5lQX5/ikjlDQULEyjoixyJaVjWUxfMnk4B6EYnN1+Wka3Av
         4EsIaru6/nWpRJYm0lEKn+7wh8R4q88nF778sDcOlrh9YKvgF5D3Ay9CykxL2BJarmz7
         fMCg6ttKI8wFp0o241UrmYZx1+e8ayFY+RHZI9LuCTTdOdTgXJ3RZBJIxuvSpVz+qOib
         qhZswPT0ICttQx16zVEoEvIR/JEc4m0wC8IaC6QXvKGJjrmqpIltcArYFcWwBlK9P+C0
         F3ryDkqiYWzO5X+Gxxf/kU9XGBmPePjR9IpJb4KE0hhXBElRAP1deqOy6/J8DKKTfvOw
         lNGw==
X-Gm-Message-State: AJIora+0tkRSk1PuH3+hrk18abG+DaYYAHJvG6qYiQIzA8vcSBmR2gLK
	/Twqa4V09h34lkfQruy2UG7Y6Q==
X-Google-Smtp-Source: AGRyM1us868YPpB392tMn7H3KK4A7rfaBwjaayrkHiss5VCTlo/g5OiMzIp0NjvcgAuBi9wC02cPVg==
X-Received: by 2002:a05:6512:1595:b0:489:da32:ec68 with SMTP id bp21-20020a056512159500b00489da32ec68mr16232700lfb.573.1658220631316;
        Tue, 19 Jul 2022 01:50:31 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id e22-20020a195016000000b00489de206812sm3061580lfb.151.2022.07.19.01.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:50:30 -0700 (PDT)
Message-ID: <2a7280cb-2bcc-4297-8beb-a9249c5bf899@linaro.org>
Date: Tue, 19 Jul 2022 10:50:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-4-tinghan.shen@mediatek.com>
 <46df4ad5-5102-b5fe-95b7-5b157fb28f01@linaro.org>
 <c4480c9ea0822ae693ff6a501c073c365e983b83.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c4480c9ea0822ae693ff6a501c073c365e983b83.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/07/2022 10:17, Tinghan Shen wrote:
>>> +    syscon@10006000 {
>>> +        compatible = "mediatek,scpsys", "syscon", "simple-mfd";
>>
>> This should be a SoC-specific compatible (and filename).
> 
> Ok. I think that you mean "mediatek,mt8195-scpsys".
> I'll update it in next version.

Yes.

> 
>>
>>> +        reg = <0x10006000 0x100>;
>>> +
>>> +        spm: power-controller {
>>
>> I think you created before less-portable, quite constrained bindings for
>> power controller. You now require that mt8195-power-controller is always
>> a child of some parent device which will share its regmap/MMIO with it.
>>
>> And what if in your next block there is no scpsys block and power
>> controller is the scpsys alone? It's not possible with your bindings.
> 
> Do you mean a power controller node that looks like this?
> 
> scpsys: power-controller@10006000 {
> 	compatible = "mediatek,mt6797-scpsys";
> 	#power-domain-cells = <1>;
> 
> 	// ...
> };

Yes, I mean, with an unit address.

> 
>>
>> Wouldn't it be better to assign some address space to the
>> power-controller (now as an offset from scpsys)?
> 
> Is this mean adding an offset after the node name?
> 
> spm: power-controller@0 {

This or above. I think it does not matter for the bindings - it's an
implementation detail, whether you give to the child absolute SoC
address or you give an bus-specific (scpsys) sub-address/offset.

The point is that you have an unit address, thus in the future this
could be a device node separate from scpsys.

Best regards,
Krzysztof
