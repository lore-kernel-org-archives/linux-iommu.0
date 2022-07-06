Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23577C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 15:18:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A220883E06;
	Wed,  6 Jul 2022 15:18:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A220883E06
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tlOoP70f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjfXv3sbdq_T; Wed,  6 Jul 2022 15:18:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6AE7783C28;
	Wed,  6 Jul 2022 15:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AE7783C28
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C1BCC0035;
	Wed,  6 Jul 2022 15:18:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C55F3C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 15:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F41560FCC
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 15:18:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F41560FCC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=tlOoP70f
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iGm2RBCaSYgG for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 15:18:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8713D60D53
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8713D60D53
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 15:18:44 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id y16so26449912lfb.9
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=o34sXf13gS9dNYvfC/d9+rktJGbU/41tC7AjUNaoSfE=;
 b=tlOoP70fhClmeDGn6OyYtjbxbmb1OaS8KTC422YM24182veuP3d/kvBY7X+d7EJ367
 LaLee21l5oFOZHt/LERQLQuMZzVzBH4W1Uh3S+LeoStH84qKP704G6G6+hDP8o5A8rdN
 RIO7uSW8KL2kgCuCd+wAUF+QisuRSOwhJAxD/MU8ilFjcj1leWnB5Y4fXz7MuuNd0yek
 7aW5PBGTVYZxViG2+A/e8POYcjpJoTfFaN2KaJxBMp/VxNjgGE6tr/PdyGWBzorB8GGv
 Dz6um5/CIwWVK5q1quxiJt0dasAVA/TqoJB0lGiZBlLbTulmwkVUCyz4LAVmm6L2SDAa
 wYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=o34sXf13gS9dNYvfC/d9+rktJGbU/41tC7AjUNaoSfE=;
 b=GRk5fe+RuVbyxAPmW+ox4aXqgLcCj/qszH4a+uZc9sWD4Bij3U80dbA/UFF8R+XrIt
 DfaOQkJ3gb20fn1Hm6bHlu67Ia8LTGqCT7NqEGGs3T3JtdTCrQLgMsImSxPhoO/3h2h8
 BMuA+8GIhsfze4YM+Z4boli33TGLROIBcG6KUahvgjWlcUOs/YKS39YvyJVp8OOl3Y8g
 mygTfDDa1qEpHdj3zp2pqvWxFmdsJBh9Ig/Iz01Pa/7W1Fz7DUMjOTjEwJFf7+MK7dSl
 v4sA+BkDsNJsDvuBf8WQXwhzXfdb2b7PhBhD8SX1tID3RIbBFrnG2W5/aOBwlC52KFe7
 GTew==
X-Gm-Message-State: AJIora/gPfUepoOH83gdCM1wuFXGsY+SQWxNHotHPSh7PQpz9ioAEgSn
 bwyeUDaoFyj9RObQ/J48ETZk5g==
X-Google-Smtp-Source: AGRyM1vdzcWdQzM1UmXWIIm9OeMBRjPNPblppO/1Nm2JRbLD3Lswd6x84BFNiMqKX8XEm3f7WV8inw==
X-Received: by 2002:a05:6512:3fa7:b0:47f:7387:926c with SMTP id
 x39-20020a0565123fa700b0047f7387926cmr25769600lfa.98.1657120722496; 
 Wed, 06 Jul 2022 08:18:42 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a056512208a00b00486944fe8d5sm313121lfr.238.2022.07.06.08.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 08:18:41 -0700 (PDT)
Message-ID: <0301ebc6-1222-e813-f237-f14ad8444940@linaro.org>
Date: Wed, 6 Jul 2022 17:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
 <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
 <eec6aee5cd023fff6d986882db0330e1ab85a59d.camel@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eec6aee5cd023fff6d986882db0330e1ab85a59d.camel@mediatek.com>
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

On 06/07/2022 14:00, Tinghan Shen wrote:
> Hi Krzysztof,
> 
> After discussing your message with our power team, 
> we realized that we need your help to ensure we fully understand you.
> 
> On Mon, 2022-07-04 at 14:38 +0200, Krzysztof Kozlowski wrote:
>> On 04/07/2022 12:00, Tinghan Shen wrote:
>>> Add power domains controller node for mt8195.
>>>
>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>>  1 file changed, 327 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> index 8d59a7da3271..d52e140d9271 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>>> @@ -10,6 +10,7 @@
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>  #include <dt-bindings/phy/phy.h>
>>>  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>>> +#include <dt-bindings/power/mt8195-power.h>
>>>  
>>>  / {
>>>  	compatible = "mediatek,mt8195";
>>> @@ -338,6 +339,332 @@
>>>  			#interrupt-cells = <2>;
>>>  		};
>>>  
>>> +		scpsys: syscon@10006000 {
>>> +			compatible = "syscon", "simple-mfd";
>>
>> These compatibles cannot be alone.
> 
> the scpsys sub node has the compatible of the power domain driver.
> do you suggest that the compatible in the sub node should move to here?

Not necessarily, depends. You have here device node representing system
registers. They need they own compatibles, just like everywhere in the
kernel (except the broken cases...).

Whether this should be compatible of power-domain driver, it depends
what this device node is. I don't know, I don't have your datasheets or
your architecture diagrams...

> 
>>> +			reg = <0 0x10006000 0 0x1000>;
>>> +			#power-domain-cells = <1>;
>>
>> If it is simple MFD, then probably it is not a power domain provider.
>> Decide.
> 
> this MFD device is the power controller on mt8195. 

Then it is not a simple MFD but a power controller. Do not use
"simple-mfd" compatible.

> Some features need 
> to do some operations on registers in this node. We think that implement 
> the operation of these registers as the MFD device can provide flexibility 
> for future use. We want to clarify if you're saying that an MFD device 
> cannot be a power domain provider.

MFD device is Linuxism, so it has nothing to do here. I am talking only
about simple-mfd. simple-mfd is a simple device only instantiating
children and not providing anything to anyone. Neither to children. This
 the most important part. The children do not depend on anything from
simple-mfd device. For example simple-mfd device can be shut down
(gated) and children should still operate. Being a power domain
controller, contradicts this usually.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
