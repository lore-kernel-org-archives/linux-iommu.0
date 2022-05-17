Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3619C433EF
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 14:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89B3E4171B;
	Tue, 17 May 2022 14:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTqdOw20ZNoy; Tue, 17 May 2022 14:23:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4154A404F9;
	Tue, 17 May 2022 14:23:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FD7BC0039;
	Tue, 17 May 2022 14:23:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E10EC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 14:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC5AC84011
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 14:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FlZCSiTUCasr for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 14:23:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D4A284008
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 14:23:29 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id f4so18817511lfu.12
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ipGn43ArCVYSMn5yPdPhdKUiz8DsEnHuPTV/NAb5S1U=;
 b=apRAf5LRhyQBx+UcWihze57kJNIiM2xFRvMG9OphdJu8PIqOaJK/oGO5Yoiexkj0GK
 mXX4PiedRkI/DQON9cqi0NH4B4y1TkLgJs3xDSmiYxVOuUDH1jANMbz4k1FMTUt89iF5
 2TR5pB/3Up6jog61gTNWOZ59/Vgl7w2voFxBAB5ib87jIbmo51FoOva9xDoL/1IlK9fS
 /3+zwcTrdPsN9uS4Rybmrcisfb61xC5ZGxfvdehlSiEFFS7UilsWTqpLYy76CK+1ztkW
 4rHpx4H9I7May0ExD8A3wK+rxCD2qcrTO8bj9GHsKH40+nZP6EMNOwmffDpT5ztMn4ei
 aDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ipGn43ArCVYSMn5yPdPhdKUiz8DsEnHuPTV/NAb5S1U=;
 b=q3Z0tHZqsygle3IxEl0wWLeW1i00intpK9ovrt7dxEnqAat1VVasXw4ng4M/TQ2iwf
 TvzBSJYET6fc3dOyS1oNRQaaZ3Nnfz17HR5vFYksGHO3f7wWAkmXavQIJUDNUNjGq1pt
 fZ2YxK0BeJn0Bh+G87KpNmUZo6/RyLwhIdt1zrBVmw/lja2uaWsvF+Si5eoF2oKdAgvf
 XTLEGasu68hlACrwycOoBBkOK9tg32o9V2nZ6IcfFnsGTx8mlEEBv4WpN0IPCW8Ujz/3
 lMpaEkEGwIoBryPyQ+CfVtwHxSEb0oEOb0FhUfdVPLixP4B45a96NtOHuJ1Qc7fItkrN
 Tu6w==
X-Gm-Message-State: AOAM5300mPI3/cla53COy+KAr7lyaDLfznIOcGFsX52O6wnjhOtFV8fu
 Y3ERx6XynUd/8b2RfznblxE++w==
X-Google-Smtp-Source: ABdhPJyxTGAe+zxXWx5gqjGdmE0EbYNh4eGxOG6VrvKZTtMhpkUzJEQKkmWSE3yYd7HYfEC3PnQizQ==
X-Received: by 2002:a05:6512:1086:b0:473:e8ad:c923 with SMTP id
 j6-20020a056512108600b00473e8adc923mr17233277lfg.463.1652797406927; 
 Tue, 17 May 2022 07:23:26 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.gmail.com with ESMTPSA id
 r27-20020a2eb61b000000b0024f3d1dae80sm1902231ljn.8.2022.05.17.07.23.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 May 2022 07:23:26 -0700 (PDT)
Message-ID: <1f259346-0ab1-fff0-7f7c-05f0838a1d59@linaro.org>
Date: Tue, 17 May 2022 16:23:25 +0200
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517132107.195932-2-angelogioacchino.delregno@collabora.com>
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
> Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..78c72c22740b 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -101,6 +101,10 @@ properties:
>      items:
>        - const: bclk
>  
> +  mediatek,infracfg:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

No need for quotes. They are not present in other places.


> +    description: The phandle to the mediatek infracfg syscon
> +
>    mediatek,larbs:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      minItems: 1


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
