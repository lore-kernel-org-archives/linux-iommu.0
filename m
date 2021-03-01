Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C67C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3649964E38
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3649964E38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61A8942D19;
	Mon,  1 Mar 2021 07:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gcSwGTFERden; Mon,  1 Mar 2021 07:46:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EAA943035;
	Mon,  1 Mar 2021 07:46:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C912C000B;
	Mon,  1 Mar 2021 07:46:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D056FC0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D76882FEA
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a7m2q5yanzM9 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:46:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 699F38432C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=n4a5R9+ylbvoibBv9Gp4RRSzd949UJhfH+kdgUzXMIA=; b=ZdtJkSTQoBpw/cdu0C97cG13/n
 hnkW6A3RrPzYaXlCcieHyhVXiP8MF2ep7TS+aJyf3GZe66+xpZWgToyCzgiH5ydTo5cY6SWeh6gSp
 eWAP2epI/P5SHOeCxT2yVEQus8aSEgI/HaWdf01Lw1tEj/ySKW/4yU6vt8dK7QexOzT/AK9BnwVJQ
 vkWA9I7c0R9uCfQWQvxfOa4meVFZhWV8w/VdbMi/iGnvdTMEwEiaN3spsgAGnkyV0mYLo6Wst8PQ4
 lqZEwHRsz0EIbqJE4HY4ZT1Oxo8rFdW+q5SvmOCXv0E3WMX1TpKxeP8ykm/dSx13AmIi0JJJusybs
 1oZ+I7pA==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGdFa-00FRD5-OZ; Mon, 01 Mar 2021 07:45:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 07/14] xen-swiotlb: remove xen_set_nslabs
Date: Mon,  1 Mar 2021 08:44:29 +0100
Message-Id: <20210301074436.919889-8-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301074436.919889-1-hch@lst.de>
References: <20210301074436.919889-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Claire Chang <tientzu@chromium.org>,
 linuxppc-dev@lists.ozlabs.org, Dongli Zhang <dongli.zhang@oracle.com>
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

The xen_set_nslabs function is a little weird, as it has just one
caller, that caller passes a global variable as the argument,
which is then overriden in the function and a derivative of it
returned.  Just add a cpp symbol for the default size using a readable
constant and open code the remaining three lines in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index e99f0614dcb979..5352655432e724 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -138,16 +138,6 @@ xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 	} while (i < nslabs);
 	return 0;
 }
-static unsigned long xen_set_nslabs(unsigned long nr_tbl)
-{
-	if (!nr_tbl) {
-		xen_io_tlb_nslabs = (64 * 1024 * 1024 >> IO_TLB_SHIFT);
-		xen_io_tlb_nslabs = ALIGN(xen_io_tlb_nslabs, IO_TLB_SEGSIZE);
-	} else
-		xen_io_tlb_nslabs = nr_tbl;
-
-	return xen_io_tlb_nslabs << IO_TLB_SHIFT;
-}
 
 enum xen_swiotlb_err {
 	XEN_SWIOTLB_UNKNOWN = 0,
@@ -170,6 +160,9 @@ static const char *xen_swiotlb_error(enum xen_swiotlb_err err)
 	}
 	return "";
 }
+
+#define DEFAULT_NSLABS		ALIGN(SZ_64M >> IO_TLB_SHIFT, IO_TLB_SEGSIZE)
+
 int __ref xen_swiotlb_init(int verbose, bool early)
 {
 	unsigned long bytes, order;
@@ -179,8 +172,10 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 
 	xen_io_tlb_nslabs = swiotlb_nr_tbl();
 retry:
-	bytes = xen_set_nslabs(xen_io_tlb_nslabs);
-	order = get_order(xen_io_tlb_nslabs << IO_TLB_SHIFT);
+	if (!xen_io_tlb_nslabs)
+		xen_io_tlb_nslabs = DEFAULT_NSLABS;
+	bytes = xen_io_tlb_nslabs << IO_TLB_SHIFT;
+	order = get_order(bytes);
 
 	/*
 	 * IO TLB memory already allocated. Just use it.
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
