From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v8 0/7] Add non-strict mode support for iommu-dma
Date: Thu, 20 Sep 2018 17:10:20 +0100
Message-ID: <cover.1537458163.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi all,

Hopefully this is the last spin of the series - I've now dropped my light
touch and fixed up all the various prose text, plus implemented the proper
quirk support for short-descriptor because it's actually just a trivial
cut-and-paste job.

Robin.


Robin Murphy (2):
  iommu/io-pgtable-arm-v7s: Add support for non-strict mode
  iommu/arm-smmu: Support non-strict mode

Zhen Lei (5):
  iommu/arm-smmu-v3: Implement flush_iotlb_all hook
  iommu/dma: Add support for non-strict mode
  iommu: Add "iommu.strict" command line option
  iommu/io-pgtable-arm: Add support for non-strict mode
  iommu/arm-smmu-v3: Add support for non-strict mode

 .../admin-guide/kernel-parameters.txt         | 12 +++
 drivers/iommu/arm-smmu-v3.c                   | 89 +++++++++++++-----
 drivers/iommu/arm-smmu.c                      | 93 +++++++++++++------
 drivers/iommu/dma-iommu.c                     | 32 ++++++-
 drivers/iommu/io-pgtable-arm-v7s.c            | 11 ++-
 drivers/iommu/io-pgtable-arm.c                | 14 ++-
 drivers/iommu/io-pgtable.h                    |  5 +
 drivers/iommu/iommu.c                         | 23 +++++
 include/linux/iommu.h                         |  1 +
 9 files changed, 225 insertions(+), 55 deletions(-)

-- 
2.19.0.dirty
