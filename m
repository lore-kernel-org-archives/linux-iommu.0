From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] iommu/exynos: Modify error handling
Date: Mon, 1 Aug 2016 11:48:38 +0530
Message-ID: <20160801061838.GA17805@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: joro@8bytes.org, kgene@kernel.org, k.kozlowski@samsung.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: iommu@lists.linux-foundation.org

of_platform_device_create returns NULL on error so an IS_ERR test is
incorrect here and a NULL check is required.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression e;
@@

  e = of_platform_device_create(...);
if(
-    IS_ERR(e)
+    !e
    )
    {
  <+...
  return
- PTR_ERR(e)
+ -ENODEV
  ;
  ...+>
  }

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 97c41b8..2888bbf 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1242,8 +1242,8 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
 		exynos_iommu_init();
 
 	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	if (!pdev)
+		return -ENODEV;
 
 	of_iommu_set_ops(np, &exynos_iommu_ops);
 	return 0;
-- 
1.9.1
