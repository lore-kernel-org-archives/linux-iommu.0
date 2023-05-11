Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A563B
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 14:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816684; x=1715352684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RiJbUCRtwm5Znm9STMCxtijeo+jb5c7PnzMHxXPV1jU=;
  b=ah5GJTVT3Ae7qhk5cO/WaphLGjLZa8TgR54be5R6A+9Ee1HMeJMOsoXW
   ZOBCAPVV5oHynf/foHzN4Or/caD87SO994DrAQA+3/9hwkPpwsnCmvmaw
   kO4bnarVqh6QvQpDQbVOR8s04hxzmlXiFqHJu7zdBa6nouXrGhI3rE3LM
   e6NGVInKIlJjW2o4nUcR0S+DmtGLVNTc4c1AvGyJLB8ggT8+otNZyCxgT
   gw9ElLulvKlNIiPsaYMQ4ykzf3bL3/qV9ysvHNw3vcvxv0uFal2sphbqA
   T9qytbwhoDIvSSN7N2a+Qw3rJJVMTG1ypFfh50O0VBcXtl+SfO6G2+OdM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025524"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025524"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355194"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355194"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:20 -0700
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
Subject: [PATCH v3 09/10] iommu/vt-d: Implement hw_info for iommu capability query
Date: Thu, 11 May 2023 07:51:09 -0700
Message-Id: <20230511145110.27707-10-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511145110.27707-1-yi.l.liu@intel.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
 include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 51612da4a1ea..20d4ae1cb8a6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4746,6 +4746,23 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
+static void *intel_iommu_hw_info(struct device *dev, u32 *length)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_hw_info_vtd *vtd;
+
+	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
+	if (!vtd)
+		return ERR_PTR(-ENOMEM);
+
+	vtd->cap_reg = iommu->cap;
+	vtd->ecap_reg = iommu->ecap;
+	*length = sizeof(*vtd);
+
+	return vtd;
+}
+
 static int intel_iommu_domain_user_data_len(u32 hwpt_type)
 {
 	if (hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
@@ -4755,6 +4772,7 @@ static int intel_iommu_domain_user_data_len(u32 hwpt_type)
 
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
+	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_user_data_len = intel_iommu_domain_user_data_len,
@@ -4769,6 +4787,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
+	.hw_info_type		= IOMMU_HW_INFO_TYPE_INTEL_VTD,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.page_response		= intel_svm_page_response,
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2e658fa346ad..b46270a4cf46 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -464,9 +464,32 @@ struct iommu_hwpt_alloc {
 
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
+ * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
+	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+};
+
+/**
+ * struct iommu_hw_info_vtd - Intel VT-d hardware information
+ *
+ * @flags: Must be 0
+ * @__reserved: Must be 0
+ *
+ * @cap_reg: Value of Intel VT-d capability register defined in VT-d spec
+ *           section 11.4.2 Capability Register.
+ * @ecap_reg: Value of Intel VT-d capability register defined in VT-d spec
+ *            section 11.4.3 Extended Capability Register.
+ *
+ * User needs to understand the Intel VT-d specification to decode the
+ * register value.
+ */
+struct iommu_hw_info_vtd {
+	__u32 flags;
+	__u32 __reserved;
+	__aligned_u64 cap_reg;
+	__aligned_u64 ecap_reg;
 };
 
 /**
-- 
2.34.1

