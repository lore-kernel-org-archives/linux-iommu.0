Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A02C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 08:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D86A240276;
	Wed,  8 Dec 2021 08:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVhjFI_2KSgY; Wed,  8 Dec 2021 08:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA60940077;
	Wed,  8 Dec 2021 08:47:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83338C0039;
	Wed,  8 Dec 2021 08:47:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D01CC006F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54B6280DF2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WaNxEsslBAeA for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 08:47:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C17680DCF
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ0iJwrf2OIyXtF4yFyZ/KQqes1aVta6kzSkwryr0zRjOcSOywomq65w1+9+88Dwu1rJmUb4qTTFC9y81QBrz48UTdQTD5nB/VaUIhVExeemLCD12U/r59BnHmQ2tLliJSk/SFn03IiVZUxQjZTzMC6rzlyDvqudleB7QNNaHLPCeG1YR8xJgC8BKJwXMR1TX+ySJdtphg7550/ZxArPOjkuFp3c0u+FWLlFWTXLvCQPCMnCOZgzixumfOC/N75Y/Pzierzhj249n1TGy3GQdYsUo47pZ0+e/x2Ph9P8i0x+voX99x7IEHcej/wkuNk+a9zsxy2anSCeqSApbP/isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS65vfo0WoHBvmAzmr0pIExlBIg0ScMsocsaJTs1wiM=;
 b=gkcGy7pPsosnHgfAPXR1FMyJi8Fa4vtXvkt31FLOf9swLhGn8o1tOMWdHxAJe07uU9dSPTUcLWo+8+hf3VJ+A6p+lM8WpB5w2U9osPWCpyqsc1fxtFxRqT3gmmgOiL5+KwqyzL0vhFNM7/mkiiVrNUq8qCs/gPxp07XtOLLsXbnIorYp14KtvFAbb2po7uKnuCDpLHRvF77ITFKDgD7nMemsgmdEQTWEGS0dQHI00eNo90wZ5RnKGL+aom1ENvLNFRg7yZ+gZ7WTiIlGvxBC+tLHdVHecB9qQN7f8fy2pEe95gPJeuu/QugRNUJ8PI7Ix+b3kuPK8IlqlmGRVXQxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS65vfo0WoHBvmAzmr0pIExlBIg0ScMsocsaJTs1wiM=;
 b=d0Ac8fJvpRzJhNHAtq4r9s4xqjcI6yFrotsXWV1ewk1JRAqCyFE0M57THgfmWHiGQ5D8AF4tle+5xiUySM5khwGX+Fi69MvgLmqMLD2N1QC4H4CsMTFzauODyixTR5X31w8AfObiuPGK4alwxSVTwLfaqTtsgpfMIai2eUoGcJqvzzoQDGqZ1cL4VnTRtdhftJQw1KUgUkJXyfVqltagmYZWTwsaG/byH8X/hGCsROgojly0A2rHzhk0sv2IFGpnzrBu4bZbrelOUYAuRp6FkX7hz2Fdge7pDusAUbQg0/f0p3XAeYwcUX7DAcgRq+DdFzjNBTJgPpfAj1pe9yhnKQ==
Received: from MWHPR21CA0034.namprd21.prod.outlook.com (2603:10b6:300:129::20)
 by MN2PR12MB3168.namprd12.prod.outlook.com (2603:10b6:208:af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 08:47:48 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::1e) by MWHPR21CA0034.outlook.office365.com
 (2603:10b6:300:129::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.7 via Frontend
 Transport; Wed, 8 Dec 2021 08:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:47:47 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:44 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:43 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 00:47:42 -0800
To: <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v7 4/6] iommu/tegra-smmu: Use swgrp pointer instead of swgroup
 id
Date: Wed, 8 Dec 2021 00:47:30 -0800
Message-ID: <20211208084732.23363-5-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208084732.23363-1-nicolinc@nvidia.com>
References: <20211208084732.23363-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f5ae65-d996-450a-d0ae-08d9ba27694d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3168:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB31683A48F35AB65619D83BA3AB6F9@MN2PR12MB3168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhaCpL1pbDnuwp8kT4MA/8jcVSiZkXb7+8jP6l3vWsgmw7GK3luVQh/K4xoSITYYNNTuleU4MoINd8KwGzWI0rCfLMTKb+4oQuTY2+MvSVmdZt5l1JEqtb1ktM2kwIfj1MOiYPwOoHllRpETqqSTV7F2C9Iz9oDAIie5b8Lg3gQsnxDwQS1wy/vYRpMa+G+IbolecS9gkE19It2JYw7isajT8G/603usP/tXIOq8G6eMF5L4xyHk4CLaUrB9JI/3yNXOluezdBbfjrdvajNfRkcORl13nLSzgVNsV94FEW8eHn/CALLyLu7U3d83N2HOotc+C7dQ5EfGH37EMQliLJZv3hGh79muXw3l4Cn14tx07PsoMXlP6lbj719cnwCtZhNapsHzAXHT/gLsbBtnKAfdVxYnGyVL41KkZs3MzMRUahHM9BzRipkWb1xRukpmVjMEeqvlZe1OdlR0TqH/gOkVeVezoAuB79sSdjHi0qzS9paBpwu05jUtHPENp4/EpQUnD0THsYGghlYwK5WvoJYmcH8mgzh8swXESnxdoFWABiO9llY4rwC7aNG3j36+0tyHyaCihUN0M6dlAZXza3J0tCemGCsX+CkZXgYzutj+W5fUZnhqmwSfJ4j6WgAbl5MiIvONHGagjKfu+aWoO7ZO5Me6ISyoaBm3sPdH4YwqG6HD0vtqCebq2zDt8X+0HR3rOfChEsURh6H6Pij4Jf2J+RDdrfTckyBP0GGv1EuPRrOI6zUpcJv/bfg8IkSfA+llwbcvWL9cCYEaDG4EWwZMN+OfFxi2LXoKHbcos60=
X-Forefront-Antispam-Report: CIP:203.18.50.12; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(83380400001)(110136005)(54906003)(2906002)(6666004)(426003)(336012)(36860700001)(8676002)(2616005)(4326008)(186003)(26005)(508600001)(70586007)(86362001)(1076003)(7696005)(316002)(5660300002)(7636003)(36756003)(356005)(8936002)(70206006)(34070700002)(40460700001)(47076005)(82310400004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:47:47.9240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f5ae65-d996-450a-d0ae-08d9ba27694d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.12];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3168
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch changes in struct tegra_smmu_group to use swgrp
pointer instead of swgroup, as a preparational change for
the "mappings" debugfs feature.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 42af216ef65c..b0a04cc8f560 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -23,8 +23,8 @@ struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
 	const struct tegra_smmu_group_soc *soc;
+	const struct tegra_smmu_swgroup *swgrp;
 	struct iommu_group *grp;
-	unsigned int swgroup;
 };
 
 struct tegra_smmu {
@@ -897,18 +897,22 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
 	const struct tegra_smmu_group_soc *soc;
+	const struct tegra_smmu_swgroup *swgrp;
 	unsigned int swgroup = fwspec->ids[0];
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
+	/* Find swgrp according to the swgroup id */
+	swgrp = tegra_smmu_find_swgrp(smmu, swgroup);
+
 	/* Find group_soc associating with swgroup */
 	soc = tegra_smmu_find_group_soc(smmu, swgroup);
 
 	mutex_lock(&smmu->lock);
 
-	/* Find existing iommu_group associating with swgroup or group_soc */
+	/* Find existing iommu_group associating with swgrp or group_soc */
 	list_for_each_entry(group, &smmu->groups, list)
-		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
+		if ((swgrp && group->swgrp == swgrp) || (soc && group->soc == soc)) {
 			grp = iommu_group_ref_get(group->grp);
 			mutex_unlock(&smmu->lock);
 			return grp;
@@ -921,7 +925,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	}
 
 	INIT_LIST_HEAD(&group->list);
-	group->swgroup = swgroup;
+	group->swgrp = swgrp;
 	group->smmu = smmu;
 	group->soc = soc;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
