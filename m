From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/3] arm-smmu: performance optimization
Date: Tue, 12 Sep 2017 21:00:35 +0800
Message-ID: <1505221238-9428-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>, Jinyue Li <lijinyue@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: iommu@lists.linux-foundation.org

v1 -> v2:
base on (add02cfdc9bc2 "iommu: Introduce Interface for IOMMU TLB Flushing")

Zhen Lei (3):
  iommu/arm-smmu-v3: put off the execution of TLBI* to reduce lock
    confliction
  iommu/arm-smmu-v3: add support for unmap an iova range with only one
    tlb sync
  iommu/arm-smmu: add support for unmap a memory range with only one tlb
    sync

 drivers/iommu/arm-smmu-v3.c        | 52 ++++++++++++++++++++++++++++++++++----
 drivers/iommu/arm-smmu.c           | 10 ++++++++
 drivers/iommu/io-pgtable-arm-v7s.c | 32 +++++++++++++++--------
 drivers/iommu/io-pgtable-arm.c     | 30 ++++++++++++++--------
 drivers/iommu/io-pgtable.h         |  1 +
 5 files changed, 99 insertions(+), 26 deletions(-)

-- 
2.5.0
