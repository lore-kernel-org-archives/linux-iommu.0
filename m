Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7063A
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917129; x=1707453129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RfT4R/xTBwZsk8AEoHLAHBvK4hYBuXf+5pIwXQ6TqQw=;
  b=hA5n1+btbbyPLNsob+UyARuL4PEejSGpX5X1CngwFxb7ZNwc1pJGxYA2
   guxNIdkHem6zdPbFHwEIuIXL1bYPW41axcaD4hOT1+bnfGcg7ekdvyU14
   S10+bj5jRbmo/BGUr0Ffdn0aJ6Xfb8uudspdhCAxi9e7ev3iWZO0z1NPI
   edaXxOo6hcUMCoc8cojeQepl5z42AbsbFfDTSMUuZUWvYNVuS6JyO7ddt
   4gkWMvbXDuLMIu094QrnMOTauG+ya6285o6/2ezEtfn+MzDSMkq8FpQN+
   v7/u8N/GqVvVojuDykkwnEEO0cRzMe4uywjheHQugtiSXCIXJTrVKYq+V
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298695"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298695"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447517"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447517"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:08 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
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
	baolu.lu@linux.intel.com
Subject: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
Date: Wed,  8 Feb 2023 20:31:42 -0800
Message-Id: <20230209043153.14964-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This converts iommufd to use iommu_domain_alloc_user() for iommu_domain
creation.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 43d473989a06..08d963ee38c7 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -30,6 +30,7 @@ struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev)
 {
+	const struct iommu_ops *ops;
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
@@ -37,7 +38,13 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt))
 		return hwpt;
 
-	hwpt->domain = iommu_domain_alloc(dev->bus);
+	ops = dev_iommu_ops(dev);
+	if (!ops || !ops->domain_alloc_user) {
+		rc = -EOPNOTSUPP;
+		goto out_abort;
+	}
+
+	hwpt->domain = ops->domain_alloc_user(dev, NULL, NULL);
 	if (!hwpt->domain) {
 		rc = -ENOMEM;
 		goto out_abort;
-- 
2.34.1

