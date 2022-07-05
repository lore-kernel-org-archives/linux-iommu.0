Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22659C43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 20:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9007481DAB;
	Tue,  5 Jul 2022 20:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9007481DAB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rhWjVXKSiD7l; Tue,  5 Jul 2022 20:49:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6333681D9F;
	Tue,  5 Jul 2022 20:49:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6333681D9F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F24DC0032;
	Tue,  5 Jul 2022 20:49:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19559C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 20:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE25760F45
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 20:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE25760F45
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FgdyLsD_wN5g for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 20:49:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0D5D60F20
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com
 [209.85.166.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0D5D60F20
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 20:49:05 +0000 (UTC)
Received: by mail-io1-f45.google.com with SMTP id p128so12306220iof.1
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 13:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mzARt3SUylprTdvbWfGQj5lJEtQuB8YwyDUa4X1Y/TQ=;
 b=u47YwdGW7XL6P1Dz+q3GwDcs5XNkFYUgTsEdV/B76zFIOOMg7Tnqx5JPdQOxBCNGd7
 qUQNyvU8MOFcHu1yzQ9NCnVYQOwbNGlt1DdFEk4KTj6Bj39qV9LEx1n4+w16iDGrF27H
 KSoqlGYXeAhrBGh5qRCvOjpg4fdZv7ng3o8DJ3l+zDOYDqB3hWmMPo8QIygFMHhBLG7p
 nvKIwS/A6jjuyzMX46kZJClPfC8zdk0YfYQj6AfLJE+c8cqXwIcP14v/iVst1Zj8cAKH
 VHwPmZ5r1Y9aLH6sbsXZciVRm9+2tv+N0PKOxI4lD+b6cyYq32otJVesUlXlii6x28ta
 f58g==
X-Gm-Message-State: AJIora+zqxRZ+XFbOI0pw/H9+nPP4IcxUmK6PsWVDoKRKgwV1ByL8zgS
 En+T+6qq261S8s36PlPW8g==
X-Google-Smtp-Source: AGRyM1t3Q/lWtfZuyq003ElF5s7OUqIiDA2Wq5dxaxnoKjRtLzsbmHFJ7CK7VeOkWtDkrsMgCyJuvQ==
X-Received: by 2002:a6b:f718:0:b0:675:54cb:dda with SMTP id
 k24-20020a6bf718000000b0067554cb0ddamr20639324iog.114.1657054144601; 
 Tue, 05 Jul 2022 13:49:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a92c709000000b002dc133c9468sm2578869ilp.6.2022.07.05.13.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 13:49:04 -0700 (PDT)
Received: (nullmailer pid 2598242 invoked by uid 1000);
 Tue, 05 Jul 2022 20:49:02 -0000
Date: Tue, 5 Jul 2022 14:49:02 -0600
From: Rob Herring <robh@kernel.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1 01/16] dt-bindings: iommu: mediatek: Increase max
 interrupt number
Message-ID: <20220705204902.GA2596733-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220704100028.19932-2-tinghan.shen@mediatek.com>
Cc: devicetree@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Mon, Jul 04, 2022 at 06:00:13PM +0800, Tinghan Shen wrote:
> mt8195 infra iommu has max 5 interrupts.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml    | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..27eb9f6aa3ce 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -91,7 +91,8 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 5
>  
>    clocks:
>      items:
> @@ -175,9 +176,18 @@ allOf:
>                const: mediatek,mt8195-iommu-infra
>  
>      then:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +
>        required:
>          - mediatek,larbs
>  
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 5

5 is already the max.

minItems: 5

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
