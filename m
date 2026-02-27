Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8283644A7
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214776; cv=none; b=oAbAmpMuF293T/4ByPlRM289O9a4yVgQr8P+RoXQYwZx8x1DxeeIlobC/Wa1DiOh/f7gs+MGIAwzj6z+TaTr0mUKGWXKw+VJ1FJPwOhh1S/qozI77Vjh5miB0eWPtmVmWq1smqTUlIzr9ipAHKnzoqBcJxRdRoLTIs7vSqWUO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214776; c=relaxed/simple;
	bh=xQZojr3GFxPw6/kHY8lEwIocu5M2D6Kr99QXLjDyrug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcfT5vUjw1GK4eT1++YmHHNcHeY9b5V6p0DGEJrkrUUDl8K+tONp01rin9+Ld/kqpiEgmwht5PxSL/GL8x+yExB4LpWnB7Mv2rMZeuMsdEFXYTqj0EacGMEaLJL9JPAIMrntJpv1N8zm6XhhlEUPMpEm3/YRfSgeqfcekx10FUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YlSGfmft; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YlSGfmft"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5203520B6F03;
	Fri, 27 Feb 2026 09:52:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5203520B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772214773;
	bh=FcyuZJLhmRk9Mvmk2JcfREx8/0r88nbmt1CfI0Gl/EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YlSGfmftimvQCiambMmyx7ij0o13mdAKQrClYzIrRxzgdcA6ycGSk7V02goT85giV
	 1tyII60TrV/URQLURhRWDQrOrf/DmVG3F+SC0FSdZXC3SRSwQHvc0BDCl6s8R4evLV
	 kYn2exqqFaHPY+Q72UtV7RUl4cc6z4bjyUF5QxN4=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 05/11] vfio: Allow null group for noiommu without containers
Date: Fri, 27 Feb 2026 09:52:41 -0800
Message-Id: <20260227175247.26103-6-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
References: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
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

