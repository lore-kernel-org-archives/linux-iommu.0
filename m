From: Xudong Hao <xudong.hao@linux.intel.com>
Subject: [PATCH v2 1/1] intel-iommu: Add device info into list before doing
	context mapping
Date: Fri, 4 May 2012 09:26:55 +0800
Message-ID: <20120504012655.GA8468@hp-xd.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: dwmw2@infradead.org
Cc: chrisw@sous-sol.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, xiantao.zhang@intel.com, xudong.hao@intel.com
List-Id: iommu@lists.linux-foundation.org

Add device info into list before do context mapping, because device info will be
 used by iommu_enable_dev_iotlb function, in this function, pci_enable_ats would
 not be called without this patch.

Signed-off-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Xiantao Zhang <xiantao.zhang@intel.com>
Acked-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/iommu/intel-iommu.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f93d5ac..5fda348 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2286,12 +2286,6 @@ static int domain_add_dev_info(struct dmar_domain *domain,
    if (!info)
        return -ENOMEM;

-   ret = domain_context_mapping(domain, pdev, translation);
-   if (ret) {
-       free_devinfo_mem(info);
-       return ret;
-   }
-
    info->segment = pci_domain_nr(pdev->bus);
    info->bus = pdev->bus->number;
    info->devfn = pdev->devfn;
@@ -2304,6 +2298,17 @@ static int domain_add_dev_info(struct dmar_domain *domain,
    pdev->dev.archdata.iommu = info;
    spin_unlock_irqrestore(&device_domain_lock, flags);

+   ret = domain_context_mapping(domain, pdev, translation);
+   if (ret) {
+       spin_lock_irqsave(&device_domain_lock, flags);
+       list_del(&info->link);
+       list_del(&info->global);
+       pdev->dev.archdata.iommu = NULL;
+       spin_unlock_irqrestore(&device_domain_lock, flags);
+       free_devinfo_mem(info);
+       return ret;
+   }
+
    return 0;
 }

--
1.6.0.rc1
