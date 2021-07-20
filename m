Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A63FC636C8
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 13:38:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6FE61106
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 13:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6FE61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BDE5540392;
	Tue, 20 Jul 2021 13:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpU2s3h__ZwC; Tue, 20 Jul 2021 13:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CAF6402AB;
	Tue, 20 Jul 2021 13:38:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68C05C0010;
	Tue, 20 Jul 2021 13:38:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A74EEC0022
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 13:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8520960857
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 13:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K-CoiyCJ4001 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 13:38:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03D326059E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 13:38:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D28C61165;
 Tue, 20 Jul 2021 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626788322;
 bh=x8mc24R43OT2/dRfM/oJ6/ewTeaK9cijJPyAspd5MqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h4ugYLKFCRyeSPbI0TezWpziozHNOckH2oPTtPvRAGah0Uy5pdKRe/0LdoudHbGTo
 EyJKOdgHoRTFUBVhAm+qKdKC9gaHTuTeXcqIFEjGQnzql+Rcbqvjc1HFUYflV7iZhS
 e7Ne01/dAfCMwlJzHpisH42Q33pT4VFebfL5niHpr9y9xv6JbhRF9MyDupwSG0nooc
 V9rhZaXMqaUDhCDHPDNly8oeRutyFdqD+W+wHRWDzx2u90BHnCR5m5x9gzomefWyHH
 1F4dOUy/7QIUSKAleeQTC6ccxjPkYHuBhbExAySCjIkHUjOQMbQzVU0bzTEwbSDV3O
 8T8O8JmWDpvNQ==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 4/4] swiotlb: Free tbl memory in swiotlb_exit()
Date: Tue, 20 Jul 2021 14:38:26 +0100
Message-Id: <20210720133826.9075-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
References: <20210720133826.9075-1-will@kernel.org>
MIME-Version: 1.0
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

Although swiotlb_exit() frees the 'slots' metadata array referenced by
'io_tlb_default_mem', it leaves the underlying buffer pages allocated
despite no longer being usable.

Extend swiotlb_exit() to free the buffer pages as well as the slots
array.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/dma/swiotlb.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b3c793ed9e64..87c40517e822 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -328,18 +328,27 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 void __init swiotlb_exit(void)
 {
-	size_t size;
 	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	unsigned long tbl_vaddr;
+	size_t tbl_size, slots_size;
 
 	if (!mem->nslabs)
 		return;
 
 	pr_info("tearing down default memory pool\n");
-	size = array_size(sizeof(*mem->slots), mem->nslabs);
-	if (mem->late_alloc)
-		free_pages((unsigned long)mem->slots, get_order(size));
-	else
-		memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
+	tbl_vaddr = (unsigned long)phys_to_virt(mem->start);
+	tbl_size = PAGE_ALIGN(mem->end - mem->start);
+	slots_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), mem->nslabs));
+
+	set_memory_encrypted(tbl_vaddr, tbl_size >> PAGE_SHIFT);
+	if (mem->late_alloc) {
+		free_pages(tbl_vaddr, get_order(tbl_size));
+		free_pages((unsigned long)mem->slots, get_order(slots_size));
+	} else {
+		memblock_free_late(mem->start, tbl_size);
+		memblock_free_late(__pa(mem->slots), slots_size);
+	}
+
 	memset(mem, 0, sizeof(*mem));
 }
 
-- 
2.32.0.402.g57bb445576-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
