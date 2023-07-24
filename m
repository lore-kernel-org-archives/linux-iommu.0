Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5355680
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690197230; x=1721733230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qDa2X3gdhagGNCK2/GQ0KFX2hlra/0tF2Yc8QKhk5M8=;
  b=bo2Xt+Tfr6xOFA8B4Dibp6azEpBYY96/9B676vBK3+JH8fmKkPmoWsfj
   HLeprDcSEcn5lHyI64qEEFgGCd0pInRavFekFdQXdtDz6dAs9hGhjnjTX
   eqU66AzCC48afQVHXwwDH9Yv9c1oJslZtCwrxtPagxBfYSBeOdnl7QFhB
   6aMiAJFnXZpde/nNtbjDFwzTEG1wvsoEFmvdhlJjycZPh0pdM6qwVUS/B
   zRx6RF8qZsQCKQjlik1nc+ho9GhYLeYktprZbdf8LjzYafRfWsBFpp3ZK
   u+F+iC/szFMNGznrXpXvowpvys7GPJm6RvAnXpv6+7p2e1VrcHi3SoBkD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347015067"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347015067"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="839415599"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839415599"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 04:13:49 -0700
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
Subject: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu capability query
Date: Mon, 24 Jul 2023 04:13:33 -0700
Message-Id: <20230724111335.107427-12-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724111335.107427-1-yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
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
index 6977d320c440..ba34827045e6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4748,8 +4748,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
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
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
+	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.probe_device		= intel_iommu_probe_device,
@@ -4763,6 +4781,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
+	.hw_info_type		= IOMMU_HW_INFO_TYPE_INTEL_VTD,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.page_response		= intel_svm_page_response,
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2c1241448c87..0dfb6f3d8dda 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -435,12 +435,35 @@ struct iommu_hwpt_alloc {
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
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
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that does not report hardware info
+ * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
+	IOMMU_HW_INFO_TYPE_INTEL_VTD,
 };
 
 /**
-- 
2.34.1

