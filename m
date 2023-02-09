Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38010640
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917143; x=1707453143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JfD/fokoPRshO4wFNzn7zhXsFRoESmD1kCTxkSknqtU=;
  b=H9NIvgAOX3jCzakzjPfMYVM/Ak/K+q0aVNnd1mdfEDlYiISTUDj+QqMG
   btvgxniuqBu+q0QjIk1KoIfysll6/bwp4fdOGiJ/7lJr2yggExdE046xk
   kcRb3MN7oEzgOf2SmnVatLkL1jLxAln3+3WUiEWpfDzle7QlW3mJ0QTnb
   wU0ab1C/Dl6Bj2DZLBLzMLNlhfeJ3yLj4xJmJ6utFxVZ1frR4FFLDBdAA
   FGK3544gHsLIOaeKU+BwjvK+k31knpn46gQ3eZzyFiAnb6iOwbkJpBiMR
   TB+UgU0fRsllPIDbLHC27t/CQr6aQe9MRY1fSm5jwdOJhll8EeVt8I+9d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298837"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298837"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447592"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447592"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:21 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	alex.williamson@redhat.com,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	robin.murphy@arm.com
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
	baolu.lu@linux.intel.com
Subject: [PATCH 13/17] iommufd/device: Report supported stage-1 page table types
Date: Wed,  8 Feb 2023 20:31:49 -0800
Message-Id: <20230209043153.14964-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209043153.14964-1-yi.l.liu@intel.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This provides a way for userspace to probe supported stage-1 page table
types on hardware IOMMU. This is helpful when the user-managed page table
is used by hardware IOMMU. e.g. nested translation.

This commit reports the supported types for IOMMU_DEVICE_DATA_INTEL_VTD.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 7 +++++++
 drivers/iommu/iommufd/main.c   | 2 +-
 include/uapi/linux/iommufd.h   | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c19e2f54a44f..826441c6005d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -224,6 +224,13 @@ int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
 	cmd->out_device_type = ops->driver_type;
 	cmd->data_len = data_len;
 
+	if (ops->driver_type != IOMMU_DEVICE_DATA_SELFTEST)
+		cmd->out_pgtbl_type_bitmap = iommufd_supported_pgtbl_types[ops->driver_type];
+#ifdef CONFIG_IOMMUFD_TEST
+	else
+		cmd->out_pgtbl_type_bitmap = 0;
+#endif
+
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
 out_free_data:
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 6e2d8805daf3..d8bac1303b33 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -290,7 +290,7 @@ struct iommufd_ioctl_op {
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
 	IOCTL_OP(IOMMU_DEVICE_GET_INFO, iommufd_device_get_info, struct iommu_device_info,
-		 __reserved),
+		 out_pgtbl_type_bitmap),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index cb6a9ee215f4..2c7533d843bc 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -396,6 +396,8 @@ enum iommu_pgtbl_data_type {
  * @out_device_type: Output the underlying iommu hardware type, it is
  *		   one of enum iommu_device_data_type.
  * @__reserved: Must be 0
+ * @out_pgtbl_type_bitmap: Output the supported page table type. Each
+ *			   bit is defined in enum iommu_pgtbl_data_type.
  *
  * Query the hardware iommu capability for given device which has been
  * bound to iommufd. @data_len is set to be the size of the buffer to
@@ -408,6 +410,10 @@ enum iommu_pgtbl_data_type {
  *
  * The @out_device_type will be filled if the ioctl succeeds. It would
  * be used to decode the data filled in the buffer pointed by @data_ptr.
+ *
+ * @out_pgtbl_type_bitmap tells the userspace the supported page tables.
+ * This differs per @out_device_type. Userspace should check it before
+ * allocating hw_pagetable in userspace.
  */
 struct iommu_device_info {
 	__u32 size;
@@ -417,6 +423,7 @@ struct iommu_device_info {
 	__aligned_u64 data_ptr;
 	__u32 out_device_type;
 	__u32 __reserved;
+	__aligned_u64 out_pgtbl_type_bitmap;
 };
 #define IOMMU_DEVICE_GET_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DEVICE_GET_INFO)
 
-- 
2.34.1

