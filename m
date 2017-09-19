From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/3] Misc IOVA tweaks
Date: Tue, 19 Sep 2017 14:48:38 +0100
Message-ID: <cover.1505827369.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

While I was elbow-deep in the IOVA code, a few other things came to
light which don't really fit into the rbtree optimisation series.
Patches #1 and #2 are more or less just cleanup, while patch #3
complements Tomasz' recent PCI allocation patch as it aims to
potentially improve the same situation.

Last time I checked, these should all apply independently and without
major conflicts against any other in-flight IOVA patches.

Robin.

Robin Murphy (3):
  iommu/iova: Simplify domain destruction
  iommu/iova: Make rcache limit_pfn handling more robust
  iommu/iova: Try harder to allocate from rcache magazine

 drivers/iommu/iova.c | 73 ++++++++++++++++++++--------------------------------
 1 file changed, 28 insertions(+), 45 deletions(-)

-- 
2.13.4.dirty
