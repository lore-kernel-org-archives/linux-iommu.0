Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A10CC433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 16:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0ADB740B0F;
	Tue, 12 Apr 2022 16:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jm4SVzzGfF4I; Tue, 12 Apr 2022 16:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DAD6F40B09;
	Tue, 12 Apr 2022 16:23:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD98CC0033;
	Tue, 12 Apr 2022 16:23:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2894C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 16:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 827C4818EC
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 16:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EvGdq2DsCDqb for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:23:56 +0000 (UTC)
X-Greylist: delayed 00:05:34 by SQLgrey-1.8.0
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F782818C0
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 16:23:56 +0000 (UTC)
Received: by rosenzweig.io (Postfix, from userid 1000)
 id 588E441BA2; Tue, 12 Apr 2022 16:18:21 +0000 (UTC)
Date: Tue, 12 Apr 2022 16:18:21 +0000
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] MAINTAINERS: merge DART into ARM/APPLE MACHINE
Message-ID: <YlWmTZxuEemYjNdr@rosenzweig.io>
References: <20220412161211.23162-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220412161211.23162-1-sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

On Tue, Apr 12, 2022 at 06:12:11PM +0200, Sven Peter wrote:
> It's the same people anyway.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..5af879de869c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1375,14 +1375,6 @@ L:	linux-input@vger.kernel.org
>  S:	Odd fixes
>  F:	drivers/input/mouse/bcm5974.c
>  
> -APPLE DART IOMMU DRIVER
> -M:	Sven Peter <sven@svenpeter.dev>
> -R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
> -L:	iommu@lists.linux-foundation.org
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> -F:	drivers/iommu/apple-dart.c
> -
>  APPLE PCIE CONTROLLER DRIVER
>  M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
>  M:	Marc Zyngier <maz@kernel.org>
> @@ -1836,6 +1828,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
>  F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
>  F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
> +F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
>  F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> @@ -1845,6 +1838,7 @@ F:	arch/arm64/boot/dts/apple/
>  F:	drivers/clk/clk-apple-nco.c
>  F:	drivers/i2c/busses/i2c-pasemi-core.c
>  F:	drivers/i2c/busses/i2c-pasemi-platform.c
> +F:	drivers/iommu/apple-dart.c
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	drivers/mailbox/apple-mailbox.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
