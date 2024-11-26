Received: from njjs-sys-mailin01.njjs.baidu.com (mx310.baidu.com [180.101.52.44])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9582192D69
	for <iommu@lists.linux.dev>; Tue, 26 Nov 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606860; cv=none; b=O4c4fumVDVU1aBt51xVKZegnDZ1ecuiL2X+AQziZppWtLR/EieSKywkHxAw3Jo989PkHl01ZDVnDL2z82G6GhIrs4GOTXu3hoXlpwpxTJKthRbA8ebDT8KmMuUPvF+6CA5ADoHeXq3fGMsmyDVJbBICACWH4dr3+FZ2GDkdIkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606860; c=relaxed/simple;
	bh=KWdZR1m/yiosVQICP/CF989WTwFAR2oa++gXl9md0Eg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uhoIfeyNtrK2nHvmEtXK74+3LqtNia7x4RKdc3m63fpoH8rpLoTFO05HFMs5KClFoAO9V0ufJ/ql+mOQc9kLq9OUS12rIqC09eXUi2R7YHSpwuuB42MXwHVA60H5GPzCd8FnREFkY05yGba+LEbvBBwJQsycxtRcyxSkuuq/DFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id F177D7F0005E;
	Tue, 26 Nov 2024 15:23:40 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu: Downgrade print level for iommu group information
Date: Tue, 26 Nov 2024 15:23:39 +0800
Message-Id: <20241126072339.25714-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This per device log is becoming longer with more and more PCI devices
in system, which slows down the boot process due to the serializing
nature of printk().

Downgrade dev_info() to dev_dbg() so it is still accessible for debug
purposes.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e61..a16f944 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1193,7 +1193,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 
 	trace_add_device_to_group(group->id, dev);
 
-	dev_info(dev, "Adding to iommu group %d\n", group->id);
+	dev_dbg(dev, "Adding to iommu group %d\n", group->id);
 
 	return device;
 
-- 
2.9.4

