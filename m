Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415552E64C
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885334; x=1727421334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2u453SswpKakc0NOsEhGqMN9HDyZwW3XZ2U2N48J7YQ=;
  b=LpX5yVnrsiZytHJrjd2QwN0pgz5nSCPN0stq1tysEP8jPpOu4Qt24VQy
   10x5wp0xwaAqHy5/2yE0QVjZ1K+i3Llm7wuEZdP13Rz2VW5pikk+mJWNC
   k22nwKw6AmHZf6lbAoInIHU16Wx52k+48d+0Ouucha6f65radNBpYIdof
   V9mFwpqnr9y5g7v0jSuVi2GJs9CZM/JK5f7vBL5sfA+Yo26MDmeLTWAxb
   G/gKTz5hwveB5gDBvya39XvjLk+A7x34rl1PSbuor27ZxH7+KC/lAoe88
   YyIBdv7PJt7j3t4B0b+9oA7lkU5hEsc5dTuTWNpmtnS132Nv4pRvKUB25
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="412914840"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="412914840"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:15:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="784601980"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="784601980"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2023 00:15:32 -0700
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
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH v2 2/6] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date: Thu, 28 Sep 2023 00:15:24 -0700
Message-Id: <20230928071528.26258-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928071528.26258-1-yi.l.liu@intel.com>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes IOMMUFD to use iommu_domain_alloc_user() for iommu_domain
creation as IOMMUFD needs to support iommu_domain allocation with
parameters from userspace in nested support. If the iommu driver
doesn't provide domain_alloc_user callback then IOMMUFD falls back to
use iommu_domain_alloc().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cf2c1504e20d..48874f896521 100644
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
 
@@ -88,10 +90,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
 
-	hwpt->domain = iommu_domain_alloc(idev->dev->bus);
-	if (!hwpt->domain) {
-		rc = -ENOMEM;
-		goto out_abort;
+	if (ops->domain_alloc_user) {
+		hwpt->domain = ops->domain_alloc_user(idev->dev, 0);
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

