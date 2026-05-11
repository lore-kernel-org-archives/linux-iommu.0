Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE84BC023
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524884; cv=none; b=rCuu946MyA9X+RBSA/9SjNfOm6oVkOFRyJxH5ptkcgOpzbJNkJOuNRZN82CnU/86sRjsLUPz2MkBghOS2JOCpRA976t6THY7iLjq7sduuFMsXsfouhLPZIC4/C3xvZgON3yzbHDPhOZCC49dXxHHNnR8BuQKzfwRdOS8cuufpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524884; c=relaxed/simple;
	bh=bQsSNTNsI2IlIYddQCMknSy1Db/4RJRmkKxSm/jKHvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHYDYfe/4OxoI+S/yT9eFSLuMlMJ/19h5ny2QnAGaG3f6+VHSY5wmBOezvWzwnAYdDCvW95ArmeJ1MAGEJXclQX18ZSEMtNJW8qjV0u3AbifBhKVh+C11d554DiNv30qeF42U1WIr9DC7YXfNl+fgcM7q80Fgf25BJUMLb7EVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y8lccsXz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y8lccsXz"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A76620B7169;
	Mon, 11 May 2026 11:41:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A76620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778524880;
	bh=TDZ5i67VQF3EWjuduA+apFnardmoQaxov31srAy2fpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8lccsXz7o2I2td4BBDbTkk3NCB4UAQcooWM6THembNSODIXKXXvR+hdXVqQ+ewUm
	 H+sQWHL7fmoed8loB53FgwRVVknUbTpBcTFaow3yA+2IYvakV71+M3odae9IEcLtUk
	 h/NppbsGCQRc0lDIm+MSu1nOnToCM3sBUb/7l6TQ=
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
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 6/9] vfio/group: Add VFIO_CDEV_NOIOMMU Kconfig and tolerate NULL group
Date: Mon, 11 May 2026 11:41:11 -0700
Message-ID: <20260511184116.3687392-7-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new CONFIG_VFIO_CDEV_NOIOMMU option, independent of
CONFIG_VFIO_GROUP, to support noiommu mode via the cdev interface.

Since CONFIG_VFIO_GROUP can be enabled while CONFIG_VFIO_GROUP_NOIOMMU
is not, guard the noiommu group allocation in vfio_group_find_or_alloc()
with IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) to prevent creating spurious
/dev/vfio/noiommu-N group files when only cdev noiommu is configured.

For cdev noiommu devices that have no group, let vfio_device_set_group()
return success with a NULL group pointer and add null guards in group
functions that may be called during device lifecycle. These guards are
contained within group.c and are dead code for IOMMU-enabled devices
where device->group is always non-NULL.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/Kconfig | 17 +++++++++++++++++
 drivers/vfio/group.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 39939be2908e..b1b1633412a9 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -75,6 +75,23 @@ config VFIO_GROUP_NOIOMMU
 
 	  If you don't know what to do here, say N.
 
+config VFIO_CDEV_NOIOMMU
+	bool "VFIO cdev No-IOMMU support"
+	depends on VFIO_DEVICE_CDEV
+	select IOMMUFD_NOIOMMU
+	help
+	  VFIO cdev no-IOMMU mode enables device access via the cdev
+	  interface without hardware IOMMU backing. This relies on
+	  IOMMUFD_NOIOMMU to provide a SW-only IO page table for
+	  IOVA-to-PA lookups.
+
+	  Use of this mode will result in an unsupportable kernel and
+	  will therefore taint the kernel. Device assignment to virtual
+	  machines is also not possible with this mode since there is
+	  no IOMMU to provide DMA translation.
+
+	  If you don't know what to do here, say N.
+
 config VFIO_VIRQFD
 	bool
 	select EVENTFD
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 5b9329df04e5..c8a75ee28f20 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -386,6 +386,9 @@ int vfio_device_block_group(struct vfio_device *device)
 	struct vfio_group *group = device->group;
 	int ret = 0;
 
+	if (!group)
+		return 0;
+
 	mutex_lock(&group->group_lock);
 	if (group->opened_file) {
 		ret = -EBUSY;
@@ -403,6 +406,9 @@ void vfio_device_unblock_group(struct vfio_device *device)
 {
 	struct vfio_group *group = device->group;
 
+	if (!group)
+		return;
+
 	mutex_lock(&group->group_lock);
 	group->cdev_device_open_cnt--;
 	mutex_unlock(&group->group_lock);
@@ -641,7 +647,8 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 	struct vfio_group *group;
 
 	iommu_group = iommu_group_get(dev);
-	if (!iommu_group && vfio_noiommu) {
+	if (!iommu_group && IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) &&
+	    vfio_noiommu) {
 		/*
 		 * With noiommu enabled, create an IOMMU group for devices that
 		 * don't already have one, implying no IOMMU hardware/driver
@@ -686,8 +693,19 @@ int vfio_device_set_group(struct vfio_device *device,
 	else
 		group = vfio_noiommu_group_alloc(device->dev, type);
 
-	if (IS_ERR(group))
+	if (IS_ERR(group)) {
+		/*
+		 * Cdev noiommu devices don't need a vfio_group. When
+		 * CONFIG_VFIO_GROUP_NOIOMMU is not set, the group alloc
+		 * above returns -EINVAL for devices without an IOMMU.
+		 * That's fine — a NULL group is expected and iommufd
+		 * handles these devices directly.
+		 */
+		if (IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU) &&
+		    vfio_noiommu && !device->dev->iommu)
+			return 0;
 		return PTR_ERR(group);
+	}
 
 	/* Our reference on group is moved to the device */
 	device->group = group;
@@ -699,6 +717,9 @@ void vfio_device_remove_group(struct vfio_device *device)
 	struct vfio_group *group = device->group;
 	struct iommu_group *iommu_group;
 
+	if (!group)
+		return;
+
 	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
 		iommu_group_remove_device(device->dev);
 
@@ -742,6 +763,8 @@ void vfio_device_remove_group(struct vfio_device *device)
 
 void vfio_device_group_register(struct vfio_device *device)
 {
+	if (!device->group)
+		return;
 	mutex_lock(&device->group->device_lock);
 	list_add(&device->group_next, &device->group->device_list);
 	mutex_unlock(&device->group->device_lock);
@@ -749,6 +772,8 @@ void vfio_device_group_register(struct vfio_device *device)
 
 void vfio_device_group_unregister(struct vfio_device *device)
 {
+	if (!device->group)
+		return;
 	mutex_lock(&device->group->device_lock);
 	list_del(&device->group_next);
 	mutex_unlock(&device->group->device_lock);
@@ -786,6 +811,8 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device)
 
 bool vfio_device_has_container(struct vfio_device *device)
 {
+	if (!device->group)
+		return false;
 	return device->group->container;
 }
 
-- 
2.43.0

