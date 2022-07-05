Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E3CCA481
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 20:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00CBD607CA;
	Tue,  5 Jul 2022 20:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00CBD607CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yiupH7uQygTs; Tue,  5 Jul 2022 20:57:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B76D460AC3;
	Tue,  5 Jul 2022 20:57:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B76D460AC3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D36EC0032;
	Tue,  5 Jul 2022 20:57:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 580E6C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 20:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 326EE81947
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 20:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 326EE81947
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bEMa2RY86DAE for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 20:57:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E798981902
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
 [209.85.166.50])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E798981902
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 20:57:42 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id y2so12276601ior.12
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 13:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VII4+LSw9T/gxl5+FohiuIGzGMIZ9dqiusLT8ztuOfQ=;
 b=4gHylidp1LAhYX2iqrJ/whyZU8jt2ezI4fUfmF5S2ZN0EDot/3PuF0rYJ6ujlgTUit
 FzWDp0IV0Xtlg5xIy9Yig1qLTUPhWbojQFnbZIVXi0pEx9oIptUbnHB1fcMgs+ml5ePT
 lh/VFLuTUz9D0Jwjqfc0gP4WWak7BHeMuUcAaLxbIuCWwULrlzDmkdXtIgFnDCNkqJVJ
 uczlM7HKqx1BiEg9MHkTqDBPQOqGuelicNrroje2OOtLI84/6BSPz7+yKHT6KZmo6mV9
 ULyIO4INOLSFZ7IOaf0Nzm9icpVvLiBmUikRdaREQ1tfissZmYog603IReT5Gl1WS57x
 qcrA==
X-Gm-Message-State: AJIora/xcZlLNTI+MG84Z9SvtG0OWARt3Zx8ubSEXqDH5kHGOhelFhaH
 w5Opwn7pCzUHD5z8bCAFkg==
X-Google-Smtp-Source: AGRyM1vfLcm6IZw7/86NYDIFZB44UKjPVyEO4I8oJE/Oz0DoqL8OE1ZY84lQlcCK/TDePXwnFj4m9w==
X-Received: by 2002:a05:6602:1355:b0:669:40a5:9c26 with SMTP id
 i21-20020a056602135500b0066940a59c26mr20818102iov.105.1657054661830; 
 Tue, 05 Jul 2022 13:57:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id
 bo22-20020a056638439600b0033c8edf022bsm12230492jab.144.2022.07.05.13.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 13:57:41 -0700 (PDT)
Received: (nullmailer pid 2609976 invoked by uid 1000);
 Tue, 05 Jul 2022 20:57:39 -0000
Date: Tue, 5 Jul 2022 14:57:39 -0600
From: Rob Herring <robh@kernel.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1 03/16] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Message-ID: <20220705205739.GA2599256-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-4-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220704100028.19932-4-tinghan.shen@mediatek.com>
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

On Mon, Jul 04, 2022 at 06:00:15PM +0800, Tinghan Shen wrote:
> Extract duplicated properties and support more levels of power
> domain nodes.
> 
> This change fix following error when do dtbs_check,
>     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../power/mediatek,power-controller.yaml      | 132 ++----------------
>  1 file changed, 12 insertions(+), 120 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 135c6f722091..09a537a802b8 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -39,8 +39,17 @@ properties:
>    '#size-cells':
>      const: 0
>  
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
>  patternProperties:
>    "^power-domain@[0-9a-f]+$":
> +    $ref: "#/$defs/power-domain-node"
> +
> +$defs:
> +  power-domain-node:
>      type: object
>      description: |
>        Represents the power domains within the power controller node as documented
> @@ -98,127 +107,10 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/phandle
>          description: phandle to the device containing the SMI register range.
>  
> -    patternProperties:
> -      "^power-domain@[0-9a-f]+$":
> -        type: object
> -        description: |
> -          Represents a power domain child within a power domain parent node.
> -
> -        properties:
> -
> -          '#power-domain-cells':
> -            description:
> -              Must be 0 for nodes representing a single PM domain and 1 for nodes
> -              providing multiple PM domains.
> -
> -          '#address-cells':
> -            const: 1
> -
> -          '#size-cells':
> -            const: 0
> -
> -          reg:
> -            maxItems: 1
> -
> -          clocks:
> -            description: |
> -              A number of phandles to clocks that need to be enabled during domain
> -              power-up sequencing.
> -
> -          clock-names:
> -            description: |
> -              List of names of clocks, in order to match the power-up sequencing
> -              for each power domain we need to group the clocks by name. BASIC
> -              clocks need to be enabled before enabling the corresponding power
> -              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> -              SUSBYS clocks need to be enabled before releasing the bus protection,
> -              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> -
> -              In order to follow properly the power-up sequencing, the clocks must
> -              be specified by order, adding first the BASIC clocks followed by the
> -              SUSBSYS clocks.
> -
> -          domain-supply:
> -            description: domain regulator supply.
> -
> -          mediatek,infracfg:
> -            $ref: /schemas/types.yaml#/definitions/phandle
> -            description: phandle to the device containing the INFRACFG register range.
> -
> -          mediatek,smi:
> -            $ref: /schemas/types.yaml#/definitions/phandle
> -            description: phandle to the device containing the SMI register range.
> -
> -        patternProperties:
> -          "^power-domain@[0-9a-f]+$":
> -            type: object
> -            description: |
> -              Represents a power domain child within a power domain parent node.
> -
> -            properties:
> +      required:
> +        - reg
>  
> -              '#power-domain-cells':
> -                description:
> -                  Must be 0 for nodes representing a single PM domain and 1 for nodes
> -                  providing multiple PM domains.
> -
> -              '#address-cells':
> -                const: 1
> -
> -              '#size-cells':
> -                const: 0
> -
> -              reg:
> -                maxItems: 1
> -
> -              clocks:
> -                description: |
> -                  A number of phandles to clocks that need to be enabled during domain
> -                  power-up sequencing.
> -
> -              clock-names:
> -                description: |
> -                  List of names of clocks, in order to match the power-up sequencing
> -                  for each power domain we need to group the clocks by name. BASIC
> -                  clocks need to be enabled before enabling the corresponding power
> -                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> -                  SUSBYS clocks need to be enabled before releasing the bus protection,
> -                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> -
> -                  In order to follow properly the power-up sequencing, the clocks must
> -                  be specified by order, adding first the BASIC clocks followed by the
> -                  SUSBSYS clocks.
> -
> -              domain-supply:
> -                description: domain regulator supply.
> -
> -              mediatek,infracfg:
> -                $ref: /schemas/types.yaml#/definitions/phandle
> -                description: phandle to the device containing the INFRACFG register range.
> -
> -              mediatek,smi:
> -                $ref: /schemas/types.yaml#/definitions/phandle
> -                description: phandle to the device containing the SMI register range.
> -
> -            required:
> -              - reg
> -
> -            additionalProperties: false
> -
> -        required:
> -          - reg
> -
> -        additionalProperties: false
> -
> -    required:
> -      - reg
> -
> -    additionalProperties: false
> -
> -required:
> -  - compatible
> -
> -additionalProperties: false
> +      additionalProperties: false

You now aren't checking more than 1 level because you have defined 
'additionalProperties' to be a DT property. Check the indentation.

You need this in $defs/power-domain-node to recurse:

    additionalProperties:
      $ref: #/$defs/power-domain-node

>  
>  examples:
>    - |
> -- 
> 2.18.0
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
