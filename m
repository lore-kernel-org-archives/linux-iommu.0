Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99BB23CB
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qzo8S0oz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704946226; x=1736482226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jTK0zsrD6iUZ/k8/QLoj03D3txfzWkMPindf/3ehAE=;
  b=Qzo8S0oztP76JQhmZSiLPVqwqHlXJPjwectJh7rSWCJBaceq74cAWZva
   59WqIx4k4Q5sYraqvqP0IG/uO4kIF1IItxADmrTcxpqCDhFxJvJgJVm8M
   bsW3xA5wvCpOopuzZ4dOGFJmz0Kb+XniKWFwriTMBOdhl0kXPmstHwJcZ
   8X5PwDX3/jIvfn7viYPPJwg8JO/r3Sd3w5VbwWgVMr2bazBkRQ6bBJ/W7
   DcE0aIyfhpHRk3IExqpA6mlNF7eJi3npP/LDhgPzlQ8wqrwHoRzDUcf29
   /K6pqZoF6D3GTwjm6g9Hum+lnf2tJJD8YA5qtiK09R4TrpwlpTzRYvFri
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="389167640"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="389167640"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 20:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1113691842"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="1113691842"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2024 20:10:25 -0800
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
	xin.zeng@intel.com,
	yan.y.zhao@intel.com,
	j.granados@samsung.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v11 3/8] iommu: Add iommu_copy_struct_from_user_array helper
Date: Wed, 10 Jan 2024 20:10:10 -0800
Message-Id: <20240111041015.47920-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111041015.47920-1-yi.l.liu@intel.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

Wrap up the data pointer/num sanity and __iommu_copy_struct_from_user
call for iommu drivers to copy driver specific data at a specific location
in the struct iommu_user_data_array.

And expect it to be used in cache_invalidate_user ops for example.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 include/linux/iommu.h | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 93c0d12dd047..580ba74a3d5d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -341,6 +341,59 @@ static inline int __iommu_copy_struct_from_user(
 				      sizeof(*kdst),                      \
 				      offsetofend(typeof(*kdst), min_last))
 
+/**
+ * __iommu_copy_struct_from_user_array - Copy iommu driver specific user space
+ *                                       data from an iommu_user_data_array
+ * @dst_data: Pointer to an iommu driver specific user data that is defined in
+ *            include/uapi/linux/iommufd.h
+ * @src_array: Pointer to a struct iommu_user_data_array for a user space array
+ * @data_type: The data type of the @dst_data. Must match with @src_array.type
+ * @index: Index to the location in the array to copy user data from
+ * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
+ * @min_len: Initial length of user data structure for backward compatibility.
+ *           This should be offsetofend using the last member in the user data
+ *           struct that was initially added to include/uapi/linux/iommufd.h
+ */
+static inline int
+__iommu_copy_struct_from_user_array(void *dst_data,
+				    const struct iommu_user_data_array *src_array,
+				    unsigned int data_type, unsigned int index,
+				    size_t data_len, size_t min_len)
+{
+	struct iommu_user_data src_data;
+
+	if (WARN_ON(!src_array || index >= src_array->entry_num))
+		return -EINVAL;
+	if (!src_array->entry_num)
+		return -EINVAL;
+	src_data.uptr = src_array->uptr + src_array->entry_len * index;
+	src_data.len = src_array->entry_len;
+	src_data.type = src_array->type;
+
+	return __iommu_copy_struct_from_user(dst_data, &src_data, data_type,
+					     data_len, min_len);
+}
+
+/**
+ * iommu_copy_struct_from_user_array - Copy iommu driver specific user space
+ *                                     data from an iommu_user_data_array
+ * @kdst: Pointer to an iommu driver specific user data that is defined in
+ *        include/uapi/linux/iommufd.h
+ * @user_array: Pointer to a struct iommu_user_data_array for a user space
+ *              array
+ * @data_type: The data type of the @kdst. Must match with @user_array->type
+ * @index: Index to the location in the array to copy user data from
+ * @min_last: The last member of the data structure @kdst points in the
+ *            initial version.
+ * Return 0 for success, otherwise -error.
+ */
+#define iommu_copy_struct_from_user_array(kdst, user_array, data_type,   \
+					  index, min_last)                \
+	__iommu_copy_struct_from_user_array(kdst, user_array, data_type, \
+					    index, sizeof(*kdst),        \
+					    offsetofend(typeof(*kdst),   \
+							min_last))
+
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
-- 
2.34.1

