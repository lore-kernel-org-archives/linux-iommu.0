Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9412C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 18:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CA7783E6E;
	Tue,  7 Jun 2022 18:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rBUETf_Pg5g9; Tue,  7 Jun 2022 18:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4711E828A9;
	Tue,  7 Jun 2022 18:43:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21852C0032;
	Tue,  7 Jun 2022 18:43:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 317C5C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 128BE418CA
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YKAsFQNSXdH4 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 18:42:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23F104161D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:42:58 +0000 (UTC)
X-ASG-Debug-ID: 1654627376-1cf43917f33965e0001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id 9IJWbVWe0kxl8Q4W; Tue, 07 Jun 2022 14:42:56 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=eQM8tN6t62Fopbgjt8uTQgBSZ1EO2wkhvfxABlFtH9o=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=IixmWpGiaqvQUprEzkz0
 RLY8E/16bD+CZb7eDVxwsJJx0WhcGJberWRDEq6vXklSwUFj/Uz/gezadInQpSSObCp8dKbeGiBa7
 w3Y7jLuYeY+HtSBYaVfbLDLoltgTK+A7YCT6QfatyfhhlsxJVy8j/AsCZzK72KxdoC1mOT995M=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11859435; Tue, 07 Jun 2022 14:42:56 -0400
Message-ID: <c918d44b-1822-b076-0833-7645a2079809@cybernetics.com>
Date: Tue, 7 Jun 2022 14:42:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 05/11] dmapool: improve accuracy of debug statistics
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 05/11] dmapool: improve accuracy of debug statistics
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
In-Reply-To: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654627376
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 1818
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

The added blks_per_alloc value will also be used in the next patch.

 mm/dmapool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 122781fe2c03..d3e5a6151fb4 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -47,6 +47,7 @@ struct dma_pool {		/* the pool */
 	unsigned int size;
 	unsigned int allocation;
 	unsigned int boundary;
+	unsigned int blks_per_alloc;
 	char name[32];
 	struct list_head pools;
 };
@@ -85,8 +86,7 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 		/* per-pool info, no real statistics yet */
 		size += sysfs_emit_at(buf, size, "%-16s %4zu %4zu %4u %2u\n",
 				      pool->name, blocks,
-				      (size_t) pages *
-				      (pool->allocation / pool->size),
+				      (size_t) pages * pool->blks_per_alloc,
 				      pool->size, pages);
 	}
 	mutex_unlock(&pools_lock);
@@ -159,6 +159,9 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
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
