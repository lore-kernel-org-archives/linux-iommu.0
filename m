From: Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
Subject: [PATCH] iommu: io-pgtable: fixed a brace coding style issue.
Date: Sun, 13 Mar 2016 02:17:27 +0200
Message-ID: <1457828247-24366-1-git-send-email-gabrielcsmo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Fixed a coding style issue.

Signed-off-by: Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
---
 drivers/iommu/io-pgtable.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6f2e319..a4a9a42 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -25,8 +25,7 @@
 #include "io-pgtable.h"
 
 static const struct io_pgtable_init_fns *
-io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
-{
+io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE
 	[ARM_32_LPAE_S1] = &io_pgtable_arm_32_lpae_s1_init_fns,
 	[ARM_32_LPAE_S2] = &io_pgtable_arm_32_lpae_s2_init_fns,
-- 
1.9.1
