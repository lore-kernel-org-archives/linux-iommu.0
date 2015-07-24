From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] iommu: avoid format string leaks into iommu_device_create
Date: Fri, 24 Jul 2015 16:27:57 -0700
Message-ID: <20150724232757.GA14747@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

This makes sure it won't be possible to accidentally leak format
strings into iommu device names. Current name allocations are safe,
but this makes the "%s" explicit.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/iommu/dmar.c        | 2 +-
 drivers/iommu/intel-iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index c9db04d4ef39..8757f8dfc4e5 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1068,7 +1068,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	if (intel_iommu_enabled)
 		iommu->iommu_dev = iommu_device_create(NULL, iommu,
 						       intel_iommu_groups,
-						       iommu->name);
+						       "%s", iommu->name);
 
 	return 0;
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0649b94f5958..0be23c589d3b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4533,7 +4533,7 @@ int __init intel_iommu_init(void)
 	for_each_active_iommu(iommu, drhd)
 		iommu->iommu_dev = iommu_device_create(NULL, iommu,
 						       intel_iommu_groups,
-						       iommu->name);
+						       "%s", iommu->name);
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	bus_register_notifier(&pci_bus_type, &device_nb);
-- 
1.9.1


-- 
Kees Cook
Chrome OS Security
