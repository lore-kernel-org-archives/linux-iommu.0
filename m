Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F08305968
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188174; cv=none; b=GN+EASWHr+bCsL/IH5vCgfLCjrlhfnGB0SfWzhGbhwE76OTfomOllH9rByMLpUvU2XPcf1xvTJS3j18TQ1VycKSv90nWKd1nt00f5TCHAzet1l6NcfUc2+qsy6e8epgpCDDbbIaQLjE77/JGo9L3kvE/BsyCEGIR0KmMwOjF8po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188174; c=relaxed/simple;
	bh=I+4RLachfE2YGCxf+3/opv+uIl26owIJgCvJ+PSkcrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MwQL0PvSO0X4Y9vBznHY33ee3cQ7mX3VSqjdIy0ifAeUcmt/ZJlRgUTdTgMBP5JIWX7mCBdhhhY/B9j8AOAyvFUDGQwFle5FngSsSlJhCZoBG7rNBXdAssMLS4FhX7u0DDA9uHxfZDuKhoDfyFBDEcEh5GSxNYI4YDXBAQ6jENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f1e03deeef6511f0a38c85956e01ac42-20260112
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, UD_TRUSTED, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fdfa1e3d-3f9e-40eb-9dc9-3ffbf7ccbd3d,IP:15,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-15
X-CID-INFO: VERSION:1.3.6,REQID:fdfa1e3d-3f9e-40eb-9dc9-3ffbf7ccbd3d,IP:15,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-15
X-CID-META: VersionHash:a9d874c,CLOUDID:deac76458c45cf9c2819b21a25f7ab62,BulkI
	D:260112112239A80IN4OA,BulkQuantity:0,Recheck:0,SF:10|38|66|78|80|102|127|
	841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,B
	ulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1e03deeef6511f0a38c85956e01ac42-20260112
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1461387842; Mon, 12 Jan 2026 11:22:37 +0800
From: Can Peng <pengcan@kylinos.cn>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	Markus.Elfring@web.de
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH v2] iommu: simplify list initialization in iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
Date: Mon, 12 Jan 2026 11:21:16 +0800
Message-Id: <20260112032116.49781-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use LIST_HEAD() to declare and initialize list heads in both
iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
instead of separate declaration and INIT_LIST_HEAD(). This simplifies the
code by combining declaration and initialization into a single idiomatic
form, improving readability without changing functionality.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
>> Use LIST_HEAD() to declare and initialize the 'mappings' list head in
>> iommu_create_device_direct_mappings() instead of separate declaration and
>> INIT_LIST_HEAD(). This simplifies the code by combining declaration and
>> initialization into a single idiomatic form, improving readability without
>> changing functionality.
>…
>
>How do you think about to repeat the mentioned transformation approach for the implementation
>of the function “iommu_group_show_resv_regions”?
>https://elixir.bootlin.com/linux/v6.19-rc4/source/drivers/iommu/iommu.c#L949-L969
Changes since v1:
 - Extend the cleanup to iommu_group_show_resv_regions() as suggested by
   reviewer, applying the same LIST_HEAD() pattern consistently across
   the file.

Best regards,
Can Peng

 drivers/iommu/iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb88..b9ffd001b4b3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -950,10 +950,9 @@ static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
 					     char *buf)
 {
 	struct iommu_resv_region *region, *next;
-	struct list_head group_resv_regions;
+	LIST_HEAD(group_resv_regions);
 	int offset = 0;
 
-	INIT_LIST_HEAD(&group_resv_regions);
 	iommu_get_group_resv_regions(group, &group_resv_regions);
 
 	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
@@ -1173,12 +1172,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
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

