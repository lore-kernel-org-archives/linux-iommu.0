Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188E517B431
	for <iommu@lists.linux.dev>; Tue, 16 Jul 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.246.186.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134995; cv=none; b=mrHyRdE51UL2whlX0rpcoeNGEf2I7a3vcn1HHmEb/5zCgXNXoWWoVwxsxaA3MeXBqqSi3TH6+ufTQx4wUPHAk97kwVe7Nh+DqggnYNFg/i197il/i7nhnRGhD47EfNxhRi/GPBZTCsfJOH1dKaNr1NagrjAur3BZHZnZPhR6mSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134995; c=relaxed/simple;
	bh=wBQVZAtEyRAncUH0l2oZWKvolfP4GGy/6DguPZSaPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMDoXckggBqhVgvDWM6WsrXTza2RjESSUBbi3t+ZXyLIK+8Hye3CWMxAWV2WCG8yg9PjiRp0ieihL/tjuuqpEkoSKxBRDaGBO2+60xOus7+GJhmTJCXiC4kjSfxSvxcHdkX0Y1rLm8KgfGzzMCz02F1dJaWXT0VEMdQBEcCHZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru; spf=pass smtp.mailfrom=red-soft.ru; arc=none smtp.client-ip=188.246.186.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red-soft.ru
Received: from localhost.biz (unknown [10.81.100.48])
	by gw.red-soft.ru (Postfix) with ESMTPA id 747043E1B85;
	Tue, 16 Jul 2024 15:55:29 +0300 (MSK)
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: Joerg Roedel <joro@8bytes.org>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iommu: sprd: Avoid NULL deref in sprd_iommu_hw_en
Date: Tue, 16 Jul 2024 15:55:14 +0300
Message-ID: <20240716125522.3690358-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 186538 [Jul 16 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;red-soft.ru:7.1.1;localhost.biz:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/07/16 12:37:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/07/16 03:46:00 #26020663
X-KLMS-AntiVirus-Status: Clean, skipped

In sprd_iommu_cleanup() before calling function sprd_iommu_hw_en()
dom->sdev is equal to NULL, which leads to null dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9afea57384d4 ("iommu/sprd: Release dma buffer to avoid memory leak")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/iommu/sprd-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ba53571a8239..a2f4ffe6d949 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -232,8 +232,8 @@ static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
 
 	pgt_size = sprd_iommu_pgt_size(&dom->domain);
 	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
-	dom->sdev = NULL;
 	sprd_iommu_hw_en(dom->sdev, false);
+	dom->sdev = NULL;
 }
 
 static void sprd_iommu_domain_free(struct iommu_domain *domain)
-- 
2.44.0

