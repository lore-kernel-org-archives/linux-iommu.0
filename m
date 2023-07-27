Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FB7477
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 05:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690437065; x=1721973065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rapigetQWIYey116Fahotdb3UUfJeYnWhEFac994Gac=;
  b=XLZ4YDQwhKEEhN5p6gbNKxAb1+1ATQ6hjvivwzzj5ct67gOp93SWL4w0
   q11cd0oUA98qwLBiETCW3FBwP57m0VSpmEazreN2BtDWsKzC1H+mBK2xw
   +XR9DVBrILB6vwbq5I9JrhhgudqxvHYq4jWgEqlux/efPqIxzxw3RZ3sH
   m943kBmJXAhlxtxYFpTAoqcWYTXWvuR0+HnkFvfbCYYcqGP1OaN12gLwg
   I3a+G+e2jaQAVFeU28kdI8L9qFd96fCuyEHkVcjiXTxWTdw5h42YwHfO0
   fMGFY1GjsOgIvi226gM/AGawBstwJ9NggHXrtZpIW5VVzP4bCKp1+pKBl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399152538"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399152538"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840585289"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840585289"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2023 22:51:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 05/12] iommu: Change the return value of dev_iommu_get()
Date: Thu, 27 Jul 2023 13:48:30 +0800
Message-Id: <20230727054837.147050-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727054837.147050-1-baolu.lu@linux.intel.com>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make dev_iommu_get() return 0 for success and error numbers for failure.
This will make the code neat and readable. No functionality changes.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 00309f66153b..4ba3bb692993 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -290,20 +290,20 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
-static struct dev_iommu *dev_iommu_get(struct device *dev)
+static int dev_iommu_get(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
 
 	if (param)
-		return param;
+		return 0;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
 	if (!param)
-		return NULL;
+		return -ENOMEM;
 
 	mutex_init(&param->lock);
 	dev->iommu = param;
-	return param;
+	return 0;
 }
 
 static void dev_iommu_free(struct device *dev)
@@ -346,8 +346,9 @@ static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
+	ret = dev_iommu_get(dev);
+	if (ret)
+		return ret;
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -2743,12 +2744,14 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int ret;
 
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
+	ret = dev_iommu_get(dev);
+	if (ret)
+		return ret;
 
 	/* Preallocate for the overwhelmingly common case of 1 ID */
 	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
-- 
2.34.1

