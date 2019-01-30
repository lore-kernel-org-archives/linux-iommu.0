From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 0/2] Some MMU notifier cleanups for Intel/AMD IOMMU
Date: Wed, 30 Jan 2019 13:57:56 +0800
Message-ID: <20190130055758.3994-1-peterx@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, Jason Wang <jasowang@redhat.com>, peterx@redhat.com, Jerome Glisse <jglisse@redhat.com>
List-Id: iommu@lists.linux-foundation.org

Recently when I'm reading the mmu notifiers I noticed that both
Intel/AMD IOMMU drivers seem to have redundancies in using the MMU
notifiers.  It can also be seen as a follow up of commit 8301da53fbc1
("iommu/amd: Remove change_pte mmu_notifier call-back", 2014-07-30).

I don't have hardwares to test them, but they compile well.

Please have a look, thanks.

Peter Xu (2):
  iommu/vt-d: Remove change_pte notifier
  iommu/amd: Remove clear_flush_young notifier

 drivers/iommu/amd_iommu_v2.c | 24 ------------------------
 drivers/iommu/intel-svm.c    |  9 ---------
 2 files changed, 33 deletions(-)

-- 
2.17.1
