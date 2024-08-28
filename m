Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E89175D5A
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847234; cv=none; b=HBR8xv1DbICdNkgqKBDkaAhx1uvvEeVLfjdNWMjyXse9IyqzufMZ/pOi7e1kCDz/oGSaJhHPOnEfoCBh0p6PQp6rAQUAc5kGp9coCrCJHX3jHK7SW905ks3ZvYjUvXHRHkbDv4u1DsZV0fHlWoDFxVpYht7aLmi/U6qFjjqOv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847234; c=relaxed/simple;
	bh=2mWV54MwCdtA//hZ2mLBmEB0Tca7ZvnBSh07AwMeVC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YNnJDzMsiG1W3jssVyfjwcbagGNUUUbIqtNGUXmCgZyWxU56oi7jeozhkEWyZR0D/BZzkKEaYwkHoslAnAATMfh/Ur7Hb6be/C4VLCFyd8Aw7PZo7pGMa80DYzXJ/VKghgFTGcxZlgmpTXLS13OQr3T2VSzTP7F4hCYLsGJ3DNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wv3Dm18cQz1xwS8;
	Wed, 28 Aug 2024 20:11:52 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D1DBB1A016C;
	Wed, 28 Aug 2024 20:13:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 20:13:49 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <lihongbo22@huawei.com>
Subject: [PATCH -next] iommu/omap: Use IS_ERR_OR_NULL() helper function
Date: Wed, 28 Aug 2024 20:21:52 +0800
Message-ID: <20240828122152.3697094-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Use the IS_ERR_OR_NULL() helper instead of open-coding a
NULL and an error pointer checks to simplify the code and
improve readability.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index c9528065a59a..b7e323aa016f 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -881,7 +881,7 @@ static int omap_iommu_attach(struct omap_iommu *obj, u32 *iopgd)
  **/
 static void omap_iommu_detach(struct omap_iommu *obj)
 {
-	if (!obj || IS_ERR(obj))
+	if (IS_ERR_OR_NULL(obj))
 		return;
 
 	spin_lock(&obj->iommu_lock);
-- 
2.34.1

