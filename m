Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F85C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 09:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E3AC41706;
	Wed, 18 May 2022 09:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11ei8k0IPbKN; Wed, 18 May 2022 09:16:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BF5CB41721;
	Wed, 18 May 2022 09:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 712ECC0039;
	Wed, 18 May 2022 09:16:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C53D5C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 09:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACC1A40141
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 09:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J5wDNK1dwUye for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 09:16:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06AA740120
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 09:16:31 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id f2so1823589wrc.0
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=AJ/PeRbastM8KtwKP00d5Dtpk6YYbHWpbi26hK6kis8=;
 b=Sb6MUDzpI3Do12SoVOog4trxfn9HkOWzjeJE76NDXkSoA5+fRAmSg1quRuL0EaHHMq
 m6AxmVYU7qZ4kUOuIhQsD2r+4H7X/eY9MdaLsZClCj+chZ/DoiVRhX9q9MC9cVk+qB2u
 rKLz50JW6LMpRFFumwP9Jdf2NLUMxYBb39/m7I1paORnMA76t7UYktiptr2D7kQNW9fM
 Ilp+EyfIAquY2zUojfnFJBq50LF3ol0dyv8ykoL/ce1uU9ZpB3AJf2RGUb5yvijmFIHy
 vhOOAZG3Pzx1dZuw2baXFhCQfbnqUvTEPayqaYHkt2lviWQdjqQoRKNEAeblCa+BKcYt
 CR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=AJ/PeRbastM8KtwKP00d5Dtpk6YYbHWpbi26hK6kis8=;
 b=s0H7HkoxiNwuEgdJ+oQc8VSVWmR7g53SqHDbGpJnKLnva6N3t3g6qRD3d68x88wrXs
 3Fx+uh7hmerE+4lnOXLOQGe/yDKv+USd6SIqR72VBIwgakyPxd9Tf8V0iqq+HzfzVd7F
 /dH0ZfemmkksBoU64K38R179x1b6T8Zs835hRGprbeOBaP161NWmswu7p7VKynP6WV4q
 wdEthweXDHapKYKmv0wJQhCWgGX5pczkgnewHN/7CV99eW7rKj2RoW137exWczecYrOl
 yWoGUgixR9YRsGMEaiB5hekGPDjJTB0fCxIH7hDGaone/6in7ePF7/TYG1PeD9FzQS3b
 yEPw==
X-Gm-Message-State: AOAM533Eo9JEtB4g/uhVgk9eRYp+byNABT1feyJ2Dvz4B5SIQlEib9aU
 ftEDC91EHAn3RhY8E6d1Ix0=
X-Google-Smtp-Source: ABdhPJwEWT0S1cQNRyp2Os4DAQEhukNT425BpsOswVM115DyQwaHDTQ4H/1aAl9xuumtGy5hK18drg==
X-Received: by 2002:a05:6000:1a45:b0:20e:6164:d86c with SMTP id
 t5-20020a0560001a4500b0020e6164d86cmr1405752wry.561.1652865390262; 
 Wed, 18 May 2022 02:16:30 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a05600c1d9200b00397122e63b6sm1227595wms.29.2022.05.18.02.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 May 2022 02:16:29 -0700 (PDT)
Message-ID: <ad4aac8a-ef1b-d4eb-7045-a46bd39ad3fc@gmail.com>
Date: Wed, 18 May 2022 11:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/8] dt-bindings: iommu: mediatek: Add mediatek,infracfg
 phandle
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-2-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220517132107.195932-2-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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



On 17/05/2022 15:21, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..78c72c22740b 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -101,6 +101,10 @@ properties:
>       items:
>         - const: bclk
>   
> +  mediatek,infracfg:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: The phandle to the mediatek infracfg syscon
> +
>     mediatek,larbs:
>       $ref: /schemas/types.yaml#/definitions/phandle-array
>       minItems: 1

I think we can squash patch 7 in here. Same holds for pericfg

Regards,
Matthias
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
