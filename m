Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9FCC433FE
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 19:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1AE5240573;
	Wed, 19 Jan 2022 19:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJcS5paVbK0i; Wed, 19 Jan 2022 19:06:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8D227404FD;
	Wed, 19 Jan 2022 19:06:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68BAAC0039;
	Wed, 19 Jan 2022 19:06:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92061C002F;
 Wed, 19 Jan 2022 19:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B6A280C4D;
 Wed, 19 Jan 2022 19:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="Z0dpaC+C";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="gO/I3NtE"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ew6oBHjRsi0J; Wed, 19 Jan 2022 19:06:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33FF080C39;
 Wed, 19 Jan 2022 19:06:37 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 67B0C5806EB;
 Wed, 19 Jan 2022 14:06:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 19 Jan 2022 14:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:reply-to:mime-version
 :content-transfer-encoding; s=fm2; bh=XoGtHOG8AyFnf2S1JWsX18T68L
 iZtgT1QGCS/Lzv0YE=; b=Z0dpaC+CnN0yiYzTq1mRWwOkyRPH017sN6ZHiGIChO
 nmpfDjp8pp8RNPA+LdfgXzQBRUkihXdVIYSYo4szEZcidjaMBMDh+5kvIiubryoi
 66m1R29c339JdNYRLdaaoS6iWxI+4RKk/z/0PsExH/w4UlGPDLIeX5twM+7umkqb
 IhxJMQso5cS9cA87YHayQDC8NC9SF5OQpS19xpa9NpUuBDSy8S0DDv5jSih9f3W+
 IT3pXQYau1KU8WlAQlPy8IbbDN03QhzGotU0zfvn4R4D72hslzoWXk08ltGOGSdY
 okbjZHc7PbKQpsDNVTfhVBbBr2iDGQJeF77f6xB4EgsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:reply-to:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XoGtHO
 G8AyFnf2S1JWsX18T68LiZtgT1QGCS/Lzv0YE=; b=gO/I3NtEdFsJenepxchu8j
 UlgO3PKzV+G9z1b9Co4w3dxKEVm8aescI/cx7jrzM1sf2pxuX+4rKKtWucUgeHdK
 7BZSvNyd66wLg8J/snTG92OG7v+luaxfdfUmhdME+MFgkwlJ7svlWfCm6Iyf5eOD
 B0ZJaTfBr8q+eTAcR7vScMOfjuU3BNF+bsUIHlMJENDDitGX4+TwKqH+EUdabudu
 rgBIIbcyivP/RNaj2l/nGgXEspAUhPVgFPmH3eeWw6T+WHpE1MhZk0j/AWOunRrG
 gUyHXW4XSNfQHrsBJCBGOaFlGojH9mVZPiwPLkeuaxxZj/7MqGSO52jyoee8EeWQ
 ==
X-ME-Sender: <xms:OWHoYTW9q79dcH0I_y05ufdpEexSVpQv2pCP8mbq8wKYJQf0uUaNyQ>
 <xme:OWHoYblJ75KeKpx-6iO3DY0uyzHzU1TD5wkPTTdItJ11kgQGTj38zriDpvxr7AKlq
 7VRJ8dtCnSv2f8Otw>
X-ME-Received: <xmr:OWHoYfbxCuhIczX6BzsDCjwxKuhdtcZdv3Hi74rHeFXEvP2XyTBHabpqgP2ZFyoNU58_SAAf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggrnhcu
 oeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetieeitdejgf
 fhfeeukeejvdeufedtvddulefhteduffeigfefteehgefhvdegudenucffohhmrghinhep
 khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:OWHoYeV1t0lxGc4gdWK-ouG9ad45A9L8NCoPoE92P1caNy2KsIL_Zw>
 <xmx:OWHoYdm0aLgpkYzkLFSOMST8y9NsQrWLBjU6CRISanXt_CDFW1Jj0g>
 <xmx:OWHoYbeSAv4kvACI_gTYkmwirMOq5KZfcgqziIj4zC8AjOHNuimYZA>
 <xmx:OmHoYQ8ynrUETe1CpldILj1hXHQkvFnP8Zg-t5StFVxtTXErGBUnvg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:32 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v4 0/7] Use pageblock_order for cma and alloc_contig_range
 alignment.
Date: Wed, 19 Jan 2022 14:06:16 -0500
Message-Id: <20220119190623.1029355-1-zi.yan@sent.com>
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

This patchset tries to remove the MAX_ORDER-1 alignment requirement for CMA
and alloc_contig_range(). It prepares for my upcoming changes to make
MAX_ORDER adjustable at boot time[1]. It is on top of mmotm-2021-12-29-20-07.

Changelog from RFC
===
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


Zi Yan (7):
  mm: page_alloc: avoid merging non-fallbackable pageblocks with others.
  mm: page_isolation: move has_unmovable_pages() to mm/page_isolation.c
  mm: page_isolation: check specified range for unmovable pages
  mm: make alloc_contig_range work at pageblock granularity
  mm: cma: use pageblock_order as the single alignment
  drivers: virtio_mem: use pageblock size as the minimum virtio_mem
    size.
  arch: powerpc: adjust fadump alignment to be pageblock aligned.

 arch/powerpc/include/asm/fadump-internal.h |   4 +-
 drivers/virtio/virtio_mem.c                |   7 +-
 include/linux/mmzone.h                     |  16 +-
 include/linux/page-isolation.h             |   3 +-
 kernel/dma/contiguous.c                    |   2 +-
 mm/cma.c                                   |   6 +-
 mm/memory_hotplug.c                        |  12 +-
 mm/page_alloc.c                            | 337 +++++++++++----------
 mm/page_isolation.c                        | 154 +++++++++-
 9 files changed, 352 insertions(+), 189 deletions(-)

-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
