Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990E75663
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553404; x=1708089404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sEeJE3lb+SBSL58VtACxqpXosFpusquhp6qgy5s/iGw=;
  b=T1XUAA3MWPFDgdtiknMKjYTjsN67QMu1fm75Ss7Fo18F1unez2T5iiYf
   0Dwfu8Ql44DkonqeguWvUqWnsqh64swH4Lbqoj+6EK9oGdn4i/jSO7c0q
   qLlW4bW1Th5zV1dVi8IWmE4PtCur+a6E9QYbYBVj9WAXcGqJeb1u3XO9M
   TlFLt0o7weXbZ6Zz3GazEVRNySsxhnda+pXmkJ+LQwE4uKD2BUq0CeiXW
   JGrvwesUcJOPsrdY6fcFSsYBXZa2WjF2fMjP/bqwGV90HiyEdxMtM3XKV
   v9h96zAuXhT4AhhmHqxwFKkz5uZ5MWV+4ECLcrY2RZ3H5XnjxNb+tV/gG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333883297"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="333883297"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="647674924"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="647674924"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 16 Feb 2023 05:16:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Tina Zhang <tina.zhang@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/vt-d: Fix error handling in sva enable/disable paths
Date: Thu, 16 Feb 2023 21:08:13 +0800
Message-Id: <20230216130816.151824-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216130816.151824-1-baolu.lu@linux.intel.com>
References: <20230216130816.151824-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Roll back all previous actions in error paths of intel_iommu_enable_sva()
and intel_iommu_disable_sva().

Fixes: d5b9e4bfe0d8 ("iommu/vt-d: Report prq to io-pgfault framework")
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230208051559.700109-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..994dffa1db57 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4642,8 +4642,12 @@ static int intel_iommu_enable_sva(struct device *dev)
 		return -EINVAL;
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-	if (!ret)
-		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		return ret;
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return ret;
 }
@@ -4655,8 +4659,12 @@ static int intel_iommu_disable_sva(struct device *dev)
 	int ret;
 
 	ret = iommu_unregister_device_fault_handler(dev);
-	if (!ret)
-		ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
+	if (ret)
+		return ret;
+
+	ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
+	if (ret)
+		iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
 
 	return ret;
 }
-- 
2.34.1

