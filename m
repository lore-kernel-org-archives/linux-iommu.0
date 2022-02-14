Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1A5C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 17:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3BD260F34;
	Mon, 14 Feb 2022 17:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PktzPOZddjS0; Mon, 14 Feb 2022 17:42:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 92E2960F26;
	Mon, 14 Feb 2022 17:42:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42748C001A;
	Mon, 14 Feb 2022 17:42:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07F95C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE81D40332
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V64pFD2LweMu for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 17:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1193F400A4
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644860513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cosw6xv3oQ315iRMA4qLGgG8Dk1NQk9XlhixQZy/TZU=;
 b=FSLqkEimDVmEEPmToHFQHbOaUWs0/OeYTiUT8ZPdkdjwy83c4LwDb8EaACL//XfPg5Hazz
 buVP+uDiX/fMeKkipx5xbGbMdytQFaG4elYh3K48H8fmESjhzjyBUkHCYiXNQ8Ixf+Bw0R
 uik3HDom0k1y8K/mLM+nMha1VizYA0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-a7Zmw9YHM-GC7OCHCJrwmQ-1; Mon, 14 Feb 2022 12:41:50 -0500
X-MC-Unique: a7Zmw9YHM-GC7OCHCJrwmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A500C1853024;
 Mon, 14 Feb 2022 17:41:46 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F5A17DE56;
 Mon, 14 Feb 2022 17:41:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] mm: enforce pageblock_order < MAX_ORDER
Date: Mon, 14 Feb 2022 18:41:30 +0100
Message-Id: <20220214174132.219303-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Hildenbrand <david@redhat.com>,
 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Zi Yan <ziy@nvidia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Having pageblock_order >= MAX_ORDER seems to be able to happen in corner
cases and some parts of the kernel are not prepared for it.

For example, Aneesh has shown [1] that such kernels can be compiled on
ppc64 with 64k base pages by setting FORCE_MAX_ZONEORDER=8, which will run
into a WARN_ON_ONCE(order >= MAX_ORDER) in comapction code right during
boot.

We can get pageblock_order >= MAX_ORDER when the default hugetlb size is
bigger than the maximum allocation granularity of the buddy, in which case
we are no longer talking about huge pages but instead gigantic pages.

Having pageblock_order >= MAX_ORDER can only make alloc_contig_range() of
such gigantic pages more likely to succeed.

Reliable use of gigantic pages either requires boot time allcoation or CMA,
no need to overcomplicate some places in the kernel to optimize for corner
cases that are broken in other areas of the kernel.

Let's enforce pageblock_order < MAX_ORDER and simplify.

Especially patch #1 can be regarded a cleanup before:
	[PATCH v5 0/6] Use pageblock_order for cma and alloc_contig_range
	alignment. [2]

[1] https://lkml.kernel.org/r/87r189a2ks.fsf@linux.ibm.com
[2] https://lkml.kernel.org/r/20220211164135.1803616-1-zi.yan@sent.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-mm@kvack.org

David Hildenbrand (2):
  cma: factor out minimum alignment requirement
  mm: enforce pageblock_order < MAX_ORDER

 arch/powerpc/include/asm/fadump-internal.h |  5 ----
 arch/powerpc/kernel/fadump.c               |  2 +-
 drivers/of/of_reserved_mem.c               |  9 ++----
 drivers/virtio/virtio_mem.c                |  9 ++----
 include/linux/cma.h                        |  8 ++++++
 include/linux/pageblock-flags.h            |  7 +++--
 kernel/dma/contiguous.c                    |  4 +--
 mm/Kconfig                                 |  3 ++
 mm/cma.c                                   | 20 ++++----------
 mm/page_alloc.c                            | 32 ++++++----------------
 10 files changed, 37 insertions(+), 62 deletions(-)


base-commit: 754e0b0e35608ed5206d6a67a791563c631cec07
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
