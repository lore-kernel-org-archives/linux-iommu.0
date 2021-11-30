Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A7EC433F5
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 07:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 097C14015E;
	Tue, 30 Nov 2021 07:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V4rhZzvUBAS7; Tue, 30 Nov 2021 07:46:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9616F400D4;
	Tue, 30 Nov 2021 07:46:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE6FC001C;
	Tue, 30 Nov 2021 07:46:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35DFBC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 07:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C30040133
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 07:46:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KIlgctBdm9KF for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 07:46:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE3BA400D4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 07:46:00 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jkchen@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UyqxeXk_1638258356; 
Received: from localhost(mailfrom:jkchen@linux.alibaba.com
 fp:SMTPD_---0UyqxeXk_1638258356) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 30 Nov 2021 15:45:57 +0800
From: Jay Chen <jkchen@linux.alibaba.com>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC PATCH] provide per numa cma with an initial default size
Date: Tue, 30 Nov 2021 15:45:56 +0800
Message-Id: <20211130074556.11091-1-jkchen@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: zhangliguang@linux.alibaba.com
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

  In the actual production environment, when we open
cma and per numa cma, if we do not increase the per
numa size configuration in cmdline, we find that our
performance has dropped by 20%.
  Through analysis, we found that the default size of
per numa is 0, which causes the driver to allocate
memory from cma, which affects performance. Therefore,
we think we need to provide a default size.

Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
---
 kernel/dma/contiguous.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..3bef8bf371d9 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -99,7 +99,7 @@ early_param("cma", early_cma);
 #ifdef CONFIG_DMA_PERNUMA_CMA
 
 static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
-static phys_addr_t pernuma_size_bytes __initdata;
+static phys_addr_t pernuma_size_bytes __initdata = size_bytes;
 
 static int __init early_cma_pernuma(char *p)
 {
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
