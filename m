Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94936CCA47A
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 12:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45B10823CB;
	Thu, 16 Jun 2022 12:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WrvPYVosuwfz; Thu, 16 Jun 2022 12:58:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C4B581A29;
	Thu, 16 Jun 2022 12:58:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04274C0039;
	Thu, 16 Jun 2022 12:58:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30A9AC002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 12:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2000F40860
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 12:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JcCoU2Cfk0pW for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 12:57:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A78CF40650
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 12:57:59 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 j5-20020a05600c1c0500b0039c5dbbfa48so2774050wms.5
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=gy0oFAby9fgPJK22xRJJtXNYPWrTCXwW8x6uK6X5dvU=;
 b=Z7w8dNVB6+HrIK1AfeHcndhIn6ZaWZVjaZIxWOsOukdpjyAuA9v5MRUoVszMrQBn3J
 OmEcavKPfNs572/UH5gmdKM7J3jRilp9xyNozanCQxRuPPAHSx18eI8pYMArV407v1zj
 ooLDM0oB0I+fjkcaMrNQZMsuuEmVZHOA89GLn8XQCQZPc5kCtcYe8LI/cYv7QVn7PPK0
 bBwexju2unXFq1uFUGN5CPtTg29DK4hfbDtw2leG52kDHQiU4m8uyyrpWyt7BxLV32vi
 kox7/OnNMP54x3gfxbTCLsOXe8nE6ebCUd2U82Z2pSCrj5cs18rIZzPc3yFkjojHXfaq
 nm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=gy0oFAby9fgPJK22xRJJtXNYPWrTCXwW8x6uK6X5dvU=;
 b=JhqxTTg9DOSEGnKD/RzE6BA576ypVsIK2GE0CK5eo0hOpUuHREeAwpI7zaC/oGXYuz
 wUz9/jle3qSmGS3tB/d9saXl7f6Z9kDe3S3X/o8GtP2I2PFnhN2YPzGw8gnHrtO1ZzJ9
 PiuUXA8hq7LdycOIlCuRTsJx6RPO4C4XT4ctE2+GrbMHkHeuTGhXNOutpJ9ILP/lh4s+
 +uOv7EaCSeePbXVyU6nZABlL+4iwT4qL3mSyMhe9LNrZEXVKfEAu6AB9cxSuOgYp2tWd
 YH2YnGzzSRREyTlDlMLY4bB/7c9FDZ9wtDr6/5ZECgkEQIxetFQ3CFYBe6xy/owA8shW
 vB8w==
X-Gm-Message-State: AJIora8ESwVbSreylCUhLspxftWFj2J4ZN6MP1QIRXr4/whFwAMj+EyR
 bpvqkY1lOagynJ2KZLX9N2g=
X-Google-Smtp-Source: AGRyM1vD+Ab3nz7tP2nVuzPb0dsUZnxwwUULdQcZmibPpfHs7wyej1w4JmMQtgxPcmsGhtrQP3nYMw==
X-Received: by 2002:a05:600c:3790:b0:39c:62b9:b164 with SMTP id
 o16-20020a05600c379000b0039c62b9b164mr4925109wmr.0.1655384277780; 
 Thu, 16 Jun 2022 05:57:57 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a5d4107000000b0020fffbc122asm2161091wrp.99.2022.06.16.05.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jun 2022 05:57:56 -0700 (PDT)
Message-ID: <d99deddb-c4a9-d5a1-d0a6-0e7f94fbdd9a@gmail.com>
Date: Thu, 16 Jun 2022 14:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] dt-bindings: iommu: mediatek: Add
 mediatek,infracfg phandle
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <20220616110830.26037-2-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220616110830.26037-2-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, miles.chen@mediatek.com, will@kernel.org,
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



On 16/06/2022 13:08, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup in the entire devicetree and set it as a required
> property for MT2712 and MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../bindings/iommu/mediatek,iommu.yaml          | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 2ae3bbad7f1a..fee0241b5098 100644
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
> @@ -167,6 +171,18 @@ allOf:
>         required:
>           - power-domains
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt2712-m4u
> +              - mediatek,mt8173-m4u
> +
> +    then:
> +      required:
> +        - mediatek,infracfg
> +
>     - if: # The IOMMUs don't have larbs.
>         not:
>           properties:
> @@ -191,6 +207,7 @@ examples:
>               interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
>               clocks = <&infracfg CLK_INFRA_M4U>;
>               clock-names = "bclk";
> +            mediatek,infracfg = <&infracfg>;
>               mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
>                                <&larb3>, <&larb4>, <&larb5>;
>               #iommu-cells = <1>;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
