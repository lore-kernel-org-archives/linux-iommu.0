Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E8FC433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 17:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 340A7614B9;
	Fri, 10 Dec 2021 17:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ys3MT0cqU_VG; Fri, 10 Dec 2021 17:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 21D93614B0;
	Fri, 10 Dec 2021 17:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E442BC002F;
	Fri, 10 Dec 2021 17:55:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BAC7C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D88F5614B6
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9RpT67BFecV for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 17:55:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6557614B3
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 17:55:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED03812FC;
 Fri, 10 Dec 2021 09:54:59 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B28663F73B;
 Fri, 10 Dec 2021 09:54:58 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 00/11] iommu: refactor flush queues into iommu-dma
Date: Fri, 10 Dec 2021 17:54:41 +0000
Message-Id: <cover.1639157090.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
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

v1: https://lore.kernel.org/linux-iommu/cover.1637671820.git.robin.murphy@arm.com/

Hi all,

Just a minor update, pulling in Xiongfeng's fix as a basis for the
subsequent patches moving that code around, and the Tegra DRM patch
previously posted separately. Plus commenting the subtlety in the AMD
pagetable code so it's hopefully easier to remember in future.

Given that no major issues have surfaced so far, hopefully this is on
track for 5.17 in parallel with the slab rework.

Thanks,
Robin.


Matthew Wilcox (Oracle) (2):
  iommu/amd: Use put_pages_list
  iommu/vt-d: Use put_pages_list

Robin Murphy (8):
  gpu: host1x: Add missing DMA API include
  drm/tegra: vic: Fix DMA API misuse
  iommu/iova: Squash entry_dtor abstraction
  iommu/iova: Squash flush_cb abstraction
  iommu/amd: Simplify pagetable freeing
  iommu/iova: Consolidate flush queue code
  iommu/iova: Move flush queue code to iommu-dma
  iommu: Move flush queue data into iommu_dma_cookie

Xiongfeng Wang (1):
  iommu/iova: Fix race between FQ timeout and teardown

 drivers/gpu/drm/tegra/vic.c    |   7 +-
 drivers/gpu/host1x/bus.c       |   1 +
 drivers/iommu/amd/io_pgtable.c | 120 ++++++---------
 drivers/iommu/dma-iommu.c      | 268 +++++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.c    |  89 ++++-------
 drivers/iommu/iova.c           | 200 ------------------------
 include/linux/iommu.h          |   3 +-
 include/linux/iova.h           |  69 +--------
 8 files changed, 303 insertions(+), 454 deletions(-)

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
