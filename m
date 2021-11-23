Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762B1C433FE
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:10:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 161CC401BC;
	Tue, 23 Nov 2021 14:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LSZrxG1ZeTTA; Tue, 23 Nov 2021 14:10:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A07314000B;
	Tue, 23 Nov 2021 14:10:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87D59C002E;
	Tue, 23 Nov 2021 14:10:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6B1BC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C574540275
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0glXoNejpxXX for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:10:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81E2840266
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:10:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AEBC1042;
 Tue, 23 Nov 2021 06:10:49 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49B553F66F;
 Tue, 23 Nov 2021 06:10:48 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 0/9] iommu: Refactor flush queues into iommu-dma
Date: Tue, 23 Nov 2021 14:10:35 +0000
Message-Id: <cover.1637671820.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
 iommu@lists.linux-foundation.org
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

Hi all,

As promised, this series cleans up the flush queue code and streamlines
it directly into iommu-dma. Since we no longer have per-driver DMA ops
implementations, a lot of the abstraction is now no longer necessary, so
there's a nice degree of simplification in the process. Un-abstracting
the queued page freeing mechanism is also the perfect opportunity to
revise which struct page fields we use so we can be better-behaved
from the MM point of view, thanks to Matthew.

These changes should also make it viable to start using the gather
freelist in io-pgtable-arm, and eliminate some more synchronous
invalidations from the normal flow there, but that is proving to need a
bit more careful thought than I have time for in this cycle, so I've
parked that again for now and will revisit it in the new year.

For convenience, branch at:
  https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/iova

I've build-tested for x86_64, and boot-tested arm64 to the point of
confirming that put_pages_list() gets passed a valid empty list when
flushing, while everything else still works.

Cheers,
Robin.


Matthew Wilcox (Oracle) (2):
  iommu/amd: Use put_pages_list
  iommu/vt-d: Use put_pages_list

Robin Murphy (7):
  gpu: host1x: Add missing DMA API include
  iommu/iova: Squash entry_dtor abstraction
  iommu/iova: Squash flush_cb abstraction
  iommu/amd: Simplify pagetable freeing
  iommu/iova: Consolidate flush queue code
  iommu/iova: Move flush queue code to iommu-dma
  iommu: Move flush queue data into iommu_dma_cookie

 drivers/gpu/host1x/bus.c       |   1 +
 drivers/iommu/amd/io_pgtable.c | 116 ++++++--------
 drivers/iommu/dma-iommu.c      | 266 +++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c    |  89 ++++-------
 drivers/iommu/iova.c           | 200 -------------------------
 include/linux/iommu.h          |   3 +-
 include/linux/iova.h           |  69 +--------
 7 files changed, 295 insertions(+), 449 deletions(-)

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
