From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v7 0/6] Add non-strict mode support for iommu-dma
Date: Fri, 14 Sep 2018 15:30:18 +0100
Message-ID: <cover.1536935328.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi all,

Since we'd like to get this polished up and merged and Leizhen has other
commitments, here's v7 of the previous series[1] wherein I address all
my own feedback :) This is a quick tweak of the v6 I sent yesterday
since I figured out slightly too late a much neater way of setting the
attribute at the appropriate time.

The principal change is that I've inverted things slightly such that
it's now a generic domain attribute controlled by iommu-dma given the
necessary support from individual IOMMU drivers. That way we can easily
enable other drivers straight away, as I've done for SMMUv2 here (which
also allowed me to give it a quick test with MMU-401s on a Juno board).
Otherwise it's really just cosmetic cleanup and rebasing onto Will's
pending SMMU queue.

Robin.

[1] https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg25150.html


Robin Murphy (1):
  iommu/arm-smmu: Support non-strict mode

Zhen Lei (5):
  iommu/arm-smmu-v3: Implement flush_iotlb_all hook
  iommu/dma: Add support for non-strict mode
  iommu/io-pgtable-arm: Add support for non-strict mode
  iommu: Add bootup option "iommu.non_strict"
  iommu/arm-smmu-v3: Add support for non-strict mode

 .../admin-guide/kernel-parameters.txt         | 13 ++++++
 drivers/iommu/arm-smmu-v3.c                   | 40 +++++++++++++++----
 drivers/iommu/arm-smmu.c                      | 40 +++++++++++++++----
 drivers/iommu/dma-iommu.c                     | 29 +++++++++++++-
 drivers/iommu/io-pgtable-arm.c                |  9 +++--
 drivers/iommu/io-pgtable.h                    |  5 +++
 drivers/iommu/iommu.c                         | 26 ++++++++++++
 include/linux/iommu.h                         |  1 +
 8 files changed, 145 insertions(+), 18 deletions(-)

-- 
2.19.0.dirty
