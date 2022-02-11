Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C003C43219
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 16:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22FDB416F5;
	Fri, 11 Feb 2022 16:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gH5xwBgkGrJw; Fri, 11 Feb 2022 16:41:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3984641630;
	Fri, 11 Feb 2022 16:41:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B6B8C0031;
	Fri, 11 Feb 2022 16:41:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1102C000B;
 Fri, 11 Feb 2022 16:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F1AA400A6;
 Fri, 11 Feb 2022 16:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="LdE+Lwdr";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Ipg7LKsL"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0uJSfmpd74Je; Fri, 11 Feb 2022 16:41:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64F1340108;
 Fri, 11 Feb 2022 16:41:49 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 48BE05801A3;
 Fri, 11 Feb 2022 11:41:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Fri, 11 Feb 2022 11:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:reply-to:sender:subject
 :subject:to:to; s=fm2; bh=yn4EluHRFjIlAOq/f3660DeKnQykfQ+VjC9Svi
 DiUcQ=; b=LdE+LwdrS7vb8o8nfNSVlSj4rVFFw4oHar8ga/I9sHEKWwe6GMwTYw
 A9l1TC9pMw3Ce0fUnshitggrSRvGi/kBCqJeAedfFbyh9dHg6EaUCwKpV9momk4E
 HK1eZ4duGrtufvpbohtk+tXvFtKVZ4jhu5Ww88ISSq0/bO+OzQBbs9xWE9oK0qxW
 meb+rWN8T+MKOZMTRNrEi9XPuTr0vc+erhGrOdhRW/Cl7S4sVfGFtp3gFwDbBa0V
 gPVQQPiIC0zYrh6IQPjAvG4+aifGmOHcDKU899W9zgRVtZRVvDMF5clxclhbcAEg
 /YraeGdj6EksggCetKJnx+h2HoBrFmFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
 :sender:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; bh=yn4EluHRFjIlAOq/f3660DeKnQykf
 Q+VjC9SviDiUcQ=; b=Ipg7LKsLWh4QZ09hDyS6jxA1pzquPIkp3VZNNObGCO5R0
 EZAHG8gm2zX1i14doz/5VTiqAfFt8LWEaW3goX4eotgegTg6XFYxlf/dXUHM5t9N
 AGDvAn88dRfDo6guGNyzrONztvAaVbg61gQdqbaM1U3YlCuAQHs65Q1H88Jno3VI
 yyogEpGdka2teZglILqZyYarQPzTRXdLevdz+c62qNCTr5is/Ct2cgwapONuGE34
 Ir9XG0ei/3vNOgSv81Qb1asjX6zyDHW04XTC+3BylAhc1JkI8pQIgYiOerTDaUFS
 BjMfx/RDinYsREbrb63kH2aI1w914nMsrtI8Na7nA==
X-ME-Sender: <xms:x5EGYmKncaHEF1UdhiDGJmzmaD2yrBcb1HNvPp3U2tVV_awawzGjng>
 <xme:x5EGYuJsFGzOpVg9hlLVVdiuf0KHz15zqV4yj3xhJxqiyI9B_Hda-CbcClMJR5ayi
 7vwcV-TAsfeD872_g>
X-ME-Received: <xmr:x5EGYmvAPbLHaSg2Rdw1680ga65cQIoS5qFrG5RsunJb_fkJDvmxBoW9Feh7y2ldYd1GX3M1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
 oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
 fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
 khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:x5EGYrZ7stBQYd7OdV0zo7ZzuYtbRptVheIKi-XrCvgkpNyKy3stVw>
 <xmx:x5EGYtb0L1ODu_B3u0_uSL5KbS9aBFvF_vp_vHJnUV-7Axf7Qa1hOg>
 <xmx:x5EGYnAfkktLWYNMCOBS9M1unJvoNxT-JLktbx-T5X4ws7wV5ovgeg>
 <xmx:yZEGYjxyA-zHLLLU42PLY1_Elpui67zm6DG7NofcGUdJ8EPTYP6KSA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:43 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v5 0/6] Use pageblock_order for cma and alloc_contig_range
 alignment.
Date: Fri, 11 Feb 2022 11:41:29 -0500
Message-Id: <20220211164135.1803616-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
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

Hi all,

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2022-02-08-15-31.

Changelog
===
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

Zi Yan (6):
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   7 +-
 include/linux/mmzone.h                     |   5 +-
 include/linux/page-isolation.h             |  16 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/internal.h                              |   3 +
 mm/memory_hotplug.c                        |   3 +-
 mm/page_alloc.c                            | 371 ++++++++++-----------
 mm/page_isolation.c                        | 172 +++++++++-
 10 files changed, 367 insertions(+), 222 deletions(-)

-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
