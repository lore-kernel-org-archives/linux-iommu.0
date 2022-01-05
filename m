Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400C3C43217
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 21:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3F52832B0;
	Wed,  5 Jan 2022 21:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hDiQJN-OA0O; Wed,  5 Jan 2022 21:48:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0FE5283268;
	Wed,  5 Jan 2022 21:48:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D33A8C0030;
	Wed,  5 Jan 2022 21:48:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF9CAC001E;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DBEA40235;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="zJFe7Ao9";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="I9TcvzqS"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U2IXP1jpajbM; Wed,  5 Jan 2022 21:48:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C1F66400D0;
 Wed,  5 Jan 2022 21:48:26 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id B286B580514;
 Wed,  5 Jan 2022 16:48:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 05 Jan 2022 16:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=F+6ytW8tADp2L
 NXytpAkKv+4a//pcBSmjTaldQvhu2o=; b=zJFe7Ao9MCOK+TZjq/K/TbeuXuhub
 uEMymMtNy7GDdtEO7HZkK2k7I0QJefpyNTc6QIDRv3VbTOQEz0mNoaKnX14u+Qdb
 o2OErLMPr8nbMPNViHntkADNEWvCU58ZNRNcUUUmv7lhKZFOrqn1ybsMWLAGNaxm
 lUcKl2Ja/YD7ICRFcBTTQK5B8G882NbVn06HGziGFLC39Gegp3cWIj7DDkwJ7odw
 C+Q7WHZw32/+23uQlB375cehRMhlM7Ev0KcGrO73+dc0fxhwnorPVP9V7xPUULlD
 Bm5XJPhUX0VfbeXD3jZhrIUp323BLLWatMr3g4u8XfgsAcn1XBlhLyzSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=F+6ytW8tADp2LNXytpAkKv+4a//pcBSmjTaldQvhu2o=; b=I9TcvzqS
 Rw1NjBo+afbuM8HtqRLcbw5Y9/BUmNxengQ94iNfi4ETD2oDiTzizNxDWj0LPQ2B
 OfoQMTZ8GfnHobghTSW7URMh5JN5eZgGZ1w1YXl8AjktYUMIuDvEgCbRBWcFvfmk
 0IByqySd67Ky97vYXjeCnQL5mgBwYo6aKzFN7QmZ5aHMGZ6AdspxurgVt+kzf4fz
 5lvpapJNbk7lbPeWTK66P7UyBJJmRF+mSGy4zhtshTg3cFHYh2Mf0BZtzjnCEePw
 eIGV2ZIxnul9Y/lJzUQVQC08PkN8ojSSITPC+8d7mVxj8WOETGsGkuW690Y2Ehkt
 n6DTyTq83VG7/w==
X-ME-Sender: <xms:KBLWYWudW-f_b8lxHrHC0ANfNhVh1kU6W5VuYTCGJeKwxUprJ2lhRw>
 <xme:KBLWYbdECgIoVGkrmS1Ler2I7x_DQeKfKtFS9G2bH723wbLALFLR2jxIMrGlNkkh1
 vYTfON0Z9EmgIU1Ew>
X-ME-Received: <xmr:KBLWYRwEMBrJrMNO3NLltA-ncavGBeJJsfnEQjJC0IqIbEYhrkNm2SwGtWlowtYCB52UGbH5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
 dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
 hnthdrtghomh
X-ME-Proxy: <xmx:KBLWYRNU1qDmXKct-2LwZuXjSGwzfevVTXIyvqvS_1nUwOXOqxqSdw>
 <xmx:KBLWYW-ikkLLSpKvGvdFTzzd6nt9QY3FeQkAZZEGGVnliys1-pAACQ>
 <xmx:KBLWYZV_mZeFmV6P6ybsv87N65vJ1FwD3zpTdVueHFAhW_SanZr7og>
 <xmx:KBLWYRUuQYynZ-mTXTyZCnQKtoV-i-cxoeAoO2SIlFPDgV2JOnSUmg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:24 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 2/8] mm: compaction: handle non-lru compound pages
 properly in isolate_migratepages_block().
Date: Wed,  5 Jan 2022 16:47:50 -0500
Message-Id: <20220105214756.91065-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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
Reply-To: Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Zi Yan <ziy@nvidia.com>

In isolate_migratepages_block(), a !PageLRU tail page can be encountered
when the page is larger than a pageblock. Use compound head page for the
checks inside and skip the entire compound page when isolation succeeds.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b4e94cda3019..ad9053fbbe06 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -979,19 +979,23 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * Skip any other type of page
 		 */
 		if (!PageLRU(page)) {
+			struct page *head = compound_head(page);
 			/*
 			 * __PageMovable can return false positive so we need
 			 * to verify it under page_lock.
 			 */
-			if (unlikely(__PageMovable(page)) &&
-					!PageIsolated(page)) {
+			if (unlikely(__PageMovable(head)) &&
+					!PageIsolated(head)) {
 				if (locked) {
 					unlock_page_lruvec_irqrestore(locked, flags);
 					locked = NULL;
 				}
 
-				if (!isolate_movable_page(page, isolate_mode))
+				if (!isolate_movable_page(head, isolate_mode)) {
+					low_pfn += (1 << compound_order(head)) - 1 - (page - head);
+					page = head;
 					goto isolate_success;
+				}
 			}
 
 			goto isolate_fail;
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
