Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759B107A5
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692188049; x=1723724049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fs7dLcn9YCMAf2UdUhEZTXtznwbetIf5y0nygEREgKs=;
  b=JWc++yAP2WXFZUPyWpQiRyX9tFO/Up2UPIF4mWWQ8KThT0kOmflD9tQ8
   /NARKqZIwPCHRqNegu/BxNFZvASsVPBKR6Kl+MSp4ueQO44HmWlpzZcOv
   iDn5ONLezKmG06YTSq3R/n38I9SSroNk7ivq4wPfeB3Fairwxr1ABP9ru
   DqUjxKK+KSRwjcT+CXiNnc+z7gHJeovyzi3s6yuB9YTr5VxZBcFMR3VZR
   zFTkuYC6CxIRu7/4xLBp140ooVuWaCu+wN274FJ+FXwcymfU74CyWkGKH
   PIiJY0YOLJMNsBFbnlfvZiEaUJPFEmowRlqtfxEf5IUmcBF2x19N/hu/9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436411618"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="436411618"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727730752"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="727730752"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2023 05:14:07 -0700
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
Subject: [PATCH v8 1/5] iommu: Move dev_iommu_ops() to private header
Date: Wed, 16 Aug 2023 05:13:45 -0700
Message-Id: <20230816121349.104436-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816121349.104436-1-yi.l.liu@intel.com>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_iommu_ops() is essentially only used in iommu subsystem, so move to a
private header to avoid being abused by other drivers.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu-priv.h | 11 +++++++++++
 include/linux/iommu.h      | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index e3e3b2015854..2024a2313348 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -6,6 +6,17 @@
 
 #include <linux/iommu.h>
 
+static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
+{
+	/*
+	 * Assume that valid ops must be installed if iommu_probe_device()
+	 * has succeeded. The device ops are essentially for internal use
+	 * within the IOMMU subsystem itself, so we should be able to trust
+	 * ourselves not to misuse the helper.
+	 */
+	return dev->iommu->iommu_dev->ops;
+}
+
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d31642596675..e0245aa82b75 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -450,17 +450,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
-static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
-{
-	/*
-	 * Assume that valid ops must be installed if iommu_probe_device()
-	 * has succeeded. The device ops are essentially for internal use
-	 * within the IOMMU subsystem itself, so we should be able to trust
-	 * ourselves not to misuse the helper.
-	 */
-	return dev->iommu->iommu_dev->ops;
-}
-
 extern int bus_iommu_probe(const struct bus_type *bus);
 extern bool iommu_present(const struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
-- 
2.34.1

