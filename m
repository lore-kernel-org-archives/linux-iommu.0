Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A2EC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 18:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92A7B60E58;
	Tue,  7 Jun 2022 18:44:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tbNyYAOn1CIV; Tue,  7 Jun 2022 18:44:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B991660D66;
	Tue,  7 Jun 2022 18:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9098BC0032;
	Tue,  7 Jun 2022 18:44:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C327C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE02740570
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1GzkCW4H4-zH for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 18:44:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55DB24055A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:44:20 +0000 (UTC)
X-ASG-Debug-ID: 1654627459-1cf43917f3396680001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id ytKMQdwzzCTN1huP; Tue, 07 Jun 2022 14:44:19 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=ko90FEQrFc3kr/EXmZEbhsh++NujIvq49Z2hdvGupnI=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=WUGhF+zc7hcw6JoFhMVn
 sGaBwqMKrtT0LAsXqUcUj76iU06x+W8kn/yVArt8p4dHAKYUv4FvRp/bnqdKNITJ8eZ4h4+G4cdWa
 MiUopTVPkmkKCknVE11Zis2M2WKnboszBLWCavFSHLU31NMgSYjzMIvvxF7fzNbz4pg+2PoWvM=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11859456; Tue, 07 Jun 2022 14:44:19 -0400
Message-ID: <06f83492-1eaf-16c4-31b0-1f148995ee59@cybernetics.com>
Date: Tue, 7 Jun 2022 14:44:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 07/11] dmapool: ignore init_on_free when DMAPOOL_DEBUG
 enabled
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 07/11] dmapool: ignore init_on_free when
 DMAPOOL_DEBUG enabled
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
In-Reply-To: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654627459
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1450
Cc: Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, kernel-team@fb.com,
 Robin Murphy <robin.murphy@arm.com>
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

There are two cases:

1) In the normal case that the memory is being freed correctly, then
DMAPOOL_DEBUG will memset the memory anyway, so speed thing up by
avoiding a double-memset of the same memory.

2) In the abnormal case that DMAPOOL_DEBUG detects that a driver passes
incorrect parameters to dma_pool_free() (e.g. double-free, invalid
free, mismatched vaddr/dma, etc.), then that is a kernel bug, and we
don't want to clear the passed-in possibly-invalid memory pointer
because we can't be sure that the memory is really free.  So don't clear
it just because init_on_free=1.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index facdb3571976..44038089a41a 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -406,8 +406,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	}
 
 	offset = vaddr - page->vaddr;
-	if (want_init_on_free())
-		memset(vaddr, 0, pool->size);
 #ifdef	DMAPOOL_DEBUG
 	if ((dma - page->dma) != offset) {
 		spin_unlock_irqrestore(&pool->lock, flags);
@@ -452,6 +450,9 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 			goto freelist_corrupt;
 	}
 	memset(vaddr, POOL_POISON_FREED, pool->size);
+#else
+	if (want_init_on_free())
+		memset(vaddr, 0, pool->size);
 #endif
 
 	page->in_use--;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
