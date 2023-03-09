Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397AA5B
	for <iommu@lists.linux.dev>; Thu,  9 Mar 2023 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349374; x=1709885374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aeM9wYEQtVfENpenMofCYElwE3QfNhdny2a0DT1ZPjw=;
  b=KEjW6vB8s6mYToqhz1b6rmmVuJSROeSZjStZZKUd2rpgXv7TJuNfjBWY
   WExe93/ZtNzXT6GswNH0ulLuFevIpIf6MPUXqNp5zu2kAIB0GB5WgYaik
   FXWU50ukIFTBkX3IT5vBozKeQs5MT5QLX5uLb+k/pcccAfsJNOq2ypq4l
   2e/c0pIyhI2uZhhB9uo6Xv7z2Bvte6MsV72Q4XYmIOdPRno7ShhhMAvQS
   SV6/oR0EqC1oxNSDpY2XzdcpkuR2ZE1IMt4NwHA/rEuT8yzspMV7BPo5Z
   U7UcXjxOLX22f/a1OQVzIUT6yeEwD296vyW8jU1zaBlL+iIVRTit0+HVR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364023034"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364023034"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787471362"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787471362"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 09 Mar 2023 00:09:23 -0800
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH 03/12] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date: Thu,  9 Mar 2023 00:09:01 -0800
Message-Id: <20230309080910.607396-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309080910.607396-1-yi.l.liu@intel.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This converts IOMMUFD to use iommu_domain_alloc_user() for iommu_domain
creation.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 13bdab4c801b..84b4a11e62f8 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -5,6 +5,7 @@
 #include <linux/iommu.h>
 #include <uapi/linux/iommufd.h>
 
+#include "../iommu-priv.h"
 #include "iommufd_private.h"
 
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
@@ -55,6 +56,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach)
 {
+	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
@@ -69,7 +71,10 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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

