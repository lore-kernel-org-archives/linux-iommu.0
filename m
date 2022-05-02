Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33976C433FE
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 16:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD34640A90;
	Mon,  2 May 2022 16:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vT7YxZHmeHZX; Mon,  2 May 2022 16:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4F3F40133;
	Mon,  2 May 2022 16:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEF1C0084;
	Mon,  2 May 2022 16:43:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C435EC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3B6083E12
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P5W2fEj6EoUw for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:43:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DE1E83466
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=wHl4cbtL1S8htSuAhU2clusrBvbTSVTyhS/hzdP276Y=; b=2tpiKq1FH/1wL6GiAlOTT2OERn
 AHRaFCLaSiXp7bne/XXu7xjgHv00b4rBfJCFARM+pMUl/i5WUJyq8A/Z6ctQXmZky5GWo+qPRaMxC
 mhEj/ibW5LT9BgSQ+mHMOp87KSrBoB/59iqC6Fz7gZmvGb0DYgr9Cjzmr3BNZTJtQfpZ6xtO5yjmM
 cAdjqogQYFSAeJN7h945zSPi/DMqJPaBp4R7n+8mtJxvLBiIRLare6lTXgxQFySooAfEi/PfXec5N
 Mg7M2g8WAxwIcrzgDqXxAdzMYoz1vgkNvvXBLq7tFW/XzPmeGHLXDe8w5DWfjUQrf2ZeWlsREijhM
 lfMWPqqQ==;
Received: from [8.34.116.185] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlZ91-001kdn-E3; Mon, 02 May 2022 16:43:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: fully convert arm to use dma-direct v2
Date: Mon,  2 May 2022 09:43:20 -0700
Message-Id: <20220502164330.229685-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Hi all,

arm is the last platform not using the dma-direct code for directly
mapped DMA.  With the dmaboune removal from Arnd we can easily switch
arm to always use dma-direct now (it already does for LPAE configs
and nommu).  I'd love to merge this series through the dma-mapping tree
as it gives us the opportunity for additional core dma-mapping
improvements.

Changes since v1:
 - remove another unused function
 - improve a few commit logs
 - add three more patches from Robin

Diffstat:
 arch/arm/common/dmabounce.c                          |  582 -----------------
 arch/arm/include/asm/dma-mapping.h                   |  128 ---
 b/arch/arm/Kconfig                                   |    5 
 b/arch/arm/common/Kconfig                            |    6 
 b/arch/arm/common/Makefile                           |    1 
 b/arch/arm/common/sa1111.c                           |   64 -
 b/arch/arm/include/asm/device.h                      |    3 
 b/arch/arm/include/asm/dma-direct.h                  |   49 -
 b/arch/arm/include/asm/memory.h                      |    2 
 b/arch/arm/mach-footbridge/Kconfig                   |    1 
 b/arch/arm/mach-footbridge/common.c                  |   19 
 b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8 
 b/arch/arm/mach-footbridge/include/mach/memory.h     |    4 
 b/arch/arm/mach-highbank/highbank.c                  |    2 
 b/arch/arm/mach-mvebu/coherency.c                    |    2 
 b/arch/arm/mm/dma-mapping.c                          |  649 ++-----------------
 b/drivers/usb/core/hcd.c                             |   17 
 b/drivers/usb/host/ohci-sa1111.c                     |   25 
 18 files changed, 137 insertions(+), 1430 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
