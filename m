From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/8] iommu/iova: Implement deferred flush queue
Date: Fri, 11 Aug 2017 16:41:10 +0200
Message-ID: <1502462478-22045-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, dwmw2@infradead.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

here is an implementation of deferred flush queues in the
common iova code. Some users of the iova code already
implement their own flush-queues, like the AMD-Vi and
Intel VT-d drivers.

The implementation adds a per-cpu ring-buffer to the
iova_domain structure and adds code to maintain that
ring-buffer.

A timer is also used to make sure pending entries in the
ring-buffer are flushed regularily, even when the
ring-buffers don't fill up.

The AMD and Intel IOMMU drivers are converted to make use of
this code and their own implementations for deferred
flushing are removed.

The code has been tested on an AMD and an Intel machine with
network and disk IO.

Please review.

Regards,

	Joerg

Joerg Roedel (8):
  iommu/iova: Add flush-queue data structures
  iommu/iova: Implement Flush-Queue ring buffer
  iommu/iova: Add flush counters to Flush-Queue implementation
  iommu/iova: Add locking to Flush-Queues
  iommu/iova: Add flush timer
  iommu/amd: Make use of iova queue flushing
  iommu/vt-d: Allow to flush more than 4GB of device TLBs
  iommu/vt-d: Make use of iova deferred flushing

 drivers/iommu/amd_iommu.c   | 229 ++------------------------------------------
 drivers/iommu/dmar.c        |   2 +-
 drivers/iommu/intel-iommu.c | 197 ++++++++-----------------------------
 drivers/iommu/iova.c        | 183 +++++++++++++++++++++++++++++++++++
 include/linux/iova.h        |  67 +++++++++++++
 5 files changed, 298 insertions(+), 380 deletions(-)

-- 
2.7.4
