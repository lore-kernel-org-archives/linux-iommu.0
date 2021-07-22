Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A68C6377C
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 02:53:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6786127C
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 02:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6786127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A2FF400A8;
	Thu, 22 Jul 2021 02:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BBVYLFyxf_Y8; Thu, 22 Jul 2021 02:53:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61F394010D;
	Thu, 22 Jul 2021 02:53:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46DE1C0010;
	Thu, 22 Jul 2021 02:53:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC50FC000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 02:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E78CD82786
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 02:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bh7NmqvXvugm for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:53:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com
 [209.85.166.180])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B1B4825BF
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 02:53:05 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id a7so4111214iln.6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 19:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=82O9pxHs2phuaInzl9cox8me6UL28Nm2JehOPgfRTdU=;
 b=tY2oQcVzZMMurlyUVpS7kzyAPTkQOoJI4uh+yEDGFc5sBAafeuIKXi7mmuYwKP8Pzc
 YMIjfmDoAp60YUaNTGvLgbCwHhwsTiJfZxLEvHQss5Aikewd7FZ0N7P5XCs4abOiNORm
 9JAflxySmMTJ0JEHG97WiJs4fdjfEoD+3OuHeAOHLpCv7kZFVrbWe3VJPGju8L6HCLpl
 6ZzSrlqinp0+GD5UuttKf9R6smwV4xnI3S9d1TVV/mNyOPncie6wqwnU4qGIEBcR+vUP
 5BUw5ZOi3KndWE8iweTVy//43D2J5Sf3rJtLiqS5oNjsh5oMUYCjrf1of7D1PZGGVT9y
 yZgA==
X-Gm-Message-State: AOAM533fI6um9u6CpJha2kRm8gDx1EQB5Z3HW/CoSperfxzGtFZjBlxA
 gwDaReTO84B9lGyFJ0IdUA==
X-Google-Smtp-Source: ABdhPJyn11/pSzoHtQk9aFg6OthLDc/3e1S3UHr3amy1RP5ecpQGjtAMSWqcQHWLLIfasZwcFAYIZQ==
X-Received: by 2002:a92:c805:: with SMTP id v5mr24196570iln.293.1626922384270; 
 Wed, 21 Jul 2021 19:53:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id i5sm14559011ilc.16.2021.07.21.19.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 19:53:03 -0700 (PDT)
Received: (nullmailer pid 3205958 invoked by uid 1000);
 Thu, 22 Jul 2021 02:53:01 -0000
Date: Wed, 21 Jul 2021 20:53:01 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 02/11] dt-bindings: memory: mediatek: Add mt8195 smi
 sub common
Message-ID: <20210722025301.GA3204448@robh.at.kernel.org>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715121209.31024-3-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, Jul 15, 2021 at 08:12:00PM +0800, Yong Wu wrote:
> Add the binding for smi-sub-common. The SMI block diagram like this:
> 
>         IOMMU
>          |  |
>       smi-common
>   ------------------
>   |      ....      |
>  larb0           larb7   <-max is 8
> 
> The smi-common connects with smi-larb and IOMMU. The maximum larbs number
> that connects with a smi-common is 8. If the engines number is over 8,
> sometimes we use a smi-sub-common which is nearly same with smi-common.
> It supports up to 8 input and 1 output(smi-common has 2 output)
> 
> Something like:
> 
>         IOMMU
>          |  |
>       smi-common
>   ---------------------
>   |      |          ...
> larb0  sub-common   ...   <-max is 8
>       -----------
>        |    |    ...   <-max is 8 too.
>      larb2 larb5
> 
> We don't need extra SW setting for smi-sub-common, only the sub-common has
> special clocks need to enable when the engines access dram.
> 
> If it is sub-common, it should have a "mediatek,smi" phandle to point to
> its smi-common. meanwhile, the sub-common only has one gals clock.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.yaml                  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 602592b6c3f5..f79d99ebc440 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -38,6 +38,7 @@ properties:
>            - mediatek,mt8192-smi-common
>            - mediatek,mt8195-smi-common-vdo
>            - mediatek,mt8195-smi-common-vpp
> +          - mediatek,mt8195-smi-sub-common
>  
>        - description: for mt7623
>          items:
> @@ -67,6 +68,10 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  mediatek,smi:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

If only a phandle, then s/phandle-array/phandle/

> +    description: a phandle to the smi-common node above. Only for sub-common.
> +
>  required:
>    - compatible
>    - reg
> @@ -93,6 +98,26 @@ allOf:
>              - const: smi
>              - const: async
>  
> +  - if:  # only for sub common
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8195-smi-sub-common
> +    then:
> +      required:
> +        - mediatek,smi
> +      properties:
> +        clock:
> +          items:
> +            minItems: 3
> +            maxItems: 3
> +        clock-names:
> +          items:
> +            - const: apb
> +            - const: smi
> +            - const: gals0
> +
>    - if:  # for gen2 HW that have gals
>        properties:
>          compatible:
> -- 
> 2.18.0
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
