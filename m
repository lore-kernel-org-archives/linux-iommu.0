Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24578C433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 09:03:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0AEC409DC;
	Tue,  5 Apr 2022 09:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ByiLPoT73zCU; Tue,  5 Apr 2022 09:03:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8BA2F405A2;
	Tue,  5 Apr 2022 09:03:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2E7C001D;
	Tue,  5 Apr 2022 09:03:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A39BDC0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 09:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 780DC8271D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 09:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qkeehu3jIhe6 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 09:03:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B841982718
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 09:03:25 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 159BACE1C6F;
 Tue,  5 Apr 2022 09:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC74C385A1;
 Tue,  5 Apr 2022 09:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1649149398;
 bh=qQXWyRu4TEliDafq6CKePkOIo5nPfDxb/EyW2btOqvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UAjVP0C7VF+vaOL+kuiGDrueRHUpT7B9Q3XcfVDr1Bl4dlS0fXePCjWcK4hpl2aF0
 b2C7JNJYN/pzLnwvZf2NFHWBljc12WxlT6jY9mpZIyjqtsSwPchP73ETkOgiDGCOzl
 MU2Pms/zkl/FAPUbLr9GS+lZ9du+Q355dXDW8hKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.16 0673/1017] dma-debug: fix return value of __setup handlers
Date: Tue,  5 Apr 2022 09:26:26 +0200
Message-Id: <20220405070414.257099109@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Cc: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Igor Zhbanov <i.zhbanov@omprussia.ru>,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 80e4390981618e290616dbd06ea190d4576f219d ]

When valid kernel command line parameters
  dma_debug=off dma_debug_entries=100
are used, they are reported as Unknown parameters and added to init's
environment strings, polluting it.

  Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc5
    dma_debug=off dma_debug_entries=100", will be passed to user space.

and

 Run /sbin/init as init process
   with arguments:
     /sbin/init
   with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc5
     dma_debug=off
     dma_debug_entries=100

Return 1 from these __setup handlers to indicate that the command line
option has been handled.

Fixes: 59d3daafa1726 ("dma-debug: add kernel command line parameters")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 7a14ca29c377..f8ff598596b8 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -927,7 +927,7 @@ static __init int dma_debug_cmdline(char *str)
 		global_disable = true;
 	}
 
-	return 0;
+	return 1;
 }
 
 static __init int dma_debug_entries_cmdline(char *str)
@@ -936,7 +936,7 @@ static __init int dma_debug_entries_cmdline(char *str)
 		return -EINVAL;
 	if (!get_option(&str, &nr_prealloc_entries))
 		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
-	return 0;
+	return 1;
 }
 
 __setup("dma_debug=", dma_debug_cmdline);
-- 
2.34.1



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
