Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6D53A6
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196653; x=1721732653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aAXUsuyKGGbCpXCaUQCKZMtfjXOAaLwSJ/Ehi0NXy/Q=;
  b=B47ozanK+M5x6JoypzENwk7fB0PqaMF71Je77AZnu9m2BkO3F9bbUPFZ
   ZvXNrF20Jpq8i4uwnZrMB1g+7xxIdxOGe8cwtiume7p6I1D6Or669Rwxy
   AjQL2UhjyVEh9u+K+NPpxFYCXfA+UPRl3vf39VjHYh213LZOltugBIr7/
   5i7Bthafj72xkEXdadErDRWfncRoMtptkJPH/eW10m+rGObn5Tbc3WZJj
   fESUy0/6wJQfor5pdpFfFAmuWBLgRXLVf0bu7oxSsLrTZbCrs77gN+O7q
   216txGzV/0xx9Ic4via5ZDIYqHJdpN/3MxgqbEetrVPLBMyM0HsmD4b0F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013251"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013251"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775772"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775772"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:12 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com,
	baolu.lu@linux.intel.com
Cc: cohuck@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	peterx@redhat.com,
	jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com,
	lulu@redhat.com,
	suravee.suthikulpanit@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com
Subject: [PATCH v3 03/17] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date: Mon, 24 Jul 2023 04:03:52 -0700
Message-Id: <20230724110406.107212-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes IOMMUFD to use iommu_domain_alloc_user() for iommu_domain
creation as IOMMUFD needs to support iommu_domain allocation with
parameters from userspace in nesting support. If the iommu driver
doesn't provide domain_alloc_user callback then it falls back to use
iommu_domain_alloc().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cf2c1504e20d..1371e96653b2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -5,6 +5,7 @@
 #include <linux/iommu.h>
 #include <uapi/linux/iommufd.h>
 
+#include "../iommu-priv.h"
 #include "iommufd_private.h"
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
@@ -74,6 +75,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach)
 {
+	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
@@ -88,10 +90,21 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
 
-	hwpt->domain = iommu_domain_alloc(idev->dev->bus);
-	if (!hwpt->domain) {
-		rc = -ENOMEM;
-		goto out_abort;
+	if (ops->domain_alloc_user) {
+		hwpt->domain = ops->domain_alloc_user(idev->dev,
+						      IOMMU_HWPT_TYPE_DEFAULT,
+						      NULL, NULL);
+		if (IS_ERR(hwpt->domain)) {
+			rc = PTR_ERR(hwpt->domain);
+			hwpt->domain = NULL;
+			goto out_abort;
+		}
+	} else {
+		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
+		if (!hwpt->domain) {
+			rc = -ENOMEM;
+			goto out_abort;
+		}
 	}
 
 	/*
-- 
2.34.1

