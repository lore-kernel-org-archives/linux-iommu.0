Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4975E364D1
	for <iommu@lists.linux.dev>; Mon, 22 Jan 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909495; cv=none; b=s8FV9JY+mjy+pgea7q/1N+c4Niab3eJjydJLaK1aSRbVYopwDEaDFSK7vZB7HAzi86lbLqAGhQLyggxkze7SZaKEVD6N6HEcED5hEepP1qcPz8Qy8F7NUXoF+5S/WKIAJqDJXI3aJKRzhWi8VUlWLxV/LPyGCakkqlTu9Pb3iSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909495; c=relaxed/simple;
	bh=3G+m/18NThTRa31/ppFhR/nvEFSddDTyIuSRJM+GD4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqYnvt8x48TxVo5JGfXUnQPEcNUIuP54hqlQspbnLZh0q7i86FTamAwzOyZDYe45N9Pq8L11PDyB80dGqJ+VgqzwslROycxtO5QOneb9tYqFUaIUQT4EEpbXiMtvZnwIFTt1yz9A22WLGJB2gEY4SKdeMG5cjr25zrr1XDz2TV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajp3Dpce; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajp3Dpce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705909494; x=1737445494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3G+m/18NThTRa31/ppFhR/nvEFSddDTyIuSRJM+GD4Q=;
  b=ajp3DpcedxPP/sOdFTAFubsg/TuHUYrdkfkKGqelzgE41Vkb4FfU8LG2
   N28AMBSWmgxPV4QDlQuVN5PHGSkYzBKq7W/P6VgpuoArBsLW/vaxn6W1z
   oB7XC54Xtwz0m1lx1dPKA2aRXfI35CDcG4jofvVv5I4v0HILFooP6Wp9v
   q6wBkZmHVYbI6AXNbXiW+wG/nE/JhgIMfvyauLqaNfwtmqnQLknMdJ+iX
   ntHco/g2I2Y7bAeFwsn1nMvZarbhqqmC9iYUhjIwAlR/O1yRoFFlaRljJ
   EjV0JInfWnLZ55tC/gA2NDQacfpzOHozArZ89snsTiRaXyaLnluiu9A82
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22611598"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22611598"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778505006"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778505006"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2024 23:44:49 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 5/8] iommufd: Associate fault object with iommufd_hw_pgtable
Date: Mon, 22 Jan 2024 15:39:00 +0800
Message-Id: <20240122073903.24406-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122073903.24406-1-baolu.lu@linux.intel.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating a user iommufd_hw_pagetable, the user space is allowed to
associate a fault object with the hw_pagetable by specifying the fault
object ID in the page table allocation data and setting the
IOMMU_HWPT_FAULT_ID_VALID flag bit.

On a successful return of hwpt allocation, the user can retrieve and
respond to page faults by reading and writing the file interface of the
fault object.

Once a fault object has been associated with a hwpt, the hwpt is
iopf-capable, indicated by fault_capable set to true. Attaching,
detaching, or replacing an iopf-capable hwpt to an RID or PASID will
differ from those that are not iopf-capable. The implementation of these
will be introduced in the next patch.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 11 ++++++++
 include/uapi/linux/iommufd.h            |  6 +++++
 drivers/iommu/iommufd/fault.c           | 14 ++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    | 36 +++++++++++++++++++------
 4 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 52d83e888bd0..2780bed0c6b1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -293,6 +293,8 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
+	struct iommufd_fault *fault;
+	bool fault_capable : 1;
 };
 
 struct iommufd_hwpt_paging {
@@ -446,8 +448,17 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
+static inline struct iommufd_fault *
+iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_FAULT),
+			    struct iommufd_fault, obj);
+}
+
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
+int iommufd_fault_iopf_handler(struct iopf_group *group);
 
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c32d62b02306..7481cdd57027 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -357,10 +357,13 @@ struct iommu_vfio_ioas {
  *                                the parent HWPT in a nesting configuration.
  * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
  *                                   enforced on device attachment
+ * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
+ *                             valid.
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
+	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
 };
 
 /**
@@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
  * @__reserved: Must be 0
  * @data_type: One of enum iommu_hwpt_data_type
  * @data_len: Length of the type specific data
+ * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
+ *            IOMMU_HWPT_FAULT_ID_VALID is set.
  * @data_uptr: User pointer to the type specific data
  *
  * Explicitly allocate a hardware page table object. This is the same object
@@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
 	__u32 __reserved;
 	__u32 data_type;
 	__u32 data_len;
+	__u32 fault_id;
 	__aligned_u64 data_uptr;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 9844a85feeb2..e752d1c49dde 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -253,3 +253,17 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_fault_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt = group->cookie->domain->fault_data;
+	struct iommufd_fault *fault = hwpt->fault;
+
+	mutex_lock(&fault->mutex);
+	list_add_tail(&group->node, &fault->deliver);
+	mutex_unlock(&fault->mutex);
+
+	wake_up_interruptible(&fault->wait_queue);
+
+	return 0;
+}
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 3f3f1fa1a0a9..2703d5aea4f5 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,6 +8,15 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->domain)
+		iommu_domain_free(hwpt->domain);
+
+	if (hwpt->fault)
+		iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
+}
+
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hwpt_paging *hwpt_paging =
@@ -22,9 +31,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 					 hwpt_paging->common.domain);
 	}
 
-	if (hwpt_paging->common.domain)
-		iommu_domain_free(hwpt_paging->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_paging->common);
 	refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
@@ -49,9 +56,7 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 	struct iommufd_hwpt_nested *hwpt_nested =
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
-	if (hwpt_nested->common.domain)
-		iommu_domain_free(hwpt_nested->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_nested->common);
 	refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
@@ -213,7 +218,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags || !user_data->len || !ops->domain_alloc_user)
+	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	    !user_data->len || !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent)
 		return ERR_PTR(-EINVAL);
@@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
-	hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+	hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
 					      parent->common.domain, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
@@ -307,6 +313,20 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
+	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
+		struct iommufd_fault *fault;
+
+		fault = iommufd_get_fault(ucmd, cmd->fault_id);
+		if (IS_ERR(fault)) {
+			rc = PTR_ERR(fault);
+			goto out_hwpt;
+		}
+		hwpt->fault = fault;
+		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
+		hwpt->domain->fault_data = hwpt;
+		hwpt->fault_capable = true;
+	}
+
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
-- 
2.34.1

