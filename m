Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F731DFFB
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997121; cv=none; b=RGe6THFiBrOM2wp0/gQlBno0vHb7GQ+sANpVykdZflz0w1Dxhpsr2yK1Nksx59kqYkuoASjuCOqTQLaEMhkJ6S7mmPZfWk0UQQXYmmtDFG0UrzhkOQRNa4rIVz+imQq+I6Lot7vaG0EXWPGFwN6M+GAWS/1dZggKxJTyPaMZH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997121; c=relaxed/simple;
	bh=NDCbVRFZZ/9i3d6rW3RpKJTKK+I5L16gReAEKpNqPFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oD/vtSOyJ4omaFmxBFJGe6jhM3vg3MVnpVVczC+Bjb+p5m0kMY3ulRK3Y/6SWA5TE0W6Hw6OvwzKY9yPsE6+/4bz/YU9+pVKcRm1/2t6ObPRaxlua6JlbkYyY5zgVDBULyYQ0h7Kk8joiUZ1SjCNT87hXcULTHSIA39ijyLyeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gwmuTxKb; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gwmuTxKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=oZ
	CtDx6VcqxgeosNH4Gx5FE52g+SWnLQtt5aEvhp+o8=; b=gwmuTxKbMJr6irYCAE
	nPQJs8G8JutSJSeFVb7pqwGyr/vf2W0W88b/FX327OW+7zAu4HiqUDAyA2nlZDV3
	N1c7VDZ7vxnITwRf0gXXZsVFuXUw75GOW1VPp8bBrwqOBskeGfVO23IymCtpssUs
	V+peJelgbigq8pM+DdxS/DEsE=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnzU2jolVqR7utJg--.39248S2;
	Tue, 14 Jul 2026 10:44:51 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu: fix possessive its in group remove kdoc
Date: Tue, 14 Jul 2026 10:44:51 +0800
Message-ID: <20260714024451.188415-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnzU2jolVqR7utJg--.39248S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr47WF4xXw1ktF45Jw1DWrg_yoWkXrb_G3
	WxZry0gry8Gr40vF1jgrW3ZrZ09a9FvrZ3XF95K3Z3GF1xX392qFy8ZrnFqay7uw4qkFnI
	vrZxKr1IvryUCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8vPfPUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0gPASWpVoqONzwAA3k

From: xiongweimin <xiongweimin@kylinos.cn>

Use "its" rather than "it's" when referring to the device's current
group.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e8f13dceb..a3dea7353 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1345,11 +1345,11 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
 
 /**
- * iommu_group_remove_device - remove a device from it's current group
+ * iommu_group_remove_device - remove a device from its current group
  * @dev: device to be removed
  *
  * This function is called by an iommu driver to remove the device from
- * it's current group.  This decrements the iommu group reference count.
+ * its current group.  This decrements the iommu group reference count.
  */
 void iommu_group_remove_device(struct device *dev)
 {
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

