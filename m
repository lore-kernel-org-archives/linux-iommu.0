Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE7C2E8
	for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 08:25:21 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.99,227,1677510000"; 
   d="scan'208";a="160810572"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Apr 2023 17:25:15 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 046AE40071E9;
	Wed, 26 Apr 2023 17:25:15 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] iommu/ipmmu-vmsa: Allow PCIe devices
Date: Wed, 26 Apr 2023 17:25:11 +0900
Message-Id: <20230426082511.3621484-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow PCIe devices, add a new condition whether the device is
a PCI device or not in the ipmmu_device_is_allowed().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v1:
 https://lore.kernel.org/all/20230421122538.3389336-1-yoshihiro.shimoda.uh@renesas.com/
 - Drop a condition in the ipmmu_attach_device().
 - Drop adding PCIe root devices into the devices_allowlist.
 - Use dev_is_pci() instead of using strcmp() in ipmmu_device_is_allowed().

 drivers/iommu/ipmmu-vmsa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f64c5c9f5b9..6efc99382edb 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -723,6 +724,10 @@ static bool ipmmu_device_is_allowed(struct device *dev)
 	if (soc_device_match(soc_denylist))
 		return false;
 
+	/* Check whether this device is a PCI device */
+	if (dev_is_pci(dev))
+		return true;
+
 	/* Check whether this device can work with the IPMMU */
 	for (i = 0; i < ARRAY_SIZE(devices_allowlist); i++) {
 		if (!strcmp(dev_name(dev), devices_allowlist[i]))
-- 
2.25.1

