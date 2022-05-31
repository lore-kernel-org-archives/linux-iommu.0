Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F02DC433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C2E66405DD;
	Tue, 31 May 2022 18:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLhH6uZ6P2EC; Tue, 31 May 2022 18:20:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A439240104;
	Tue, 31 May 2022 18:20:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A356C0039;
	Tue, 31 May 2022 18:20:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F2B5C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BE4561290
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OIV5-Q7ho1kl for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:20:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 593326128D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:20:53 +0000 (UTC)
X-ASG-Debug-ID: 1654021252-1cf43917f334b0a0001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id ozEi06WftSCDC9Dn; Tue, 31 May 2022 14:20:52 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=UMD3peLOU8xJDRQl6tZsqYH8OxWwTPFkkNKZO4VgqaY=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=rydeBuE75zkiJLNnZRfb
 /WOveUINnngDKbuBAnssoipJio6AJ8XrL7lA7d2NMt/+12EgQmGf8wBBwWfKyMEadPRL7VtaKsi4T
 JRDTXjFqiek64nTQq0wNQegdcxjMhWIPs7A+BZAqIBPh7j1EN9i6chqiPkEMvl7Zyb2O2XsC+w=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11829220; Tue, 31 May 2022 14:20:52 -0400
Message-ID: <d7499103-95c4-a002-cb6c-c8c5e3375a8d@cybernetics.com>
Date: Tue, 31 May 2022 14:20:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 06/10] dmapool: ignore init_on_free when DMAPOOL_DEBUG enabled
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 06/10] dmapool: ignore init_on_free when DMAPOOL_DEBUG
 enabled
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
In-Reply-To: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654021252
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1451
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
DMAPOOL_DEBUG will memset the memory anyway, so speed things up by
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
index 7a9161d4f7a6..49019ef6dd83 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -415,8 +415,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	}
 
 	offset = vaddr - page->vaddr;
-	if (want_init_on_free())
-		memset(vaddr, 0, pool->size);
 #ifdef	DMAPOOL_DEBUG
 	if ((dma - page->dma) != offset) {
 		spin_unlock_irqrestore(&pool->lock, flags);
@@ -461,6 +459,9 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
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
