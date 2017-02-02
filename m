From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iommu: mtk: remove bogus 'select' statements
Date: Thu,  2 Feb 2017 15:29:03 +0100
Message-ID: <20170202142921.3467470-1-arnd@arndb.de>
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
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, Honghui Zhang <honghui.zhang@mediatek.com>, Andy Fleming <afleming@gmail.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

The mediatek IOMMU driver enables some drivers that it does not directly
rely on, and that causes a warning for build testing:

warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_VDECSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)
warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)
warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_MMSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)

This removes the select statements.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index bb537d06d319..8b6fd8928819 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -352,9 +352,6 @@ config MTK_IOMMU_V1
 	select IOMMU_API
 	select MEMORY
 	select MTK_SMI
-	select COMMON_CLK_MT2701_MMSYS
-	select COMMON_CLK_MT2701_IMGSYS
-	select COMMON_CLK_MT2701_VDECSYS
 	help
 	  Support for the M4U on certain Mediatek SoCs. M4U generation 1 HW is
 	  Multimedia Memory Managememt Unit. This option enables remapping of
-- 
2.9.0
