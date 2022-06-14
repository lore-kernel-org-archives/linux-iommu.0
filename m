Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415D9C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 15:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE6E940B40;
	Tue, 14 Jun 2022 15:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uzxVBRvo-ap; Tue, 14 Jun 2022 15:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C5AB44010E;
	Tue, 14 Jun 2022 15:16:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4601C0032;
	Tue, 14 Jun 2022 15:16:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F933C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 15:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E896832D8
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 15:16:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SxuKcuRcn9Qe for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 15:16:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06D93832D1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 15:16:43 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id x17so11732648wrg.6
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=vhkIKfkGo8kjikdx6e7XD32K64ham8C6J5zyVmKGo9E=;
 b=mn9mH9dlcktjsbOMweXezuaZH6SedKsBiAp/sPrP+O/C4uzVoiTXk0Hp2qzmmYN8mH
 txJIAOk0oCR3M4iXvuNWj36oJ5TXwOXGhsvH3FLUorO0KJCZXKZZnwWPJYbZ4ESJmdf+
 S9WtMjEksOcMwWCn4jHjLhFrSaYEUPcJJYtLmzE22G2yT6MVn3QND8NEpCxaaCqm3Ba+
 gvFcCl7VOOzuOSf69Is+3ei0t5tbkfcY56+nNn/6GSoQ1xMsJVcD9FYC47Z8mjUp5kUg
 uQaJfFGtgXl9F1UOXFC7ht0yd3Euz9EUuj6jKHpk+ZOw4NXqoY1LWCjP56Rtws3Oujb5
 ClmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vhkIKfkGo8kjikdx6e7XD32K64ham8C6J5zyVmKGo9E=;
 b=7/j8fffFJ/CFOPvouQJW218ZBf9yPnSs3M8cIJolMC5/uux9cB+y/Nn7jn6I4S4S3e
 wTAinWxAk178asRqR8LS5CpaTEddsk+t3F8beGQv08stz36kSfnxW8PARfplYCyVGOme
 xwnvQfJWLB+DN0iRCpzdb+eCt6raK/hZrG798DTzBT3ZVmysLVUqlEJ1q0nvgbkTMy7O
 qlrRrht+mdoMwE1cQ1hZUg8paLhuaI1GQn5ADCNzniiaQzp8LcjVstLEqR75+TE/478w
 4bglrkpboW20P+lyJ3IYoC+v7UnP4ZhfO5hMK58uBp+nWsJtX6Ahvg2r4i/FDN+NMDBz
 DWag==
X-Gm-Message-State: AJIora8xZRfyKNdp98J8gSjt6R91bgYSf6dry2svVhDYXnVPYZV8aFRt
 pqIWp0WoiP3KZtkDA85z/j8=
X-Google-Smtp-Source: AGRyM1sTU/BX79X8IM4FR68caCqL83NVFcemJZ7ybhRIwDuMBFF47IEvxKSKZvZKgUvjv9UhRysOaA==
X-Received: by 2002:adf:f584:0:b0:218:5a97:8f05 with SMTP id
 f4-20020adff584000000b002185a978f05mr5365598wro.333.1655219802133; 
 Tue, 14 Jun 2022 08:16:42 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c024400b0039c811077d3sm13490956wmj.22.2022.06.14.08.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jun 2022 08:16:41 -0700 (PDT)
Message-ID: <9a5afd0c-0c92-52c3-72d9-2c2f6c469e05@gmail.com>
Date: Tue, 14 Jun 2022 17:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 5/6] dt-bindings: iommu: mediatek: Add mediatek, pericfg
 phandle
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-6-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220609100802.54513-6-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, will@kernel.org,
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



On 09/06/2022 12:08, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,pericfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup in the entire devicetree and set it as a required
> property for MT8195's infra IOMMU.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewd-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/iommu/mediatek,iommu.yaml  | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 4142a568b293..d5e3272a54e8 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -116,6 +116,10 @@ properties:
>         Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
>         according to the local arbiter index, like larb0, larb1, larb2...
>   
> +  mediatek,pericfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the mediatek pericfg syscon
> +
>     '#iommu-cells':
>       const: 1
>       description: |
> @@ -183,6 +187,16 @@ allOf:
>         required:
>           - mediatek,infracfg
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8195-iommu-infra
> +
> +    then:
> +      required:
> +        - mediatek,pericfg
> +
>     - if: # The IOMMUs don't have larbs.
>         not:
>           properties:
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
