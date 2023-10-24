Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9B113FED
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TizbtBrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698160203; x=1729696203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QKBOqCJPnh6h05S/Q8c3RcBvwQLEe/d639sV2r2Ld/Y=;
  b=TizbtBrWrxASXjQ54hoV53WBPJZNO/1Zj1i936hn7xvHMJ7SaRFdjafR
   QEKbqHLJaH665qFHiCKS+l9wnCm7/cL79ftUjJ7q38UU/n6B11aUiezNP
   XQFbTEV9dVAD1DmNpsB+srr4IqWIgtNzFK0VNRd8B8L3COy/bSxZuD0c2
   cBecJZS5OaBXxKHVPYPBdB+SlcZdoa5fk9/cd3GOOxQ2wtCXmZuuIk7q4
   nRS0voeM4HVZ36xmL8cQFnU1nzvxzT6fOXL4Zc62GmWPhCOLbXn2oe/FR
   UOBS/XmADOv/10NQ1tkDwkf28Nz9QjBZI16/muSpMhHWHwSyhwSQI2Rc3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418203091"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="418203091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 08:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6486191"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa001.fm.intel.com with ESMTP; 24 Oct 2023 08:06:23 -0700
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
	joao.m.martins@oracle.com
Subject: [PATCH v6 08/10] iommu: Add iommu_copy_struct_from_user helper
Date: Tue, 24 Oct 2023 08:06:07 -0700
Message-Id: <20231024150609.46884-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024150609.46884-1-yi.l.liu@intel.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Wrap up the data type/pointer/len sanity and a copy_struct_from_user call
for iommu drivers to copy driver specific data via struct iommu_user_data.
And expect it to be used in the domain_alloc_user op for example.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a86ce9cb3547..9417b9e0616b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -280,6 +280,47 @@ struct iommu_user_data {
 	size_t len;
 };
 
+/**
+ * __iommu_copy_struct_from_user - Copy iommu driver specific user space data
+ * @dst_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @src_data: Pointer to a struct iommu_user_data for user space data info
+ * @data_type: The data type of the @dst_data. Must match with @src_data.type
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int
+__iommu_copy_struct_from_user(void *dst_data,
+			      const struct iommu_user_data *src_data,
+			      unsigned int data_type, size_t data_len,
+			      size_t min_len)
+{
+	if (src_data->type != data_type)
+		return -EINVAL;
+	if (WARN_ON(!dst_data || !src_data))
+		return -EINVAL;
+	if (src_data->len < min_len || data_len < src_data->len)
+		return -EINVAL;
+	return copy_struct_from_user(dst_data, data_len,
+				     src_data->uptr, src_data->len);
+}
+
+/**
+ * iommu_copy_struct_from_user - Copy iommu driver specific user space data
+ * @kdst: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @user_data: Pointer to a struct iommu_user_data for user space data info
+ * @data_type: The data type of the @kdst. Must match with @user_data->type
+ * @min_last: The last memember of the data structure @kdst points in the
+ *            initial version.
+ * Return 0 for success, otherwise -error.
+ */
+#define iommu_copy_struct_from_user(kdst, user_data, data_type, min_last)        \
+	__iommu_copy_struct_from_user(kdst, user_data, data_type, sizeof(*kdst), \
+				      offsetofend(typeof(*kdst), min_last))
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.34.1

