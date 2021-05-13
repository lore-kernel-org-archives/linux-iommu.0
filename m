Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0B0C433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:46:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB97B613C8
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB97B613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8454E60694;
	Thu, 13 May 2021 13:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-Wt0aDvjHDG; Thu, 13 May 2021 13:46:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86D1C606BD;
	Thu, 13 May 2021 13:46:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D1E5C000E;
	Thu, 13 May 2021 13:46:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A33B9C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90FD1403C4
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XT40f6wqplZM for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:46:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8B47403BA
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:50 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgtDS1vrVzsRJ1;
 Thu, 13 May 2021 21:44:08 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.81.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:46:40 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v4 4/8] iommu/arm-smmu-v3: Introduce strtab init helper
Date: Thu, 13 May 2021 14:45:46 +0100
Message-ID: <20210513134550.2117-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.81.63]
X-CFilter-Loop: Reflected
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, wanghuiqiang@huawei.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Introduce a helper to check the sid range and to init the l2 strtab
entries(bypass). This will be useful when we have to initialize the
l2 strtab with bypass for RMR SIDs.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..754bad6092c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2369,6 +2369,19 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static int arm_smmu_init_sid_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	/* Check the SIDs are in range of the SMMU and our stream table */
+	if (!arm_smmu_sid_in_range(smmu, sid))
+		return -ERANGE;
+
+	/* Ensure l2 strtab is initialised */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		return arm_smmu_init_l2_strtab(smmu, sid);
+
+	return 0;
+}
+
 static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				  struct arm_smmu_master *master)
 {
@@ -2392,20 +2405,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		new_stream->id = sid;
 		new_stream->master = master;
 
-		/*
-		 * Check the SIDs are in range of the SMMU and our stream table
-		 */
-		if (!arm_smmu_sid_in_range(smmu, sid)) {
-			ret = -ERANGE;
+		ret = arm_smmu_init_sid_strtab(smmu, sid);
+		if (ret)
 			break;
-		}
-
-		/* Ensure l2 strtab is initialised */
-		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-			ret = arm_smmu_init_l2_strtab(smmu, sid);
-			if (ret)
-				break;
-		}
 
 		/* Insert into SID tree */
 		new_node = &(smmu->streams.rb_node);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
