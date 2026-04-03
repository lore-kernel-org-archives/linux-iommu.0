Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC57359A61
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775193119; cv=none; b=BrlzEPgcX5PDh3fCUtjbiZby/ragNngdKHKtd+CZ/wfLmaVZ2Yse7rOk0cQVggvhGVtsAJANRKfxiXtWgum07lr0YucNntrtGRga7vC+GGooF6MFLE9k5RPjYdL/t2DQsfKkOGA8F5+rRcsYkTt8OtgkeDmEC7DycoCY3rFXG3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775193119; c=relaxed/simple;
	bh=r9uS1u4FyJ+3NCQ6ITbuIK0WrTodfCVWNAT1xwSzMPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYnjr5EugCNHUR7KqxcujjT49/UEEJbcjBayZAfpEmUIoWomQLLP8NaYPwktfEmUe+85SdtGN6yTJ/1vsIoEk8yGBIW4rjViKs3uor1mUvdRFdmcrOGrjUJVfObybjRFIaGSMajQTEBj7IuXjews8IR8NwetpVnfQl9iBHCEXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iT/9wsG5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iT/9wsG5"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1163120B713B;
	Thu,  2 Apr 2026 22:11:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1163120B713B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775193115;
	bh=0XLHYn1MtL0Hn31TAJOci4t1QT0kv89JwvfP0cPC1Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iT/9wsG5jzVZAuHbmiwWzxNGBktgmN8VrlEcY+VphWvs7rHHm3EUGDo0oUDXELy5X
	 XHJfu9DacX3zF2MZI9j/4Bi8lnZ3nRi7vQA++ESTRmfysge6E1Ue/l8WzeYBrulbdD
	 HGqbzYRJk3zkxrQPZXvE6TfmqpFlEVIAXaaMvsr8=
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
Subject: [PATCH V3 05/10] vfio: Allow null group for noiommu without containers
Date: Thu,  2 Apr 2026 22:11:41 -0700
Message-Id: <20260403051146.10210-6-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
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
index 0fa9761b13d3..9e88610934c8 100644
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
-- 
2.34.1

