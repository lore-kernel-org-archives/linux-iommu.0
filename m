Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CC3C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 14:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75AD483E46;
	Wed,  6 Jul 2022 14:35:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75AD483E46
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J6aEaA93
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJjG7ArleqdL; Wed,  6 Jul 2022 14:35:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46D6883E37;
	Wed,  6 Jul 2022 14:35:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46D6883E37
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D2FAC0033;
	Wed,  6 Jul 2022 14:35:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D598EC002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF62383E42
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF62383E42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nkzx37ju25Rk for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 14:35:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EA1883E37
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EA1883E37
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 14:35:21 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id bf9so3029122lfb.13
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=vHzDk8iDFWu26W/brex+TMJ8rS3+AlVCn+1TtO/d/+w=;
 b=J6aEaA93f6HARN0t/xaA82XJaM88rLxgWepc8chGBv0nECRXeki8VoeFiLxbk0bD0W
 NECJ1vNaouHr3IyfPJEcxgkOj5p/xbvUvyLBpytO37yN5u2UmbJsFcNzJcn8NDBHt48k
 JOlyQBmcRJvvQf8MhHEF3PAlZN4cTRpAnGlU0PTzFmYT9irpHiG9yN6guR4setcg9okh
 dl+iEju53llS49uZgo+DBoF4kdjp+Zf0F1AVuNlEU+e+xQx0H65pxWjQK3ephirk+aB7
 y80eFot9nKxq9aXCX7zRAlAlSMsOjjstIDgHEv/NqvjjABvIw66RIQ3wHPtNeQ4dNH2w
 yu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vHzDk8iDFWu26W/brex+TMJ8rS3+AlVCn+1TtO/d/+w=;
 b=XH2JqzWqZmEYDX6EVpnAdUj/Ap6J3pBCRRrkqY1OwhqQ/wTAxQd8HUZ1Im8GWPamjp
 MPY+c4OQkJK1fIuXIPO+jn+5REyBO74jTqtRDry4ljFsdGb92vj0q7+oItjr7hYzcyId
 rrXDXIXDZjNMZhKqZwA0sNNZZEpikWRey6Tf33k0pfYFD4DTiZTnKKKMUT6IrK2Wy2/h
 OMJLHVDVzVqM5Ag6I7UGGJ4KvKTsYViiipEvBtd4z8VTHkzduoSqWbKReQIWYsXu1x2F
 u8L1r61JzC03vwbmrm8A6bez+zAlOFp1N1RGxMeMAezzfy6Cw6I50ZhcSunWusNsYkCx
 /Kaw==
X-Gm-Message-State: AJIora8cf8/sLJjkKCq1py7khyGrl8MzEc6gGIYHKyc4YhIJ6TN1FX24
 9r1MwYu20lfAMy2scfaPdED8cA==
X-Google-Smtp-Source: AGRyM1vZt21fHb4CPWwcERIsmHIfne9uEYyXkXvwQU6KzIQn9abhEBmceqxhXa74eYVxw2w3BF7y/Q==
X-Received: by 2002:a05:6512:32c1:b0:47f:9d5b:d558 with SMTP id
 f1-20020a05651232c100b0047f9d5bd558mr27803365lfg.488.1657118119332; 
 Wed, 06 Jul 2022 07:35:19 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a056512349700b0048600adb5d9sm425876lfr.10.2022.07.06.07.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 07:35:18 -0700 (PDT)
Message-ID: <27c99ecf-75ab-1798-2b59-3be397d153d0@linaro.org>
Date: Wed, 6 Jul 2022 16:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
 <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
 <17203a8a-407e-30cf-79de-352716c3ebce@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <17203a8a-407e-30cf-79de-352716c3ebce@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 06/07/2022 15:41, Matthias Brugger wrote:
> 
> 
> On 04/07/2022 14:38, Krzysztof Kozlowski wrote:
>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>> Add power domains controller node for mt8195.
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>>   1 file changed, 327 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> index 8d59a7da3271..d52e140d9271 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> @@ -10,6 +10,7 @@
>>>   #include <dt-bindings/interrupt-controller/irq.h>
>>>   #include <dt-bindings/phy/phy.h>
>>>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>> +#include <dt-bindings/power/mt8195-power.h>
>>>   
>>>   / {
>>>   	compatible = "mediatek,mt8195";
>>> @@ -338,6 +339,332 @@
>>>   			#interrupt-cells = <2>;
>>>   		};
>>>   
>>> +		scpsys: syscon@10006000 {
>>> +			compatible = "syscon", "simple-mfd";
>>
>> These compatibles cannot be alone.
>>
> 
> You mean we would need something like "mediatek,scpsys" as dummy compatible 
> that's not bound to any driver?

Yes. syscon (and simple-mfd) must always come with a specific compatible.

> 
>>> +			reg = <0 0x10006000 0 0x1000>;
>>> +			#power-domain-cells = <1>;
>>
>> If it is simple MFD, then probably it is not a power domain provider.
>> Decide.
> 
> The SCPSYS IP block of MediaTek SoCs group several functionality, one is the 
> power domain controller. Others are not yet implemented, but defining the scpsys 
> as a MFD will give us the possibility to do so in the future.

No, quite the opposite. Having simple-mfd prevents you from implementing
it correctly later as a driver, because you cannot remove it. It would
be ABI break.

It's fine to have one block being a simple MFD having several children,
but then it's not a power controller. Children could be such power
controller, but not simple-mfd. Rob explained this several times:
https://lore.kernel.org/all/YXhINE00HG6hbQI4@robh.at.kernel.org/
https://lore.kernel.org/all/20220701000959.GA3588170-robh@kernel.org/


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
