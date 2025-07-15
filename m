Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DF126F477
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561693; cv=none; b=KBdsf1Ktu7uJiRAvod0BJeOXwcswYpGUqoIk89BsaVvwxwfBBb3g5PIJtunh+IBdRAPH4azO8bg+ZqLLblzyU6OmTZfQqXeUMDgV9ZzYvptv6NNAId7JJDG/2JgqT4gjdL3kwy7zOOCWCQZMq5zdfB659ASXadI9ZOuXVxs+IuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561693; c=relaxed/simple;
	bh=JITLAe7Ss9LRUk8R17DJr/BRXXLBIam+ZkRxFIaW8YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRoYXlizq/nvq+1KqT3xskGVl3CeovigobEneNq152KVdm4yb/ixsujXqeitXp7YERCpoLbUeYzLWoaI/ZSQbbz0CPrRIeixF4ZOxeJQU/7TeOzbdLYP+MRxRHTPSjkTT3sq1jzLHht66gYVyVjWuxRSgEa0iQSiCVKRoRIMjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R82GccxX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R82GccxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561692; x=1784097692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JITLAe7Ss9LRUk8R17DJr/BRXXLBIam+ZkRxFIaW8YI=;
  b=R82GccxX0s75VB5lflLJJjpJZw1o66skg8UkDLNeVRbhKUTVu3xI2Lua
   xXtkQ6edUfBDU6vihD8yYM7SoNuHvZYBNLAaTe5HyIARRaZaeTAIE26Mr
   pz6ZEoYFpxc93i0T2vWuxoFDmDVoiLXtP2th/3WsXBYDQ8JmSkb2gZRMd
   HPvTMSyg5LsTJf6iAxIV+kjarcBm4jL1cR0a3XzXzR4WoXUA43v+eaGXj
   0Hrx6uF3o12RedWMvdojBth3mJo5U3tQIykyRIgHOFZ1+nHCFfAcW9krt
   ODPTxmSsbzu+MstARAc7bSEX8AYMLYSZLdCwGlyBMywflzSiqb4xkAOKh
   Q==;
X-CSE-ConnectionGUID: gh6TO33uTzmJ/PwX6gK8zw==
X-CSE-MsgGUID: lIPLu3cQQaCaRbXe7hjDqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880836"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880836"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:32 -0700
X-CSE-ConnectionGUID: ZxAGOtpZSBGNm/sp09Qn8Q==
X-CSE-MsgGUID: 9fhg/NNRQ4KbAqJxNCyu2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157648967"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:28 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v5 2/8] iommufd: Add iommufd_object_tombstone_user() helper
Date: Tue, 15 Jul 2025 14:32:39 +0800
Message-Id: <20250715063245.1799534-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the iommufd_object_tombstone_user() helper, which allows the caller
to destroy an iommufd object created by userspace.

This is useful on some destroy paths when the kernel caller finds the
object should have been removed by userspace but is still alive. With
this helper, the caller destroys the object but leave the object ID
reserved (so called tombstone). The tombstone prevents repurposing the
object ID without awareness of the original user.

Since this happens for abnormal userspace behavior, for simplicity, the
tombstoned object ID would be permanently leaked until
iommufd_fops_release(). I.e. the original user gets an error when
calling ioctl(IOMMU_DESTROY) on that ID.

The first use case would be to ensure the iommufd_vdevice can't outlive
the associated iommufd_device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            | 24 +++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index cd14163abdd1..149545060029 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -202,7 +202,8 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
 enum {
-	REMOVE_WAIT_SHORTTERM = 1,
+	REMOVE_WAIT_SHORTTERM	= BIT(0),
+	REMOVE_OBJ_TOMBSTONE	= BIT(1),
 };
 int iommufd_object_remove(struct iommufd_ctx *ictx,
 			  struct iommufd_object *to_destroy, u32 id,
@@ -228,6 +229,26 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
 	WARN_ON(ret);
 }
 
+/*
+ * Similar to iommufd_object_destroy_user(), except that the object ID is left
+ * reserved/tombstoned.
+ */
+static inline void iommufd_object_tombstone_user(struct iommufd_ctx *ictx,
+						 struct iommufd_object *obj)
+{
+	int ret;
+
+	ret = iommufd_object_remove(ictx, obj, obj->id,
+				    REMOVE_WAIT_SHORTTERM | REMOVE_OBJ_TOMBSTONE);
+
+	/*
+	 * If there is a bug and we couldn't destroy the object then we did put
+	 * back the caller's users refcount and will eventually try to free it
+	 * again during close.
+	 */
+	WARN_ON(ret);
+}
+
 /*
  * The HWPT allocated by autodomains is used in possibly many devices and
  * is automatically destroyed when its refcount reaches zero.
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 69c2195e77ca..71135f0ec72d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -225,7 +225,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 		goto err_xa;
 	}
 
-	xas_store(&xas, NULL);
+	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
 	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
 		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
@@ -311,19 +311,41 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	while (!xa_empty(&ictx->objects)) {
 		unsigned int destroyed = 0;
 		unsigned long index;
+		bool empty = true;
 
+		/*
+		 * We can't use xa_empty() to end the loop as the tombstones
+		 * are stored as XA_ZERO_ENTRY in the xarray. However
+		 * xa_for_each() automatically converts them to NULL and skips
+		 * them causing xa_empty() to be kept false. Thus once
+		 * xa_for_each() finds no further !NULL entries the loop is
+		 * done.
+		 */
 		xa_for_each(&ictx->objects, index, obj) {
+			empty = false;
 			if (!refcount_dec_if_one(&obj->users))
 				continue;
+
 			destroyed++;
 			xa_erase(&ictx->objects, index);
 			iommufd_object_ops[obj->type].destroy(obj);
 			kfree(obj);
 		}
+
+		if (empty)
+			break;
+
 		/* Bug related to users refcount */
 		if (WARN_ON(!destroyed))
 			break;
 	}
+
+	/*
+	 * There may be some tombstones left over from
+	 * iommufd_object_tombstone_user()
+	 */
+	xa_destroy(&ictx->objects);
+
 	WARN_ON(!xa_empty(&ictx->groups));
 
 	mutex_destroy(&ictx->sw_msi_lock);
-- 
2.25.1

