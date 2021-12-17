Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FB5C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 15:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98C9E84BD1;
	Fri, 17 Dec 2021 15:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hO42E4uURdZS; Fri, 17 Dec 2021 15:31:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 72CA384CCA;
	Fri, 17 Dec 2021 15:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 353BBC0030;
	Fri, 17 Dec 2021 15:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C9C9C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 15:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C68A61111
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 15:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iSjbJafY3iJY for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 15:31:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1FD16111C
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 15:31:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC061042;
 Fri, 17 Dec 2021 07:31:12 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C32973F774;
 Fri, 17 Dec 2021 07:31:10 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v3 0/9] iommu: refactor flush queues into iommu-dma
Date: Fri, 17 Dec 2021 15:30:54 +0000
Message-Id: <cover.1639753638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com, hch@lst.de
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

v1: https://lore.kernel.org/linux-iommu/cover.1637671820.git.robin.murphy@arm.com/
v2: https://lore.kernel.org/linux-iommu/cover.1639157090.git.robin.murphy@arm.com/

Hi all,

Just another quick update addressing the trivial nits and picking up the
review tags so far. The previous Tegra DRM fixes for the initial kbuild
issues have been picked up, so I've posted a final fix separately[1] for
the others subsequently reported on v2. I've confirmed that arm64
allmodconfig builds cleanly with that, and nothing else jumped out from
a manual audit of iova.h includers. At worst we could hold off applying
the last patch (or the last two, logically), or temporarily reinstate
the dma-iommu.h include, if we're worried about issues in linux-next
until the DRM tree has caught up.

Thanks
Robin.

[1] https://lore.kernel.org/linux-iommu/dc81eec74be9064e33247257b1fe439b0f6ec78d.1639664721.git.robin.murphy@arm.com/

Matthew Wilcox (Oracle) (2):
  iommu/amd: Use put_pages_list
  iommu/vt-d: Use put_pages_list

Robin Murphy (6):
  iommu/iova: Squash entry_dtor abstraction
  iommu/iova: Squash flush_cb abstraction
  iommu/amd: Simplify pagetable freeing
  iommu/iova: Consolidate flush queue code
  iommu/iova: Move flush queue code to iommu-dma
  iommu: Move flush queue data into iommu_dma_cookie

Xiongfeng Wang (1):
  iommu/iova: Fix race between FQ timeout and teardown

 drivers/iommu/amd/io_pgtable.c | 120 ++++++---------
 drivers/iommu/dma-iommu.c      | 266 +++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c    |  89 ++++-------
 drivers/iommu/iova.c           | 200 -------------------------
 include/linux/iommu.h          |   3 +-
 include/linux/iova.h           |  69 +--------
 6 files changed, 297 insertions(+), 450 deletions(-)

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
