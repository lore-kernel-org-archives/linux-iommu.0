Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362334F24D
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546634; cv=none; b=LBVHmN/5V0nKD+hEYcqFURQl0B571AsVH7M1reOT7L60SYj11ZeyBQMY4jlK4Mx49DUO3zbdgN3Vry7AoHgZ/lpYZpbPM0vqgdfLHGxmcraRsghW40eWau6+Iwf9tjwrn5rXWN8XxYbtwdtcRbkKtNkY0fdRK3OPWbubV1r9LIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546634; c=relaxed/simple;
	bh=jgWiO+RmKANPJSAyJWxKxrsTEXyQZdR9DhQw72QUBuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=del2OOQTCfCnHNNRWWM9awqjMB+dIvDoOVqPeYpZ+qUuk+2chY5HWxBpaLhqrvAwzcwm15weyjN5d3bG1PfNUmABZA63YUjhkEXZANaAaPecBdN1Z2cR47wLj9yJ/pFHLvM/+wJQkWuxsY2PaiJ+FMkRPdSSu0qyyS0sgRgZliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8d595ae0f2a811f0b0f03b4cfa9209d1-20260116
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f14f3aae-c8f5-4e95-896d-8adf8f3cb945,IP:15,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-15
X-CID-INFO: VERSION:1.3.6,REQID:f14f3aae-c8f5-4e95-896d-8adf8f3cb945,IP:15,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-15
X-CID-META: VersionHash:a9d874c,CLOUDID:85178abcf0bab9a63b057a6ed2ee289c,BulkI
	D:260116145700HP4Z2B2D,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8d595ae0f2a811f0b0f03b4cfa9209d1-20260116
X-User: pengcan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 616118724; Fri, 16 Jan 2026 14:56:58 +0800
From: Can Peng <pengcan@kylinos.cn>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	Markus.Elfring@web.de,
	vasant.hegde@amd.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH v4] iommu: simplify list initialization across the iommu subsystem
Date: Fri, 16 Jan 2026 14:55:54 +0800
Message-Id: <20260116065554.830579-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace separate list head declarations and INIT_LIST_HEAD() calls with
the combined LIST_HEAD() macro throughout the iommu directory.
Using LIST_HEAD() merges declaration and initialization into a single
statement, improving code readability and reducing boilerplate without
altering any functionality.

No functional change intended.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
Changes since previous version:
Rebased on top of iommu/next as requested by Vasant Hegde.
Adjusted commit message to be shorter and clearer, following Markus Elfring's suggestion.
Retained the LIST_HEAD() cleanup pattern consistently across the iommu directory.

Notes on prior discussion (from chat history):
The earlier version was reviewed positively:
Link: https://lore.kernel.org/all/4526ca31-71a4-4b3f-b378-32546eb8133d@amd.com/

Markus Elfring suggested using a more concise summary and
recommended the use of Coccinelle for this kind of transformation.

Best regards,
Can Peng

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +--
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 +--
 drivers/iommu/iommu.c                       | 6 ++----
 drivers/iommu/iommufd/eventq.c              | 3 +--
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fc5a705f6cb3..a772010b5331 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4659,10 +4659,9 @@ static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
 
 static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 {
-	struct list_head rmr_list;
+	LIST_HEAD(rmr_list);
 	struct iommu_resv_region *e;
 
-	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
 	list_for_each_entry(e, &rmr_list, list) {
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 5e690cf85ec9..d7e58ac1e14a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2072,12 +2072,11 @@ static int arm_smmu_device_dt_probe(struct arm_smmu_device *smmu,
 
 static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
 {
-	struct list_head rmr_list;
+	LIST_HEAD(rmr_list);
 	struct iommu_resv_region *e;
 	int idx, cnt = 0;
 	u32 reg;
 
-	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
 	/*
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4926a43118e6..2652ab6f5dde 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -932,7 +932,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 
 	mutex_lock(&group->mutex);
 	for_each_group_device(group, device) {
-		struct list_head dev_resv_regions;
+		LIST_HEAD(dev_resv_regions);
 
 		/*
 		 * Non-API groups still expose reserved_regions in sysfs,
@@ -941,7 +941,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 		if (!dev_has_iommu(device->dev))
 			break;
 
-		INIT_LIST_HEAD(&dev_resv_regions);
 		iommu_get_resv_regions(device->dev, &dev_resv_regions);
 		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
 		iommu_put_resv_regions(device->dev, &dev_resv_regions);
@@ -957,10 +956,9 @@ static ssize_t iommu_group_show_resv_regions(struct iommu_group *group,
 					     char *buf)
 {
 	struct iommu_resv_region *region, *next;
-	struct list_head group_resv_regions;
+	LIST_HEAD(group_resv_regions);
 	int offset = 0;
 
-	INIT_LIST_HEAD(&group_resv_regions);
 	iommu_get_group_resv_regions(group, &group_resv_regions);
 
 	list_for_each_entry_safe(region, next, &group_resv_regions, list) {
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index e23d9ee4fe38..95a9ee581072 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -21,12 +21,11 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_fault *fault = hwpt->fault;
 	struct iopf_group *group, *next;
-	struct list_head free_list;
+	LIST_HEAD(free_list);
 	unsigned long index;
 
 	if (!fault || !handle)
 		return;
-	INIT_LIST_HEAD(&free_list);
 
 	mutex_lock(&fault->mutex);
 	spin_lock(&fault->common.lock);
-- 
2.25.1

