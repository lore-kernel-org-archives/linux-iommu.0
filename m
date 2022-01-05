Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A270DC4332F
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 21:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 28FA940235;
	Wed,  5 Jan 2022 21:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1TPDxkSK6D7; Wed,  5 Jan 2022 21:48:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD9D440102;
	Wed,  5 Jan 2022 21:48:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7C0C0038;
	Wed,  5 Jan 2022 21:48:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 485CFC001E;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 364236FBB7;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="uXAApkQx";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="HvGpC6u6"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gGjwkEM0iUNK; Wed,  5 Jan 2022 21:48:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEDCD6FB95;
 Wed,  5 Jan 2022 21:48:25 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 3F36858050E;
 Wed,  5 Jan 2022 16:48:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 05 Jan 2022 16:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:reply-to:mime-version
 :content-transfer-encoding; s=fm2; bh=XuWtzwLjwrz+Pbdt4BURzbEzIj
 SMHmc6+71DP0kr+2E=; b=uXAApkQxB/AHFvFh1fVn4pkg+KKcnsaui9GQg+9dH2
 SFYnWmEe/ldaxJywT/GwaCyzOGCO7m3X3o7M2ae4OZ5FwshRwxYqmF2HHcYSBN+l
 9cN0zSWwU+iJgj48GoYpZARjxLtIxBz/MEaf4nXDalkH9VxbNETon9AOq2B6V5Yn
 R8ua7i82K3DpMMPVPOF/w6LsKrCuyc6TjyNOvKROMMETe9xzLO5cC3Ffps0owCmH
 QYsGLqdUmE4xmYJmg2PhMyrjcINl8V8GMjpIKvOphS/M1lNkpn6mljULn5plg5Iq
 noSas0MQqxTl2XI75bT9fLaUwmm2bgOM6d0/rSYCDrow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:reply-to:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XuWtzw
 Ljwrz+Pbdt4BURzbEzIjSMHmc6+71DP0kr+2E=; b=HvGpC6u6DuKlQgEP1Gev3q
 Rgt0hQDTeg3WsXqtwHcudSdbaKQu8JDpLAweDlFjaFqFA7lBZ/9bDgR795dTixy1
 f7V42zwWZwyXcowz+luRUA+bGINa/MWHjF86ilacqzjFnEC+fuqbVISuOs6o3llr
 KHjupyMVFFsCrGDqF96lDXqj2pt/0rnU+UBL3KtG+8VkyeP4l1hjavc8D11hjFy8
 zY+IhJp6cdJJxerPIaHnBgnoxlLPg5S12HwGq8A/So6NCYMGFgywYRAJ56G4DFsE
 zMSvfMWf6lZgS8RlKZvtuQs77mBhI1iFNJO38LfEOHPApe271dGpBTxzAZKPzi8g
 ==
X-ME-Sender: <xms:JhLWYVKXz0XA-qpUi52ORQJ3b_vlMtwapPHJBVHKj_u8hnWMqZtHDw>
 <xme:JhLWYRI25R7Exx_bhZKo2mRzyd3q9dVvcisZIUCr31t90YK1E4xvbWaGsmUPpj_de
 BJetflZTamAnZXawQ>
X-ME-Received: <xmr:JhLWYduJJIK6sAiI5lQNR2rS0BCbdvheZt-9dhfIDkum0PZ9kGFM9vJpYTRMPYLLxXF9xtHR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkfforhgggfestdhqredtredttdenucfhrhhomhepkghiucgjrghn
 uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteeiiedtje
 fghfefueekjedvueeftddvudelhfetudffiefgfeetheeghfdvgedunecuffhomhgrihhn
 pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:JhLWYWbgMIL6YDHpejS7gaz3xF3GYtJHhXnUYyFsNUqmiljYKpIE3Q>
 <xmx:JhLWYcbztubtuPOSHETmw9gpNOrWQHFUkEEHVSpmQ4TOAFs0hRhHMw>
 <xmx:JhLWYaBLWIq4Yx8-4V6VLWCHmTnK9L_CQAWAl-5CipObOrjm1hOrNA>
 <xmx:JxLWYYT6deCytecTH9xSlMQ4YWXiP-dvNcZMaqJzj3Q7ESFepFN1pw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:21 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 0/8] Use pageblock_order for cma and alloc_contig_range
 alignment.
Date: Wed,  5 Jan 2022 16:47:48 -0500
Message-Id: <20220105214756.91065-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

This patchset tries to remove the MAX_ORDER - 1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make MAX_ORDER
adjustable at boot time[1]. It is on top of mmotm-2021-12-29-20-07.

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
3. only checks unmovable pages within the range instead of MAX_ORDER - 1 aligned
   range during isolation to avoid alloc_contig_range() failure when pageblocks
   within a MAX_ORDER - 1 aligned range are allocated separately.
3. splits free pages spanning multiple pageblocks at the beginning and the end
   of the range and puts the split pages to the right migratetype free lists
   based on the pageblock migratetypes;
4. returns pages not in the range as it did before.

Isolation needs to be done at MAX_ORDER - 1 granularity, because otherwise
either 1) it is needed to detect to-be-isolated page size (free, PageHuge, THP,
or other PageCompound) to make sure all pageblocks belonging to a single page
are isolated together and later restore pageblock migratetypes outside the
range, or 2) assuming isolation happens at pageblock granularity, a free page
with multi-migratetype pageblocks can seen in free page path and needs
to be split and freed at pageblock granularity.

One optimization might come later:
1. make MIGRATE_ISOLATE a separate bit to avoid saving and restoring existing
   migratetypes before and after isolation respectively.

Feel free to give comments and suggestions. Thanks.


[1] https://lore.kernel.org/linux-mm/20210805190253.2795604-1-zi.yan@sent.com/
[2] https://lore.kernel.org/linux-mm/d19fb078-cb9b-f60f-e310-fdeea1b947d2@redhat.com/

Zi Yan (8):
  mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
  mm: compaction: handle non-lru compound pages properly in
    isolate_migratepages_block().
  mm: migrate: allocate the right size of non hugetlb or THP compound
    pages.
  mm: make alloc_contig_range work at pageblock granularity
  mm: page_isolation: check specified range for unmovable pages during
    isolation.
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   3 +-
 include/linux/mmzone.h                     |  11 +-
 include/linux/page-isolation.h             |   3 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/compaction.c                            |  10 +-
 mm/memory_hotplug.c                        |  12 +-
 mm/migrate.c                               |  11 +-
 mm/page_alloc.c                            | 328 +++++++++++----------
 mm/page_isolation.c                        | 148 +++++++++-
 11 files changed, 353 insertions(+), 185 deletions(-)

-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
