Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA040C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 10:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D312400BA;
	Thu, 21 Apr 2022 10:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MCAbSgzs0nxN; Thu, 21 Apr 2022 10:41:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2EC37408C3;
	Thu, 21 Apr 2022 10:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09EEEC0033;
	Thu, 21 Apr 2022 10:41:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65E06C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 10:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 452868402E
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 10:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Key3Kc9FthBO for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 10:41:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31C918401F
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 10:41:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4941FB;
 Thu, 21 Apr 2022 03:41:12 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54ABA3F5A1;
 Thu, 21 Apr 2022 03:41:10 -0700 (PDT)
Date: Thu, 21 Apr 2022 11:41:05 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: fully convert arm to use dma-direct
Message-ID: <20220421114105.4bb06db7@donnerap.cambridge.arm.com>
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
 Robin Murphy <robin.murphy@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

On Thu, 21 Apr 2022 09:41:57 +0200
Christoph Hellwig <hch@lst.de> wrote:

Hi,

> arm is the last platform not using the dma-direct code for directly
> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> arm to always use dma-direct now (it already does for LPAE configs
> and nommu).  I'd love to merge this series through the dma-mapping tree
> as it gives us the opportunity for additional core dma-mapping
> improvements.
> 
> Diffstat:
>  arch/arm/common/dmabounce.c                          |  582 -------------------
>  arch/arm/include/asm/dma-mapping.h                   |  128 ----
>  b/arch/arm/Kconfig                                   |    5 
>  b/arch/arm/common/Kconfig                            |    6 
>  b/arch/arm/common/Makefile                           |    1 
>  b/arch/arm/common/sa1111.c                           |   64 --
>  b/arch/arm/include/asm/device.h                      |    3 
>  b/arch/arm/include/asm/dma-direct.h                  |   49 -
>  b/arch/arm/include/asm/memory.h                      |    2 
>  b/arch/arm/mach-footbridge/Kconfig                   |    1 
>  b/arch/arm/mach-footbridge/common.c                  |   19 
>  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8 
>  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4 
>  b/arch/arm/mach-highbank/highbank.c                  |    2 

FWIW, I applied this on top of 5.18-rc3 and pushed my Midway (the Highbank
successor) a bit with it (scp-ing GBs forth and back to a SATA SSD). Not a
really conclusive test, but so far it looks all fine.

So for the Highbank part:
Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


>  b/arch/arm/mach-mvebu/coherency.c                    |    2 
>  b/arch/arm/mm/dma-mapping.c                          |  381 ------------
>  b/drivers/usb/core/hcd.c                             |   17 
>  b/drivers/usb/host/ohci-sa1111.c                     |   25 
>  18 files changed, 84 insertions(+), 1215 deletions(-)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
