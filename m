From: <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/1] iommu/amd: Fix PASID format in INVALIDATE_IOTLB_PAGES command
Date: Wed, 26 Feb 2014 15:49:31 -0600
Message-ID: <1393451371-17894-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, joro@8bytes.org
Cc: linux-kernel@vger.kernel.org, Jay Cornwall <jay.cornwall@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Jay Cornwall <jay.cornwall@amd.com>

This patch corrects the PASID format in the INVALIDATE_IOTLB_PAGES
command, which was caused by incorrect information in
the AMD IOMMU Architectural Specification v2.01 document.

    Incorrect format:
         cmd->data[0][16:23] = PASID[7:0]
         cmd->data[1][16:27] = PASID[19:8]

     Correct format:
         cmd->data[0][16:23] = PASID[15:8]
         cmd->data[1][16:23] = PASID[7:0]

However, this does not affect the IOMMUv2 hardware implementation,
and has been corrected since version 2.02 of the specification
(available through AMD NDA).

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index faf0da4..1dd9f81 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -982,10 +982,10 @@ static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int pasid,
 	address &= ~(0xfffULL);
 
 	cmd->data[0]  = devid;
-	cmd->data[0] |= (pasid & 0xff) << 16;
+	cmd->data[0] |= ((pasid >> 8) & 0xff) << 16;
 	cmd->data[0] |= (qdep  & 0xff) << 24;
 	cmd->data[1]  = devid;
-	cmd->data[1] |= ((pasid >> 8) & 0xfff) << 16;
+	cmd->data[1] |= (pasid & 0xff) << 16;
 	cmd->data[2]  = lower_32_bits(address);
 	cmd->data[2] |= CMD_INV_IOMMU_PAGES_GN_MASK;
 	cmd->data[3]  = upper_32_bits(address);
-- 
1.8.1.2
