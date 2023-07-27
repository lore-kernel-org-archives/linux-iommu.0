Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B167477
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 05:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690437069; x=1721973069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GLGfwzE0Y7wFUcyclBPwhDRKj0nvBYdZjZRsBpwb4Wc=;
  b=lPw0q4rzCSeYXGg9p3jPJIOs6UrakDvoiVtB1mAj5ZFyRS7F2HOY8CMe
   N1GZwwP1UETmsZwZE5BPvEi9fnUakjYj7veAuOEkVqQbErLoNhC/MuqYt
   eU6ZXgfCp0R9vBJAJGJOQCKPehDoh9/jJtxCaCDDIz0QEEXSzDZifosu1
   CzAxDlHm6OvtVW53mb/74rPWDUC/oTBCoCxvFYbwPcTE3MfqkVK882Hqx
   Qm720wuZZH/xkIWhIxPfvEcz5eSpsbP/7I7ghIGs/0QnuPYS1S2aHUeTp
   EcIYES0KkC3rTRipoi09awc6iCFsAdGgRCMDITMyc4iYMS/KQ3o+KU3/3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="399152555"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="399152555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 22:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="840585294"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="840585294"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2023 22:51:05 -0700
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
Subject: [PATCH v2 06/12] iommu: Make dev->fault_param static
Date: Thu, 27 Jul 2023 13:48:31 +0800
Message-Id: <20230727054837.147050-7-baolu.lu@linux.intel.com>
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

The iommu faults, including recoverable faults (IO page faults) and
unrecoverable faults (DMA faults), are generic to all devices. The
iommu faults could possibly be triggered for every device.

The fault_param pointer under struct dev_iommu is the per-device fault
data. Therefore, the fault_param pointer could be static and allocated
during iommu device probe and freed when the device is released.

With this done, the individual iommu drivers that support iopf have no
need to call iommu_[un]register_device_fault_handler() any more.
This will make it easier for the iommu drivers to support iopf, and it
will also make the fault_param allocation and free simpler.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 13 +------------
 drivers/iommu/intel/iommu.c                    | 18 ++++--------------
 drivers/iommu/iommu.c                          | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a5a63b1c947e..fa8ab9d413f8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -437,7 +437,6 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
 
 static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
 {
-	int ret;
 	struct device *dev = master->dev;
 
 	/*
@@ -450,16 +449,7 @@ static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
 	if (!master->iopf_enabled)
 		return -EINVAL;
 
-	ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
-	if (ret)
-		return ret;
-
-	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-	if (ret) {
-		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
-		return ret;
-	}
-	return 0;
+	return iopf_queue_add_device(master->smmu->evtq.iopf, dev);
 }
 
 static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
@@ -469,7 +459,6 @@ static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
 	if (!master->iopf_enabled)
 		return;
 
-	iommu_unregister_device_fault_handler(dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d5ca2387e65c..e94e833638a7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4587,23 +4587,14 @@ static int intel_iommu_enable_iopf(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-	if (ret)
-		goto iopf_remove_device;
-
 	ret = pci_enable_pri(pdev, PRQ_DEPTH);
-	if (ret)
-		goto iopf_unregister_handler;
+	if (ret) {
+		iopf_queue_remove_device(iommu->iopf_queue, dev);
+		return ret;
+	}
 	info->pri_enabled = 1;
 
 	return 0;
-
-iopf_unregister_handler:
-	iommu_unregister_device_fault_handler(dev);
-iopf_remove_device:
-	iopf_queue_remove_device(iommu->iopf_queue, dev);
-
-	return ret;
 }
 
 static int intel_iommu_disable_iopf(struct device *dev)
@@ -4630,7 +4621,6 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	 * fault handler and removing device from iopf queue should never
 	 * fail.
 	 */
-	WARN_ON(iommu_unregister_device_fault_handler(dev));
 	WARN_ON(iopf_queue_remove_device(iommu->iopf_queue, dev));
 
 	return 0;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4ba3bb692993..3e4ff984aa85 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -302,7 +302,15 @@ static int dev_iommu_get(struct device *dev)
 		return -ENOMEM;
 
 	mutex_init(&param->lock);
+	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
+	if (!param->fault_param) {
+		kfree(param);
+		return -ENOMEM;
+	}
+	mutex_init(&param->fault_param->lock);
+	INIT_LIST_HEAD(&param->fault_param->faults);
 	dev->iommu = param;
+
 	return 0;
 }
 
@@ -315,6 +323,12 @@ static void dev_iommu_free(struct device *dev)
 		fwnode_handle_put(param->fwspec->iommu_fwnode);
 		kfree(param->fwspec);
 	}
+	/*
+	 * All pending faults should have been drained before
+	 * device release.
+	 */
+	WARN_ON_ONCE(!list_empty(&param->fault_param->faults));
+	kfree(param->fault_param);
 	kfree(param);
 }
 
-- 
2.34.1

