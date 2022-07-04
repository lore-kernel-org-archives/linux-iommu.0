Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413A0C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 12:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCCF460E6F;
	Mon,  4 Jul 2022 12:36:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CCCF460E6F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kakAYzAv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BAqcDCAXYVy; Mon,  4 Jul 2022 12:36:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A4C7260E51;
	Mon,  4 Jul 2022 12:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A4C7260E51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76747C0032;
	Mon,  4 Jul 2022 12:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6B3BC002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 12:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C8604049F
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 12:36:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C8604049F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=kakAYzAv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7_Wsd8GVXcyw for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 12:36:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99C15401A2
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99C15401A2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 12:36:08 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id s14so10939392ljs.3
 for <iommu@lists.linux-foundation.org>; Mon, 04 Jul 2022 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iPKFsn5fgFC3dh7g4FEmoTkg1BmyHxMILE2vHE8EovU=;
 b=kakAYzAv3NzfFeDUN+1/0H8cOwRS5NqlQ27nFKj7WIejGwKhWzq7PYg92rhzNELiok
 ows4QwIkoF9T/PEjYcacupijYOGztmIJZX5YdHTCt3hjFdawbgKTdqTaV6X7nBRw7S3T
 AXH0gKwluMjUJWlDwI5dk9h305balLQvjZXjNgfj8QNQkyOv5iSvci8Ht5scpAM7Igho
 DCubFtKdQXghwAMldj0MDUQ4tO1CpDbwAuKH8DBDDNe3zPp6iys8MQwWuh+1QlJ5iG3q
 07cYHofieHH6/bTNQXBanUdfaKrMjdJKOLNvLTNTQg2AN2MO4crHODHokwL2rzBMdm9t
 fT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iPKFsn5fgFC3dh7g4FEmoTkg1BmyHxMILE2vHE8EovU=;
 b=7e9tmyoXxRIjQJta3eL2n5Ca/LtXeNayc40HAAgfg/CjJfOy2ePd4FSIr01pURD7R+
 95L2lTpBGP+ZWHbN9G36NGffns63COnXC4zd/6XVD2DLplahcDJpprSy3LSbD12eGkvI
 e3H3VpOiHctRTH0/yfgSgsSalcZmM01xizU1xX8VALYZKkclBbvdXdOWgEGhPtDCntnq
 Do1QkTJZkc3tKZQY6FVQS3zZEAQOpzlymF23wlybdkI9Y6EkyKmO1kNwLluFuEE0WELd
 lfF+89K9IJZb2P0jGwazGUdGBBESrRcy2VTnw1SkIInWRxBiucnMIBUjlcYBCvReRAuY
 BE6Q==
X-Gm-Message-State: AJIora/LlHcvFdZOaqd3QSMVg6/Lcb6UkZ2gc6hoHGtmUArbPJCCJdLb
 gpV+5JiSbAldqQUKgfc9AK+PGg==
X-Google-Smtp-Source: AGRyM1tXWRrB0b5dEJCLzGc/R5uafVj4v54jWmEi9eVLKfsI4Srl/ADg1V4X5sgKVHCa6i63d9K/IA==
X-Received: by 2002:a2e:b713:0:b0:25a:90bd:cb6b with SMTP id
 j19-20020a2eb713000000b0025a90bdcb6bmr16083013ljo.380.1656938166435; 
 Mon, 04 Jul 2022 05:36:06 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a056512360a00b0047255d211c2sm1727143lfs.241.2022.07.04.05.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 05:36:05 -0700 (PDT)
Message-ID: <119f2a98-ef56-7b99-631f-221b737939ae@linaro.org>
Date: Mon, 4 Jul 2022 14:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 02/16] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
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
 <20220704100028.19932-3-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704100028.19932-3-tinghan.shen@mediatek.com>
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

On 04/07/2022 12:00, Tinghan Shen wrote:
> The max clock items for the dts node with compatible
> 'mediatek,mt8195-smi-sub-common' should be 3.
> 
> However, the dtbs_check of such node will get following message,
> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> 
> Remove the last 'else' checking to fix this error.

Missing fixes tag.

> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.yaml        | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index a98b359bf909..e5f553e2e12a 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -143,7 +143,15 @@ allOf:
>              - const: gals0
>              - const: gals1
>  
> -    else:  # for gen2 HW that don't have gals
> +  - if:  # for gen2 HW that don't have gals
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt2712-smi-common
> +            - mediatek,mt8167-smi-common
> +            - mediatek,mt8173-smi-common
> +

Without looking at the code, it's impossible to understand what you are
doing here. The commit msg says one, but you are doing something else.

Write commit msg explaining what you want to achieve and what you are doing.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
