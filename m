Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8C1854
	for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 06:34:14 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id k19so662898lji.10
        for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 23:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cnm73MX252Caj40ytmqHkjELENAHvDfcWrwZYR1/NVM=;
        b=TBOCPKAISq594QJmpljtXK5JvWglm2X0HAFUA+CLSC4fkmSuZGHuCVimq5IRhaiwTx
         7n4WQRUTkg7StEr07HUdlrnNngap3N9Dpptg779Uy6RPdLngI1bENO1KU+4HhdU6CI4a
         ZZ5n1Iaqhcb7Iuon41ih6fknwVYDtgjnxQZSdyBehcrzqcAXz+3mNlarYN4687J7AIV7
         HMVhwuc6sqyLPIbvRY14983JqnZGW6RK5johigv/Za282R0x8PDSZ2KDQ7rzOR8ERgOB
         WzQTZCGsID/tFmeI8kAwLUJOjqNCw5uRIP+GV8KPUwAChH4hhEmaAlj7NxkxHJ1PSWMk
         kHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cnm73MX252Caj40ytmqHkjELENAHvDfcWrwZYR1/NVM=;
        b=XzF78dReste6S/1Lf8lY7Roj+GqLmlaGTLfpQgOQzJRdlEdH0v3CsH+8jnXHRyV0cG
         j+VstgRaw104MX/u5/VH6aT8cYSgK+jQFSsEi4ndC7YB10K38C0tdbWbYPr7J/UFzOtc
         U5Hfnm80k8xcGYwWfx93n/AaV+NDvi2o8b6XB2/o2VRtzv7zUpQaZLl2T147gtjBDyRo
         h02rfmyaz7LoY0VAyqmx+yaAdW1suheCpWYfs1Ts1Bq4domcGThmb9oP33zDAugpNhYT
         Asry+9ROYhk8R5Cz9dt8DGAlGXE8+D6pmbGMRwM1f/DxcCplUzXeY6MCDk2QXr+JLsHw
         CpXw==
X-Gm-Message-State: AJIora9rcqNjBAAnMaKokYR66iWPLN4rUmFeJX4rteL6oZxSnX7FsLk0
	t8g9s+1dmhqzFpFgGfr/J4oEbA==
X-Google-Smtp-Source: AGRyM1s1d4f5h2aNvGMt18zpn/ZfYfDPXUBZrMkOm4gFgu21R/BTsAfUGEaL5WsUnMIMqTbhpQg8HA==
X-Received: by 2002:a05:651c:1a1f:b0:25d:4517:faf with SMTP id by31-20020a05651c1a1f00b0025d45170fafmr17849916ljb.415.1658385252232;
        Wed, 20 Jul 2022 23:34:12 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512015000b00483e5f0192esm240085lfo.87.2022.07.20.23.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 23:34:11 -0700 (PDT)
Message-ID: <bba2bbbd-834e-d70a-91a4-6f2e989a6647@linaro.org>
Date: Thu, 21 Jul 2022 08:34:10 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
 <57b0cf62-0312-05cf-31ff-d38f83a35578@linaro.org>
 <00bc3a146f39feb1a83213fc8503ad1b52cda9f9.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <00bc3a146f39feb1a83213fc8503ad1b52cda9f9.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2022 05:05, Tinghan Shen wrote:
> On Wed, 2022-07-20 at 19:35 +0200, Krzysztof Kozlowski wrote:
>> On 20/07/2022 14:30, Tinghan Shen wrote:
>>> The System Control Processor System (SCPSYS) has several power
>>> management related tasks in the system. Add the bindings for it.
>>>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 68 +++++++++++++++++++
>>>  1 file changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
>>> b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
>>> new file mode 100644
>>> index 000000000000..4117a6dbc19c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
>>> @@ -0,0 +1,68 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: 
>>> https://urldefense.com/v3/__http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml*__;Iw!!CTRNKA9wMg0ARbw!y63E-9qbCW_vyn8RrsCCs7YvZ7NxKqFT7l8C0ZZirEW95Ec0ce3lwegsSq51wrjtz8GjVSpkK-omCBP5CKx1l0WESQ$
>>>  
>>> +$schema: 
>>> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!y63E-9qbCW_vyn8RrsCCs7YvZ7NxKqFT7l8C0ZZirEW95Ec0ce3lwegsSq51wrjtz8GjVSpkK-omCBP5CKzzr9p82Q$
>>>  
>>> +
>>> +title: MediaTek System Control Processor System
>>> +
>>> +maintainers:
>>> +  - MandyJH Liu <mandyjh.liu@mediatek.com>
>>> +
>>> +description:
>>> +  MediaTek System Control Processor System (SCPSYS) has several
>>> +  power management tasks. The tasks include MTCMOS power
>>> +  domain control, thermal measurement, DVFS, etc.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - mediatek,mt8167-scpsys
>>> +          - mediatek,mt8173-scpsys
>>> +          - mediatek,mt8183-scpsys
>>> +          - mediatek,mt8192-scpsys
>>> +          - mediatek,mt8195-scpsys
>>> +      - const: syscon
>>> +      - const: simple-mfd
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +patternProperties:
>>> +  "^power-controller(@[0-9a-f]+)?$":
>>> +    $ref: /schemas/power/mediatek,power-controller.yaml#
>>
>> We talked that unit address might be useful but it was with an
>> assumption that you will actually use it. I think you don't use it, so
>> it is kind of meaningless now... unless you plan to use it?
> 
> I tried to add the offset in the node name, but the binding check reports this message.
>  	
>     power-controller@0: node has a unit name, but no reg or ranges property

Why would you add unit address without reg? What point would it solve?

> After considering the fact of mt8195 power controller HW resides in scpsys and the current power
> domain driver doesn't support parsing the register address seperated from scpsys, I decide to
> keep the power controller node as in v2 to pass the binding check and compatible with driver.

Then adding unit addresses in bindings has no point.


Best regards,
Krzysztof
