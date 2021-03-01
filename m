Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9C9C433E0
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C3064E3F
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C3064E3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F00242D19;
	Mon,  1 Mar 2021 07:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 44Sz_skzD9Pn; Mon,  1 Mar 2021 07:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82336414EF;
	Mon,  1 Mar 2021 07:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BEE2C000B;
	Mon,  1 Mar 2021 07:46:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19F6FC0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C9A84F293
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aoK0Oe5BDJpT for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:46:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 472B44F290
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=JFey0nQH0q27BLg8sKUeuXSyZDiQiQFLOD6BixvKeyU=; b=NOzDrThXk5sQLHtG3a7GXeBGS9
 H2XGITYrLulEacH0a8AvtD4GcR3a2s77sP1xJjnehH3ArsbGm+hD5Yg+R4px9hPi+g+Hqawj5XasA
 USCZkvxqssnycydmnC4rU9Kn3Dp7ojnB+xcinZ1+dr2f3ywKfxV6zOcD7Kwh/7lBlruP/9QUg21lZ
 FZB2z4KkS3r112xjPrzwRHn0SffHvc9LiSxaQmlgIEzvoxWUQ9A+bGnTQDUWoUtbAOlVvg3mcywgr
 5zo9Ej6FKEwbLIhTjZHYLebzvkQLYCHjA/PtqDXKiu7RlyNYJviJ7iXcpJ36kfbd/1Ijq+NNQpDOs
 QO9Tuoyw==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGdFm-00FRDp-Lh; Mon, 01 Mar 2021 07:46:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 09/14] swiotlb: lift the double initialization protection from
 xen-swiotlb
Date: Mon,  1 Mar 2021 08:44:31 +0100
Message-Id: <20210301074436.919889-10-hch@lst.de>
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

Lift the double initialization protection from xen-swiotlb to the core
code to avoid exposing too many swiotlb internals.  Also upgrade the
check to a warning as it should not happen.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c | 7 -------
 kernel/dma/swiotlb.c      | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 1a31ddf7139799..060eeb056486f5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -172,12 +172,6 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	bytes = nslabs << IO_TLB_SHIFT;
 	order = get_order(bytes);
 
-	/*
-	 * IO TLB memory already allocated. Just use it.
-	 */
-	if (io_tlb_start != 0)
-		goto end;
-
 	/*
 	 * Get IO TLB memory from any location.
 	 */
@@ -232,7 +226,6 @@ int __ref xen_swiotlb_init(int verbose, bool early)
 	} else
 		rc = swiotlb_late_init_with_tbl(start, nslabs);
 
-end:
 	if (!rc)
 		swiotlb_set_max_segment(PAGE_SIZE);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 388d9be35b5795..ebe7c123e27e52 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -229,6 +229,10 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 	unsigned long i, bytes;
 	size_t alloc_size;
 
+	/* protect against double initialization */
+	if (WARN_ON_ONCE(io_tlb_start))
+		return -ENOMEM;
+
 	bytes = nslabs << IO_TLB_SHIFT;
 
 	io_tlb_nslabs = nslabs;
@@ -367,6 +371,10 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
 	unsigned long i, bytes;
 
+	/* protect against double initialization */
+	if (WARN_ON_ONCE(io_tlb_start))
+		return -ENOMEM;
+
 	bytes = nslabs << IO_TLB_SHIFT;
 
 	io_tlb_nslabs = nslabs;
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
