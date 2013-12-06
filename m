From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch Part1 V2 06/20] iommu/vt-d, trivial: print correct domain id of static identity domain
Date: Fri,  6 Dec 2013 11:21:09 +0800
Message-ID: <1386300083-6882-7-git-send-email-jiang.liu@linux.intel.com>
References: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386300083-6882-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ashok Raj <ashok.raj@intel.com>, Yijing Wang <wangyijing@huawei.com>, Jiri Kosina <trivial@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Field si_domain->id is set by iommu_attach_domain(), so we could only
print domain id for static identity domain after calling
iommu_attach_domain(si_domain, iommu).

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 70bc071..68bce9d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2246,8 +2246,6 @@ static int __init si_domain_init(int hw)
 	if (!si_domain)
 		return -EFAULT;
 
-	pr_debug("Identity mapping domain is domain %d\n", si_domain->id);
-
 	for_each_active_iommu(iommu, drhd) {
 		ret = iommu_attach_domain(si_domain, iommu);
 		if (ret) {
@@ -2262,6 +2260,7 @@ static int __init si_domain_init(int hw)
 	}
 
 	si_domain->flags = DOMAIN_FLAG_STATIC_IDENTITY;
+	pr_debug("Identity mapping domain is domain %d\n", si_domain->id);
 
 	if (hw)
 		return 0;
-- 
1.7.10.4
