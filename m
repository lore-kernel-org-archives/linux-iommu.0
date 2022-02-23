Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315FAC4332F
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 04:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D072940912;
	Wed, 23 Feb 2022 04:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VzosX-35wpBE; Wed, 23 Feb 2022 04:30:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 93314409A3;
	Wed, 23 Feb 2022 04:30:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECE63C0078;
	Wed, 23 Feb 2022 04:30:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAD9DC001A;
 Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94E1A60BE8;
 Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="moTacVGx";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Os0hmMfz"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u81KxP6iTxWa; Wed, 23 Feb 2022 04:30:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47BF560ACB;
 Wed, 23 Feb 2022 04:30:48 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 42B94580055;
 Tue, 22 Feb 2022 23:30:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 22 Feb 2022 23:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:reply-to:sender:subject
 :subject:to:to; s=fm2; bh=ETC2AAf47GJ+iGkmCj4k43U6GvDQMOzkmXEXAA
 ZFQiE=; b=moTacVGxwQE7c3T9nkxC0XjeIrAoEmvXOQC6Eo3J/3XXfZ26exoKAT
 /QsARQD9yWNIh3jhTbxVulurxuo/F6T30nnZylLM6Dohzj7dnHCSbD4BmmS4zRio
 yR8K4wAJb76Rstdbh1K6WwR4ZE80ibQLj7S0hmS24CPmlcDOUP/MDVVxy1uJkQjA
 BahzsRtK5VLT8eeGTx9Ni+YN+fzMloOa1Vz4jSxEq542dW5ZKPZNB3kT7JVK0+Sl
 BFfBUVn4ESU+tSGh+uQbnlW12UyImkmR30R8Yri7sBxl9/TvLjQmpu+1G1XtQLi9
 taOqjBQzYJmbwvBTR2VcnlETcaOgGKiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
 :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; bh=ETC2AAf47GJ+iGkmCj4k43U6GvDQM
 OzkmXEXAAZFQiE=; b=Os0hmMfzfgNY/B8oGtvV6Jd9ITb3gcMUIKPpKDNXNoU2N
 Cyt23PLwW1ebDpqR9nZ9SshDsT8+3kJXAhllhWPX7d5WRbw1sEy4rKaf/6yuG9SN
 hEcbE+u8GPX/+GWlQa8r7oqN2KAb1S9BdtunW6oAW9NL0T8tz93HGOS8m8zK+Yul
 +cB/OGwzOFvytXnMOhFPyKiLJR/bLQigqfq1UBlWTLah2QmxGA/sH3ypL1HpOkAS
 oJvGmAYN3487umX+YXwjj9xU65Ke57gK03Fa7LOhV+JY1dzmpEetKK1cjzZ/Xv7/
 yhfjSKAXsN4wsyKJEq8NeTVivVednNXUVTEIyD3Qw==
X-ME-Sender: <xms:dLgVYsCpZZWNlf23WFuQPTHx2zdIcIxL0CRuIvWs3Usv9F4RmTiu_A>
 <xme:dLgVYujiwTdRsCBGPK6Mbs1axfLEP3WwlBGFFljGXBj3dIRQrilhVL7b8JtH4jLnr
 CQP5HewyF0xMHDBcA>
X-ME-Received: <xmr:dLgVYvlkqkTJ_Em9cN0jQ66_ZDW5tetVG1hkFpxi-2yhi0DxzzL8HwXZ_iRW5SiTGbowahMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
 oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
 fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
 khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:dLgVYiwgtJsC4TTp-NgRiUs4LlTbG2OEF9FvT_y7h4N_dEBfqlnuhw>
 <xmx:dLgVYhT_bC3TztO9W9pyWxBtw8SRE7X240RoPGvzrOO6zUfTkhE9Gw>
 <xmx:dLgVYtYv60Pf2HZz4ovPownyKi1ix78bnmjL1YPXDmVr4DXSS2_U6A>
 <xmx:dbgVYqhDWi2mKIPAZo2N-TZw9MeRB7_ZPObODmzTAaQ0kglhZtI2xQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:43 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v6 0/5] Use pageblock_order for cma and alloc_contig_range
 alignment.
Date: Tue, 22 Feb 2022 23:30:32 -0500
Message-Id: <20220223043037.715205-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-02-14-17-46.

Changelog
===
V6
---
1. Resolved compilation error/warning reported by kernel test robot.
2. Tried to solve the coding concerns from Christophe Leroy.
3. Shortened lengthy lines (pointed out by Christoph Hellwig).

V5
---
1. Moved isolation address alignment handling in start_isolate_page_range().
2. Rewrote and simplified how alloc_contig_range() works at pageblock
   granularity (Patch 3). Only two pageblock migratetypes need to be saved and
   restored. start_isolate_page_range() might need to migrate pages in this
   version, but it prevents the caller from worrying about
   max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) alignment after the page range
   is isolated.

V4
---
1. Dropped two irrelevant patches on non-lru compound page handling, as
   it is not supported upstream.
2. Renamed migratetype_has_fallback() to migratetype_is_mergeable().
3. Always check whether two pageblocks can be merged in
   __free_one_page() when order is >= pageblock_order, as the case (not
   mergeable pageblocks are isolated, CMA, and HIGHATOMIC) becomes more common.
3. Moving has_unmovable_pages() is now a separate patch.
4. Removed MAX_ORDER-1 alignment requirement in the comment in virtio_mem code.

Description
===

The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
isolates pageblocks to remove free memory from buddy allocator but isolating
only a subset of pageblocks within a page spanning across multiple pageblocks
causes free page accounting issues. Isolated page might not be put into the
right free list, since the code assumes the migratetype of the first pageblock
as the whole free page migratetype. This is based on the discussion at [2].

To remove the requirement, this patchset:
1. isolates pages at pageblock granularity instead of
   max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages);
2. splits free pages across the specified range or migrates in-use pages
   across the specified range then splits the freed page to avoid free page
   accounting issues (it happens when multiple pageblocks within a single page
   have different migratetypes);
3. only checks unmovable pages within the range instead of MAX_ORDER - 1 aligned
   range during isolation to avoid alloc_contig_range() failure when pageblocks
   within a MAX_ORDER - 1 aligned range are allocated separately.
4. returns pages not in the range as it did before.

One optimization might come later:
1. make MIGRATE_ISOLATE a separate bit to be able to restore the original
   migratetypes when isolation fails in the middle of the range.

Feel free to give comments and suggestions. Thanks.

[1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.com/
[2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com/

Zi Yan (5):
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.

 drivers/virtio/virtio_mem.c    |   6 +-
 include/linux/cma.h            |   4 +-
 include/linux/mmzone.h         |   5 +-
 include/linux/page-isolation.h |  14 +-
 mm/internal.h                  |   6 +
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                | 246 +++++++--------------------
 mm/page_isolation.c            | 296 +++++++++++++++++++++++++++++++--
 8 files changed, 367 insertions(+), 213 deletions(-)

-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
