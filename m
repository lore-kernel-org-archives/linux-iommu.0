Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FC620
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683816682; x=1715352682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vbt/gRKp77bRwjDyaiyibCBpUzoPaDniGF7JiqNVd8w=;
  b=XYO5VV3UUjkYQFgc0demqVnf0kYClAIt8WFW6+ko9fDck06qycfUMH1E
   27CNOO+DDOXsHqhSFBDUSySjiFNT8U9h9JAKVs4a789LbxqRX/b48J2sn
   VtHLxAUmLVW9M8oEdzMvdVL2cQziobvA7+Sbk/Gq6WVgLiJwMpNa3VOQJ
   iUjnrCwslddrByYC+IUFhV9ST6OT04UlzAmszwfaasdysaFzfWkaF9vxh
   8f31GGCwGEJQ5c6wRcrfLC5Act1SF9VxW17Bf/rou/p/RTZ+YX4aac7A7
   nzjL6utvM2d6xtAHyWNSzkvZgkPQTOLnLJZx7NOCgVEoqu7S/FuotlKVj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335025513"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="335025513"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769355189"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="769355189"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga004.fm.intel.com with ESMTP; 11 May 2023 07:51:19 -0700
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
Subject: [PATCH v3 08/10] iommu/vt-d: Add nested domain allocation
Date: Thu, 11 May 2023 07:51:08 -0700
Message-Id: <20230511145110.27707-9-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

This adds the support for IOMMU_HWPT_TYPE_VTD_S1 type.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 19 +++++++++++++++++++
 include/linux/iommu.h       |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5f27cee4656a..51612da4a1ea 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4092,6 +4092,16 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	return NULL;
 }
 
+static struct iommu_domain *
+intel_iommu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
+			      const union iommu_domain_user_data *user_data)
+{
+	if (parent)
+		return intel_nested_domain_alloc(parent, user_data);
+	else
+		return iommu_domain_alloc(dev->bus);
+}
+
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
 	if (domain != &si_domain->domain && domain != &blocking_domain)
@@ -4736,9 +4746,18 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 }
 
+static int intel_iommu_domain_user_data_len(u32 hwpt_type)
+{
+	if (hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
+		return -EOPNOTSUPP;
+	return sizeof(struct iommu_hwpt_intel_vtd);
+};
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_alloc_user	= intel_iommu_domain_alloc_user,
+	.domain_alloc_user_data_len = intel_iommu_domain_user_data_len,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c696d8e7f43b..32324f0756de 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -234,6 +234,7 @@ union iommu_domain_user_data {
 #ifdef CONFIG_IOMMUFD_TEST
 	__u64 test[2];
 #endif
+	struct iommu_hwpt_intel_vtd vtd;
 };
 
 /**
-- 
2.34.1

