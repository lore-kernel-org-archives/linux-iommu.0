Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F121C433E2
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 17:34:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22B72137B
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 17:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFp4HORQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22B72137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 34E0A2E13F;
	Thu, 17 Sep 2020 17:34:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LdfU4SVluzeo; Thu, 17 Sep 2020 17:34:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 343F42A16D;
	Thu, 17 Sep 2020 17:34:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 074C4C0888;
	Thu, 17 Sep 2020 17:34:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12021C0859
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0E5B9870D6
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:34:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kc6LRnyrvulv for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 17:34:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C4C12870BE
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=4maTmDv4AP9a2BVWoeVpaTsF7J85VdHKVOCXW2UepmM=; b=QFp4HORQVPspQyGcNMbSL/1M6h
 1sRHDmXrzXxAaFTyenkhdDUzIMqP/3+LRa350pLnLpT27G2DmCVVkxHUjnP33eNWr1Xe/Ns7Bvptw
 vOPfeREcXNIfZqhfq8jWWDP0i0ha8XUbevEgNwzzX/Y1e0aFpnylsDHlGF3R0u+iYrWP+M6dA0XrE
 iYAo6gjMsKD6ohHAWMaam19wPmRXH9esO6hN7Lel1JKz9Df1pKIq1/nEtH9JMN98jM/CTg7Ximrup
 IcCrMulugPrDBiaLexpCbwKTzRuGq9nAw4/d0fvsBfSnenDIsLffBWaspUXE/HOhiaP5vI2OcA790
 CPS34y1A==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIxns-0002tg-8A; Thu, 17 Sep 2020 17:34:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Subject: RFC: remove the need for <asm/dma-direct.h> on ARM
Date: Thu, 17 Sep 2020 19:32:25 +0200
Message-Id: <20200917173229.3311382-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi Russell,

as Robin pointed out there is not much need for the ARM specific
routines to translated to and from a dma_addr_t given that we have
the dma offset (and now offset range) functionality.  This series
converts ARM over to the generic helpers.  This has only been tested
on qemu, and specificall not on omap1 and footbridge given that I
do not have the hardware.

The patches are on to of the dma-mapping for-next tree, to make
review and testing easier a git tree is also available here:

    git://git.infradead.org/users/hch/misc.git arm-dma-direct-cleanups

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-dma-direct-cleanups


Diffstat:
 arch/arm/include/asm/dma-direct.h                |   66 -----------------------
 b/arch/arm/Kconfig                               |    1 
 b/arch/arm/common/dmabounce.c                    |   14 ++--
 b/arch/arm/include/asm/memory.h                  |    2 
 b/arch/arm/mach-footbridge/cats-pci.c            |    7 +-
 b/arch/arm/mach-footbridge/common.c              |   40 ++++++++++---
 b/arch/arm/mach-footbridge/common.h              |    3 +
 b/arch/arm/mach-footbridge/ebsa285-pci.c         |    7 +-
 b/arch/arm/mach-footbridge/include/mach/memory.h |    4 -
 b/arch/arm/mach-footbridge/netwinder-pci.c       |    7 +-
 b/arch/arm/mach-footbridge/personal-pci.c        |    7 +-
 b/arch/arm/mach-omap1/include/mach/memory.h      |   31 ----------
 b/arch/arm/mach-omap1/usb.c                      |   22 +++++++
 b/arch/arm/mm/dma-mapping.c                      |   20 +++---
 14 files changed, 91 insertions(+), 140 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
