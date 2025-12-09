Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E9221543
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264583; cv=none; b=KLFlDAHKYYj+SvsdsCPgPFg0ngP5zOKJ8BQy/vKs1fzLISgzz6VeSgqBmWJybNXT5Av1rHiJvsR7MSz5Mf+wyj+fkfaSH1O2uGow9UGAFup+FwjRfA8RSbrcaw/pk3aecB+wyLuxdOhmebKBrQgx2JKVWDKtMX71wuR0omQAop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264583; c=relaxed/simple;
	bh=fuSU/yz+3lNd+UukYUwckCG81d+UjAcZbXROdw4GeBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CGjg4fS/E/7kLVP1xxcL7NvnBK6rbg0hGZ23krc7gt5XnnQVkn8KkqYiCvU00HG2EytbiUNLuovmVvguyF2PPW3gYhvclpxAVgVKEWWjstpat/HjK7bqIDHQXtbV+N75p3sdh1kKryjSISPd3H57DbY78xAFV7OCMX3H9px7i4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f1ec6206d4ce11f0a38c85956e01ac42-20251209
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:95f3d03f-ff7e-4e8d-ae2e-54db6b0d9f00,IP:15,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.6,REQID:95f3d03f-ff7e-4e8d-ae2e-54db6b0d9f00,IP:15,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:f163a3a3537efa1b4756bd1133e7ade1,BulkI
	D:251209151614WPJU2IWZ,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1ec6206d4ce11f0a38c85956e01ac42-20251209
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2048188439; Tue, 09 Dec 2025 15:16:13 +0800
From: Can Peng <pengcan@kylinos.cn>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] iommu: simplify list initialization in iommu_create_device_direct_mappings()
Date: Tue,  9 Dec 2025 15:15:13 +0800
Message-Id: <20251209071513.3105610-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use LIST_HEAD() to declare and initialize the 'mappings' list head in
iommu_create_device_direct_mappings() instead of separate declaration and
INIT_LIST_HEAD(). This simplifies the code by combining declaration and
initialization into a single idiomatic form, improving readability without
changing functionality.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/iommu/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb88..77d723f43546 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1173,12 +1173,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 					       struct device *dev)
 {
 	struct iommu_resv_region *entry;
-	struct list_head mappings;
+	LIST_HEAD(mappings);
 	unsigned long pg_size;
 	int ret = 0;
 
 	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
-	INIT_LIST_HEAD(&mappings);
 
 	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
 		return -EINVAL;
-- 
2.25.1

