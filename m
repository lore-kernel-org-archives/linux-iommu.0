Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E6BC433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 17:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0EDC4175C;
	Tue, 12 Apr 2022 17:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rx0NCEaEtG4Y; Tue, 12 Apr 2022 17:39:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3FF4F410AA;
	Tue, 12 Apr 2022 17:39:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 103C3C002F;
	Tue, 12 Apr 2022 17:39:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19BBFC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 17:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1564540A05
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 17:39:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ptgt1NfMqOE for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 17:39:03 +0000 (UTC)
X-Greylist: delayed 00:05:45 by SQLgrey-1.8.0
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0724340A00
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 17:39:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 6A364419B4;
 Tue, 12 Apr 2022 17:33:12 +0000 (UTC)
Message-ID: <e5e7ae3d-8b4e-b177-6b26-37ae12b4e440@marcan.st>
Date: Wed, 13 Apr 2022 02:33:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: merge DART into ARM/APPLE MACHINE
Content-Language: es-ES
To: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>
References: <20220412161211.23162-1-sven@svenpeter.dev>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20220412161211.23162-1-sven@svenpeter.dev>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 linux-kernel@vger.kernel.org
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

On 13/04/2022 01.12, Sven Peter wrote:
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

Acked-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
