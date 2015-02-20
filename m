From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] iommu/io-pgtable-arm: Add built time dependency
Date: Fri, 20 Feb 2015 19:44:45 +0100
Message-ID: <20150220194445.4225d56b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

If io-pgtable-arm is an ARM-specific driver then configuration option
IOMMU_IO_PGTABLE_LPAE should not be presented to the user by default
for non-ARM kernels.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-3.20-rc0.orig/drivers/iommu/Kconfig	2015-02-20 17:24:46.838955014 +0100
+++ linux-3.20-rc0/drivers/iommu/Kconfig	2015-02-20 19:38:45.804582668 +0100
@@ -23,6 +23,7 @@ config IOMMU_IO_PGTABLE
 config IOMMU_IO_PGTABLE_LPAE
 	bool "ARMv7/v8 Long Descriptor Format"
 	select IOMMU_IO_PGTABLE
+	depends on ARM || COMPILE_TEST
 	help
 	  Enable support for the ARM long descriptor pagetable format.
 	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page


-- 
Jean Delvare
SUSE L3 Support
