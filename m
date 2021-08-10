Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C08C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 04:44:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1262560EBD
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 04:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1262560EBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E58716081E;
	Tue, 10 Aug 2021 04:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tuuH_jj08ZPO; Tue, 10 Aug 2021 04:44:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F0D5260632;
	Tue, 10 Aug 2021 04:44:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE6AFC0010;
	Tue, 10 Aug 2021 04:44:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74EC7C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63703401B4
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id io02vrbFWCUX for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 04:44:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D68540507
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=manjzIaSkO0IRDHCaRPrwM5BNMJnGze5g7fl4lYL/ttqDJoOMa06qAb9hiysdrP+RzPVOVc3x7OsPra0+5pjxQr5sfr2Eoo+WWhjMSc9bKqPJW+AjaC8skZJeZVt13e14wb8eLBCXPnAXalhyZHHNqqpnc1OxZC+e+6Jber9/EDqBzkKNFeP8yrPADVtqDRFMnKgPZ1WiooVEkZoxFgXy5cKPy1BdEKtk4HE2MouBkK65CkAYRL+e8MqOwsHGJ2JWT0yUc3rdJrI0Ii6RgxpwFy0zdcCu7kRLVW9JsGORvuxu3eVk0hI9393eKv7GJgG7zMT4jBRABCR0hOL6CGvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN3AvopMMiaOpNbeKK0m8WW8/HbWLf5MlU5g4GWZAvM=;
 b=CZasmt4JhKlcRKiX/fgACMx0U7y6rU2dXOMaWYx8QsGwYtDBTOJ2PzHUbJlQrnn/vbf2Kl/JmFiw64GQwLOEZA1Qj3pFkuEZMhJPloTFtR+Q++XEa9ue/zRSLgnKrQ4ig3zng+dwLq9mX9vsOuv0wdgBuucRGcIsNVxfnazoax1eLuvYB84gktwmmCutKMWTaK1mrOzyQ5D8qj4BS3UlPi6l1qpjXaP929N1Qln8iYkpEV7rccl3R1MFJveErTjJNFBFiobLoHFzkT5IInxFtlYvBTD5sPA0K2FL5kn6L0uok9SFFtDxewg1vlpDPblpSxGL3gPPkRDMmkI19ay2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN3AvopMMiaOpNbeKK0m8WW8/HbWLf5MlU5g4GWZAvM=;
 b=Ego3jeiFkfesK/guIFtS9F7HNiIaQmjpAIpY0RMUspz4oSzvG5NdScLhEOUrGg89+WbTIPHJRbYs2MPkVDzIoi6Y9n+BcqTtsg+a+dCWJYpnwtiwY94/WOgga0zSWuLOJH5YRaNB7wu3bhdvP4GPK/2boiN7WYyrq7URTuAiFwj5L6F+4SqH0O01lCWONLGxI19qwCIJ4Ea8eg8JAVqmxwujvAqlGdP4KaA+TBRVlm7FGh64Jw4+2mTY1ZKjVEo1aflG7jbHOUprGcjZbdj02rfbmxLM/fcyr7BjxmXA8VvnG8QRh3flIzWthJ5sVo9jzPeMkHtUIhGi1x3ZAP8HzA==
Received: from BN6PR19CA0069.namprd19.prod.outlook.com (2603:10b6:404:e3::31)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 10 Aug
 2021 04:44:21 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::52) by BN6PR19CA0069.outlook.office365.com
 (2603:10b6:404:e3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=pass action=none header.from=nvidia.com; 
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 04:44:21 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Aug
 2021 21:44:21 -0700
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:19 +0000
To: <amhetre@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
 <vdumpa@nvidia.com>
Subject: [Patch V3 2/2] iommu/arm-smmu: Fix race condition during iommu_group
 creation
Date: Tue, 10 Aug 2021 10:14:01 +0530
Message-ID: <1628570641-9127-3-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
References: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e280373f-4c00-42bc-b1fe-08d95bb985b3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5190235F258078B8BD7644CBCAF79@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KR2k2GktIBeHyZu11oPWc/HastQUZ4hIpM8WylE92Z2PnvYhqkz+nEylwzcWVpZCIgc1T0L4ov9QURdpKZX4h996Waqqx+i+ICu7JfQ3lMkHqMl5uNEGDgjR5XfpIoo5IvDxjrY9hOz7mMIkI238J6E+SOh+lHPmkmisGrRrY/0lCrY/7BL/aqg92JU+yLsbkSIM8SBZYaVNyc3Q0p3S5Njdpq/U5Z9PC6kXtE0/EgDrH3/jYPDw+au6lRtZwtypM5WyvKjGYBGy+GKFavlw2wh3ui2GXATW3WcFtEkRrMBGbPUgzsPqGnUia5TJH8CCSP6fB99VWSyRdKG1uRZNGA32y56SekPMOnw9kvLuY31sDEuFKze7CEwtgIlJkwHkzHrj+bNZCGC4Cg3TmYVNUI0JiH1s2JQ6MtDcO9upd7crn3PCemZqyskhNk+izDhNoYci9LnhelkSt1iWtD/KO0W2B4Q+SBB4UFCVehy1bwK+WF46lL0K33bVcZeBrA1ExkgVOe1EXJmz+IFHpGe0Gx2YZ9OR34ZxsZV9R7O/eKAMBwePBa9xXUViwlQh54XQgDWG13V4OYFogaVW7R4vGwraOKba6fdkryt1eJQXS7qlLWcU8PX43fES2hLZkaFn9rtsx0DctXo8BOkitztIG+hR8UWYcw6mJG/NU8yn4T/SwdPiwcwVxEmBl8fwd8ABFzYZSDE6RQ10mHRk3JUtbg==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39850400004)(46966006)(36840700001)(6636002)(6666004)(82310400003)(8936002)(54906003)(2906002)(36756003)(26005)(110136005)(186003)(2616005)(83380400001)(5660300002)(426003)(336012)(70586007)(7636003)(70206006)(8676002)(86362001)(356005)(316002)(36860700001)(478600001)(4326008)(47076005)(7696005)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 04:44:21.8290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e280373f-4c00-42bc-b1fe-08d95bb985b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Ashish Mhetre via iommu <iommu@lists.linux-foundation.org>
Reply-To: Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Krishna Reddy <vdumpa@nvidia.com>

When two devices with same SID are getting probed concurrently through
iommu_probe_device(), the iommu_group sometimes is getting allocated more
than once as call to arm_smmu_device_group() is not protected for
concurrency. Furthermore, it leads to each device holding a different
iommu_group and domain pointer, separate IOVA space and only one of the
devices' domain is used for translations from IOMMU. This causes accesses
from other device to fault or see incorrect translations.
Fix this by protecting iommu_group allocation from concurrency in
arm_smmu_device_group().

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dba15f3..f9c6648 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1457,6 +1457,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	struct iommu_group *group = NULL;
 	int i, idx;
 
+	mutex_lock(&smmu->stream_map_mutex);
 	for_each_cfg_sme(cfg, fwspec, i, idx) {
 		if (group && smmu->s2crs[idx].group &&
 		    group != smmu->s2crs[idx].group)
@@ -1465,8 +1466,10 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 		group = smmu->s2crs[idx].group;
 	}
 
-	if (group)
+	if (group) {
+		mutex_unlock(&smmu->stream_map_mutex);
 		return iommu_group_ref_get(group);
+	}
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
@@ -1480,6 +1483,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 		for_each_cfg_sme(cfg, fwspec, i, idx)
 			smmu->s2crs[idx].group = group;
 
+	mutex_unlock(&smmu->stream_map_mutex);
 	return group;
 }
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
