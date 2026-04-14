Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792437FF67
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201260; cv=none; b=JqCfzlta9VTMYqqtGkilLpoDbzpy6BVqn7np2CtxFzEf5ZAgYy1XkqzyqMixTPZGWO7CnlrudOJR4w1gWQVMCKUotXhK6wjqRLKyCkemc8W5IXMmdBmOkZ18vAYJ5K1MAJHUxLeSgI7T3hCv7zqm/jI2G0UshCMANe+pBuQME2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201260; c=relaxed/simple;
	bh=zISu7q0PpKyEhEY/6t/70q0QbuRGGmIjDGc/QHXhVis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ImIcwbxNBRzsRZOO3NbFamNocMzx2X+QTPRqKiBaQMWAuTTSEVMyDIDgA1LOZeV444nIPi5KkNM/iwLsPVrzJ3BbFr7JkYfAoz7gNdfdVHzpqo7d8e7hJ/QG13xJIUqVk029PP337N8/tOJbWpqN/NdOXRwS0FiKOB1PZBDJF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OS1iKw8O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OS1iKw8O"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id EFF1B20B6F01;
	Tue, 14 Apr 2026 14:14:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFF1B20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776201258;
	bh=oVf1LLQ0I/WldtbE72D4+914B1WjLkuib6Ic+fwSG8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OS1iKw8OqrOGLBnARs3fKGG5W/3uChV0sx/QJ605tw+bmwreB2Z8ek0O++Aixgc66
	 fLyJDcBpSK4k46JmdmScgOpVJ53802zwssEMGyp3WkxMgtFgf/PCFr2tGqweedPINB
	 qhUy7bj8ayxbQtBjRKOk/ye+k0iSuJUomfKQ2etE=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
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
Subject: [PATCH V4 05/10] vfio: Allow null group for noiommu without containers
Date: Tue, 14 Apr 2026 14:14:07 -0700
Message-Id: <20260414211412.2729-6-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
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
v4: (Jason)
   - Avoid null pointer deref in error unwind
   - Add null group check in vfio_device_group_unregister
   - repartition to include vfio_device_has_group() in this patch
---
 drivers/vfio/group.c     | 20 ++++++++++++++++++++
 drivers/vfio/vfio.h      | 17 +++++++++++++++++
 drivers/vfio/vfio_main.c | 14 ++++++++++++++
 include/linux/vfio.h     |  9 +++++++++
 4 files changed, 60 insertions(+)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 0fa9761b13d3..451e49d851f8 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -390,6 +390,9 @@ int vfio_device_block_group(struct vfio_device *device)
 	struct vfio_group *group = device->group;
 	int ret = 0;
 
+	if (vfio_null_group_allowed() && !group)
+		return 0;
+
 	mutex_lock(&group->group_lock);
 	if (group->opened_file) {
 		ret = -EBUSY;
@@ -407,6 +410,9 @@ void vfio_device_unblock_group(struct vfio_device *device)
 {
 	struct vfio_group *group = device->group;
 
+	if (vfio_null_group_allowed() && !group)
+		return;
+
 	mutex_lock(&group->group_lock);
 	group->cdev_device_open_cnt--;
 	mutex_unlock(&group->group_lock);
@@ -598,6 +604,14 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
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
@@ -705,6 +719,9 @@ void vfio_device_remove_group(struct vfio_device *device)
 	struct vfio_group *group = device->group;
 	struct iommu_group *iommu_group;
 
+	if (!group)
+		return;
+
 	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
 		iommu_group_remove_device(device->dev);
 
@@ -756,6 +773,9 @@ void vfio_device_group_register(struct vfio_device *device)
 
 void vfio_device_group_unregister(struct vfio_device *device)
 {
+	if (!device->group)
+		return;
+
 	mutex_lock(&device->group->device_lock);
 	list_del(&device->group_next);
 	mutex_unlock(&device->group->device_lock);
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 8fcc98cf9577..db1530bb1716 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -114,6 +114,18 @@ bool vfio_device_has_container(struct vfio_device *device);
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
@@ -190,6 +202,11 @@ static inline void vfio_group_cleanup(void)
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
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index e5886235cad4..5d7c2d014689 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -358,6 +358,10 @@ static int __vfio_register_dev(struct vfio_device *device,
 	/* Refcounting can't start until the driver calls register */
 	refcount_set(&device->refcount, 1);
 
+	/* noiommu device w/o container may have NULL group */
+	if (!vfio_device_has_group(device))
+		return 0;
+
 	vfio_device_group_register(device);
 	vfio_device_debugfs_init(device);
 
@@ -392,6 +396,16 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 	bool interrupted = false;
 	long rc;
 
+	/*
+	 * For noiommu devices without a container, thus no dummy group,
+	 * simply delete and unregister to balance refcount.
+	 */
+	if (!vfio_device_has_group(device)) {
+		vfio_device_del(device);
+		vfio_device_put_registration(device);
+		return;
+	}
+
 	/*
 	 * Prevent new device opened by userspace via the
 	 * VFIO_GROUP_GET_DEVICE_FD in the group path.
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 7384965d15d7..ceb5034c3a2e 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -328,6 +328,10 @@ struct iommu_group *vfio_file_iommu_group(struct file *file);
 #if IS_ENABLED(CONFIG_VFIO_GROUP)
 bool vfio_file_is_group(struct file *file);
 bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
+static inline bool vfio_device_has_group(struct vfio_device *device)
+{
+	return device->group;
+}
 #else
 static inline bool vfio_file_is_group(struct file *file)
 {
@@ -338,6 +342,11 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 {
 	return false;
 }
+
+static inline bool vfio_device_has_group(struct vfio_device *device)
+{
+	return false;
+}
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-- 
2.34.1

