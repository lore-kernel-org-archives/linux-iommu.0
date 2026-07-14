Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE2367B72
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997113; cv=none; b=GY4qb7kKt9DA4i8iNYd5YkkiepGmReyuxwCWFoPIza60c7y0LibTnTEwwz3iywmfRwSv2P5ysFQ11Cym1CWkoaPqKqPukkgxsaj/fnMTXk8wcFTv2J/wEa01iFFNoTkeMp/ZlMnE9m53SG+NkmEHdNg9GYH5AlLTKkgrvO+Fjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997113; c=relaxed/simple;
	bh=y/tkCWz5x+nSVOEFi4WI+mPg/HM3g3bRMrmTXq4VuCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYwMX1qkupaa7YgaT5y1ZMJp5+LkW9SAlvEy4bbcfRbViu/fCpOrCU3qWCE8QB+uQqwxSSYcgPAAw3ejCQmE1n0bW3SjAerzGuhXNhFhScIlc3emIx9opmQvW8Ouc9r7DB07DrKggTPRLHEnUkYWHtQlGFAKnzgJgDNxDns1ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j1mVKU8O; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j1mVKU8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ar
	0rPXU8NI1gtTbp1nRmNqLFnJb6vzlfmwoaUrXEseM=; b=j1mVKU8O2ICHlXX5uI
	3WfpmbgevgRpmbMPmIyrDpRh5kIFCpxjfJLq8jeHRO7xY5hvsznFU86QCYmYuGxX
	crzXF34NBM0OWGHcbO0+9zlvunBiYdicIqu3C8QVLjz8XNQ5+dnY+0RUT8/+PShO
	16tw8i8aymIX6iRuEwuf1ZPVA=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHI9mYolVq45e7JQ--.36321S2;
	Tue, 14 Jul 2026 10:44:40 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommufd: fix grammar and spelling in comments
Date: Tue, 14 Jul 2026 10:44:40 +0800
Message-ID: <20260714024440.188358-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHI9mYolVq45e7JQ--.36321S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1kKr4fWr45uFWDGw43Awb_yoW5Gr4Dpr
	W7WFy2yryxtFyfuanxXw1DZF95t3s0yayFyFWYga90gr1fGryqyrn3X345CrWDJrZrJF42
	v34UArnrAr1fJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYiihUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9Bi+R2pVopjO0AAA3O

From: xiongweimin <xiongweimin@kylinos.cn>

Correct detach kdoc ("device/pasid from"), article use before
IOMMUFD_OBJ_*, and "propogated" -> "propagated".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/iommufd/device.c       | 6 +++---
 drivers/iommu/iommufd/io_pagetable.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f..f1a45a341 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -989,7 +989,7 @@ static int iommufd_device_change_pt(struct iommufd_device *idev,
  * iommufd_device_attach - Connect a device/pasid to an iommu_domain
  * @idev: device to attach
  * @pasid: pasid to attach
- * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
+ * @pt_id: Input an IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
  *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
  *
  * This connects the device/pasid to an iommu_domain, either automatically
@@ -1022,7 +1022,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, "IOMMUFD");
  * iommufd_device_replace - Change the device/pasid's iommu_domain
  * @idev: device to change
  * @pasid: pasid to change
- * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
+ * @pt_id: Input an IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HWPT_PAGING
  *         Output the IOMMUFD_OBJ_HWPT_PAGING ID
  *
  * This is the same as::
@@ -1044,7 +1044,7 @@ int iommufd_device_replace(struct iommufd_device *idev, ioasid_t pasid,
 EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, "IOMMUFD");
 
 /**
- * iommufd_device_detach - Disconnect a device/device to an iommu_domain
+ * iommufd_device_detach - Disconnect a device/pasid from an iommu_domain
  * @idev: device to detach
  * @pasid: pasid to detach
  *
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 24d491710..ad15d6d2d 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1513,7 +1513,7 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 		return -EINVAL;
 
 	down_write(&iopt->iova_rwsem);
-	/* FIXME: drivers allocate memory but there is no failure propogated */
+	/* FIXME: drivers allocate memory but there is no failure propagated */
 	iommu_get_resv_regions(dev, &resv_regions);
 
 	list_for_each_entry(resv, &resv_regions, list) {
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

