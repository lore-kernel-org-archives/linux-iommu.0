Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E06263F5D
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034264; cv=none; b=M8FOV1USUJ6C2IeI34FF5e5oJMUOzgfJdlxb2q7ep9SSNjRWin01jL65BdAb/as9y+midFdfRhWHh0z1ZenmXz3gRtfjFVRCsNbIpMZNv1D5ABul8X2vhdG8C+DRDRdAOMvyI3GP5F64Ux9NbOT5v0Ch4oxtGtnldNATpnb2NAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034264; c=relaxed/simple;
	bh=Eur89hJPxvnHqwEMw2EpPn8/RxU/EpEFx7z9l0CyxRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9I4+o8ZhKU6h5vmdLubwcR58qwFQCjD56SLjo8Fp8lnPhCQMFy/0H2FBRkgQJSEyesDsEa3r1whrQfkWDLRbEif/FRIvVRLhUQIeSZBxGOx9AIzERCDdmjeptpA/vOYyRTclQIeI7HJOR9oPv9uaIm9NbnDH4/9Qjhsee7Xrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBApEcq7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBApEcq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034262; x=1783570262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eur89hJPxvnHqwEMw2EpPn8/RxU/EpEFx7z9l0CyxRo=;
  b=SBApEcq7Qe34DlN7MstYKOaKZHvEweY9TiQneOrlJddT/3cJqafj1zoy
   0rgGWz9Juqk576yuWEQZuwWM+On3aQyhQSqkoLa2T+cTR8/IivQ7euCRW
   egjLPnuRWWTERFNGKQHYN4iOig4FlDKpucKFVFH6xefIvn2CkL7+8Rz7C
   Q5kxRTVVot7dE0bX7AUIF8j8Ngt0jQI0I3rAS3OxYkSF1e67oygGlQEJ7
   A37nu8Msgak4uV3esFx4dvPO6kkp48MqU8RFeTcdt6zELLqijpUZHYfzT
   HcVz3UMmO7njxXBRPSKu6o/LHIT7IyM1VVDc2lvfpJOe6ZtU+td7eSasG
   g==;
X-CSE-ConnectionGUID: wlD4cOMXTGK/6VCn86ollw==
X-CSE-MsgGUID: 0ntxci8JSCyrfWu+vCU7Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831783"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831783"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:11:02 -0700
X-CSE-ConnectionGUID: xfxnayMBTyqaHfyisvdcCA==
X-CSE-MsgGUID: fvo3WRe8T8qkT4nESGrnUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851578"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:10:59 -0700
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
Subject: [PATCH v4 2/7] iommufd: Add iommufd_object_tombstone_user() helper
Date: Wed,  9 Jul 2025 12:02:29 +0800
Message-Id: <20250709040234.1773573-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
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
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 ++++++++++++++++++++++-
 drivers/iommu/iommufd/main.c            | 24 ++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 4f5e8cd99c96..da1bced8c945 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -188,7 +188,8 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
 enum {
-	REMOVE_WAIT_SHORTTERM = 1,
+	REMOVE_WAIT_SHORTTERM	= BIT(0),
+	REMOVE_OBJ_TOMBSTONE	= BIT(1),
 };
 int iommufd_object_remove(struct iommufd_ctx *ictx,
 			  struct iommufd_object *to_destroy, u32 id,
@@ -214,6 +215,26 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
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
index 778694d7c207..25ab2f41d650 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -216,7 +216,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 		goto err_xa;
 	}
 
-	xas_store(&xas, NULL);
+	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
 	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
 		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
@@ -298,22 +298,42 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	 * until the entire list is destroyed. If this can't progress then there
 	 * is some bug related to object refcounting.
 	 */
-	while (!xa_empty(&ictx->objects)) {
+	for (;;) {
 		unsigned int destroyed = 0;
 		unsigned long index;
+		bool empty = true;
 
+		/*
+		 * xa_for_each() will not return tomestones (zeroed entries),
+		 * which prevent the xarray being empty. So use an empty flag
+		 * instead of xa_empty() to indicate all entries are either
+		 * NULLed or tomestoned.
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

