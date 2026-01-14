Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3C328B43
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768370075; cv=none; b=dOUsh86YyPh1FtLqOKWbvmCe6GAOhx0tpUJNjo1JfKtnWIM5UAXql8Qwd/zcnEl/XaYb2dXB07PJoSVkGsUeVN0SeJ6o3F5WSS6svFTOXYClsQrz8gbvB658cIFc1SveY7j0mf3hkaLt5tAnheRcgzKNnicAZ4v4iP3XgXivBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768370075; c=relaxed/simple;
	bh=t78q2Z5dQ/ATdkMhm9UzJ4XG4/ai3s/A/WSHz1L6TG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=de9dvn+XC9tRWJVkZOYasrupbK59uImQaFxYXp7/us5dLNmFuvYlTMbmtwVlPQR4ZZaZKUzoFeteVh3ZdzAkeYZeQhoTnonL22RtrJTU2+Xq9BbtE9hVotElvrLk7i9FRLT7tHi2cI3rFxz1UnhL/TtVTbPX5UGrz6mzjbd5QzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 76c71f7af10d11f0a38c85956e01ac42-20260114
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dad36939-c1f2-4128-a90e-84edf2be5a8b,IP:15,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.6,REQID:dad36939-c1f2-4128-a90e-84edf2be5a8b,IP:15,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:460f675b2440a6cf5507a15ae30cfd67,BulkI
	D:26011413542086Q2IW7K,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|200
	|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,
	Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BR
	R:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76c71f7af10d11f0a38c85956e01ac42-20260114
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 832139564; Wed, 14 Jan 2026 13:54:17 +0800
From: Can Peng <pengcan@kylinos.cn>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	Markus.Elfring@web.de,
	vasant.hegde@amd.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH v3] iommu: use LIST_HEAD() for group_resv_regions initialization
Date: Wed, 14 Jan 2026 13:53:20 +0800
Message-Id: <20260114055320.399056-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the manual declaration and INIT_LIST_HEAD() call with the
LIST_HEAD() macro when initializing group_resv_regions in
iommu_group_show_resv_regions(). This simplifies the code and makes
the list initialization more concise.

No functional change intended.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
### Changes since v2:
- Rebased on top of iommu/next as requested by Vasant Hegde.
- Adjusted commit message to be shorter and clearer, following Markus Elfring's
  suggestion.
- Retained the LIST_HEAD() cleanup pattern consistently across the file.

### Notes on v2 discussion:
- V2 was reviewed positively:
  - Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
  Link: https://lore.kernel.org/all/4526ca31-71a4-4b3f-b378-32546eb8133d@amd.com/
- Markus Elfring suggested a shorter summary phrase and pointed out that
  Jörg Rödel had already applied the patch ("Applied, thanks." on 2026-01-10).
  Link: https://lore.kernel.org/lkml/stpavkxy3sbevk7zmt4kxyecqy5gc6phubvcfutbtnuk7vphlh@a7aimtvk423i/

Thanks everyone for the review and suggestions.

Best regards,
Can Peng

 drivers/iommu/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4926a43118e6..2f31527b3c62 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -957,10 +957,9 @@ static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
 					     char *buf)
 {
 	struct iommu_resv_region *region, *next;
-	struct list_head group_resv_regions;
+	LIST_HEAD(group_resv_regions);
 	int offset = 0;
 
-	INIT_LIST_HEAD(&group_resv_regions);
 	iommu_get_group_resv_regions(group, &group_resv_regions);
 
 	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
-- 
2.25.1

