Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81328EB
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676627777; x=1708163777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svzPQoaIiOVo1++kdQiL9mjZd3QRrwDo4zYQS1l6NZs=;
  b=oC79neqPbAOIBG61OSaNlie66MCpHcqYQ3VTlGHLmqFHmFogM4zpeJr9
   2MMaILIUisIlkgWTB/F5VPAWSQaKogkM+pQ5ea72JBmntg0k31e/+RJHL
   qUauYFJdUpXxzw+XIcQ0MxStfGgpV8wuunhKtdfCqc/kL16yGkFdTXTFZ
   XekHCHMyKtf7KtaNQckOGaMalbPBhfq0E9afUPRtV7ZrAOQLs2mQV0D7L
   khp0eiHepOvhNrUsiqKMuVDoj+nQcB674L6aGT1JTD9iftjXLJH/5/hjk
   xkj7B+mCPoZW3fE5ZbsQzGZaJ/DabE6Yo1k7S/RiMO09HYfg0db0fzEXm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331955233"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="331955233"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 01:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999391225"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999391225"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2023 01:56:13 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/6] iommu: Same critical region for device release and removal
Date: Fri, 17 Feb 2023 17:47:33 +0800
Message-Id: <20230217094736.159005-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217094736.159005-1-baolu.lu@linux.intel.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a non-driver context, it is crucial to ensure the consistency of a
device's iommu ops. Otherwise, it may result in a situation where a
device is released but it's iommu ops are still used.

Put the ops->release_device and __iommu_group_remove_device() in a some
group->mutext critical region, so that, as long as group->mutex is held
and the device is in its group's device list, its iommu ops are always
consistent.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6247883991e2..093692308b80 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -101,6 +101,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static struct group_device *
+__iommu_group_remove_device(struct iommu_group *group, struct device *dev);
+static void __iommu_group_release_device(struct iommu_group *group,
+					 struct group_device *grp_dev);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -466,18 +470,25 @@ int iommu_probe_device(struct device *dev)
 
 void iommu_release_device(struct device *dev)
 {
+	struct iommu_group *group = dev->iommu_group;
+	struct group_device *device;
 	const struct iommu_ops *ops;
 
-	if (!dev->iommu)
+	if (!dev->iommu || !group)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	mutex_lock(&group->mutex);
 	ops = dev_iommu_ops(dev);
 	if (ops->release_device)
 		ops->release_device(dev);
+	device = __iommu_group_remove_device(group, dev);
+	mutex_unlock(&group->mutex);
+
+	if (device)
+		__iommu_group_release_device(group, device);
 
-	iommu_group_remove_device(dev);
 	module_put(ops->owner);
 	dev_iommu_free(dev);
 }
-- 
2.34.1

