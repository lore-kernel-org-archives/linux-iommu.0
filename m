Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFFDC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 23:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC03D401B1;
	Thu,  9 Dec 2021 23:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8cQEvJiRu2Py; Thu,  9 Dec 2021 23:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B25A34019F;
	Thu,  9 Dec 2021 23:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3EA0C007E;
	Thu,  9 Dec 2021 23:36:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4FDBC0012;
 Thu,  9 Dec 2021 23:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A49CD6F9EB;
 Thu,  9 Dec 2021 23:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="TuuRuLss";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="dTp5YN8n"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tmyBON8gDfP4; Thu,  9 Dec 2021 23:04:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03BC96F9DB;
 Thu,  9 Dec 2021 23:04:42 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 2ACDE5802C9;
 Thu,  9 Dec 2021 18:04:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 09 Dec 2021 18:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=UTQs1ux+hZ7wP
 wqBSLphwUkfQ6f0lSb5ot+4msaDpHs=; b=TuuRuLssMKg6UBRpj/SlIFAWKPmqa
 s+1erp14Y9Z35RZSebwiDROJcjArV2wRAmJBjjX3uEEbDHV6qChrQcfmMdIFce7i
 szjDQPkGHVOHJLgC3+AY3iqMVelNSYSPa/7FhfSQ3mcx4XFHNKTsbJRMO0YhxZtB
 2jq0UT2K5ZPUJdFqfiwoTcKtsEXjEdwJj6blyVPQ7/n2O2uzXZZJx3knBjJKDKGD
 ln9hIdsuSHCBcVBdHNF4VNWtHRG+0/A3ZZISc3e6on4Njg3oJLUjCfL5bBRPsTqX
 lIZmC4qR835uuOA05xjmm3bIjA5WiH5J8YUFs7c3zwAnWCjvRQa8SwjFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=UTQs1ux+hZ7wPwqBSLphwUkfQ6f0lSb5ot+4msaDpHs=; b=dTp5YN8n
 NtGl0Q1FCz+Ay7HWSTl7DdQPolH5VXkIDGCHCA57hz0dFeNaCrC4cnAJJicMQmBA
 JlxuJYU7S4lGdLLK0NXpfSQi2jbck+onVDsYNJEqdwj2wjCwYwvFCSmNrZxyeYut
 Z+gS6VrkBSBcQLTFmdrxoDg0YKkSQH0PpgIgqzQCZ4GU3z5hHriKkalvxe+dJ3ur
 853yQ/qjrRseoiy0mfCXDWJTAF7lse+m8bhYxJs0yfr+oeQJdmUwWI7zSiQDo866
 syGhBzkc8H1QGu5blmZYAwDC71n4xDHHhNIs6Ykc2k33jD3Lg5a68VaJpnYGz6PZ
 kHyXZxRCfwAKWQ==
X-ME-Sender: <xms:iYuyYck0WYFqaCD_WJ4jOvDYi898Fbo7RFveIA_M73YY1bNC0R7yeg>
 <xme:iYuyYb0rqnc7K8ue5vQv3x9rMvRzb5zQAjvLP_nXm9Gl0pxg83zogVESeUXPsYrQ5
 qjqCxNjwYXjt7grcQ>
X-ME-Received: <xmr:iYuyYarFXAZsHAtOn4M6sDjTNLM5rLGrPfqzpZvcpzkqEuHADwiKMhO0aabh45rwzxFGQLUW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:iYuyYYlRsvjzvKR13_WATPZX6pQGBfVbrzROhdKBN-GTQ-3Q50BO0Q>
 <xmx:iYuyYa2RvU11-ltbh154NTkkUlTTCBgE95K_DCfpMLKeE8P-zWj79w>
 <xmx:iYuyYfsQ-zwAi1n3M7mBT5c7NjKZLkTReI_mo9_VLpbeB7m-LHDQ9w>
 <xmx:iouyYQOyibWXBG_QwhJoKzINkPiUFnGMOJHiezyfZ2RY9ICjW5sGgA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:41 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 6/7] drivers: virtio_mem: use pageblock size as the
 minimum virtio_mem size.
Date: Thu,  9 Dec 2021 18:04:13 -0500
Message-Id: <20211209230414.2766515-7-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
References: <20211209230414.2766515-1-zi.yan@sent.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 Dec 2021 23:36:06 +0000
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

alloc_contig_range() now only needs to be aligned to pageblock_order,
drop virtio_mem size requirement that it needs to be the max of
pageblock_order and MAX_ORDER.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 drivers/virtio/virtio_mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 96e5a8782769..dab4bce417fd 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2436,15 +2436,13 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
 
 	/*
-	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
-	 * pageblock_nr_pages pages. This:
+	 * We want subblocks to span at least pageblock_nr_pages pages. This:
 	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
 	 *   and fake page onlining code (virtio_mem_fake_online).
 	 * - Is required for now for alloc_contig_range() to work reliably -
 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
-			pageblock_nr_pages) * PAGE_SIZE;
+	sb_size = pageblock_nr_pages * PAGE_SIZE;
 	sb_size = max_t(uint64_t, vm->device_block_size, sb_size);
 
 	if (sb_size < memory_block_size_bytes() && !force_bbm) {
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
