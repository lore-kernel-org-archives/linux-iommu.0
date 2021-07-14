Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5DAC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:38:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FD3613B2
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FD3613B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FCE1401FA;
	Wed, 14 Jul 2021 08:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hd6EAfyTDuQc; Wed, 14 Jul 2021 08:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C97D540114;
	Wed, 14 Jul 2021 08:38:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C19DC001A;
	Wed, 14 Jul 2021 08:38:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48AA0C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A540401FA
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b4Fw7QdKGZz9 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:38:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2269D40114
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:38:39 +0000 (UTC)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9EA68CC;
 Wed, 14 Jul 2021 10:38:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1626251915;
 bh=YbyFIqNHO3+cig/EdKRQenB4YdAV8pA1dPKaR9Ajrb0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pZ0PKnDxKLI8zEjX4dbxQdGSqpGC0WsyAIK8YFApt9/5WfEUne+DwoFdwe719/AfP
 q88kPyOc7s2GDRkoRX0SP6fZstxlduNZ7cq5hBJ6OQf97998wtga0XVb+HHu7oxcGp
 +ri5+FqXm+R52UKo3X+sPsPQYvQ0Z+iF5BLNOVbc=
Date: Wed, 14 Jul 2021 11:38:34 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: More dropping redundant minItems/maxItems
Message-ID: <YO6iinTsYE6EC+mn@pendragon.ideasonboard.com>
References: <20210713193453.690290-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210713193453.690290-1-robh@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-usb@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Richard Weinberger <richard@nod.at>, Sebastian Siewior <bigeasy@linutronix.de>,
 devicetree@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kamal Dasu <kdasu.kdev@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Brian Norris <computersforpeace@gmail.com>
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

Hi Rob,

Thank you for the patch.

On Tue, Jul 13, 2021 at 01:34:53PM -0600, Rob Herring wrote:
> Another round of removing redundant minItems/maxItems from new schema in
> the recent merge window.
> 
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
> 
> This condition is partially checked with the meta-schema already, but
> only if both 'minItems' and 'maxItems' are equal to the 'items' length.
> An improved meta-schema is pending.
> 
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sebastian Siewior <bigeasy@linutronix.de>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-clk@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-rtc@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/clock/brcm,iproc-clocks.yaml      | 1 -
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml         | 2 --
>  .../bindings/memory-controllers/arm,pl353-smc.yaml        | 1 -
>  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml  | 8 --------
>  .../devicetree/bindings/rtc/faraday,ftrtc010.yaml         | 1 -
>  Documentation/devicetree/bindings/usb/nxp,isp1760.yaml    | 2 --
>  6 files changed, 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.yaml b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.yaml
> index 8dc7b404ee12..1174c9aa9934 100644
> --- a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.yaml
> +++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.yaml
> @@ -50,7 +50,6 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 3
>      items:
>        - description: base register
>        - description: power register
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> index d2e28a9e3545..ba9124f721f1 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
> @@ -28,14 +28,12 @@ properties:
>        - description: configuration registers for MMU instance 0
>        - description: configuration registers for MMU instance 1
>      minItems: 1
> -    maxItems: 2
>  
>    interrupts:
>      items:
>        - description: interruption for MMU instance 0
>        - description: interruption for MMU instance 1
>      minItems: 1
> -    maxItems: 2
>  
>    clocks:
>      items:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> index 7a63c85ef8c5..01c9acf9275d 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.yaml
> @@ -57,7 +57,6 @@ properties:
>  
>    ranges:
>      minItems: 1
> -    maxItems: 3
>      description: |
>        Memory bus areas for interacting with the devices. Reflects
>        the memory layout with four integer values following:
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> index e5f1a33332a5..dd5a64969e37 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> @@ -84,7 +84,6 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 3
>      items:
>        - description: NAND CTLRDY interrupt
>        - description: FLASH_DMA_DONE if flash DMA is available
> @@ -92,7 +91,6 @@ properties:
>  
>    interrupt-names:
>      minItems: 1
> -    maxItems: 3
>      items:
>        - const: nand_ctlrdy
>        - const: flash_dma_done
> @@ -148,8 +146,6 @@ allOf:
>      then:
>        properties:
>          reg-names:
> -          minItems: 2
> -          maxItems: 2
>            items:
>              - const: nand
>              - const: nand-int-base
> @@ -161,8 +157,6 @@ allOf:
>      then:
>        properties:
>          reg-names:
> -          minItems: 3
> -          maxItems: 3
>            items:
>              - const: nand
>              - const: nand-int-base
> @@ -175,8 +169,6 @@ allOf:
>      then:
>        properties:
>          reg-names:
> -          minItems: 3
> -          maxItems: 3
>            items:
>              - const: nand
>              - const: iproc-idm
> diff --git a/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
> index 657c13b62b67..056d42daae06 100644
> --- a/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
> +++ b/Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml
> @@ -30,7 +30,6 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    minItems: 2
>      items:
>        - description: PCLK clocks
>        - description: EXTCLK clocks. Faraday calls it CLK1HZ and says the clock
> diff --git a/Documentation/devicetree/bindings/usb/nxp,isp1760.yaml b/Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
> index a88f99adfe8e..f238848ad094 100644
> --- a/Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
> +++ b/Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
> @@ -25,14 +25,12 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 2
>      items:
>        - description: Host controller interrupt
>        - description: Device controller interrupt in isp1761
>  
>    interrupt-names:
>      minItems: 1
> -    maxItems: 2
>      items:
>        - const: host
>        - const: peripheral

-- 
Regards,

Laurent Pinchart
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
