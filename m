Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF07E
	for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 01:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667178395; x=1698714395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2yp9akidaoFr+h4pIHRp2BZ1P9liVQ3w2A6JZy31yM=;
  b=fRDd95z5YUX9CHhDF1AYPDVe9u4uutXbxSb3K4lnHD9MjS0DF8bAUoxB
   0RnZYUCYfwzqIohcb7eNPc7RnI3FFGrT15W91X60T7T3S8H7F2RFUF//R
   3NNSrDEZf/Q+4qvey1PqtNydU7ql75uaAvbgeZKn9uf05GmSugUUXUbUy
   IcV9vOWqBxmLAQXD1w9NPumHsdf+8wfCMMaxcFzmpJHfMgtFPWDXELw4A
   G6RZDoOSvJn1z8uNj2iOsMTkeUmyDeWuK044eUn4JNuF5aTZnlWL+5+1R
   xDslet/3jAohoxTB5Hkk8UeIC59iWfnwWd7hCgI6u+XNbDA7xnoj/B/16
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="335447149"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="335447149"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="584496218"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="584496218"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2022 18:06:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v14 07/13] iommu/vt-d: Add SVA domain support
Date: Mon, 31 Oct 2022 08:59:11 +0800
Message-Id: <20221031005917.45690-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031005917.45690-1-baolu.lu@linux.intel.com>
References: <20221031005917.45690-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops. This implementation is based on the existing SVA
code. Possible cleanup and refactoring are left for incremental
changes later.

The VT-d driver will also need to support setting a DMA domain to a
PASID of device. Current SVA implementation uses different data
structures to track the domain and device PASID relationship. That's
the reason why we need to check the domain type in remove_dev_pasid
callback. Eventually we'll consolidate the data structures and remove
the need of domain type check.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/iommu/intel/iommu.h | 10 ++++++++
 drivers/iommu/intel/iommu.c | 25 ++++++++++++++++++++
 drivers/iommu/intel/svm.c   | 47 +++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 33e5bcaf2a6c..252fa344f88a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -753,6 +753,8 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+struct iommu_domain *intel_svm_domain_alloc(void);
+void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 
 struct intel_svm_dev {
 	struct list_head list;
@@ -777,6 +779,14 @@ struct intel_svm {
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
+static inline struct iommu_domain *intel_svm_domain_alloc(void)
+{
+	return NULL;
+}
+
+static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 48cdcd0a5cf3..7b67e431dd36 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4169,6 +4169,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
+	case IOMMU_DOMAIN_SVA:
+		return intel_svm_domain_alloc();
 	default:
 		return NULL;
 	}
@@ -4712,6 +4714,28 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 }
 
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct iommu_domain *domain;
+
+	/* Domain type specific cleanup: */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
+	if (domain) {
+		switch (domain->type) {
+		case IOMMU_DOMAIN_SVA:
+			intel_svm_remove_dev_pasid(dev, pasid);
+			break;
+		default:
+			/* should never reach here */
+			WARN_ON(1);
+			break;
+		}
+	}
+
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4724,6 +4748,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
+	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.sva_bind		= intel_svm_bind,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 94bc47b68c93..86c8ea0d9635 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -882,3 +882,50 @@ int intel_svm_page_response(struct device *dev,
 out:
 	return ret;
 }
+
+void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	mutex_lock(&pasid_mutex);
+	intel_svm_unbind_mm(dev, pasid);
+	mutex_unlock(&pasid_mutex);
+}
+
+static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct mm_struct *mm = domain->mm;
+	struct iommu_sva *sva;
+	int ret = 0;
+
+	mutex_lock(&pasid_mutex);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
+	if (IS_ERR(sva))
+		ret = PTR_ERR(sva);
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
+static void intel_svm_domain_free(struct iommu_domain *domain)
+{
+	kfree(to_dmar_domain(domain));
+}
+
+static const struct iommu_domain_ops intel_svm_domain_ops = {
+	.set_dev_pasid		= intel_svm_set_dev_pasid,
+	.free			= intel_svm_domain_free
+};
+
+struct iommu_domain *intel_svm_domain_alloc(void)
+{
+	struct dmar_domain *domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+	domain->domain.ops = &intel_svm_domain_ops;
+
+	return &domain->domain;
+}
-- 
2.34.1

