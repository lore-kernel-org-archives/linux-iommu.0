From: Nikola Pajkovsky <npajkovs@redhat.com>
Subject: [PATCH] amd_iommu_init: remove __init from amd_iommu_erratum_746_workaround
Date: Tue, 26 Feb 2013 16:12:05 +0100
Message-ID: <a6e63dc6f1bdc2d20f3d7d07a5d878e9c1b01d85.1361891160.git.npajkovs@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

commit 318fe78 ("IOMMU, AMD Family15h Model10-1Fh erratum 746 Workaround")
added amd_iommu_erratum_746_workaround and it's marked as __init, which is wrong

WARNING: drivers/iommu/built-in.o(.text+0x639c): Section mismatch in reference from the function iommu_init_pci() to the function .init.text:amd_iommu_erratum_746_workaround()
The function iommu_init_pci() references
the function __init amd_iommu_erratum_746_workaround().
This is often because iommu_init_pci lacks a __init
annotation or the annotation of amd_iommu_erratum_746_workaround is wrong.

Signed-off-by: Nikola Pajkovsky <npajkovs@redhat.com>
---
 drivers/iommu/amd_iommu_init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index faf10ba..9761a4f 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -980,7 +980,7 @@ static void __init free_iommu_all(void)
  *     BIOS should disable L2B micellaneous clock gating by setting
  *     L2_L2B_CK_GATE_CONTROL[CKGateL2BMiscDisable](D0F2xF4_x90[2]) = 1b
  */
-static void __init amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
+static void amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
 {
 	u32 value;
 
-- 
1.7.1
