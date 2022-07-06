Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FBEC43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 13:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1401140B3D;
	Wed,  6 Jul 2022 13:41:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1401140B3D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Jlle0rhz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85PoR8CL2ORq; Wed,  6 Jul 2022 13:41:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C140540148;
	Wed,  6 Jul 2022 13:41:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C140540148
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C1BDC0035;
	Wed,  6 Jul 2022 13:41:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5E9BC002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 13:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACB4660FEE
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 13:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ACB4660FEE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=Jlle0rhz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6siguBF1pEKO for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 13:41:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5824E60FE9
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5824E60FE9
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 13:41:40 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 g39-20020a05600c4ca700b003a03ac7d540so11618926wmp.3
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=J37bnxv35AKNMkkxULLkWayVHEaMjv0zIAo9khsK/xs=;
 b=Jlle0rhzTTAnWZ/MNh25r/iMQIdPg+Nu4CyuUQnEB3+XRfZWe+9CZwdtvObPWmIv6g
 d913Ju/S7mnMovkMbGewR/EJ+C5hKF2jryill+Reaw1pTWmgv8OAkwAghmrTDutguk4Q
 SDRosAPaNN+hGVT71HuA/B9Esxx0cYVXiQjFvXDsdTGo7ASRZIONNC4+54ApG9tqpPi8
 dAp/BlYJDauy6Cy12yvpidH/bodG8wQQhyC1J0YUuQOVTwNttLSB8AvN8+SX88WjcVbl
 b+DKOSfFHI1jNA6LLUabbhounPawG5AlMa6HNpwSyCeqBqtN+6gRteWmi1fx+JReOXzf
 dCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=J37bnxv35AKNMkkxULLkWayVHEaMjv0zIAo9khsK/xs=;
 b=JG29p0UAz2e/MrSsfBkVlR9ogAejkvVzih2gaxol9vl1IiZ3UPjuq926rjqNIb566S
 qJSrwUKsh2R+RE059uglssZ0pNJp2y4dLQRj5xPnQlcCx24k8Tm0IUM4A6gLSFLTvJWo
 JmYSUzgY+gWolp8TB7FLfvMkPb0cv/FPrKvL8M016sjb/tXea0+rL4JKzyad6p/Vme0p
 SNBFPfHAF+WdEgJUm/5yBH8+E2phVyIA5284xZcdcOqWnkIGDYWQOBcU24xqmtRirZ8N
 6w5oEKLY+937d9gfB83ieOCoIazFj+tmamiPJ7JfeUhel+gjVgkE8zjnEps8CPhE30RB
 M2Xg==
X-Gm-Message-State: AJIora9+OoTwgSD7oA5osThngg1fkncjDK2pz/pfaQ2eMAH52Pv3iP6d
 BbXVyBtggS9uCOpuryxELKw=
X-Google-Smtp-Source: AGRyM1uzrUL3jgHl7v16xkNIYUGr+iA0aegNeob2FrKF9QFhYl/5MRV7Rool8Fm50IsaKRG6foS/1A==
X-Received: by 2002:a05:600c:274b:b0:3a0:47e8:ca85 with SMTP id
 11-20020a05600c274b00b003a047e8ca85mr45800324wmw.156.1657114898287; 
 Wed, 06 Jul 2022 06:41:38 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a5d4310000000b0021d7b41255esm2225662wrq.98.2022.07.06.06.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 06:41:37 -0700 (PDT)
Message-ID: <17203a8a-407e-30cf-79de-352716c3ebce@gmail.com>
Date: Wed, 6 Jul 2022 15:41:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 04/07/2022 14:38, Krzysztof Kozlowski wrote:
> On 04/07/2022 12:00, Tinghan Shen wrote:
>> Add power domains controller node for mt8195.
>>
>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>>   1 file changed, 327 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> index 8d59a7da3271..d52e140d9271 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
>> @@ -10,6 +10,7 @@
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/phy/phy.h>
>>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>> +#include <dt-bindings/power/mt8195-power.h>
>>   
>>   / {
>>   	compatible = "mediatek,mt8195";
>> @@ -338,6 +339,332 @@
>>   			#interrupt-cells = <2>;
>>   		};
>>   
>> +		scpsys: syscon@10006000 {
>> +			compatible = "syscon", "simple-mfd";
> 
> These compatibles cannot be alone.
> 

You mean we would need something like "mediatek,scpsys" as dummy compatible 
that's not bound to any driver?

>> +			reg = <0 0x10006000 0 0x1000>;
>> +			#power-domain-cells = <1>;
> 
> If it is simple MFD, then probably it is not a power domain provider.
> Decide.

The SCPSYS IP block of MediaTek SoCs group several functionality, one is the 
power domain controller. Others are not yet implemented, but defining the scpsys 
as a MFD will give us the possibility to do so in the future.

Regards,
Matthias

> 
> Best regards,
> Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
