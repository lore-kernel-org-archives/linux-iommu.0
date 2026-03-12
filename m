Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A53F2111
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331011; cv=none; b=Mtv840essDAbDmZ8xwGDrMGtfKnUtHlr42n6wd/cNMfZoAkkhtnpHJUTiwJBBzL97il3OXiCCA9Tx1ZP9p6QxadsPRZJRN1tg6P4ftdtRxyF8DXtXm2PClwmrpGCjxdYRKzEB/VDJ0ozqes9snQb2N4ptr5raJjOTHITeV061E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331011; c=relaxed/simple;
	bh=xQZojr3GFxPw6/kHY8lEwIocu5M2D6Kr99QXLjDyrug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxXELYJuSC766RwJmYLR5vn1OTOV6V/IXKvAxxXq9oL7BarOsf0FtzbYf7N8ZD8g01nJJAa4xgrXX8lbH5bmnIEk33lO48Ykjay3SZZi6w/7+g389dCmMWRM7Du1IPcQ/71pqRdI5bkIiVmBHbQ2C/0MC+JaOkI4LUGfeJIUeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dz/42FJ1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dz/42FJ1"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id F0DC120B6F01;
	Thu, 12 Mar 2026 08:56:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0DC120B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773331010;
	bh=FcyuZJLhmRk9Mvmk2JcfREx8/0r88nbmt1CfI0Gl/EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dz/42FJ1K9X0Svi3dlsabPIcLoeFYNVXOsntIqHO3HAGki6cy5/uzxxgnzzCTmWMQ
	 VmRd6cxD7Uq+2cRWxCot0ywpFEocd3U6GGLlhHFL/X3L4RmeCBTKgyv8UUuNYU61Qq
	 clnetLuzy0RaSwsREu0KwXvY8wVPjNo/5KW6CrY0=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V2 05/11] vfio: Allow null group for noiommu without containers
Date: Thu, 12 Mar 2026 08:56:31 -0700
Message-Id: <20260312155637.376854-6-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of noiommu mode is enabled for VFIO cdev without VFIO container
nor IOMMUFD provided compatibility container, there is no need to
create a dummy group. Update the group operations to tolerate null group
pointer.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/group.c | 14 ++++++++++++++
 drivers/vfio/vfio.h  | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..98f2a4f2ebff 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -381,6 +381,9 @@ int vfio_device_block_group(struct vfio_device *device)
 	struct vfio_group *group = device->group;
 	int ret = 0;
 
+	if (vfio_null_group_allowed() && !group)
+		return 0;
+
 	mutex_lock(&group->group_lock);
 	if (group->opened_file) {
 		ret = -EBUSY;
@@ -398,6 +401,9 @@ void vfio_device_unblock_group(struct vfio_device *device)
 {
 	struct vfio_group *group = device->group;
 
+	if (vfio_null_group_allowed() && !group)
+		return;
+
 	mutex_lock(&group->group_lock);
 	group->cdev_device_open_cnt--;
 	mutex_unlock(&group->group_lock);
@@ -589,6 +595,14 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	struct vfio_group *group;
 	int ret;
 
+	/*
+	 * With noiommu enabled under cdev interface only, there is no need to
+	 * create a vfio_group if the group based containers are not enabled.
+	 * The cdev interface is exclusively used for iommufd.
+	 */
+	if (vfio_null_group_allowed())
+		return NULL;
+
 	iommu_group = iommu_group_alloc();
 	if (IS_ERR(iommu_group))
 		return ERR_CAST(iommu_group);
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..838c08077ce2 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -113,6 +113,18 @@ bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
 
+/*
+ * With noiommu enabled and no containers are supported, allow devices that
+ * don't have a dummy group.
+ */
+static inline bool vfio_null_group_allowed(void)
+{
+	if (vfio_noiommu && (!IS_ENABLED(CONFIG_VFIO_CONTAINER) && !IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER)))
+		return true;
+
+	return false;
+}
+
 static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
 {
 	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
@@ -189,6 +201,11 @@ static inline void vfio_group_cleanup(void)
 {
 }
 
+static inline bool vfio_null_group_allowed(void)
+{
+	return false;
+}
+
 static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
 {
 	return false;
-- 
2.34.1

