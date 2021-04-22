Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453E6C433ED
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 13:21:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A340461435
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 13:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A340461435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36D07401E5;
	Thu, 22 Apr 2021 13:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1vTQJO93ZWAe; Thu, 22 Apr 2021 13:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECD0F40112;
	Thu, 22 Apr 2021 13:21:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD794C000E;
	Thu, 22 Apr 2021 13:21:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28021C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 13:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09DCB401E5
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 13:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zLuIDd1crOs1 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 13:13:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5050640112
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 13:13:44 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id u17so68756761ejk.2
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3hsr6lCLd7JFlK9taoygzcaxUpuGrqlvJuCbv9uQLPQ=;
 b=faywr3P7WFufLom1rX2WOmWEReYjumYY9+Q6qWzuIDUblJZ2Hxu+9YJPrj+Eikd4cf
 RHkz3e/YFfIXC6Us+iaAW/hnfF7gtQ4tegZIM1gbbESI19XyOjf+9s60ZhU4khOVRGSz
 TMU4rRlg+LNAyMKzX5rNrDsMZ6AA80QzwLWnt5ac/tggOvuZN901ZZ5Ah1lUv4DWXVUB
 1pRQyRooIodQOoPK0gLLq2miQkvc1pgNe82optlJgVzv+pSvAmJzpXJU5kYuuEE0BqEF
 XVYqJJZbvEGytp0OI/5zaAbSILvPtqeY+DNHFIALp6cCINm1R5CtzQXunT4f7g7+06PB
 n9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3hsr6lCLd7JFlK9taoygzcaxUpuGrqlvJuCbv9uQLPQ=;
 b=cj8AFAlgunrsqS28pPuxEFuTD+75wQ/hizuISKMOBJZ/3/o0ZT1dQk4dLxHbLba2M5
 jjJRKwqccAIj1fmrdquuQytviErwePJJ+4gsxpQGeyJ7bOF04LpEiSmrFgtwjriTKTWP
 tBPtXWKszJ2giGRFHYKl5/d4Yvnjq4Cu4bj9e5j3BTQWOLaYMy6JEzFPVg5g5Jf/jRY1
 8C59/yly4JFUNVg+gUGY6K9d4pOB1qPu/H/IgplVyZD4pclfQFgx7mMNKW17M8XzX1ET
 RtvkEtd0Vb1WRUCH0LvPe6z94uIGlvZEYA+GjmiBYk4A4ZQxWZvs26/gQdOcQ3KuyB7b
 49ZQ==
X-Gm-Message-State: AOAM530zxgfYELuNMc0sntNzVdfJE9OhMdew/N7ZTioOsyJkZ4s+9KdO
 QiYsloArVALahDEkHCjX3n0=
X-Google-Smtp-Source: ABdhPJzXCfbHhFUzaYpljXPt1Ch/X5HDXhU8dNkH2BmhotD1eZOoiPgxt8o6p0gUe9CTiF8IOY5I3g==
X-Received: by 2002:a17:906:a449:: with SMTP id
 cb9mr3312469ejb.118.1619097222388; 
 Thu, 22 Apr 2021 06:13:42 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 f22sm1828519ejr.35.2021.04.22.06.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Apr 2021 06:13:41 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: iommu: rockchip: Convert IOMMU to DT
 schema
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, heiko@sntech.de, xxm@rock-chips.com
References: <20210422072442.111070-1-benjamin.gaignard@collabora.com>
 <20210422072442.111070-2-benjamin.gaignard@collabora.com>
From: Johan Jonker <jbx6244@gmail.com>
Message-ID: <c2087946-0dfb-b66e-bcb9-5bba5fd098bf@gmail.com>
Date: Thu, 22 Apr 2021 15:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210422072442.111070-2-benjamin.gaignard@collabora.com>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 22 Apr 2021 13:21:39 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
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

Hi Benjamin,

Please check robh/dtbs-check failed build log at

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210422072442.111070-2-benjamin.gaignard@collabora.com/

make ARCH=arm64 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml


make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml

Test if all notifications are gone.

===

YAML also checks extra properties like "power-domains" not yet included
but needed for rk3568.
Add them in a separate patch.

===

rk3229-evb.dt.yaml: iommu@20030480: 'iommu-cells' does not match any of
the regexes

Change a rk322x.dtsi property to #iommu-cells in a separate patch.

===

rk3229-xms6.dt.yaml: iommu@20030480: reg: [[537068672, 64], [537068736,
64]] is too long

Change reg minItems maxItems.

===

Johan

On 4/22/21 9:24 AM, Benjamin Gaignard wrote:
> Convert Rockchip IOMMU to DT schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../bindings/iommu/rockchip,iommu.txt         | 38 ----------
>  .../bindings/iommu/rockchip,iommu.yaml        | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> deleted file mode 100644
> index 6ecefea1c6f9..000000000000
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -Rockchip IOMMU
> -==============
> -
> -A Rockchip DRM iommu translates io virtual addresses to physical addresses for
> -its master device.  Each slave device is bound to a single master device, and
> -shares its clocks, power domain and irq.
> -
> -Required properties:
> -- compatible      : Should be "rockchip,iommu"
> -- reg             : Address space for the configuration registers
> -- interrupts      : Interrupt specifier for the IOMMU instance
> -- interrupt-names : Interrupt name for the IOMMU instance
> -- #iommu-cells    : Should be <0>.  This indicates the iommu is a
> -                    "single-master" device, and needs no additional information
> -                    to associate with its master device.  See:
> -                    Documentation/devicetree/bindings/iommu/iommu.txt
> -- clocks          : A list of clocks required for the IOMMU to be accessible by
> -                    the host CPU.
> -- clock-names     : Should contain the following:
> -	"iface" - Main peripheral bus clock (PCLK/HCL) (required)
> -	"aclk"  - AXI bus clock (required)
> -
> -Optional properties:
> -- rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> -			       Some mmu instances may produce unexpected results
> -			       when the reset operation is used.
> -
> -Example:
> -
> -	vopl_mmu: iommu@ff940300 {
> -		compatible = "rockchip,iommu";
> -		reg = <0xff940300 0x100>;
> -		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> -		interrupt-names = "vopl_mmu";
> -		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> -		clock-names = "aclk", "iface";
> -		#iommu-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> new file mode 100644
> index 000000000000..ab128f8e4c73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -0,0 +1,76 @@

> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

GPL-2.0
This is a conversion of an existing document.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/rockchip,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip IOMMU
> +
> +maintainers:
> +  - Simon Xue <xxm@rock-chips.com>

  - Heiko Stuebner <heiko@sntech.de>

Add someone that can respond in a short time in case rob+dt wants to
delete something.

> +
> +description: |+
> +  A Rockchip DRM iommu translates io virtual addresses to physical addresses for

> +  its master device. Each slave device is bound to a single master device, and

No comma "," before "and"

> +  shares its clocks, power domain and irq.
> +
> +  For information on assigning IOMMU controller to its peripheral devices,
> +  see generic IOMMU bindings.
> +
> +properties:
> +  compatible:
> +    const: rockchip,iommu
> +
> +  reg:

> +    maxItems: 1

minItems: 1
maxItems: 2


> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Core clock
> +      - description: Interface clock
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: iface
> +
> +  "#iommu-cells":
> +    const: 0
> +

  power-domains:
    maxItems: 1

Add in separate patch for review by rob+bt

> +  rockchip,disable-mmu-reset:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

> +      Don't use the mmu reset operation.

Do not use ....

The use of "'" in a YAML description gives problems in some text
highlighters. Try to avoid.

> +      Some mmu instances may produce unexpected results
> +      when the reset operation is used.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    vopl_mmu: iommu@ff940300 {
> +      compatible = "rockchip,iommu";
> +      reg = <0xff940300 0x100>;
> +      interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "vopl_mmu";
> +      clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> +      clock-names = "aclk", "iface";
> +      #iommu-cells = <0>;
> +    };
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
