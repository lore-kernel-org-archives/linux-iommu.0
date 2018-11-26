From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/9] iommu: rockchip: make it explicitly non-modular
Date: Mon, 26 Nov 2018 17:31:31 -0500
Message-ID: <1543271498-28966-3-git-send-email-paul.gortmaker@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Simon Xue <xxm@rock-chips.com>, linux-rockchip@lists.infradead.org, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
List-Id: iommu@lists.linux-foundation.org

The Kconfig currently controlling compilation of this code is:

drivers/iommu/Kconfig:config ROCKCHIP_IOMMU
drivers/iommu/Kconfig:  bool "Rockchip IOMMU Support"

...meaning that it currently is not being built as a module by anyone.

The bind/unbind/remove was already explicitly disabled in commit
98b72b94def9 ("iommu/rockchip: Prohibit unbind and remove").

Lets remove the remaining traces of  modular infrastructure, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Simon Xue <xxm@rock-chips.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/rockchip-iommu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ad3e2b97469e..c9ba9f377f63 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1,4 +1,9 @@
 /*
+ * IOMMU API for Rockchip
+ *
+ * Module Authors:	Simon Xue <xxm@rock-chips.com>
+ *			Daniel Kurtz <djkurtz@chromium.org>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -17,7 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
@@ -1281,7 +1286,6 @@ static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
@@ -1299,8 +1303,3 @@ static int __init rk_iommu_init(void)
 	return platform_driver_register(&rk_iommu_driver);
 }
 subsys_initcall(rk_iommu_init);
-
-MODULE_DESCRIPTION("IOMMU API for Rockchip");
-MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
-MODULE_ALIAS("platform:rockchip-iommu");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4
