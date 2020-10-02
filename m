Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6532C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 11:08:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F069206B8
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 11:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F069206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 55AD6273E1;
	Fri,  2 Oct 2020 11:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7MYwmHte-UW3; Fri,  2 Oct 2020 11:08:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5A5F3204CA;
	Fri,  2 Oct 2020 11:08:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40D03C016F;
	Fri,  2 Oct 2020 11:08:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD4AC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 11:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7541D84B89
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 11:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jvL5KLx2Mxtg for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 11:08:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ECA94847E6
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 11:08:36 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id t16so1222102edw.7
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 04:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8+XTJgLgGvu+PgnQvEqvP3vrDLHMLZXGcZ/b+5gA0Fg=;
 b=uG0NihStx4sJW4l3mGmgE9R/+vsC4VPTmLv+5yFmswVZrPcMwkMw4DM7/ynKZon14M
 QEecCDzyT2X78G3Q1KvU6/2lWU5IphSqQGl4z3H0LxDNrkyTxAFUJajcs842urdUe/1J
 YBgwbmypv3F1hzM2rCF/P111u1L/kbHXsefEPGsagquaK9uD249WoFuRM2xNlY055JlL
 HqeBoCpDstGS04M9rsis0zdD9+O/0GBH4UuzuNm09oZX4obtUzvX0HJN7QGCr7Z37zYf
 yKKLIi86h0TFYf+cdXSRu/jL86dErAjAQX7nptGngjIXoBxF2XtgqJPiJm4FFdeyXp0s
 A+ow==
X-Gm-Message-State: AOAM531Ttj+498Y2nmBIrUQJX/IKsbit0uiwp6p2LAquG5zrxz4rU3c+
 uCBNDLMtO3jxuinP7EJkwKY=
X-Google-Smtp-Source: ABdhPJy+3cpdhcQpP3L2cVztpQbxIGRTeujm02q8HW2n6jNeMvzXQDu4DC+Ju5QkkLyIC+PCSEHvUQ==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr1753263edj.94.1601636915406; 
 Fri, 02 Oct 2020 04:08:35 -0700 (PDT)
Received: from pi3 ([194.230.155.194])
 by smtp.googlemail.com with ESMTPSA id g9sm61954ejz.23.2020.10.02.04.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:08:34 -0700 (PDT)
Date: Fri, 2 Oct 2020 13:08:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 02/24] dt-bindings: memory: mediatek: Convert SMI to
 DT schema
Message-ID: <20201002110831.GD6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-3-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

On Wed, Sep 30, 2020 at 03:06:25PM +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  49 ---------
>  .../mediatek,smi-common.yaml                  | 100 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  49 ---------
>  .../memory-controllers/mediatek,smi-larb.yaml |  91 ++++++++++++++++
>  4 files changed, 191 insertions(+), 98 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> deleted file mode 100644
> index b64573680b42..000000000000
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -SMI (Smart Multimedia Interface) Common
> -
> -The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
> -
> -Mediatek SMI have two generations of HW architecture, here is the list
> -which generation the SoCs use:
> -generation 1: mt2701 and mt7623.
> -generation 2: mt2712, mt6779, mt8173 and mt8183.
> -
> -There's slight differences between the two SMI, for generation 2, the
> -register which control the iommu port is at each larb's register base. But
> -for generation 1, the register is at smi ao base(smi always on register
> -base). Besides that, the smi async clock should be prepared and enabled for
> -SMI generation 1 to transform the smi clock into emi clock domain, but that is
> -not needed for SMI generation 2.
> -
> -Required properties:
> -- compatible : must be one of :
> -	"mediatek,mt2701-smi-common"
> -	"mediatek,mt2712-smi-common"
> -	"mediatek,mt6779-smi-common"
> -	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
> -	"mediatek,mt8173-smi-common"
> -	"mediatek,mt8183-smi-common"
> -- reg : the register and size of the SMI block.
> -- power-domains : a phandle to the power domain of this local arbiter.
> -- clocks : Must contain an entry for each entry in clock-names.
> -- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
> -  for generation 2 smi HW as follows:
> -  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
> -	    the register.
> -  - "smi" : It's the clock for transfer data and command.
> -	    They may be the same if both source clocks are the same.
> -  - "async" : asynchronous clock, it help transform the smi clock into the emi
> -	      clock domain, this clock is only needed by generation 1 smi HW.
> -  and these 2 option clocks for generation 2 smi HW:
> -  - "gals0": the path0 clock of GALS(Global Async Local Sync).
> -  - "gals1": the path1 clock of GALS(Global Async Local Sync).
> -  Here is the list which has this GALS: mt6779 and mt8183.
> -
> -Example:
> -	smi_common: smi@14022000 {
> -		compatible = "mediatek,mt8173-smi-common";
> -		reg = <0 0x14022000 0 0x1000>;
> -		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> -		clocks = <&mmsys CLK_MM_SMI_COMMON>,
> -			 <&mmsys CLK_MM_SMI_COMMON>;
> -		clock-names = "apb", "smi";
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> new file mode 100644
> index 000000000000..76ecc7205438
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SMI (Smart Multimedia Interface) Common
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +
> +description: |+
> +  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
> +
> +  MediaTek SMI have two generations of HW architecture, here is the list
> +  which generation the SoCs use:
> +  generation 1: mt2701 and mt7623.
> +  generation 2: mt2712, mt6779, mt8173 and mt8183.
> +
> +  There's slight differences between the two SMI, for generation 2, the
> +  register which control the iommu port is at each larb's register base. But
> +  for generation 1, the register is at smi ao base(smi always on register
> +  base). Besides that, the smi async clock should be prepared and enabled for
> +  SMI generation 1 to transform the smi clock into emi clock domain, but that is
> +  not needed for SMI generation 2.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2701-smi-common
> +          - mediatek,mt2712-smi-common
> +          - mediatek,mt6779-smi-common
> +          - mediatek,mt8173-smi-common
> +          - mediatek,mt8183-smi-common
> +
> +      - description: for mt7623
> +        items:
> +          - const: mediatek,mt7623-smi-common
> +          - const: mediatek,mt2701-smi-common
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      apb and smi are mandatory. the async is only for generation 1 smi HW.
> +      gals(global async local sync) also is optional, here is the list which
> +      require gals: mt6779 and mt8183.
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      - description: apb is Advanced Peripheral Bus clock, It's the clock for
> +          setting the register.
> +      - description: smi is the clock for transfer data and command.
> +      - description: async is asynchronous clock, it help transform the smi clock
> +          into the emi clock domain.
> +      - description: gals0 is the path0 clock of gals.
> +      - description: gals1 is the path1 clock of gals.
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: apb
> +          - const: smi
> +      - items:
> +          - const: apb
> +          - const: smi
> +          - const: async
> +      - items:
> +          - const: apb
> +          - const: smi
> +          - const: gals0
> +          - const: gals1

Similarly to my comment to other properties, this requirement per
compatible should be part of the schema within 'if-then'.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
