Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3B289E36
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649970; cv=none; b=ZqCan5f2tg9xb4v5np6kgSsLueSHUWWIdFt/Mg2nxt7G2W7exQYFp4do16qJ+gsAnjbqeYtGs2sy3M4ckd4Jbw2XqQyc0maL2tSxcARQFE33Pm7OyUzG7Tewmul3M23kXLaSk998qvMluxUc2z1EpQXxRcinjcVq3sIuWPaFVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649970; c=relaxed/simple;
	bh=M0kCbGdguK2I01sYIudQTuezVBCEY6JDjSwYgkYvvVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBATtXkfO5Dl+rWuEQtWqiWnU/RzLP4o5fWfcfk3JMLCGqFpH/k9lcf2qSWKw2apDbmfJ+UNAKaNsr2RNgdcnNUeGDCMUchFWOi909Doovh7eMfGegsKNYdU/FuJ/i+scLl8hiJXA0xCu34MgjxyaBTIvHiOg4+/lN6ELAaOK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MS7fB0N4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MS7fB0N4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649969; x=1784185969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0kCbGdguK2I01sYIudQTuezVBCEY6JDjSwYgkYvvVE=;
  b=MS7fB0N4UwaHt+drPdy+iosriAkzhE5Uup8mcKQ7RVPaLT2f38az8znd
   9AClt5O8z1YUqNyKwz8Q09dBaQB3L1s7ngmmgeEEIER2GnSAlKjVXD1I8
   zDtZflGDgxPo4Dvrgs1pHXW8Ki+XyrSav5NL8fFmUxACl/aPiBVaCwndP
   MIhqchC5DOJEYleJrMb418ivQlCm0fbRCwAF9ogV66Iy1EfZ4YD4HZNz5
   828I8iQknj9lJZ1VNhBp1e5ynhNhb+etOLEY8yFJcjV5DNXkW+T1giJqh
   XRbRnyCvpz2c6+kOarESEu5+D9JFCMaZ15cJWUisooiH29OqfQw0zEcAo
   Q==;
X-CSE-ConnectionGUID: 1vJFXQFbSD2C2YWKKbs+yQ==
X-CSE-MsgGUID: BqLYWi+TQm6E6YsswRqfNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540799"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540799"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:37 -0700
X-CSE-ConnectionGUID: j9rzoG2zTP+vUbJ97F1ByA==
X-CSE-MsgGUID: vo9QC6qAThyXxKIvxVVXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453640"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:33 -0700
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
Subject: [PATCH v6 2/8] iommufd: Add iommufd_object_tombstone_user() helper
Date: Wed, 16 Jul 2025 15:03:43 +0800
Message-Id: <20250716070349.1807226-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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

