From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/3] drivers: iommu: declare iommu_gather_ops structures as const
Date: Tue, 25 Oct 2016 23:36:09 +0530
Message-ID: <1477418772-12184-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, julia.lawall@lip6.fr
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Constify iommu_gather_ops structures and replace __initdata with
__initconst where needed.

Bhumika Goyal (3):
  drivers: iommu: arm-smmu: constify iommu_gather_ops structures
  drivers: iommu: arm-smmu-v3: constify iommu_gather_ops structures
  drivers: iommu: io-pgtable-arm: use const and __initconst for
    iommu_gather_ops structures

 drivers/iommu/arm-smmu-v3.c    | 2 +-
 drivers/iommu/arm-smmu.c       | 2 +-
 drivers/iommu/io-pgtable-arm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
