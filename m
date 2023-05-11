Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99856629
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683815929; x=1715351929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oxvupeqb12UC7Ej2KuinDMGVCV9GTwjqOvc7w7xUds=;
  b=C1IUoDSgyCrki/vVq0KUyk1f/1JaQQGtHR3q18+jI//Q4ox/medEsVvc
   /EhU9a0G/+gPjzDNIOUCvNXWWOKzHjPdMtO0S3WR34SjGaeSpJ2d4oWOJ
   BVitesRaGEU3wN9gOrzd/DxtNhTIdo+SWoYVVT06L6acHvAdr0eAuTSXQ
   2ix5QNKqbb3gJVgXwwBQH4IvlZ0X/Eokn39Ev4g5aByyZA6Lu972g1YWO
   xp/3p54/2jfO9DBykf3NnxyvmoPcK0A7Nw6s7lqhzSqu9VKQn42Glardz
   aqG1TjINlCc07+Y4Py0vqJ29odV/713TQWBt+h8vxEtCMo/0OG92dMLyL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="339812876"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="339812876"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730382611"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730382611"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 07:38:48 -0700
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
Subject: [PATCH v2 03/11] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date: Thu, 11 May 2023 07:38:36 -0700
Message-Id: <20230511143844.22693-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511143844.22693-1-yi.l.liu@intel.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index cf2c1504e20d..b6323ad9c32d 100644
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
 
@@ -88,7 +90,10 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
 
-	hwpt->domain = iommu_domain_alloc(idev->dev->bus);
+	if (ops->domain_alloc_user)
+		hwpt->domain = ops->domain_alloc_user(idev->dev, NULL, NULL);
+	else
+		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
 	if (!hwpt->domain) {
 		rc = -ENOMEM;
 		goto out_abort;
-- 
2.34.1

