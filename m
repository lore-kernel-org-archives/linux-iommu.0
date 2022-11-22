Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C57E
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 00:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669077419; x=1700613419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9iAPzEu2PlT22fqsgpaH64fRtTDWJ2ZYYPwO3Bv5IQ=;
  b=VWN2xx1zo7b0N/sJRnmbNfSzl1ffaABRd2XsNhrG3RT5VLmpdlWqmrEK
   bcXsvCu01i8fJlLgR1OIZuN3HxmwGEqdB7IcJnVFoRbi/hLnL1fbEi4y0
   EaPvXy83pmV5c9VOpbrNQxfISq5f5KUHtHvyGxEHWR4mO47FpOP6uqwh6
   K1kF0ryK8FFRUwQ1aFTzcr2IIIzkgDzY/6grpmfOOn6Lu7vCQsCixus1K
   CHBf7NlfoJTdEqw3MTyCAKARr8uPGdvovVIQ0GLugiKacGc6/N1XiTNPo
   WdJGqfEHuIvO+pg21ZFpffniVux5oUfh9oJpFlWdAS8Q4myYe0CS4HJM1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="297052081"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="297052081"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 16:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="619018425"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="619018425"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 21 Nov 2022 16:36:58 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iommu/vt-d: Rename iommu_disable_dev_iotlb()
Date: Tue, 22 Nov 2022 08:29:46 +0800
Message-Id: <20221122002949.148140-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122002949.148140-1-baolu.lu@linux.intel.com>
References: <20221122002949.148140-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename iommu_disable_dev_iotlb() to iommu_disable_pci_caps() to pair with
iommu_enable_pci_caps().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20221118132451.114406-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 603332740bc3..e814ddb84bbf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1441,7 +1441,7 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	}
 }
 
-static void iommu_disable_dev_iotlb(struct device_domain_info *info)
+static void iommu_disable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -4099,7 +4099,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
 
-		iommu_disable_dev_iotlb(info);
+		iommu_disable_pci_caps(info);
 		domain_context_clear(info);
 	}
 
@@ -4122,7 +4122,7 @@ static void device_block_translation(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	unsigned long flags;
 
-	iommu_disable_dev_iotlb(info);
+	iommu_disable_pci_caps(info);
 	if (!dev_is_real_dma_subdevice(dev)) {
 		if (sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, dev,
-- 
2.34.1

