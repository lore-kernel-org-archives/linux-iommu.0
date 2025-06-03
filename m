Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7623BCF3
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964233; cv=none; b=FdTkJLChrBkAjfXwgD9q/fMrzstpYYkiB9nSm48kStPxAXJGuKRsY8IYc6fQj4fZbYUpIbu4vzTOXHWZTRcUBreDTnz53AJG2uD8C52AOWVeKUkezfRLHBs82HZiif+HmAKO9v7yGVW7n5R2TnyNpLREdxcHRkqfsfu7EYUT7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964233; c=relaxed/simple;
	bh=JJnGrIjE6naL3oGjRh6/MBEFHgom2M/7ArvHRcliA18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHaPTygBRAzu+nCCJ7iKeCyXoOXAow5xrovkr2gnjEJu9EHy6x50M4bp4Bse7VFd1ODy5bKrfc/WuuP8ivyBjxWm0PgaluuygSXlS3opTW2YF6Aj0XT4Q9ztn2gen90PStCjuiKLEzEHNBhXkT2pp3VoVmK9yy1f+NsGb2ufJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y/SF2V6Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y/SF2V6Z"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 848F52113A78;
	Tue,  3 Jun 2025 08:23:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 848F52113A78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748964224;
	bh=nEZGhZIEBiGEYK9Ra1JaVWMXDfX+1OH7IrG6xPm0nMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/SF2V6ZpO3BtmMPxp2lV0gH/5Uu55509aRJh9ELDRR7plYZQ1JJMYzM3Dyd7izPt
	 Ekv2eBIrlgxd5DL2cKrUgx3X5k+3ZnELId9T87add6Xl3Px1QbtS4FcNxVfE9Tx6g7
	 f4PrSm8zi8DmacLBfIWC8uxNzwGCGLMcjM8TVBwA=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v2 2/2] vfio: Fix unbalanced vfio_df_close call in no-iommu mode
Date: Tue,  3 Jun 2025 08:23:43 -0700
Message-Id: <20250603152343.1104-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group
open path skips vfio_df_open(), leaving open_count at 0. This causes a
warning in vfio_assert_device_open(device) when vfio_df_close() is called
during group close.

The correct behavior is to skip only the IOMMUFD bind in the device open
path for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(),
which was too broad. This patch restores the previous behavior, ensuring
the vfio_df_open is called in the group open path.

Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v2: Use a fix from Jason
---
 drivers/vfio/group.c     | 10 +++++-----
 drivers/vfio/iommufd.c   |  3 ---
 drivers/vfio/vfio_main.c | 26 ++++++++++++++++----------
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c321d442f0da..8f5fe8a392de 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 		 * implies they expected translation to exist
 		 */
 		if (!capable(CAP_SYS_RAWIO) ||
-		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
+		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
 			ret = -EPERM;
-		else
-			ret = 0;
-		goto out_put_kvm;
+			goto out_put_kvm;
+		}
 	}
 
 	ret = vfio_df_open(df);
 	if (ret)
 		goto out_put_kvm;
 
-	if (df->iommufd && device->open_count == 1) {
+	if (df->iommufd && device->open_count == 1 &&
+	    !vfio_device_is_noiommu(device)) {
 		ret = vfio_iommufd_compat_attach_ioas(device, df->iommufd);
 		if (ret)
 			goto out_close_device;
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index c8c3a2d53f86..26c9c3068c77 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -54,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_noiommu(vdev))
-		return;
-
 	if (vdev->ops->unbind_iommufd)
 		vdev->ops->unbind_iommufd(vdev);
 }
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 5046cae05222..ac2dbd4e5d04 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -506,17 +506,19 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
 {
 	struct vfio_device *device = df->device;
 	struct iommufd_ctx *iommufd = df->iommufd;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&device->dev_set->lock);
 
 	if (!try_module_get(device->dev->driver->owner))
 		return -ENODEV;
 
-	if (iommufd)
-		ret = vfio_df_iommufd_bind(df);
-	else
+	if (iommufd) {
+		if (!vfio_device_is_noiommu(device))
+			ret = vfio_df_iommufd_bind(df);
+	} else {
 		ret = vfio_device_group_use_iommu(device);
+	}
 	if (ret)
 		goto err_module_put;
 
@@ -528,10 +530,12 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
 	return 0;
 
 err_unuse_iommu:
-	if (iommufd)
-		vfio_df_iommufd_unbind(df);
-	else
+	if (iommufd) {
+		if (!vfio_device_is_noiommu(device))
+			vfio_df_iommufd_unbind(df);
+	} else {
 		vfio_device_group_unuse_iommu(device);
+	}
 err_module_put:
 	module_put(device->dev->driver->owner);
 	return ret;
@@ -546,10 +550,12 @@ static void vfio_df_device_last_close(struct vfio_device_file *df)
 
 	if (device->ops->close_device)
 		device->ops->close_device(device);
-	if (iommufd)
-		vfio_df_iommufd_unbind(df);
-	else
+	if (iommufd) {
+		if (!vfio_device_is_noiommu(device))
+			vfio_df_iommufd_unbind(df);
+	} else {
 		vfio_device_group_unuse_iommu(device);
+	}
 	module_put(device->dev->driver->owner);
 }
 
-- 
2.34.1

