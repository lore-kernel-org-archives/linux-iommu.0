Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E01155738
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574223; cv=none; b=laW+lcDQ+AU5BcHidnMAE5N34X0XEjgCc0ceNU1wAob1YylZbamHtA6RAn/yKlSnN2kjpVns14vpABTDfVlNQDNybeMNfmBJJZxrR9GOtFsY7HRH9PWJkK38c0GDqIGoN1jWj98vCjA8qrzUwRnW6f5tUGQb+cm15NFtCdW14k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574223; c=relaxed/simple;
	bh=0EQePSRiBV0bqp1McXfFeQFrK5vwQYcgBf5qhIHPeJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JcO0JicKDBDjpn2fNz1wrHzaE7Gbdbac8WedLNHNrwuH6/4i2jGeJ4cf3AQsUeoEnXt4s9doGTkYg86h1I+h94YP6a5KSy4j9nJhqXVu6gQYTUucOR/LTB9ynPXl20aF+LjTZh2Iwkf9n39ZOElUqPiei6mTEf8Dil1FGheR3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Vw3h66Ic; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vw3h66Ic"
X-UUID: ca5a569a354111ef99dc3f8fac2c3230-20240628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+danxBg72kkVWhHZ7NufVUsP5WdRg7pgzK5U7q+oXYY=;
	b=Vw3h66IcM7Ih/RuLuPAitnpVkOahLYiB1KN0xW0o3rMhMSliiACVhdHUAuNOxVrC/YwAY6B6TEm0/hRokSClEqcj2xLXvwyb/mFIWjvOQAawRaXBqW6CisTgdn+RDpKKIHu4R+L5eS/GgGXJVpMg0mg7u9XA44WxDZgaJHvUPBQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:3f9ccaf6-48d3-45d8-9760-ccb85f6a391f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:a147ad44-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ca5a569a354111ef99dc3f8fac2c3230-20240628
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1768470028; Fri, 28 Jun 2024 19:30:15 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Jun 2024 19:30:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 28 Jun 2024 19:30:13 +0800
From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <yj.chiang@mediatek.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] iommu: Remove iommu_sva_unbind_gpasid
Date: Fri, 28 Jun 2024 19:30:04 +0800
Message-ID: <20240628113011.3535-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.239400-8.000000
X-TMASE-MatchedRID: S6zgMyN4g9KGsPek1xLHVnH7HV/mO4UTT9kSL7SwB1hq1Zuz1uJuCNn7
	b/+Y15IvMm6uZ1zccZcQCEi5k+nQxB8TzIzimOwP0C1sQRfQzEHEQdG7H66TyHEqm8QYBtMOvwY
	XYCR6VwgLQgZ3u/DVwAgsD3ZCYFN1JDDLO9wvb7dnPqKjSU9SXe7o5tZbWcdZRvCkNdMmYoFxsN
	4zhBrsExsXRXHy1IH0eZUpm6wun3ba/06NhYDa4wyzCDjlUx89djekYOaiKTo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.239400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9C659BD85D1E1F99FDEC3C8CB47448B2FD5AFBB33DCB9AD1BC9FAA614F21077D2000:8
X-MTK: N

This is a left over of commit 0c9f17877891
("iommu: Remove guest pasid related interfaces and definitions")

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 include/linux/iommu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 17b3f36ad843..225403cfe614 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -785,8 +785,6 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
-extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
-- 
2.18.0

