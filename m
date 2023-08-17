Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EC1BB58
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692315852; x=1723851852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZRkou5+WvkDInF2JwAq3cQtZp+dFMEyNGBCi2pJTPk=;
  b=f174WOgvPW07R8NnxYa9A4m7eUZuMeatVr4gJoZKPKcfQhpGROpa3bO0
   lKoGynHtqh3Mx9bsLj9KODKDMtpmiA4gv2L5IYRq5F8pzpuBkCgeLB8HB
   xmHjF3G0mQaQTl3k9TmLlQsJGn98r2TRi/eveOLyof5Qac0rpPMuze5m2
   GBDXKZh8PrYNFhlwBvLnh4mpCqtXlO0J9eMJ2VUQ1xoGxpxhY+DNxOkUO
   FO3t6JWXV5k60NAULv9YiZISSRBFKr0NSGWuILRxV+CKIkA/b8z+DlOx+
   riAHo6LQNdiTNg0aF6svdrVv9pWn+S/T8PBbTHUdsYTqFpDQvOgp3idXz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352552128"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="352552128"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 16:44:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849051969"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="849051969"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 17 Aug 2023 16:44:06 -0700
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
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 10/11] iommu: Add debugging on domain lifetime for iopf
Date: Fri, 18 Aug 2023 07:40:46 +0800
Message-Id: <20230817234047.195194-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817234047.195194-1-baolu.lu@linux.intel.com>
References: <20230817234047.195194-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iopf handling framework in the core requires the domain's lifetime
should cover all possible iopfs. This has been documented in the comments
for iommu_queue_iopf() which is the entry of the framework.

Add some debugging to enforce this.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/io-pgfault.c |  3 +++
 drivers/iommu/iommu.c      | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index a61c2aabd1b8..bf667ed39b01 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -129,6 +129,9 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 		domain = iommu_get_domain_for_dev(dev);
 
 	if (!domain || !domain->iopf_handler) {
+		dev_warn_ratelimited(dev,
+			"iopf from pasid %d received without handler installed\n",
+			 fault->prm.pasid);
 		ret = -ENODEV;
 		goto cleanup_partial;
 	}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9b622088c741..c170bcd3f05e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2032,6 +2032,28 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return 0;
 }
 
+static void assert_no_pending_iopf(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_fault_param *iopf_param = dev->iommu->fault_param;
+	struct iommu_fault_event *evt;
+	struct iopf_fault *iopf;
+
+	if (!iopf_param)
+		return;
+
+	mutex_lock(&iopf_param->lock);
+	list_for_each_entry(iopf, &iopf_param->partial, list) {
+		if (WARN_ON(iopf->fault.prm.pasid == pasid))
+			break;
+	}
+
+	list_for_each_entry(evt, &iopf_param->faults, list) {
+		if (WARN_ON(evt->fault.prm.pasid == pasid))
+			break;
+	}
+	mutex_unlock(&iopf_param->lock);
+}
+
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	/* Caller must be a probed driver on dev */
@@ -2040,6 +2062,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 	if (!group)
 		return;
 
+	assert_no_pending_iopf(dev, IOMMU_NO_PASID);
 	mutex_lock(&group->mutex);
 	if (WARN_ON(domain != group->domain) ||
 	    WARN_ON(list_count_nodes(&group->devices) != 1))
@@ -3340,6 +3363,7 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 	/* Caller must be a probed driver on dev */
 	struct iommu_group *group = dev->iommu_group;
 
+	assert_no_pending_iopf(dev, pasid);
 	mutex_lock(&group->mutex);
 	__iommu_remove_group_pasid(group, pasid);
 	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
-- 
2.34.1

