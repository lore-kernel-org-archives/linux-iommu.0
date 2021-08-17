Return-Path: <SRS0=VUzA=NI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A738C4338F
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 20:12:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DF960EB9
	for <iommu@archiver.kernel.org>; Tue, 17 Aug 2021 20:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4DF960EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F1E960B90;
	Tue, 17 Aug 2021 20:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0G-C8cC_CFWI; Tue, 17 Aug 2021 20:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4921D60699;
	Tue, 17 Aug 2021 20:12:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22DB3C001A;
	Tue, 17 Aug 2021 20:12:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5EB8C000E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 20:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7D3560699
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 20:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-kTxkrgjlEA for <iommu@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 20:12:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 299AC60688
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 20:12:09 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 t1-20020a4a54010000b02902638ef0f883so3216ooa.11
 for <iommu@lists.linux-foundation.org>; Tue, 17 Aug 2021 13:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9Y8O/ugVUGd/pj+YpwBoilPPzVox4p1gBlgEBXz9RZM=;
 b=HkItZhAGrUJgl7rRT1+2xciUsEyCx0kg89zWkyz44tdgpj8IvdODW5oB1FplYPaM+S
 PHExf4CK8N+yQI3cf6u7bnB2HUOR3Xis/DHzKhOaB6lcJTP9P6LKafQcQubREfn/uUIy
 luisF6/gg283D/Mv939zAyJaUpsFCpNQCypfgOotg1YPwAPeIdqd06dCP2J3lIwK99HM
 14Ca5VlfUS4mZrv4rpX9i+IDvpgyIWmBGemDM54A8HWH/GWl7xudZ4A+35fUx51hk21P
 PTXxebu12/tNMBMGNTmSpIhc9EiaFHyOs7c3P9Y/j+Tj/KfNwL9flUegKROxBd/nJmbl
 0C3Q==
X-Gm-Message-State: AOAM530F274eyMrsfQCtjkErcktSFXeDolhwMcQkS9Pdk2MibzvKxgdX
 6RE7qBqGjXq9PtomuUGrSg==
X-Google-Smtp-Source: ABdhPJzXi2Qb6T0n6M6hziTxPBlA6ZUr+4xKRXs2HwFfG0DIibNMEo5wtI0feqdM1bdl918jWY2pRQ==
X-Received: by 2002:a4a:d5d0:: with SMTP id a16mr3910689oot.18.1629231128239; 
 Tue, 17 Aug 2021 13:12:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i188sm708832oih.7.2021.08.17.13.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 13:12:07 -0700 (PDT)
Received: (nullmailer pid 762404 invoked by uid 1000);
 Tue, 17 Aug 2021 20:12:06 -0000
Date: Tue, 17 Aug 2021 15:12:06 -0500
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 02/13] dt-bindings: memory: mediatek: Add mt8195 smi
 sub common
Message-ID: <YRwYFtVlNjxyRwX+@robh.at.kernel.org>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
 <20210810080859.29511-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210810080859.29511-3-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
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

On Tue, Aug 10, 2021 at 04:08:48PM +0800, Yong Wu wrote:
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
> its smi-common. meanwhile the sub-common only has one gals clock.
> 
> Additionally, add a new property "mediatek,smi_sub_common" for this
> sub-common, this is needed in the IOMMU driver in which we create a device
> link between smi-common and the IOMMU device. If we add the smi-sub-common
> here, the IOMMU driver still need to find the smi-common device. thus,
> add this bool property to indicate if it is sub-common.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> change note:
> a. change mediatek, smi type from phandle-array to phandle from Rob.
> b. Add a new bool property (mediatek,smi_sub_common) to indicate this is
>    smi-sub-common. the reason is as above.
> ---
>  .../mediatek,smi-common.yaml                  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 602592b6c3f5..26bb9903864b 100644
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
> @@ -67,6 +68,14 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  mediatek,smi:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the smi-common node above. Only for sub-common.
> +
> +  mediatek,smi_sub_common:

s/_/-/

> +    type: boolean
> +    description: Indicate if this is smi-sub-common.
> +
>  required:
>    - compatible
>    - reg
> @@ -93,6 +102,27 @@ allOf:
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
> +        - mediatek,smi_sub_common
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

If not allowed for other compatibles, you need:

else:
  properties:
    mediatek,sni: false
    mediatek,smi_sub_common: false


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
