Return-Path: <SRS0=PBOI=OA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E7C433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 00:16:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA946115A
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 00:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECA946115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AFE66401B3;
	Fri, 10 Sep 2021 00:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0HefFsRd597W; Fri, 10 Sep 2021 00:16:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 731394011B;
	Fri, 10 Sep 2021 00:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CFE0C0011;
	Fri, 10 Sep 2021 00:16:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95B4AC000D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 00:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E3E9401B3
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 00:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rzYjbthkm0kS for <iommu@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 00:16:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C41DF4011B
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 00:16:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5161B61101;
 Fri, 10 Sep 2021 00:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631232962;
 bh=ZNXd/V5oNf4rXgz79oD/2VxGRTsmiQ+9lAGE/6Vbktg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ABItK5sjbfclnGUXSQ3voHJY+VPNA5Aslc6cwcPZLDeWS9jwD4CeTtwcrWaLb+oEM
 JTz2sBQFfMzNHRV4ux2yp5wmZnfFqPVhgASt5ygoSbu8gLmn3eNrDXLLrPQR25itB3
 Ar7cvRiZaxe2aMJ/SSXJwKrDwkcVtYHGcKhjiE1g3iCnkzLdyQssNMzN3wSpVKWH1A
 2CL9G1p8eGxoUsOXMZyOGr9vtxSze7I+RLouq81b12wa6/6Lstvo7HnGXwITIL6AYo
 cAMm9/eqhtX9Gp8FRHGEwsVqNCgVnYxxikvJU51o59UIpAWyUk3bZmKgeacwf6n8Vs
 aSBAD54oTFB4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 02/99] swiotlb: add overflow checks to
 swiotlb_bounce
Date: Thu,  9 Sep 2021 20:14:21 -0400
Message-Id: <20210910001558.173296-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001558.173296-1-sashal@kernel.org>
References: <20210910001558.173296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 iommu@lists.linux-foundation.org, Chanho Park <chanho61.park@samsung.com>,
 Christoph Hellwig <hch@lst.de>
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

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

[ Upstream commit 868c9ddc182bc6728bb380cbfb3170734f72c599 ]

This is a follow-up on 5f89468e2f06 ("swiotlb: manipulate orig_addr
when tlb_addr has offset") which fixed unaligned dma mappings,
making sure the following overflows are caught:

- offset of the start of the slot within the device bigger than
requested address' offset, in other words if the base address
given in swiotlb_tbl_map_single to create the mapping (orig_addr)
was after the requested address for the sync (tlb_offset) in the
same block:

 |------------------------------------------| block
              <----------------------------> mapped part of the block
              ^
              orig_addr
       ^
       invalid tlb_addr for sync

- if the resulting offset was bigger than the allocation size
this one could happen if the mapping was not until the end. e.g.

 |------------------------------------------| block
      <---------------------> mapped part of the block
      ^                               ^
      orig_addr                       invalid tlb_addr

Both should never happen so print a warning and bail out without trying
to adjust the sizes/offsets: the first one could try to sync from
orig_addr to whatever is left of the requested size, but the later
really has nothing to sync there...

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Bumyong Lee <bumyong.lee@samsung.com
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e50df8d8f87e..23f8d0b168c5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -354,13 +354,27 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
 	unsigned char *vaddr = phys_to_virt(tlb_addr);
-	unsigned int tlb_offset;
+	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
-	tlb_offset = (tlb_addr & (IO_TLB_SIZE - 1)) -
-		     swiotlb_align_offset(dev, orig_addr);
+	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
+	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
+	if (tlb_offset < orig_addr_offset) {
+		dev_WARN_ONCE(dev, 1,
+			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
+			orig_addr_offset, tlb_offset);
+		return;
+	}
+
+	tlb_offset -= orig_addr_offset;
+	if (tlb_offset > alloc_size) {
+		dev_WARN_ONCE(dev, 1,
+			"Buffer overflow detected. Allocation size: %zu. Mapping size: %zu+%u.\n",
+			alloc_size, size, tlb_offset);
+		return;
+	}
 
 	orig_addr += tlb_offset;
 	alloc_size -= tlb_offset;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
