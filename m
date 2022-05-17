Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0055EC4332F
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 14:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9629140C78;
	Tue, 17 May 2022 14:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fUybK60DhBPb; Tue, 17 May 2022 14:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 874C44051F;
	Tue, 17 May 2022 14:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F4C0C0039;
	Tue, 17 May 2022 14:23:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23E33C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 14:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1269160E49
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 14:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1NjiD4GGJYe6 for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:23:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3180860E3C
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 14:23:39 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id d19so31622555lfj.4
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Lnn8RnWZse55RuB4yg/vu5G7bPymERhSpz38ty/G94A=;
 b=FCgjt+lf9hFi7sB3SJOv43XgmvYxTBFuv1iaHRc4BG+bzmJCFyEIRbbuX7L4KvN6D1
 jZaNpeKuLQIZh/dpKpDJaxcH4kaEHje4Ykc3lHWSRziSPuY8QwGCJud7QM/OoPS6EpVb
 kc5CU3UASpZXUpsJvnh2zCBHk4tAyNZsOcI00zufriY6glGzShgkNNc5ozlAnT5M117f
 WHcVHF+SzeFZ82gNRuZVjqex1jnKBeiVOKRcuk0AxbEqYVEErcSv8AsbQ7LRcMzEw3Qa
 vHWff82Bt/+ba99MkJtVfDbo7fdUDKThMCLfT0oVRAUI1Uc/T7E01TJUepkNX+LO1B4q
 0h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Lnn8RnWZse55RuB4yg/vu5G7bPymERhSpz38ty/G94A=;
 b=UbiAIYZXBtP5bcfOIDnIhHJvmyRJRO12DwVfpRJMir5KD09Slh3VRkzgkwtkOIrlaN
 ET2b0nkOHV+MqmGlYoRp17vAWaMeK/WfBkvXZmr6iez1pLxe67F7u/8QqlISvuyyicH2
 fdhD5/HKTQIOJs6URlkqn34XMWrHkPWYBrRb9EfR4VRf/7bQIEf3G0EYc7fLGfpLgDGr
 dyunj6PcKqsWFvf7E5VWH9ffy/ItKnMGCXug0aWIXOlHYUvRemqxPHoJrZ7PJwynax3S
 kchEX7TzQZN6y4pg1Kyt7SKwVhSmNbEt5DCvBgcgF2QX1wWmQ4nCkktuoscrVJWPlBYf
 mtSQ==
X-Gm-Message-State: AOAM530zdHRyg517YxiFzH/fwjkyG/maQ8iWfgtRy436NxAHsqILlk98
 8J5K6U7iqd8z7ZX0qyDqIc4NnPwOoQZhnZcO
X-Google-Smtp-Source: ABdhPJzdrATa4hivK3skT4LaVtlu+jnncbJ7AOzRa56KLicCMPpXG+kCMdTvT8ScBNWmHguDQbZUVw==
X-Received: by 2002:a05:6512:3c9b:b0:472:60d0:ebb0 with SMTP id
 h27-20020a0565123c9b00b0047260d0ebb0mr17556169lfv.682.1652797417174; 
 Tue, 17 May 2022 07:23:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.gmail.com with ESMTPSA id
 q23-20020a2e8757000000b0024f3d1daed4sm1892435ljj.92.2022.05.17.07.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 May 2022 07:23:36 -0700 (PDT)
Message-ID: <669d68ce-959b-5486-8b1e-316aafa7b52a@linaro.org>
Date: Tue, 17 May 2022 16:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/8] dt-bindings: iommu: mediatek: Add mediatek,pericfg
 phandle
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-4-angelogioacchino.delregno@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517132107.195932-4-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On 17/05/2022 15:21, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,pericfg" to let the mtk_iommu driver retrieve
> a phandle to the pericfg syscon instead of performing a per-soc
> compatible lookup, as it was also done with infracfg.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 78c72c22740b..a6cf9678271f 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -116,6 +116,10 @@ properties:
>        Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
>        according to the local arbiter index, like larb0, larb1, larb2...
>  
> +  mediatek,pericfg:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

No need for quotes.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
