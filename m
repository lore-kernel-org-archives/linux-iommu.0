Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF7648
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675917141; x=1707453141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/H8ZSKH2xgNyiyBa6YD1+wJavpzaKvy5wsbSiOu9Dw=;
  b=cz9plvnZAJibYNbwNMqm31cIFL3qYXNSlnQbVqBhKjPYLxdtPfs/Mj5+
   u2doEZD462CZYR94yLf/NYN331KExBkrr/KJmyXtQ0AyXzjR7FX7cnpd9
   Jx7kvHlNi9kbMcPq3cY91DwWRrJTipv3yX8llfQ2CpCkSqVLmCuQ2S/lk
   jDZegu8k7atk8KwVyZPyjks0R8JHOt6wvY7wz+UsAKeJHa/iNx1WHYhac
   7VdoeQCyL3LQuarguIGTel1FhlDmeEzpRw5We61oaGghgjvS2JK6EeV7T
   6xA3AO/fc1h5kBfGkR4Mg609Z44Ys9StZYSzSDeCsCaOWC5Z5ZNwkOYIj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331298818"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="331298818"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 20:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="669447587"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="669447587"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2023 20:32:19 -0800
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
Subject: [PATCH 12/17] iommufd: Add user-managed hw_pagetable allocation
Date: Wed,  8 Feb 2023 20:31:48 -0800
Message-Id: <20230209043153.14964-13-yi.l.liu@intel.com>
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

As the introduction of nested translation, there are page tables managed
by userspace. hw_pagetables can be stage-1 pagetable, stage-2 pagetable or
just standalone pagetable.

Stage-2 page table and standalone pagetable are kernel-managed for security.
iommufd has already supported it.

Stage-1 pagetable is user-managed and needs to work with a stage-2 page table.
Hence, userspace should provide a hw_pagetable ID that points to a stage-2
hw_pagetable. Since stage-1 is user-managed, so an ioctl is added to sync
the IOTLB when there is modification in the stage-1 page table.

The first available user-managed hw_pagtable type is the Intel VT-d stage-1
pagetable for nested translation.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          |  3 +-
 drivers/iommu/iommufd/hw_pagetable.c    | 71 ++++++++++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  8 +++
 include/uapi/linux/iommufd.h            | 34 ++++++++++++
 5 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6d948fa418d5..c19e2f54a44f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -164,7 +164,8 @@ struct device *iommufd_obj_dev(struct iommufd_object *obj)
  * indexed by the members defined in enum iommu_device_data_type.
  */
 const u64 iommufd_supported_pgtbl_types[] =  {
-	[IOMMU_DEVICE_DATA_INTEL_VTD] = BIT_ULL(IOMMU_PGTBL_DATA_NONE),
+	[IOMMU_DEVICE_DATA_INTEL_VTD] = BIT_ULL(IOMMU_PGTBL_DATA_NONE) |
+					BIT_ULL(IOMMU_PGTBL_DATA_VTD_S1),
 };
 
 int iommufd_device_get_info(struct iommufd_ucmd *ucmd)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 02dee8e8d958..44a75ccc8e08 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -108,11 +108,12 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
  */
 static const size_t iommufd_hwpt_info_size[] = {
 	[IOMMU_PGTBL_DATA_NONE] = 0,
+	[IOMMU_PGTBL_DATA_VTD_S1] = sizeof(struct iommu_hwpt_intel_vtd),
 };
 
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 {
-	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_hw_pagetable *hwpt, *parent = NULL;
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
 	struct iommufd_ctx *ictx = ucmd->ictx;
 	struct iommufd_object *pt_obj = NULL;
@@ -160,6 +161,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	switch (pt_obj->type) {
+	case IOMMUFD_OBJ_HW_PAGETABLE:
+		parent = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
+		/*
+		 * Cannot allocate user-managed hwpt linking to auto_created
+		 * hwpt. If the parent hwpt is already a user-managed hwpt,
+		 * don't allocate another user-managed hwpt linking to it.
+		 */
+		if (parent->auto_domain || parent->parent) {
+			rc = -EINVAL;
+			goto out_put_pt;
+		}
+		ioas = parent->ioas;
+		break;
 	case IOMMUFD_OBJ_IOAS:
 		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
 		break;
@@ -189,7 +203,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	}
 
 	mutex_lock(&ioas->mutex);
-	hwpt = __iommufd_hw_pagetable_alloc(ictx, ioas, dev, NULL, data);
+	hwpt = __iommufd_hw_pagetable_alloc(ictx, ioas, dev, parent, data);
 	mutex_unlock(&ioas->mutex);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
@@ -217,3 +231,56 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(dev_obj);
 	return rc;
 }
+
+static u32 iommufd_hwpt_invalidate_info_size[] = {
+	[IOMMU_PGTBL_DATA_VTD_S1] = sizeof(struct iommu_hwpt_invalidate_intel_vtd),
+};
+
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
+	struct iommufd_hw_pagetable *hwpt;
+	u64 user_ptr;
+	u32 user_data_len, klen;
+	int rc = 0;
+
+	/*
+	 * No invalidation needed for type==IOMMU_PGTBL_DATA_NONE.
+	 * data_len should not exceed the size of iommufd_invalidate_buffer.
+	 */
+	if (cmd->data_type == IOMMU_PGTBL_DATA_NONE || !cmd->data_len)
+		return -EOPNOTSUPP;
+
+	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt))
+		return PTR_ERR(hwpt);
+
+	/* Do not allow any kernel-managed hw_pagetable */
+	if (!hwpt->parent) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	klen = iommufd_hwpt_invalidate_info_size[cmd->data_type];
+	if (!klen) {
+		rc = -EINVAL;
+		goto out_put_hwpt;
+	}
+
+	/*
+	 * copy the needed fields before reusing the ucmd buffer, this
+	 * avoids memory allocation in this path.
+	 */
+	user_ptr = cmd->data_uptr;
+	user_data_len = cmd->data_len;
+
+	rc = copy_struct_from_user(cmd, klen,
+				   u64_to_user_ptr(user_ptr), user_data_len);
+	if (rc)
+		goto out_put_hwpt;
+
+	hwpt->domain->ops->iotlb_sync_user(hwpt->domain, cmd);
+out_put_hwpt:
+	iommufd_put_object(&hwpt->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5ef034451f4b..bb341e633c18 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -267,6 +267,7 @@ iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
 }
 
 int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
+int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd);
 
 struct device *iommufd_obj_dev(struct iommufd_object *obj);
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 831303d64abe..6e2d8805daf3 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -252,6 +252,12 @@ union ucmd_buffer {
 	struct iommu_destroy destroy;
 	struct iommu_device_info info;
 	struct iommu_hwpt_alloc hwpt;
+	struct iommu_hwpt_invalidate cache;
+	/*
+	 * data_type specific structure used in the cache invalidation
+	 * path.
+	 */
+	struct iommu_hwpt_invalidate_intel_vtd vtd;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -287,6 +293,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
 		 __reserved),
+	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
+		 struct iommu_hwpt_invalidate, data_uptr),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index f501add5ffe9..cb6a9ee215f4 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -47,6 +47,7 @@ enum {
 	IOMMUFD_CMD_VFIO_IOAS,
 	IOMMUFD_CMD_DEVICE_GET_INFO,
 	IOMMUFD_CMD_HWPT_ALLOC,
+	IOMMUFD_CMD_HWPT_INVALIDATE,
 };
 
 /**
@@ -377,9 +378,11 @@ struct iommu_device_info_vtd {
 /**
  * enum iommu_pgtbl_data_type - IOMMU Page Table User Data type
  * @IOMMU_PGTBL_DATA_NONE: no user data
+ * @IOMMU_PGTBL_DATA_VTD_S1: Data for Intel VT-d stage-1 page table
  */
 enum iommu_pgtbl_data_type {
 	IOMMU_PGTBL_DATA_NONE,
+	IOMMU_PGTBL_DATA_VTD_S1,
 };
 
 /**
@@ -495,6 +498,8 @@ struct iommu_hwpt_intel_vtd {
  * +------------------------------+-------------------------------------+
  * | IOMMU_PGTBL_DATA_NONE        |                 N/A                 |
  * +------------------------------+-------------------------------------+
+ * | IOMMU_PGTBL_DATA_VTD_S1      |      struct iommu_hwpt_intel_vtd    |
+ * +------------------------------+-------------------------------------+
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -562,4 +567,33 @@ struct iommu_hwpt_invalidate_intel_vtd {
 	__u64 granule_size;
 	__u64 nb_granules;
 };
+
+/**
+ * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
+ * @size: sizeof(struct iommu_hwpt_invalidate)
+ * @hwpt_id: HWPT ID of target hardware page table for the invalidation
+ * @data_type: One of enum iommu_pgtbl_data_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
+ *
+ * Invalidate the iommu cache for user-managed page table. Modifications
+ * on user-managed page table should be followed with this operation to
+ * sync the userspace with the kernel and underlying hardware. This operation
+ * is only needed by user-managed hw_pagetables, so the @data_type should
+ * never be IOMMU_PGTBL_DATA_NONE.
+ *
+ * +==============================+========================================+
+ * | @data_type                   |     Data structure in @data_uptr       |
+ * +------------------------------+----------------------------------------+
+ * | IOMMU_PGTBL_DATA_VTD_S1      | struct iommu_hwpt_invalidate_intel_vtd |
+ * +------------------------------+----------------------------------------+
+ */
+struct iommu_hwpt_invalidate {
+	__u32 size;
+	__u32 hwpt_id;
+	__u32 data_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
+};
+#define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 #endif
-- 
2.34.1

