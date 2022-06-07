Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675BBC43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 18:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C36E418EB;
	Tue,  7 Jun 2022 18:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F9GjuKPNrUdi; Tue,  7 Jun 2022 18:42:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1863418CA;
	Tue,  7 Jun 2022 18:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CF1BC0032;
	Tue,  7 Jun 2022 18:42:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5794AC002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4595260E31
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kYRj3U0MYaSw for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 18:42:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72ABC60F07
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:42:10 +0000 (UTC)
X-ASG-Debug-ID: 1654627329-1cf43917f33965c0001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id 79iRHZabdgVhHOFB; Tue, 07 Jun 2022 14:42:09 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=QbGgNEs9DYDdDETge9nU6qZiAN8p+i0+8LJZVlYu570=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=jsWpK2MOULqWUEtEYypu
 BZF113V20OKS/bUvhZVyqHKTY3exH3pnTa1QbMsrI0H9CbQGv9hAAG8PzWuG8R9hLqsUNEYUi26EP
 8sXIBWYag6D+3OMUTNSodUaPd+OaQi/fx5JrYEKxj7ulxkltkon72+19JDoSSGToGumE1b7Fto=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11859424; Tue, 07 Jun 2022 14:42:09 -0400
Message-ID: <6eaea467-cc50-acbd-6232-892011fc803c@cybernetics.com>
Date: Tue, 7 Jun 2022 14:42:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 04/11] dmapool: fix boundary comparison
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 04/11] dmapool: fix boundary comparison
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
In-Reply-To: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654627329
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1388
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

Fix the boundary comparison when constructing the list of free blocks
for the case that 'size' is a power of two.  Since 'boundary' is also a
power of two, that would make 'boundary' a multiple of 'size', in which
case a single block would never cross the boundary.  This bug would
cause some of the allocated memory to be wasted (but not leaked).

Example:

size       = 512
boundary   = 2048
allocation = 4096

Address range
   0 -  511
 512 - 1023
1024 - 1535
1536 - 2047 *
2048 - 2559
2560 - 3071
3072 - 3583
3584 - 4095 *

Prior to this fix, the address ranges marked with "*" would not have
been used even though they didn't cross the given boundary.

Fixes: e34f44b3517f ("pool: Improve memory usage for devices which can't cross boundaries")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f85d6bde2205..122781fe2c03 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -201,7 +201,7 @@ static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 
 	do {
 		unsigned int next = offset + pool->size;
-		if (unlikely((next + pool->size) >= next_boundary)) {
+		if (unlikely((next + pool->size) > next_boundary)) {
 			next = next_boundary;
 			next_boundary += pool->boundary;
 		}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
