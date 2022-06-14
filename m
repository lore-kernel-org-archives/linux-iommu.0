Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57660C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 09:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47BCF60B18;
	Tue, 14 Jun 2022 09:21:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9oPa1-WDIAze; Tue, 14 Jun 2022 09:21:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D79D860AD2;
	Tue, 14 Jun 2022 09:21:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 973D9C0032;
	Tue, 14 Jun 2022 09:21:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFEDC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 09:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6497981C6E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 09:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I4NxXmypF3Rj for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 09:21:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CD0481C93
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=U6PoerE9UCYpP4xSLqMKP1SJdUCxaCfj3/XK0rIc3e4=; b=cUTdTvyAk6sfntwoLmCm7BNRnw
 UiPjTyCzLLzLWIcPXL+HFSEoGO7dRMDpxrdgrOgl3bWFtSfZtctEal3MT4b+aULh4sAI9rFWtw3lN
 skBAwH+2v4vbjKGieaUl9/RCzwHOv+1ncywbF2JUpHErtgWmwKKDHgfJNXKVeyY5JGe4zisvy5gMg
 FJ9YV2IzEcvZZ685Cuk/yKE5Wn6evqdWBQMrkAFT+aBH3k3p5O8Bss2RFHDvw31rMJ33rP8nMNXFP
 GPrq34WCn+/sHP/iys5BtM7ma6i2oZOWap8guOIS9sbp6NP6t1H8QjUHv7GkfVLrjFOt8j+mxdwe3
 xbNAHYYw==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o12jB-008fFa-RD; Tue, 14 Jun 2022 09:20:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: fully convert arm to use dma-direct v3
Date: Tue, 14 Jun 2022 11:20:37 +0200
Message-Id: <20220614092047.572235-1-hch@lst.de>
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

Changes since v2:
 - rebased to Linux 5.19-rc2

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
