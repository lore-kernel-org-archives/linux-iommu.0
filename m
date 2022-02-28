Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F322C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 23:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 142F1405F7;
	Mon, 28 Feb 2022 23:18:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqyM8O7IHAZf; Mon, 28 Feb 2022 23:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9024D40127;
	Mon, 28 Feb 2022 23:18:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70CA2C0077;
	Mon, 28 Feb 2022 23:18:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5246CC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 23:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C8C5812F6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 23:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T15-D1mjGvfg for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 23:18:50 +0000 (UTC)
X-Greylist: delayed 01:13:44 by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10163812C9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=mmm+PW+NtNM5o6/cJBgUmQCsMyjF6xFQu4DaDU5Rl54=; b=PHwapDxrfaF56tA9Lag8PmfkBV
 FFJIDTvG6qC0Ik1grXkkfvHixsQ5zdbdu+gK1aLB9BHhrfDuIK6Pvpr9uJ5Ya8cu+qzfxBjhggAVb
 Vt3F28dwYNdx/4rXtYFScArR33X05bkdgtVkt5PAJikCBYrs7ehnC1DuYuBEXSEu3W4P3Q5l6dS5s
 l0If5FoHoNXyA3ZaXsXi2loUiSXbnOcB3KHdD873KAHK0HyYROXG8qg9J0MIliRFkYhVB2c/LaXUd
 ZWSWLvZCPlf3Z7F1PswoZi6vj8lEpsReK10GCtHR4iL1PchWIF79mKcbaAl86wN9ZumKFUFZy6ZWG
 TDc9qRAQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOo8W-00EFxg-2B; Mon, 28 Feb 2022 22:04:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: dma-debug: fix return value of __setup handlers
Date: Mon, 28 Feb 2022 14:04:53 -0800
Message-Id: <20220228220453.23726-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Randy Dunlap <rdunlap@infradead.org>, Igor Zhbanov <i.zhbanov@omprussia.ru>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
---
 kernel/dma/debug.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220228.orig/kernel/dma/debug.c
+++ linux-next-20220228/kernel/dma/debug.c
@@ -927,7 +927,7 @@ static __init int dma_debug_cmdline(char
 		global_disable = true;
 	}
 
-	return 0;
+	return 1;
 }
 
 static __init int dma_debug_entries_cmdline(char *str)
@@ -936,7 +936,7 @@ static __init int dma_debug_entries_cmdl
 		return -EINVAL;
 	if (!get_option(&str, &nr_prealloc_entries))
 		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
-	return 0;
+	return 1;
 }
 
 __setup("dma_debug=", dma_debug_cmdline);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
