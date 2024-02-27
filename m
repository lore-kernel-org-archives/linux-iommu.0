Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3B130E27
	for <iommu@lists.linux.dev>; Tue, 27 Feb 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025218; cv=none; b=k+O9A/zLGhnaIwMiz4BUZNUVW7+KP/p8iwp/GpZCzh2nohjqLC9GER0sH5Jnbx0x6RqgCdwRF6TMcgBzd3ZKFTJyU0+2OY/lDYjp/9CFcqaK+s8q1kHX4yTxedF+yhSGQi2DkVVDM3nzCzg7/+Mi0v+YW0k8ssB/Cn1AzHHMb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025218; c=relaxed/simple;
	bh=kUucMWcN1gzSD3nuVGZ8AdNn9SZk4BXKz5H2jbJ3fzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aacVPxty3lWY/10UXBplm/v9JeKHJKE4VQTotA0CaDIKPKfHjudqk8SeEDS2rHei7dQAdKNlavwlVmvW7F/kkfU7+cHR/Y2ngiB8Oy/MAdWablhOWBuKIc+c1W+Ywwf98WP7X7+7tj6aROqeWt7lTx5thFWI/bdZsfqH06K2UWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7308ab9104af48c9bb1a1d486dbe15f8-20240227
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:467c87d6-4014-47bb-9be2-ec11e3300fb7,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.37,REQID:467c87d6-4014-47bb-9be2-ec11e3300fb7,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:f98a5e84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2402271708129XE05GC6,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 7308ab9104af48c9bb1a1d486dbe15f8-20240227
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1570390208; Tue, 27 Feb 2024 17:08:10 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Cong Liu <liucong2@kylinos.cn>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/iova: Simplify IOVA cache allocation with KMEM_CACHE()
Date: Tue, 27 Feb 2024 17:08:07 +0800
Message-Id: <20240227090807.82318-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/iommu/iova.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d59d0ea2fd21..9134acae76f5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -950,14 +950,11 @@ int iova_cache_get(void)
 
 	mutex_lock(&iova_cache_mutex);
 	if (!iova_cache_users) {
-		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova), 0,
-					       SLAB_HWCACHE_ALIGN, NULL);
+		iova_cache = KMEM_CACHE(iova, SLAB_HWCACHE_ALIGN);
 		if (!iova_cache)
 			goto out_err;
 
-		iova_magazine_cache = kmem_cache_create("iommu_iova_magazine",
-							sizeof(struct iova_magazine),
-							0, SLAB_HWCACHE_ALIGN, NULL);
+		iova_magazine_cache = KMEM_CACHE(iova_magazine, SLAB_HWCACHE_ALIGN);
 		if (!iova_magazine_cache)
 			goto out_err;
 
-- 
2.34.1

