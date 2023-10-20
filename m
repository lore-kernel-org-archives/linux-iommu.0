Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC713AE9
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9lGt53G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697794644; x=1729330644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIzGLY3NTvO8QdhVNwrnfazybXL/lUWimvex+9KJLiU=;
  b=G9lGt53G6RmZ8wW6kMu32KVLrzxnGo4hNyb7kc/POSxrmxjg94sYlABb
   xgQSzn3DVpILN9j7LCBeAI9yBetUA241xC4ra9hO7cKWPLaN8WkI5MigV
   U+xgOOYfUt60RiUJ8hJb8x1ncW+oOaNk3LM5FX3rqunPYsqaS5fgJtY92
   H6rjDUXXhEsCLvwwuuDysSjiB9LsNOR5ktHxNpxBaqeR43+cecDVzG5wk
   H+XEzQp1Cn/naRC7AhG2AZ1H0CtouVMn5HHXIO6hYxlYUAynrP+H0oqsJ
   SdByj1ojIE57H98Of3DzC07KeddKBQHupDJCeX/JtbNPwwrCb9cn3UnxV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="385341740"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="385341740"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 02:37:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707181310"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707181310"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2023 02:37:22 -0700
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
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com,
	xin.zeng@intel.com
Subject: [PATCH v6 3/3] iommu/vt-d: Add iotlb flush for nested domain
Date: Fri, 20 Oct 2023 02:37:18 -0700
Message-Id: <20231020093719.18725-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020093719.18725-1-yi.l.liu@intel.com>
References: <20231020093719.18725-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This implements the .cache_invalidate_user() callback to support iotlb
flush for nested domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/nested.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 19538fb616db..ef8fe53c33ef 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -73,9 +73,63 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(to_dmar_domain(domain));
 }
 
+static void domain_flush_iotlb_psi(struct dmar_domain *domain,
+				   u64 addr, unsigned long npages)
+{
+	struct iommu_domain_info *info;
+	unsigned long i;
+
+	xa_for_each(&domain->iommu_array, i, info)
+		iommu_flush_iotlb_psi(info->iommu, domain,
+				      addr >> VTD_PAGE_SHIFT, npages, 1, 0);
+}
+
+static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
+					      struct iommu_user_data_array *array,
+					      u32 *cerror_idx)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct iommu_hwpt_vtd_s1_invalidate inv_info;
+	u32 index;
+	int ret;
+
+	/* REVISIT:
+	 * VT-d has defined ITE, ICE, IQE for invalidation failure per hardware,
+	 * but no error code yet, so just set the error code to be 0.
+	 */
+	*cerror_idx = 0;
+
+	for (index = 0; index < array->entry_num; index++) {
+		ret = iommu_copy_struct_from_user_array(&inv_info, array,
+							IOMMU_HWPT_DATA_VTD_S1,
+							index, __reserved);
+		if (ret) {
+			pr_err_ratelimited("Failed to fetch invalidation request\n");
+			break;
+		}
+
+		if (inv_info.__reserved || (inv_info.flags & ~IOMMU_VTD_INV_FLAGS_LEAF) ||
+		    !IS_ALIGNED(inv_info.addr, VTD_PAGE_SIZE)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (inv_info.addr == 0 && inv_info.npages == -1)
+			intel_flush_iotlb_all(domain);
+		else
+			domain_flush_iotlb_psi(dmar_domain,
+					       inv_info.addr, inv_info.npages);
+	}
+
+	array->entry_num = index;
+
+	return ret;
+}
+
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
 	.free			= intel_nested_domain_free,
+	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
 
 struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
-- 
2.34.1

