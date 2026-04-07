Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0DE3B6352
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567563; cv=none; b=JdpjQZ2Sbdgg3U+R+Cxczfh2gb4+gKA0Xpfy+Hyl6sXY6Wcc43HI2oYZU9M2YZoU6wtJ2J4dI7qJirJU4HyoSYepcNvW8/BCqQrpqh7Z7dIilAZ0pzJgYQMAON9TeWqz40MW9MOYj8SqViOGfy9yMab66HWKBkLMelx69EAciA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567563; c=relaxed/simple;
	bh=CVzHb7WL0ZX6TJ/PofvfbXptINizOo2cVnPm442g5cI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PzTtYXEoCAoZYqOgHdDu2zGheSrnzVzypgeahesCXprBiEMkBZcJYWJvmjoHs71Xblu2WWZ1hIuvhq1sZTobCdH0qG5bRMJ6FmEdboQQzCAz7jGGErNcvDc0rVSkpPwurL8sbLoNnd260/pd+GvrmxlQxD/1f8M70/r2KAOaceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MTxH2jRU; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MTxH2jRU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QWD1LN6GAwlg7hD6bl6aUN0HG9Z4lEwncqV02NEZPBY=;
	b=MTxH2jRU4c0lU4D/FbuJzgdXXTkGqtKgRcOlMJT3ywKd5G7RtszP9+vSjxmtEfib7VYKJr/37
	3933wYJlM4KxbbgQJlt53ZwpACTIrhv7vGj9ENOA72iPVQY6ruOKLFEapLMdLWj3GoZXUpfcBxH
	spugrZ2wQp7KpjRWEcBelhE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fqmfn2cMgzLlT3;
	Tue,  7 Apr 2026 21:06:25 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DC204055B;
	Tue,  7 Apr 2026 21:12:38 +0800 (CST)
Received: from huawei.com (10.50.87.63) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Apr
 2026 21:12:37 +0800
From: Lin Ruifeng <linruifeng4@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<jroedel@suse.de>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu: Use dev_dbg for group handling code
Date: Tue, 7 Apr 2026 21:06:38 +0800
Message-ID: <20260407130638.1920205-1-linruifeng4@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500012.china.huawei.com (7.185.36.8)

When devices are frequently registered/unregistered, there will be a large
number of iommu group adding/remove messages, which will flood the dmesg buffer
and flush out other logs. For iommu group handling messages, we can use dev_dbg
to output logs only when needed.

Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 50718ab810a4..18ceaba6cf0a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1283,7 +1283,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 
 	trace_add_device_to_group(group->id, dev);
 
-	dev_info(dev, "Adding to iommu group %d\n", group->id);
+	dev_dbg(dev, "Adding to iommu group %d\n", group->id);
 
 	return device;
 
@@ -1337,7 +1337,7 @@ void iommu_group_remove_device(struct device *dev)
 	if (!group)
 		return;
 
-	dev_info(dev, "Removing from iommu group %d\n", group->id);
+	dev_dbg(dev, "Removing from iommu group %d\n", group->id);
 
 	__iommu_group_remove_device(dev);
 }
-- 
2.43.0

