Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9D7C433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 07:28:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C16722BEA
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 07:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="em5/N1lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C16722BEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1F0DB20529;
	Thu, 27 Aug 2020 07:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zK+XCA9LNPt; Thu, 27 Aug 2020 07:28:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 54F1B204F2;
	Thu, 27 Aug 2020 07:28:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39315C07FF;
	Thu, 27 Aug 2020 07:28:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 144EAC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 07:28:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0EEC188191
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 07:28:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZmL58Mpibhfo for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 07:28:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8CE8A8818E
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=F7j6/JkLjJQn2l7mos39jAxfA+TH0RGAJAACDkfjOI0=; b=em5/N1lQR3Hvg5fJopFgo5Pftv
 T6KF/0W/WkNX8gHXSnyFF8yjEEFjmbBdgAvYw6ZDF8ADrQMioEfbxQVgIHMJBoMcW46d6N2ezojfg
 S15iqWrX/uWEwFXISLDUyOD+H2UOuDiAxvpSF+SJiS6LIWiht8LCDLS+4p9G3s80N74gMgsgo1p6b
 A+toTck6Xnr84Xn/5Wc1Z+8AAqvjCLqK1nPfSZ7VeIgZBCLC8qlKyI9dgUMV49aexCSxEwlSOIZBu
 ka9BWmnxHhhvvfgWUYM8ff6D+Q4Zyzcf7n/v+PsYJflhvsIPbQx+BaNRH+Ge1sUepTGxAG9tOReeO
 yjYVGM/g==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBCKX-0007aU-TL; Thu, 27 Aug 2020 07:28:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: nsaenzjulienne@suse.de
Subject: [PATCH] dma-pool: turn the end variable in cma_in_zone into a u64
Date: Thu, 27 Aug 2020 09:28:15 +0200
Message-Id: <20200827072815.69936-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, kernel test robot <lkp@intel.com>,
 dan.carpenter@oracle.com
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

phys_addr_t can be 32-bit, in which case smatch will complain:

kernel/dma/pool.c:79 cma_in_zone() warn: always true condition '(end <= ((((32) == 64)) ?~0:((1 << (32)) - 1))) => (0-u32max <= u32max)'

Just turn the variable into a u64 to make the range check valid.

Fixes: d7e673ec2c8e ("dma-pool: Only allocate from CMA when in same memory zone")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 1281c0f0442bc5..b59325bad8edda 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -60,7 +60,7 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
 static bool cma_in_zone(gfp_t gfp)
 {
 	unsigned long size;
-	phys_addr_t end;
+	u64 end;
 	struct cma *cma;
 
 	cma = dev_get_cma_area(NULL);
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
