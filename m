Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD82C43217
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 23:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B4754016A;
	Thu,  9 Dec 2021 23:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjKvV24w6OYk; Thu,  9 Dec 2021 23:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1ADCB40160;
	Thu,  9 Dec 2021 23:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33AFBC007A;
	Thu,  9 Dec 2021 23:36:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D76BC001E;
 Thu,  9 Dec 2021 23:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A6886F9DB;
 Thu,  9 Dec 2021 23:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="Kc7pBU31";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="iKm2mq+z"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FtzUysVuol3D; Thu,  9 Dec 2021 23:04:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B43B6F9EE;
 Thu,  9 Dec 2021 23:04:40 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id EE8A6580231;
 Thu,  9 Dec 2021 18:04:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 09 Dec 2021 18:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:reply-to:mime-version
 :content-transfer-encoding; s=fm2; bh=NSbPeTFmC3VX/ha0W/GXZKCwx7
 d2S9q3uKceYNqXMuU=; b=Kc7pBU31o8EbMxFXphV9zG6IiT+0lU3sHlVTVDJUhN
 838c2vFfjgqO41QJ4mrUwBwF0dYW1pR04fr+sFab8ANkVOEBeq2FrG+3B/SpYjXc
 vrs1yru1XjUF9VtzoCsmTc3YlMaOwP8pd7F8iFWHglZ7uZxIjm7q8dj6KDtaBgYF
 6MYK/MJS8gRNHY8rDq07wKmdQMAP/SRTwYMb2LI5hOCLQZ9iOWw6Or4uXI6recCV
 LkphAh+xx7La0uSVlm03JtVOBKs7YjYo19BDsSEWLLr97ZA3YjXYQYYqGlFRfxcb
 MEKRwha4KpDNRD/fP1U8WBn2UybgF6xuBrCIkCPankfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:reply-to:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NSbPeT
 FmC3VX/ha0W/GXZKCwx7d2S9q3uKceYNqXMuU=; b=iKm2mq+zRARqu6Az24pOud
 6cYie2iC8A2n77TsKaeKbYjyVdUFbvHGVRB/sy5b38R1fHtkxGTXQ58tgWsW2eOV
 NBnoRR1sxESACauibFV6K5D7ass+nLZGPdOpPXsoQ5h9kTesYKp94ZOCLsUC0mmK
 d08HILFUYVE/ExBdrNYAMmNBMN0Mgxvrq0XNr0POOzMZWS0Ht8TDrsw+yMCLqzUK
 daaeGy+yClJcboe60hfEOdDkm8gZ5lxHRVomoOXs7SbGtQx3cP6sqGc+wXFXjv/z
 dv064kjkv+5kpRPO4hqP9Yu+SKqDSwKQaPKzrvNeGJo1qFCu2hv91xKoxEirtbLw
 ==
X-ME-Sender: <xms:hIuyYW7KJ2VGvmwWyftbYGKwWK5HJvCSFmJcGjK5tF1EAOU1NiOcxw>
 <xme:hIuyYf4gLhuzV8STMC4PJkvPi2eNA8vecJ4xHCQIisM3hcF3m2zeF1UyvMQdYjLBg
 Z0szHSqPdFTpxRSUQ>
X-ME-Received: <xmr:hIuyYVeY0KnyI8D_rgHPH8k1jJQ-_Cj2aDK-HWDCitfV9QvSilgzQcaWfMxPKP3kae2Tu-lh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
 oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
 fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
 khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:hIuyYTJzxt05EzsOOhpkGX-Qdg3ntRF66l4AebHbDrJ0S27qmDccxQ>
 <xmx:hIuyYaK8WYPLDvA2xw1NU47aotgeBqzt0NNUNsSTBpe9FRmeXlZTSw>
 <xmx:hIuyYUx57W7-ctHGwgaG8T3SVd_sb9nShRzXsMRaaOGHnxLfxB8kmA>
 <xmx:hIuyYcD79eHf97d9tBbwlV2NsHtpEe_KPv6XHDW2Z65FuIIXa_dDcg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:35 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/7] Use pageblock_order for cma and alloc_contig_range
 alignment.
Date: Thu,  9 Dec 2021 18:04:07 -0500
Message-Id: <20211209230414.2766515-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
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

Hi all,

This patchset tries to remove the MAX_ORDER - 1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make MAX_ORDER
adjustable at boot time[1].

The MAX_ORDER - 1 alignment requirement comes from that alloc_contig_range()
isolates pageblocks to remove free memory from buddy allocator but isolating
only a subset of pageblocks within a page spanning across multiple pageblocks
causes free page accounting issues. Isolated page might not be put into the
right free list, since the code assumes the migratetype of the first pageblock
as the whole free page migratetype. This is based on the discussion at [2].

To remove the requirement, this patchset:
1. still isolates pageblocks at MAX_ORDER - 1 granularity;
2. but saves the pageblock migratetypes outside the specified range of
   alloc_contig_range() and restores them after all pages within the range
   become free after __alloc_contig_migrate_range();
3. splits free pages spanning multiple pageblocks at the beginning and the end
   of the range and puts the split pages to the right migratetype free lists
   based on the pageblock migratetypes;
4. returns pages not in the range as it did before this patch.

Isolation needs to happen at MAX_ORDER - 1 granularity, because otherwise
1) extra code is needed to detect pages (free, PageHuge, THP, or PageCompound)
to make sure all pageblocks belonging to a single page are isolated together 
and later pageblocks outside the range need to have their migratetypes restored;
or 2) extra logic will need to be added during page free time to split a free
page with multi-migratetype pageblocks.

Two optimizations might come later:
1. only check unmovable pages within the range instead of MAX_ORDER - 1 aligned
   range during isolation to increase successful rate of alloc_contig_range().
2. make MIGRATE_ISOLATE a separate bit to avoid saving and restoring existing
   migratetypes before and after isolation respectively.

Feel free to give comments and suggestions. Thanks.


[1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.com/
[2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com/


Zi Yan (7):
  mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
  mm: compaction: handle non-lru compound pages properly in
    isolate_migratepages_block().
  mm: migrate: allocate the right size of non hugetlb or THP compound
    pages.
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   6 +-
 include/linux/mmzone.h                     |  11 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/compaction.c                            |  10 +-
 mm/migrate.c                               |   8 +-
 mm/page_alloc.c                            | 203 +++++++++++++++++----
 8 files changed, 196 insertions(+), 54 deletions(-)

-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
