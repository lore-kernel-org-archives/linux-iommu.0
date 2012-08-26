From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] iommu/amd: remove duplicated include from amd_iommu_init.c
Date: Sun, 26 Aug 2012 09:51:15 +0800
Message-ID: <CAPgLHd9NxLd3m_s9KqF5P-n9BACgE2Nj=xCL-+0tkEuG-ZwGnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg.roedel@amd.com
Cc: yongjun_wei@trendmicro.com.cn, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iommu/amd_iommu_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 0a2ea31..1292b5a 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -26,7 +26,6 @@
 #include <linux/msi.h>
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
-#include <linux/acpi.h>
 #include <acpi/acpi.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
