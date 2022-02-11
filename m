Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD10AC433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 16:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9983409E7;
	Fri, 11 Feb 2022 16:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bNJLW5TF5qf3; Fri, 11 Feb 2022 16:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 967D940A0A;
	Fri, 11 Feb 2022 16:41:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 412A7C001A;
	Fri, 11 Feb 2022 16:41:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F039C001A;
 Fri, 11 Feb 2022 16:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E26583487;
 Fri, 11 Feb 2022 16:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="HhkSZgj0";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="b+HoxZQU"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D1mQAw5hCd9q; Fri, 11 Feb 2022 16:41:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D1FB82D0C;
 Fri, 11 Feb 2022 16:41:51 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id AB9DA58037C;
 Fri, 11 Feb 2022 11:41:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 11 Feb 2022 11:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to
 :reply-to:sender:subject:subject:to:to; s=fm2; bh=ns7zKpm4A9Xmsm
 ZwroT9dHnb6rgarNlTVL3pcGHHu0o=; b=HhkSZgj0d6uRtnT7s5z1WUa0qj27bC
 RPCjKEp+cbL/NNOORX1x08Je1Mb+zbU9hACFgx4vaehD0ZTg5j8N5A60hXkTStCy
 Rv3h+mkhOAeW+uSlBJXL2tBu25fgGR1H036XJbizSq7S+1Jo/kOmWIFe9ke16Omh
 vAU+Ys9UTqbD4kgtyX6RyUKSfEFijWPBxjbxZoDeOHAfCLwr8bNOqW7VSiUScaiP
 UXWhGfveqUGCmzHskSNDQhIqL71z/XsmBtobnRUISr9WbV1hvE7vqWkBckPtwQVR
 uoPFf1TYIIpWKFZQRzNfPhkJGXzXJ9VNr0/BjJVnIcPYaME1mwO8QF4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=ns7zKpm4A9XmsmZwroT9dHnb6rgarNlTVL3pcGHHu0o=; b=b+HoxZQU
 sEXEVT7xD5fjST3/BM4MLUWPtVa/KKDHkcI8gFADHiFTXKmt7DZXdHdx6ZwYbwoq
 BklXre/vDPSfD0+Qw8Lx0GErCtY2BCkp24uBzza6Gus/TtT4yAVtGCX1SzS/UC2T
 qcKZnMV7l1b0G64riBoSSPoS8aUFV0q+o5zYaC5ZMVpHrU/2P7YqZ4uSGCiaAimf
 4+HJJ/OMddls4LrrNOvGOG90TS3HS1/VoAKDA39nyPDD0EdqJBFZkALEJ3wmGxyC
 6J4gppe20SdY1bb8QZGNwb/Tmk996l331/q91v4f7LAecyWfYMBpua2+7rkiIDCu
 633kilwZzAHD/g==
X-ME-Sender: <xms:zpEGYt8YBMIg8CcaUo7OhFh16T-q410PSZmYmPZAgExWxInlYMMB7g>
 <xme:zpEGYhsNoeGu3IfROXDOMCJCEILTPI5V9eTNzWyjubD6QCdzZbWrTfQxakq2vGPdh
 AhBktCT1ZbLbaz1ug>
X-ME-Received: <xmr:zpEGYrAunTmnZ4Lihw66gtLKSavy8pghJlRaXMkVOx0KAfFo_KSGaByNO17aWuyx_Xc0rHs8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeklecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:zpEGYhdtAq80HV6uL94doGOQhiGCJT2kRZQklRM_ncx5859q-xVh0A>
 <xmx:zpEGYiPhgnG7MOILjVrDdUXC1xtgAwIf_oRHvBXUCCQVvnx9y3RXqg>
 <xmx:zpEGYjnqKVITtFlfbkrccG5Yo0EBjtUr5VJw2ePxbh93T4FsYNUNCQ>
 <xmx:zpEGYpn3rhItMIS_FdKpzmOeT8IkC1ap9lgL03qU1_2AM5KWNIB4IA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:49 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v5 5/6] drivers: virtio_mem: use pageblock size as the minimum
 virtio_mem size.
Date: Fri, 11 Feb 2022 11:41:34 -0500
Message-Id: <20220211164135.1803616-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211164135.1803616-1-zi.yan@sent.com>
References: <20220211164135.1803616-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
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
 drivers/virtio/virtio_mem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 38becd8d578c..2307e65d18c2 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2476,13 +2476,12 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
 
 	/*
-	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
-	 * pageblock_nr_pages pages. This:
+	 * We want subblocks to span at least pageblock_nr_pages pages.
+	 * This:
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
-			pageblock_nr_pages) * PAGE_SIZE;
+	sb_size = pageblock_nr_pages * PAGE_SIZE;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
