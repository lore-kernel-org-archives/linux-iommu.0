From: Luis de Bethencourt <luisbg@kernel.org>
Subject: [PATCH] iommu/vt-d: Fix trailing semicolon
Date: Wed, 17 Jan 2018 18:19:26 +0000
Message-ID: <20180117181926.12862-1-luisbg@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Luis de Bethencourt <luisbg@kernel.org>
List-Id: iommu@lists.linux-foundation.org

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 88a54a0a5f92..67bd4b56e2d9 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -193,7 +193,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
 			 * for example, an "address" value of 0x12345f000 will
 			 * flush from 0x123440000 to 0x12347ffff (256KiB). */
 			unsigned long last = address + ((unsigned long)(pages - 1) << VTD_PAGE_SHIFT);
-			unsigned long mask = __rounddown_pow_of_two(address ^ last);;
+			unsigned long mask = __rounddown_pow_of_two(address ^ last);
 
 			desc.high = QI_DEV_EIOTLB_ADDR((address & ~mask) | (mask - 1)) | QI_DEV_EIOTLB_SIZE;
 		} else {
-- 
2.15.1
