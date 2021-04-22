Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C7C433ED
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 07:19:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF696145C
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 07:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF696145C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB8BC40E59;
	Thu, 22 Apr 2021 07:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TjmjOhOXE99c; Thu, 22 Apr 2021 07:19:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94C3F40E6E;
	Thu, 22 Apr 2021 07:19:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49F78C0025;
	Thu, 22 Apr 2021 07:19:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78D39C000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 07:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54B1560686
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 07:19:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDYHdSQqIToE for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 07:19:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAEBD60669
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=mQKOkV7O/cQZUeeS2ywVjzBgZ2gsXE3uYRnoQOufOWY=; b=uebudFWLuE7bflMDQQdSHpip3B
 XJBkAvt2kX2G6MchzpNWjh2R5I5XUFdiU9YEccqUF4kwnqBT3m4sBkXQnHY9jHNuENyd0DCmXMTZN
 dBJOdK44cce23/YdS7uP/U8DAILaoZKRL9UpKZjV12NYQkp/tF5xNjHAfhtREAB42GK2cPt59erj+
 tSye60ezBe7oalDxD5wTkF/SJvwbJs5HXXv+xq4rYo4ueA78wnZB3d83Oztierm4iFQ19mw/9DrkA
 DjDnoSkiQsnQNtwCys4BZhCzdt0vHegfZjJoWaoeydlI294lUbZ2HKrrreZNLkVdBQGWu0/XnueMs
 ek06CYVA==;
Received: from [2001:4bb8:19b:f845:15fc:cef6:715a:fb03] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTca-00DRkx-Hb; Thu, 22 Apr 2021 07:19:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 3/7] swiotlb: use swiotlb_adjust_size in setup_io_tlb_npages
Date: Thu, 22 Apr 2021 09:19:17 +0200
Message-Id: <20210422071921.1428607-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210422071921.1428607-1-hch@lst.de>
References: <20210422071921.1428607-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linuxppc-dev@lists.ozlabs.org
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

Use the proper helper to do the proper alignment of the buffer size
to the requirements of the swiotlb allocator instead of open coding
the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 27461fd63e0330..93737d0932fbf2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -76,11 +76,9 @@ static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static int __init
 setup_io_tlb_npages(char *str)
 {
-	if (isdigit(*str)) {
-		/* avoid tail segment of size < IO_TLB_SEGSIZE */
-		default_nslabs =
-			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
-	}
+	if (isdigit(*str))
+		swiotlb_adjust_size(
+			simple_strtoul(str, &str, 0) << IO_TLB_SHIFT);
 	if (*str == ',')
 		++str;
 	if (!strcmp(str, "force"))
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
