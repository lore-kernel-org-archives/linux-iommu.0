Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB218AE4
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707701362; cv=none; b=RWuQXbYtSm6PLV8vD68dkf+MMISfiU97URpyzngPQ5dcsE8zDgB/c5TYrE9PxGvlaCjo4ZS2/ZUzvCEgeW+hMwDpNH5oBowSCze7tOjewcFa79UwiiCsKGgdwGk6vDN5S3WivrilCJEGYh84UCi2H2qw/56PcrMbHLb8t49r2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707701362; c=relaxed/simple;
	bh=XBlWfviHQ2r7aBjkRLrI3TMQKAtXtxPcTjG5M5Y798c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCZu6hA+v6EcdCxlwn9r9tl9guCwfJCCuHgACs4bal3P/ibNhtr0LWQRE/3NSyfMc7nQrv/xr3H0jN4BwvKwKVPyUgWMuTfEzy+cqB2MtVmUotSHnYUYV3S+s59TfETDxPyxQfPAu4uTlqkbJ53C8vP2NkfhBt42A6fFErjr3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XK6Kx+CE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XK6Kx+CE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707701361; x=1739237361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBlWfviHQ2r7aBjkRLrI3TMQKAtXtxPcTjG5M5Y798c=;
  b=XK6Kx+CEbPY1mtvVQpnaN7k9bt8LCTyysL/lE9oSODrZkQLZQuacO6Wj
   whsGc3dQh7eUDGUCjlpfXoKyAcg4hs6Y0OOeOjKHFbdTBWOxfwnvYtSYd
   wC+ulhWmcm1C/KcEIwfbHapbmueEgYBKe6UKrzoIMCoRy0FlB+FC3APOX
   dh/sMnxmO/8FBA1DLnhY49GTcRJS0ceoaBZ/RmSg0MhRn/Rtihy2BOYid
   sEOq820RI9IxknaG6ttxwhMA7ullgDnTNkdwoSb91epdG9kffR1IHk3Zp
   SziMhFEFApqriUggXgN4OU++NXd7FKuHO0Ck0S6Bq9mShxE45lvrWqvGS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="5502223"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="5502223"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 17:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="7132268"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 11 Feb 2024 17:29:17 -0800
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
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Joel Granados <j.granados@samsung.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v13 16/16] iommu: Make iommu_report_device_fault() return void
Date: Mon, 12 Feb 2024 09:22:27 +0800
Message-Id: <20240212012227.119381-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212012227.119381-1-baolu.lu@linux.intel.com>
References: <20240212012227.119381-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the iommu_report_device_fault() has been converted to auto-respond a
page fault if it fails to enqueue it, there's no need to return a code
in any case. Make it return void.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h                       |  5 ++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 ++--
 drivers/iommu/intel/svm.c                   | 19 ++++++----------
 drivers/iommu/io-pgfault.c                  | 25 +++++++--------------
 4 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 326aae1ab3a2..de839fd01bb8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1569,7 +1569,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
 void iopf_free_group(struct iopf_group *group);
-int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
+void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
 #else
@@ -1607,10 +1607,9 @@ static inline void iopf_free_group(struct iopf_group *group)
 {
 }
 
-static inline int
+static inline void
 iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
-	return -ENODEV;
 }
 
 static inline void iopf_group_response(struct iopf_group *group,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 42eb59cb99f4..02580364acda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1455,7 +1455,7 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 /* IRQ and event handlers */
 static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 {
-	int ret;
+	int ret = 0;
 	u32 perm = 0;
 	struct arm_smmu_master *master;
 	bool ssid_valid = evt[0] & EVTQ_0_SSV;
@@ -1511,7 +1511,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		goto out_unlock;
 	}
 
-	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	iommu_report_device_fault(master->dev, &fault_evt);
 out_unlock:
 	mutex_unlock(&smmu->streams_mutex);
 	return ret;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2f8716636dbb..b644d57da841 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -561,14 +561,11 @@ static int prq_to_iommu_prot(struct page_req_dsc *req)
 	return prot;
 }
 
-static int intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
-				struct page_req_dsc *desc)
+static void intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
+				 struct page_req_dsc *desc)
 {
 	struct iopf_fault event = { };
 
-	if (!dev || !dev_is_pci(dev))
-		return -ENODEV;
-
 	/* Fill in event data for device specific processing */
 	event.fault.type = IOMMU_FAULT_PAGE_REQ;
 	event.fault.prm.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
@@ -601,7 +598,7 @@ static int intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
 		event.fault.prm.private_data[0] = ktime_to_ns(ktime_get());
 	}
 
-	return iommu_report_device_fault(dev, &event);
+	iommu_report_device_fault(dev, &event);
 }
 
 static void handle_bad_prq_event(struct intel_iommu *iommu,
@@ -704,12 +701,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (!pdev)
 			goto bad_req;
 
-		if (intel_svm_prq_report(iommu, &pdev->dev, req))
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-		else
-			trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
-					 req->priv_data[0], req->priv_data[1],
-					 iommu->prq_seq_number++);
+		intel_svm_prq_report(iommu, &pdev->dev, req);
+		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
+				 req->priv_data[0], req->priv_data[1],
+				 iommu->prq_seq_number++);
 		pci_dev_put(pdev);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 6a325bff8164..06d78fcc79fd 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -176,26 +176,22 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
  * freed after the device has stopped generating page faults (or the iommu
  * hardware has been set to block the page faults) and the pending page faults
  * have been flushed.
- *
- * Return: 0 on success and <0 on error.
  */
-int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
+void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
 	struct iommu_fault *fault = &evt->fault;
 	struct iommu_fault_param *iopf_param;
 	struct iopf_group abort_group = {};
 	struct iopf_group *group;
-	int ret;
 
 	iopf_param = iopf_get_dev_fault_param(dev);
 	if (WARN_ON(!iopf_param))
-		return -ENODEV;
+		return;
 
 	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
-		ret = report_partial_fault(iopf_param, fault);
+		report_partial_fault(iopf_param, fault);
 		iopf_put_dev_fault_param(iopf_param);
 		/* A request that is not the last does not need to be ack'd */
-		return ret;
 	}
 
 	/*
@@ -207,25 +203,21 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	 * leaving, otherwise partial faults will be stuck.
 	 */
 	group = iopf_group_alloc(iopf_param, evt, &abort_group);
-	if (group == &abort_group) {
-		ret = -ENOMEM;
+	if (group == &abort_group)
 		goto err_abort;
-	}
 
 	group->domain = get_domain_for_iopf(dev, fault);
-	if (!group->domain) {
-		ret = -EINVAL;
+	if (!group->domain)
 		goto err_abort;
-	}
 
 	/*
 	 * On success iopf_handler must call iopf_group_response() and
 	 * iopf_free_group()
 	 */
-	ret = group->domain->iopf_handler(group);
-	if (ret)
+	if (group->domain->iopf_handler(group))
 		goto err_abort;
-	return 0;
+
+	return;
 
 err_abort:
 	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
@@ -233,7 +225,6 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 		__iopf_free_group(group);
 	else
 		iopf_free_group(group);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_report_device_fault);
 
-- 
2.34.1

