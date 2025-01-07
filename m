Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8467C55887
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736220972; cv=none; b=rZa050EBnvzc/iRkPeXF/Jglr6v8W8UGFIP1M5pQDRnztxzE8jnouMMFbbexEIADZYp588n11phG0gvFSpE2lPkxiqYcx8isrvCslWlkhmqrsAS/rDbKxe9sarSHtubLtMMQSLL0Ax7EkeeGZAI1xq0rnD0AqWw8HrMSfsbg9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736220972; c=relaxed/simple;
	bh=x9tmvcN+FW9WEf459jFjPK3PoO1W/G6lSA2mtYJGWL0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=B4pinv40Kkv9jFuLVyVX0QlVhWPCkSvrarzxE3lNR5pjsq2k7OHYWQQKY1L54G054MWn5AouqPcX03/94yL3HycoBD9EL4dv0zjg29u8YbsHB5X0G95xPvScmDI3/LnhM5fFV44QxIWbo6rPnLj2Ksm65dYsMVjlKGQHq9OU4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 5C6157F0004B;
	Tue,  7 Jan 2025 11:36:00 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	baolu.lu@linux.intel.com,
	vasant.hegde@amd.com
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] iommu: move the adding group info to proper place
Date: Tue,  7 Jan 2025 11:35:58 +0800
Message-Id: <20250107033558.41135-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

After commit fa0828036488 ("iommu: Split iommu_group_add_device()"), the
adding group information is left in iommu_group_alloc_device, but which
only allocate group device, not attach the device to iommu group;

so move the print to iommu probing and adding functions

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: add log when iommu_group_alloc_device failed in iommu_group_add_device

 drivers/iommu/iommu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 599030e..2eaa8ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -586,6 +586,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 	mutex_unlock(&group->mutex);
 
+	trace_add_device_to_group(group->id, dev);
+	dev_info(dev, "Adding to iommu group %d\n", group->id);
+
 	return 0;
 
 err_remove_gdev:
@@ -594,6 +597,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 err_put_group:
 	iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
+	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
 	iommu_group_put(group);
 
 	return ret;
@@ -1192,10 +1196,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 		goto err_free_name;
 	}
 
-	trace_add_device_to_group(group->id, dev);
-
-	dev_info(dev, "Adding to iommu group %d\n", group->id);
-
 	return device;
 
 err_free_name:
@@ -1204,7 +1204,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 err_free_device:
 	kfree(device);
-	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
 	return ERR_PTR(ret);
 }
 
@@ -1219,10 +1218,14 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	struct group_device *gdev;
+	int ret;
 
 	gdev = iommu_group_alloc_device(group, dev);
-	if (IS_ERR(gdev))
-		return PTR_ERR(gdev);
+	if (IS_ERR(gdev)) {
+		ret = PTR_ERR(gdev);
+		dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
+		return ret;
+	}
 
 	iommu_group_ref_get(group);
 	dev->iommu_group = group;
@@ -1230,6 +1233,10 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	mutex_lock(&group->mutex);
 	list_add_tail(&gdev->list, &group->devices);
 	mutex_unlock(&group->mutex);
+
+	trace_add_device_to_group(group->id, dev);
+	dev_info(dev, "Adding to iommu group %d\n", group->id);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
-- 
2.9.4

