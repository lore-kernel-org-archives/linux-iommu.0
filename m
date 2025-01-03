Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138D33991
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735882097; cv=none; b=f2iiFl20V+THWtibS9cIPdn72LITtvxoxmoN3ezp+PKWgR15ORXt0TQnmLTqlIZqIeY7j16iN+orFdUeD7NF1IifaMLJhpbllQ5Fr+kPH0YmghhtCpnYqaztDdX5TNhq1ECgM7eFcxLWVMEiDc3pmx5yDvvkqdhbP0/R9Uf/TJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735882097; c=relaxed/simple;
	bh=BA2MP8PvcmklWjvXaEZPAYrpTTWH+hmlfzvhm8A08/U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FVh98fb28T6vFwD9XGxjcodtS3SzAC3Ah0vt2L8m0mtUh7d1pQFeclopnKEjwwWOL5quxu1GIFDSKNLSrkTBId9aB7GRX3FA02irfQv9QEyA0Ljdk0sh/XWI2ZgUeT0DAekOldBGISoBfYUWZpzBO3Sy1MOIqev/2wTwArjd9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 0BD9F7F0004B;
	Fri,  3 Jan 2025 13:28:12 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: iommu@lists.linux.dev,
	robin.murphy@arm.com,
	will@kernel.org,
	joro@8bytes.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu: move the adding group info to proper place
Date: Fri,  3 Jan 2025 13:28:11 +0800
Message-Id: <20250103052811.39544-1-lirongqing@baidu.com>
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

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 599030e..03f95f2 100644
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
 
@@ -1230,6 +1229,10 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
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

