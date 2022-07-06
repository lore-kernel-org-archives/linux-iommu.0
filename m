Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B897C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 13:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 941094089B;
	Wed,  6 Jul 2022 13:48:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 941094089B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fV8aJ9j+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bL2KZyhK-xg; Wed,  6 Jul 2022 13:48:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9FF5404BF;
	Wed,  6 Jul 2022 13:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9FF5404BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8386C0035;
	Wed,  6 Jul 2022 13:48:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B45AC002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 13:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52AB982FA5
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 13:48:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52AB982FA5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=fV8aJ9j+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3rOSx7a_Je7d for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 13:48:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8550281902
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8550281902
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 13:48:10 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id h17so9011860wrx.0
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jul 2022 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Ys6nhaWDkYktLlUqq0SwlRalsF7YwG4ENbLhHnvqbhY=;
 b=fV8aJ9j+yuHCeCJsnseihO3elQIXDVuluuk4eEAuWmKG+ZK7rCd24w3roTCv9M3cST
 X5kMf3UXuNCGkNWELxZKURXY0ztY/VKtR6/sCuBqAOOoH759XuEGDMn/RcFj0qaYKaLe
 kTRu9z4IqfmlqILQRbqADqlV2hrVFq77785WL1jQIwYmp+9cY0tfQOInOH7Enyih4OQy
 6QzZVmfouiDIElYWsH34+xwHK6E3jiSnOTph+07cgrvKE00fQA4IeucMqhvFgxJVPpbh
 Fjf7bydjRVlNfviN68vi9tA2pbet372RqOUYk7ePKh4exRP1IaJp4myFJmdOIavAtPu3
 TN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Ys6nhaWDkYktLlUqq0SwlRalsF7YwG4ENbLhHnvqbhY=;
 b=0dkL7/DHoUVMn8hoUa4cAWEpbs4sVZmXskbVmIw3MnTBBFk3ypZM1/PtZ6K1WvnE+u
 FwKds7UZz3WPpSKlYFrOTh9so2dVqEraTzauV3cGoDtX72DoLLQ08Euolr/ASdvaMGM7
 4ccwsBaG8iiw3bfRGIHgT0V/2yzlTPa3hyeqtleVCrHOAlVZ8Xqq3s9PbzPha5yLz2Ej
 8f9/0oL/Iva4sFUAQ0zw8F7VKt7+olF5B6mepXIwi4yDBNLFdwcrGnuMgtC8itp/wvka
 lGdJNH3AvAgfnmrlqdf4kAmn4clALr+FUtRTFem7rHpTjgRyvqEChwy2FzOLa29ZWuKc
 /L1Q==
X-Gm-Message-State: AJIora+85lDjTSrR5WQRtGbsMhjgb8E7zlX/+y/3Y+Y+ohzPI7Eo44Aq
 nlO/EY8wGG0IFk+uT3QpayE=
X-Google-Smtp-Source: AGRyM1uKokpPXD3KIW+1SGhOJH0F4Ot+3fwFEVIyD8thjoxNU4UTGfcWYVexdf/YGnIyZIvbYxqHnQ==
X-Received: by 2002:a5d:4201:0:b0:21d:7b63:1b43 with SMTP id
 n1-20020a5d4201000000b0021d7b631b43mr3917188wrq.225.1657115288718; 
 Wed, 06 Jul 2022 06:48:08 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a7bcb81000000b003a05621dc53sm25703913wmi.29.2022.07.06.06.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jul 2022 06:48:07 -0700 (PDT)
Message-ID: <9757b32c-c196-f7e0-3c61-1d4edae854dc@gmail.com>
Date: Wed, 6 Jul 2022 15:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 02/16] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
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
 <20220704100028.19932-3-tinghan.shen@mediatek.com>
 <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
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



On 04/07/2022 14:36, Krzysztof Kozlowski wrote:
> On 04/07/2022 12:00, Tinghan Shen wrote:
>> The max clock items for the dts node with compatible
>> 'mediatek,mt8195-smi-sub-common' should be 3.
>>
>> However, the dtbs_check of such node will get following message,
>> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>>           From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>>
>> Remove the last 'else' checking to fix this error.
> 
> Missing fixes tag.
> 

 From my understanding, fixes tags are for patches that fix bugs (hw is not 
working etc) and not a warning message from dtbs_check. So my point of view 
would be to not add a fixes tag here.

Regards,
Matthias

>>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>> ---
>>   .../memory-controllers/mediatek,smi-common.yaml        | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>> index a98b359bf909..e5f553e2e12a 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>> @@ -143,7 +143,15 @@ allOf:
>>               - const: gals0
>>               - const: gals1
>>   
>> -    else:  # for gen2 HW that don't have gals
>> +  - if:  # for gen2 HW that don't have gals
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - mediatek,mt2712-smi-common
>> +            - mediatek,mt8167-smi-common
>> +            - mediatek,mt8173-smi-common
>> +
> 
> Without looking at the code, it's impossible to understand what you are
> doing here. The commit msg says one, but you are doing something else.
> 
> Write commit msg explaining what you want to achieve and what you are doing.
> 
> 
> Best regards,
> Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
