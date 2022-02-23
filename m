Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C132C4332F
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 04:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAB12813A0;
	Wed, 23 Feb 2022 04:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TML6HwNwTtTq; Wed, 23 Feb 2022 04:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C0436813B2;
	Wed, 23 Feb 2022 04:30:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93AC5C001A;
	Wed, 23 Feb 2022 04:30:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5551CC0011;
 Wed, 23 Feb 2022 04:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FB3A60BE8;
 Wed, 23 Feb 2022 04:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="OvJS9MBw";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="QQvfRN3w"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QeHUA2WebMMH; Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B838160ACB;
 Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id E68F7580151;
 Tue, 22 Feb 2022 23:30:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 22 Feb 2022 23:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to
 :reply-to:sender:subject:subject:to:to; s=fm2; bh=EW0q3DKsqq85t3
 6Mhl5XwyP6zYfcE0gyy04nLECgLok=; b=OvJS9MBw0ak9QSpdlP0SjZT4EbTlVg
 G957KqEariXB87msO6UEXK8rXWBNRiPEu8WQJtJhslcx5XbwmNwSj3g3yHIcD3Aa
 SXiPHwpFb9ZgkYzgwvFBvEml0kMAqhy4E9+2zq6+vi+84oAzkthnmjNYuJQvkkn3
 NvFUSmz6hDV3JJJ/ZumtEv+VUUgQpHWpllbYbuOSSKSGMHKg/USS+2Gk+fz7X8bI
 U/ERaWqu7MWOyHGgT7DwKGWmA4vtyGUeJiWMOrwCTh4+jisPnnkxbBVin85fUNea
 udm6VtqSbdnaaffHtdOQ/X2JowEj6fIe6V17/71xEMwF6xKyGL7fUOdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=EW0q3DKsqq85t36Mhl5XwyP6zYfcE0gyy04nLECgLok=; b=QQvfRN3w
 vMMnMOJfAC8ZY+rjIyJbgTJjBhTpPhCYy90nbh3dYxs8/uZ6tuSzkBIGf4/x0vP5
 h6P/BKfhvldynl22wSwYvr/jJhB0Oj1gfbn2dv85xVGT0THw00i/Yb+ZW08YEtZD
 SylhU/7swIv5Xpg1J9U+wYuAMU4ISXpTUJJLGf9nEfvU68RBOCylLg7vWlESVm6O
 /pv6gyEJguWkNqbwAqQaTD2H17LYwzISaEX8/JsZFDYvcjRF9y2MyAjK3Ohvfwmp
 ROwTD+y/D+k1wO3Ca5vLJJskVHGgGB4uJuPwU1yVayCIqmrf6wG2Z/N+vrtWHYkC
 kMaHkBXEgB4Qmg==
X-ME-Sender: <xms:ebgVYrJ4ulT1rRejF-PBu9amo-MxXNhUbsVqtw7ain1W8mUD58c-NA>
 <xme:ebgVYvJr44MKSnAMIpfiFXrgh2SAnUbxdILzJb1_a8PBvyfIOlDuTvbaFqhkAf9J7
 0QUS0ul53vLMFTvfQ>
X-ME-Received: <xmr:ebgVYju6SNG5wG97wpYPtCi_ac0X3RGv8KZHIVFAuAZJON7ognS8SMc9XbZ2L2hWHeMKdajw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:ebgVYka5j5CFpx65WA7YkbyC4MicIWPpBuOfY6VBkCLl3oxKxg5CZg>
 <xmx:ebgVYiaLcmpM7HJmJ_-H90HXOnxzCK4ajyZGKggtrmU_EpQHSNW_bw>
 <xmx:ebgVYoD_t_cAY9j91YpfqwQPi4RLTQ3GIsRpGMeyU5h7eBCnrG1gRw>
 <xmx:ebgVYnLK_DN2ZYxxBsbKhrUuS3SRjebwvZKdMzoMrfnalSiIoXwspw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:49 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v6 5/5] drivers: virtio_mem: use pageblock size as the minimum
 virtio_mem size.
Date: Tue, 22 Feb 2022 23:30:37 -0500
Message-Id: <20220223043037.715205-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223043037.715205-1-zi.yan@sent.com>
References: <20220223043037.715205-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mike Rapoport <rppt@kernel.org>,
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

alloc_contig_range() now only needs to be aligned to pageblock_order,
drop virtio_mem size requirement that it needs to be the max of
pageblock_order and MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e7d6b679596d..e07486f01999 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,10 +2476,10 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
 
 	/*
-	 * TODO: once alloc_contig_range() works reliably with pageblock
-	 * granularity on ZONE_NORMAL, use pageblock_nr_pages instead.
+	 * alloc_contig_range() works reliably with pageblock
+	 * granularity on ZONE_NORMAL, use pageblock_nr_pages.
 	 */
-	sb_size = PAGE_SIZE * MAX_ORDER_NR_PAGES;
+	sb_size = PAGE_SIZE * pageblock_nr_pages;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
