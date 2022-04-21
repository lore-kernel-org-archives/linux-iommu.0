Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67998C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 07:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C21160BA6;
	Thu, 21 Apr 2022 07:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z8yBZwCS5OFK; Thu, 21 Apr 2022 07:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E161360B74;
	Thu, 21 Apr 2022 07:42:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A150EC0033;
	Thu, 21 Apr 2022 07:42:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E234C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3522F41707
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KbO6x6FBMRFL for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:42:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A59B409B2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=2mMRupdTibHP92zSqaJ1XHBYwKEXmx1jN9N5J5PfPKA=; b=a8SN8amWkK5b+WwqYYs3BkbqdD
 aNUpfiWWOC+FKwZNUV3qNmadhpDu7TdDmoDQHs37i8PrnBIMSNr+qv38GstUp5xDmFD6YOFe6kT7o
 47IAm1qNvIXhXwE550bNDqeeZ60TUjG5g6k9XgckFo8fd6BKM9ZhjCW3EDcmlI1EeWm2lG11nOalz
 EvoX3CEgUuyhcQIQ/z4oVa6P/ZxRyer8BgLSgpVoF/r/adK1WFl68rF8J4qnEZhoPQcEmQKg5Qq03
 qTmEtOo+Ng9dc8P/TxyqYIYTJgItF17s1SU8LFbWLE9nl5VXORrcGTZYhnaGq7hTW3eDVtVgC6H7z
 hbd6lo9g==;
Received: from [2001:4bb8:191:364b:7b50:153f:5622:82f7] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhRS2-00C7P9-5g; Thu, 21 Apr 2022 07:42:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: fully convert arm to use dma-direct
Date: Thu, 21 Apr 2022 09:41:57 +0200
Message-Id: <20220421074204.1284072-1-hch@lst.de>
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

Diffstat:
 arch/arm/common/dmabounce.c                          |  582 -------------------
 arch/arm/include/asm/dma-mapping.h                   |  128 ----
 b/arch/arm/Kconfig                                   |    5 
 b/arch/arm/common/Kconfig                            |    6 
 b/arch/arm/common/Makefile                           |    1 
 b/arch/arm/common/sa1111.c                           |   64 --
 b/arch/arm/include/asm/device.h                      |    3 
 b/arch/arm/include/asm/dma-direct.h                  |   49 -
 b/arch/arm/include/asm/memory.h                      |    2 
 b/arch/arm/mach-footbridge/Kconfig                   |    1 
 b/arch/arm/mach-footbridge/common.c                  |   19 
 b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8 
 b/arch/arm/mach-footbridge/include/mach/memory.h     |    4 
 b/arch/arm/mach-highbank/highbank.c                  |    2 
 b/arch/arm/mach-mvebu/coherency.c                    |    2 
 b/arch/arm/mm/dma-mapping.c                          |  381 ------------
 b/drivers/usb/core/hcd.c                             |   17 
 b/drivers/usb/host/ohci-sa1111.c                     |   25 
 18 files changed, 84 insertions(+), 1215 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
