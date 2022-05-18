Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20A8C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 11:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B31541B4F;
	Wed, 18 May 2022 11:29:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f6JDvrwuPzj3; Wed, 18 May 2022 11:29:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 27AB3408A8;
	Wed, 18 May 2022 11:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 002CAC0039;
	Wed, 18 May 2022 11:29:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23537C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 206F441B4F
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QD7jt6z8gxiA for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 11:29:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16DD3408A8
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 11:29:26 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 i20-20020a05600c355400b0039456976dcaso2179417wmq.1
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=uFIsWxhH+SfWDbQeGJib3EffwTOsdWgNhmP3BKg6cTI=;
 b=GIk1v/SP46GpQB2aa29XniHa4XWAzmRQTBwJvI2ojRUnPlE+MqZBO6G6nMAupnb8W+
 G2EA2unw0FCDCoBzqtVzORAZzUFAFXx+Kdr8mqijkt1cl3qR20Nu7ks1Ou4EEIyvLfG1
 BKNUqHtpdNg9JkHJn34prfdFRVXewGK/0aMoRwE31kjLG9CzM4rhFuUz60WAX4Xx4Qtf
 Iw5hAdG4s9z4F6oM41gnCOxtwot5uL5itCKcTOqR+V3kIeqKyCtmTTLGt5h7TbNeBK4l
 1nRGHnUOJvvntrUCPXJu1pJXgzrO3r0Q2kDfNl8uDHZhwRBCu9LgjhUgB/igxBzXk6Dk
 Y+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=uFIsWxhH+SfWDbQeGJib3EffwTOsdWgNhmP3BKg6cTI=;
 b=AukXXDlqhikzXyjsreo1MZe+okoJryC8I9vrJRfPyp1HkO4Wfo1/rvi5/dXds23fzP
 BEi7Kvel+dUtvhkuxTF1mKrLnHKKQXYLlBm/FJst8ajQl6s5rLcMiwCBBRPez0LtamcG
 8eRixAbGq3UJLnLuiv0CHV4IvspdRGgp3+O3Ge2pE7O5sAStWuLbt7YYXQO8jJSPN1K8
 ec46lHkhphV4LXlbAcRK9bldpGvZqnHOa01IDEAhgPM/Ic7HO6lt0UktQW8AzHlILUzX
 LkNm3wR/Xf1KO3RnqJXQRDq5CSe0cosFxe0CLFkkzKv/edmU/myZSklfAsC3lD3rIlMI
 TE1w==
X-Gm-Message-State: AOAM532mim6Coq8HakOZQVMD2dMPzgGV56VT3JTKL014J1O6Bv99ApL9
 ClMqPCKkd6AFjSsHf+Z/0DY=
X-Google-Smtp-Source: ABdhPJwmMEJmW+CILoBoRlmxrlpjiQs7Ka6eyFZQusCiGX6OE9WPle9wfc8RX8mJ6nniBuuCC/UxRQ==
X-Received: by 2002:a05:600c:3549:b0:394:89ba:e1be with SMTP id
 i9-20020a05600c354900b0039489bae1bemr25309861wmq.181.1652873364178; 
 Wed, 18 May 2022 04:29:24 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
 by smtp.gmail.com with ESMTPSA id
 v65-20020a1cac44000000b003947b59dfdesm5121659wme.36.2022.05.18.04.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 May 2022 04:29:23 -0700 (PDT)
Message-ID: <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
Date: Wed, 18 May 2022 13:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for
 mediatek infra/pericfg
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
 <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
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



On 18/05/2022 12:04, AngeloGioacchino Del Regno wrote:
> Add properties "mediatek,infracfg" and "mediatek,pericfg" to let the
> mtk_iommu driver retrieve phandles to the infracfg and pericfg syscon(s)
> instead of performing a per-soc compatible lookup.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   .../devicetree/bindings/iommu/mediatek,iommu.yaml         | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..c4af41947593 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -101,6 +101,10 @@ properties:
>       items:
>         - const: bclk
>   
> +  mediatek,infracfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the mediatek infracfg syscon
> +
>     mediatek,larbs:
>       $ref: /schemas/types.yaml#/definitions/phandle-array
>       minItems: 1
> @@ -112,6 +116,10 @@ properties:
>         Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
>         according to the local arbiter index, like larb0, larb1, larb2...
>   
> +  mediatek,pericfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle to the mediatek pericfg syscon
> +

I didn't explain myself. What I was suguesting was to squash the patch that add 
requiered mediatek,infracfg with the patch that adds mediatk,infracfg to the 
binding description. And then squash the both patches adding pericfg as well.

Regards,
Matthias


>     '#iommu-cells':
>       const: 1
>       description: |
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
