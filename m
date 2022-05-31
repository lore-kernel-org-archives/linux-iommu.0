Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D52FC433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3596C41746;
	Tue, 31 May 2022 18:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CIaMLjQR7uyT; Tue, 31 May 2022 18:17:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFA6B41744;
	Tue, 31 May 2022 18:17:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9307CC0039;
	Tue, 31 May 2022 18:17:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF7DC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 795DE40D99
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UIx58BQEg7cW for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:17:45 +0000 (UTC)
X-Greylist: delayed 00:06:25 by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF0BD40D82
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:17:45 +0000 (UTC)
X-ASG-Debug-ID: 1654021064-1cf43917f334b060001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id FnUZ9qI4R7alRl3A; Tue, 31 May 2022 14:17:44 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=rVEbYmgCF5qNaIoY0xv9QyqFa+k5xItzdRlzexwASwY=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=PXGrGGD2CLPjjbPjqwhg
 zGiqsmvhXj07rY/Ga/zD8aEmocIXs+Ic868AT/FzjqouS9izAh8h4wg0ckuZd+Ja1jlF7EjM0eYd3
 mlXd+sZ5m0ONdtjtAziIP1j0Set+ooCEjaMO/cnHIX+CZIE7D8h6dIEr0gMQUBlyfSMfftPsDw=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11829214; Tue, 31 May 2022 14:17:44 -0400
Message-ID: <a922c30f-d6d7-dde2-554f-254441290331@cybernetics.com>
Date: Tue, 31 May 2022 14:17:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 04/10] dmapool: improve accuracy of debug statistics
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 04/10] dmapool: improve accuracy of debug statistics
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
In-Reply-To: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654021064
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1718
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

The "total number of blocks in pool" debug statistic currently does not
take the boundary value into account, so it diverges from the "total
number of blocks in use" statistic when a boundary is in effect.  Add a
calculation for the number of blocks per allocation that takes the
boundary into account, and use it to replace the inaccurate calculation.

This depends on the patch "dmapool: fix boundary comparison" for the
calculated blks_per_alloc value to be correct.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 782143144a32..9e30f4425dea 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -47,6 +47,7 @@ struct dma_pool {		/* the pool */
 	struct device *dev;
 	unsigned int allocation;
 	unsigned int boundary;
+	unsigned int blks_per_alloc;
 	char name[32];
 	struct list_head pools;
 };
@@ -92,8 +93,7 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 		/* per-pool info, no real statistics yet */
 		temp = scnprintf(next, size, "%-16s %4zu %4zu %4u %2u\n",
 				 pool->name, blocks,
-				 (size_t) pages *
-				 (pool->allocation / pool->size),
+				 (size_t) pages * pool->blks_per_alloc,
 				 pool->size, pages);
 		size -= temp;
 		next += temp;
@@ -168,6 +168,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	retval->size = size;
 	retval->boundary = boundary;
 	retval->allocation = allocation;
+	retval->blks_per_alloc =
+		(allocation / boundary) * (boundary / size) +
+		(allocation % boundary) / size;
 
 	INIT_LIST_HEAD(&retval->pools);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
