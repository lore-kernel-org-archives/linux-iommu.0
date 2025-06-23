Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0E23D280
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672645; cv=none; b=gKTWkD73jSEmXugcpEMoVW93OXCY2ORXAeAg2fJjbM11nPakoyOdVY71xPDe0BRlmez3EsMMTreF4J7S+K+oicekk4YSKNDsiH9LFuB+faHNKZHx+Ogpmz63j4zs+2zDOVZjBc5q6H2HbeUumykfYazGSdUhDaN8Awl/PQQdbl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672645; c=relaxed/simple;
	bh=R4ymocCvY35VgWBYLTK+OrWIsRUfApFcm1v81xqi+wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twtJyq+L5SkTqCGizjjhZ8v7sMgTK//ebWyD0KEV5W33DfHqo5WTqO1OJprwBJ9c8ADi32HriVi4gn0qiESWqH4htEn2oXDBh7xc1YGsPbsBvXzrMfR+lbUZGh+s9IYv2x5beSYm/78FFm2u77sYT1R4MAdhker2FnwI6+NShvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEG3duXC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEG3duXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750672643; x=1782208643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4ymocCvY35VgWBYLTK+OrWIsRUfApFcm1v81xqi+wc=;
  b=ZEG3duXCl/Sm4xD+3K9ZtrlmijM6e0Y0mJHow5aX/PzMZjivh0C6ecsk
   Vs6nzZwe58oALLAcFIqirevV7lC0ZdO2fTawvuy6ed71tNyGltPyQ8Aiz
   6bkyAZ+tPLUR+zKmecD3Xn0CUSUAXy8WJCRPU8HahT0wtuZxOdr0iGGFk
   xD+w/BzhkI7IJmPzh+B+OjDgBj8SIj5szpGQzY9cYb/LjMF38pf9rVD7L
   V/tQ/pNj5YsS12eWTo+y//BL8bChFNfOFX7YBmxTx1KBodUnjHZTWyPv4
   reKSBWrOoH7C8LZNHOvPsj4roUhFcI8USHOoxU0ao+q4Q6B3kBdm081U9
   g==;
X-CSE-ConnectionGUID: rNsysxjZT7y8Sd2+O0oMyQ==
X-CSE-MsgGUID: YxeG/cy5TVuppis13vfSgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78285795"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="78285795"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:57:23 -0700
X-CSE-ConnectionGUID: XB7CLA9uS/eCizvlqNrJWA==
X-CSE-MsgGUID: SrRtBjALRLGNUhwSn/eBkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155859340"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jun 2025 02:57:20 -0700
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
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v2 1/4] iommufd: Add iommufd_object_tombstone_user() helper
Date: Mon, 23 Jun 2025 17:49:43 +0800
Message-Id: <20250623094946.1714996-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
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
object ID without awareness from the original user.

Since this happens for abnomal userspace behavior, for simplicity, the
tombstoned object ID would be permanently leaked until
iommufd_fops_release(). I.e. the original user gets an error when
calling ioctl(IOMMU_DESTROY) on that ID.

The first use case would be to ensure the iommufd_vdevice can't outlive
the associated iommufd_device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 23 +++++++++++++++++-
 drivers/iommu/iommufd/main.c            | 31 ++++++++++++++++++-------
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ccc83341f32..fbc9ef78d81f 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -187,7 +187,8 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
 enum {
-	REMOVE_WAIT_SHORTTERM = 1,
+	REMOVE_WAIT_SHORTTERM	= BIT(0),
+	REMOVE_OBJ_TOMBSTONE	= BIT(1),
 };
 int iommufd_object_remove(struct iommufd_ctx *ictx,
 			  struct iommufd_object *to_destroy, u32 id,
@@ -213,6 +214,26 @@ static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
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
index 3df468f64e7d..5fd75aba068b 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -167,7 +167,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 		goto err_xa;
 	}
 
-	xas_store(&xas, NULL);
+	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
 	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
 		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
@@ -238,6 +238,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	struct iommufd_ctx *ictx = filp->private_data;
 	struct iommufd_sw_msi_map *next;
 	struct iommufd_sw_msi_map *cur;
+	XA_STATE(xas, &ictx->objects, 0);
 	struct iommufd_object *obj;
 
 	/*
@@ -251,16 +252,30 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	 */
 	while (!xa_empty(&ictx->objects)) {
 		unsigned int destroyed = 0;
-		unsigned long index;
 
-		xa_for_each(&ictx->objects, index, obj) {
-			if (!refcount_dec_if_one(&obj->users))
-				continue;
+		xas_set(&xas, 0);
+		for (;;) {
+			rcu_read_lock();
+			obj = xas_find(&xas, ULONG_MAX);
+			rcu_read_unlock();
+
+			if (!obj)
+				break;
+
+			if (!xa_is_zero(obj)) {
+				if (!refcount_dec_if_one(&obj->users))
+					continue;
+
+				iommufd_object_ops[obj->type].destroy(obj);
+				kfree(obj);
+			}
+
 			destroyed++;
-			xa_erase(&ictx->objects, index);
-			iommufd_object_ops[obj->type].destroy(obj);
-			kfree(obj);
+			xas_lock(&xas);
+			xas_store(&xas, NULL);
+			xas_unlock(&xas);
 		}
+
 		/* Bug related to users refcount */
 		if (WARN_ON(!destroyed))
 			break;
-- 
2.25.1

