From: James Dong <xmdong@google.com>
Subject: [PATCH] iommu/vt-d: Handle hotplug devices' default identity mapping setting
Date: Fri, 22 Feb 2019 02:44:55 +0000
Message-ID: <20190222024455.20802-1-xmdong@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, James Dong <xmdong@google.com>, Jis Ben <jisben@google.com>
List-Id: iommu@lists.linux-foundation.org

With specific Linux command line option such as "iommu=pt", some types
of hotplug devices will be assigned to the static 1:1 iommu domain by
default during kernel init.

If such a hotplug device is rescanned after being removed, for example,
with following sample commands:
  echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove
  echo 1 > /sys/bus/pci/rescan
, an iommu group for this hotplug device will be added without attaching
it to the default static 1:1 domain. As a result, this device's I/O
operation won't work.

Keep hotplug devices with default static 1:1 iommu mapping in their default
domain after such hotplug devices are rescanned.

Signed-off-by: James Dong <xmdong@google.com>
Reported-by: Jis Ben <jisben@google.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..4b02949e58ca 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5230,6 +5230,7 @@ static int intel_iommu_add_device(struct device *dev)
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
 	u8 bus, devfn;
+	int ret = 0;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -5242,8 +5243,19 @@ static int intel_iommu_add_device(struct device *dev)
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
+	if (!iommu_group_default_domain(group) &&
+	    !find_domain(dev) && iommu_should_identity_map(dev, 0)) {
+		ret = domain_add_dev_info(si_domain, dev);
+		if (!ret)
+			pr_info("identity mapping for device %s\n",
+				dev_name(dev));
+		else
+			pr_info("identity mapping failed (%d) for device %s\n",
+				ret, dev_name(dev));
+	}
+
 	iommu_group_put(group);
-	return 0;
+	return ret;
 }
 
 static void intel_iommu_remove_device(struct device *dev)
-- 
2.21.0.rc0.258.g878e2cd30e-goog
