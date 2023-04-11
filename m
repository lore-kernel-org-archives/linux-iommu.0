Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB65211C
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195705; x=1712731705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDMJTalig0nzuhTIrI4QQ+mFyR3+Py8XwH5/FAztKD8=;
  b=lujSkFGO4rN2RBWdcYIA2ibkiiSLA5bS9zrJYiFfn2heyOSUL3RSqMmK
   TeCaTfFmw0PtX69cvjilu1ZgCc7ifHqdd19569hNnFm2csdyqkZVFtCSC
   wL8+WZkX1f1vTo2tZOcE35J7Qt+N7EK7pAShIfXiqH4vN3TPhDsnTOAK5
   aZ65CVy3n4uvOAkFzeDChQW0/oKElYmOVOPD18qkzWu8UPbrLrJj2W6om
   RAZfnJxUZ1LQlSJrrlEnQ+3JIe5rFKoyZU2ud30h2n0nrtjtQbSoGCzZY
   FkIMD9+LjHJXfsdPqQgcCm9M65076fNoCqkHLORExHvPYIKy7RTZz9fwY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028541"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028541"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256574"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256574"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] iommu/vt-d: Remove unnecessary checks in iopf disabling path
Date: Tue, 11 Apr 2023 14:48:04 +0800
Message-Id: <20230411064815.31456-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_unregister_device_fault_handler() and iopf_queue_remove_device()
are called after device has stopped issuing new page falut requests and
all outstanding page requests have been drained. They should never fail.
Trigger a warning if it happens unfortunately.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cd3a3c4b5e64..c771233d6f2a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4707,7 +4707,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
-	int ret;
 
 	if (!info->pri_enabled)
 		return -EINVAL;
@@ -4723,15 +4722,15 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	pci_disable_pri(to_pci_dev(dev));
 	info->pri_enabled = 0;
 
-	ret = iommu_unregister_device_fault_handler(dev);
-	if (ret)
-		return ret;
-
-	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
-	if (ret)
-		iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	/*
+	 * With PRI disabled and outstanding PRQs drained, unregistering
+	 * fault handler and removing device from iopf queue should never
+	 * fail.
+	 */
+	WARN_ON(iommu_unregister_device_fault_handler(dev));
+	WARN_ON(iopf_queue_remove_device(iommu->iopf_queue, dev));
 
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.34.1

