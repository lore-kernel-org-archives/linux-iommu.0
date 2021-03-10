Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F1BC433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7909964FFC
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 09:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7909964FFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B338431AE;
	Wed, 10 Mar 2021 09:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljVwV-38oF9E; Wed, 10 Mar 2021 09:07:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDBBE431B1;
	Wed, 10 Mar 2021 09:07:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE734C001D;
	Wed, 10 Mar 2021 09:07:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D82C0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A910B842F1
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7jfubtX0Bl71 for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 09:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FC9D8435E
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 09:06:56 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DwR3z3vPkzrTKS;
 Wed, 10 Mar 2021 17:05:03 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:25 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Robin Murphy <robin.murphy@arm.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 08/11] iommu/arm-smmu-v3: Add HWDBM device feature reporting
Date: Wed, 10 Mar 2021 17:06:11 +0800
Message-ID: <20210310090614.26668-9-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210310090614.26668-1-zhukeqian1@huawei.com>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, lushenming@huawei.com,
 Kirti Wankhede <kwankhede@nvidia.com>, James Morse <james.morse@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, wanghaibin.wang@huawei.com
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

From: jiangkunkun <jiangkunkun@huawei.com>

We have implemented these interfaces required to support iommu
dirty log tracking. The last step is reporting this feature to
upper user, then the user can perform higher policy base on it.

This adds a new dev feature named IOMMU_DEV_FEAT_HWDBM in iommu
layer. For arm smmuv3, it is equal to ARM_SMMU_FEAT_HD and it is
enabled by default if supported. Other types of IOMMU can enable
it by default or when dev_enable_feature() is called.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - As dev_has_feature() has been removed from iommu layer, IOMMU_DEV_FEAT_HWDBM
   is designed to be used through "enable" interface.

---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 include/linux/iommu.h                       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 696df51a3282..cd1627123e80 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2722,6 +2722,8 @@ static bool arm_smmu_dev_has_feature(struct device *dev,
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
 		return arm_smmu_master_sva_supported(master);
+	case IOMMU_DEV_FEAT_HWDBM:
+		return !!(master->smmu->features & ARM_SMMU_FEAT_HD);
 	default:
 		return false;
 	}
@@ -2738,6 +2740,8 @@ static bool arm_smmu_dev_feature_enabled(struct device *dev,
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
 		return arm_smmu_master_sva_enabled(master);
+	case IOMMU_DEV_FEAT_HWDBM:
+		return arm_smmu_dev_has_feature(dev, feat);
 	default:
 		return false;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4f7db5d23b23..88584a2d027c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -160,6 +160,7 @@ struct iommu_resv_region {
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
 	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+	IOMMU_DEV_FEAT_HWDBM,	/* Hardware Dirty Bit Management */
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
