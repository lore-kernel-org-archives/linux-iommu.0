Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E2EC43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 06:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46FD960C13;
	Wed, 29 Jun 2022 06:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46FD960C13
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 70i8a5Mjx3uq; Wed, 29 Jun 2022 06:28:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A1FE60A6D;
	Wed, 29 Jun 2022 06:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A1FE60A6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8F52C0032;
	Wed, 29 Jun 2022 06:28:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B46CC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 459A2408FC
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 459A2408FC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyE23qM2FXAg for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:28:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07AD240886
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07AD240886
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 06:28:42 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3AFBD67373; Wed, 29 Jun 2022 08:28:37 +0200 (CEST)
Date: Wed, 29 Jun 2022 08:28:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@kernel.org>
Subject: Re: fully convert arm to use dma-direct v3
Message-ID: <20220629062837.GA17140@lst.de>
References: <20220614092047.572235-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220614092047.572235-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Andrew Lunn <andrew@lunn.ch>, Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Any comments or additional testing?  It would be really great to get
this off the table.

On Tue, Jun 14, 2022 at 11:20:37AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> arm is the last platform not using the dma-direct code for directly
> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> arm to always use dma-direct now (it already does for LPAE configs
> and nommu).  I'd love to merge this series through the dma-mapping tree
> as it gives us the opportunity for additional core dma-mapping
> improvements.
> 
> Changes since v2:
>  - rebased to Linux 5.19-rc2
> 
> Changes since v1:
>  - remove another unused function
>  - improve a few commit logs
>  - add three more patches from Robin
> 
> Diffstat:
>  arch/arm/common/dmabounce.c                          |  582 -----------------
>  arch/arm/include/asm/dma-mapping.h                   |  128 ---
>  b/arch/arm/Kconfig                                   |    5 
>  b/arch/arm/common/Kconfig                            |    6 
>  b/arch/arm/common/Makefile                           |    1 
>  b/arch/arm/common/sa1111.c                           |   64 -
>  b/arch/arm/include/asm/device.h                      |    3 
>  b/arch/arm/include/asm/dma-direct.h                  |   49 -
>  b/arch/arm/include/asm/memory.h                      |    2 
>  b/arch/arm/mach-footbridge/Kconfig                   |    1 
>  b/arch/arm/mach-footbridge/common.c                  |   19 
>  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8 
>  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4 
>  b/arch/arm/mach-highbank/highbank.c                  |    2 
>  b/arch/arm/mach-mvebu/coherency.c                    |    2 
>  b/arch/arm/mm/dma-mapping.c                          |  649 ++-----------------
>  b/drivers/usb/core/hcd.c                             |   17 
>  b/drivers/usb/host/ohci-sa1111.c                     |   25 
>  18 files changed, 137 insertions(+), 1430 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
---end quoted text---
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
