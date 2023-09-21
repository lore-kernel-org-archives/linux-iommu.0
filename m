Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66193567E
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695282751; x=1726818751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/iiqZNASYdDaSFvw490mVbipdDkiEm+mbdVppSrYxQ=;
  b=MguWeBPKJu2tFmYasNlUnHgXgbZTAhDT+p+A44aJRYu7jg5IOqCZw2hs
   wtJPQztDZ9KJqHU/8qOKaDjEZH6P0UPhULBosBM6e3bWNgAoYmNCgxbbB
   Nj/oxjss8OqIeP7Ug0bYK2suLQ4CtQ9iewsusn4o7lnJdgW6Rs4QeLd6f
   Jy9+qR1hzkZ/q6SzCvNkcbiOxNxfs1zZ7CwYSJa3eETYRVtCUwetMU20Z
   SQ+En1L1lJ26JWuI5l66oVyi34kdbjPnj4P22uM8eOcPGk/LvlrGbP3UE
   MRIGsM+3gfVziYkNAUsBTrfAtsqlaWv+Uy6Q4Yj3lVbkD0OiZoj51ROtb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832912"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832912"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649564"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649564"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:15 -0700
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
Subject: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation with user data
Date: Thu, 21 Sep 2023 00:51:31 -0700
Message-Id: <20230921075138.124099-11-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
But it can only allocate a hw_pagetable that associates to a given IOAS,
i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.

IOMMU drivers can now support user-managed hw_pagetables, for two-stage
translation use cases, that require user data input from the user space.

Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
type specified user data. Also, update the @pt_id to accept hwpt_id too
besides an ioas_id. Then, pass them to the downstream alloc_fn().

Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
 include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 90fd65859e28..ab25de149ae6 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -300,6 +300,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 					bool flag);
 	struct iommufd_hw_pagetable *hwpt, *parent;
 	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	struct iommu_user_data *data = NULL;
 	struct iommufd_object *pt_obj;
 	struct iommufd_device *idev;
 	struct iommufd_ioas *ioas;
@@ -308,6 +309,11 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 
 	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
 		return -EOPNOTSUPP;
+	if (!cmd->data_len && cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT)
+		return -EINVAL;
+	if (cmd->flags & IOMMU_HWPT_ALLOC_NEST_PARENT &&
+	    cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT)
+		return -EINVAL;
 
 	idev = iommufd_get_device(ucmd, cmd->dev_id);
 	if (IS_ERR(idev))
@@ -340,9 +346,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
+	if (cmd->data_len) {
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
+		if (!data) {
+			rc = -ENOMEM;
+			goto out_put_pt;
+		}
+		data->uptr = u64_to_user_ptr(cmd->data_uptr);
+		data->len = cmd->data_len;
+	}
+
 	mutex_lock(mutex);
 	hwpt = alloc_fn(ucmd->ictx, pt_obj, idev, cmd->flags,
-			IOMMU_HWPT_TYPE_DEFAULT, NULL, false);
+			cmd->hwpt_type, data, false);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
@@ -359,6 +375,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(mutex);
+	kfree(data);
 out_put_pt:
 	iommufd_put_object(pt_obj);
 out_put_idev:
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 3c8660fe9bb1..c46b1f772f20 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -370,15 +370,31 @@ enum iommu_hwpt_type {
  * @size: sizeof(struct iommu_hwpt_alloc)
  * @flags: Combination of enum iommufd_hwpt_alloc_flags
  * @dev_id: The device to allocate this HWPT for
- * @pt_id: The IOAS to connect this HWPT to
+ * @pt_id: The IOAS or HWPT to connect this HWPT to
  * @out_hwpt_id: The ID of the new HWPT
  * @__reserved: Must be 0
+ * @hwpt_type: One of enum iommu_hwpt_type
+ * @data_len: Length of the type specific data
+ * @data_uptr: User pointer to the type specific data
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
  * underlying iommu driver's iommu_domain kernel object.
  *
- * A HWPT will be created with the IOVA mappings from the given IOAS.
+ * A kernel-managed HWPT will be created with the mappings from the given
+ * IOAS via the @pt_id. The @hwpt_type for this allocation can be set to
+ * either IOMMU_HWPT_TYPE_DEFAULT or a pre-defined type corresponding to
+ * an I/O page table type supported by the underlying IOMMU hardware.
+ *
+ * A user-managed HWPT will be created from a given parent HWPT via the
+ * @pt_id, in which the parent HWPT must be allocated previously via the
+ * same ioctl from a given IOAS (@pt_id). In this case, the @hwpt_type
+ * must be set to a pre-defined type corresponding to an I/O page table
+ * type supported by the underlying IOMMU hardware.
+ *
+ * If the @hwpt_type is set to IOMMU_HWPT_TYPE_DEFAULT, @data_len and
+ * @data_uptr should be zero. Otherwise, both @data_len and @data_uptr
+ * must be given.
  */
 struct iommu_hwpt_alloc {
 	__u32 size;
@@ -387,6 +403,9 @@ struct iommu_hwpt_alloc {
 	__u32 pt_id;
 	__u32 out_hwpt_id;
 	__u32 __reserved;
+	__u32 hwpt_type;
+	__u32 data_len;
+	__aligned_u64 data_uptr;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
-- 
2.34.1

