Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BF7C49361
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 20:31:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60586100B
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 20:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60586100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEE3C842CC;
	Thu, 17 Jun 2021 20:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SyMpoVxioeX3; Thu, 17 Jun 2021 20:31:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8D83840F9;
	Thu, 17 Jun 2021 20:31:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92174C000D;
	Thu, 17 Jun 2021 20:31:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB745C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 20:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CED26842BB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 20:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YKF07J7ZTipj for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 20:31:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFA41840F9
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 20:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWEqTLdbByD+tbrSzZlJ43uftinx1galA/grYXLqWvhoReUM9JLqWNM9Ag/STSjkHMytx+VwM3i9bdFNQXW54KZifLK0xep5HRAZOevftr2Oe+IKIwOCiP2ISyzNpiVCphEicIRcfxM2RTSdVIqL76/6oGJ2Uzin3GGBMnZF1L5mt3MwQAzF7E4MwXro3cmOVMwUYpHjDgwVIX//aywHMgC6guk6OFL+Ex9pGyYUMxYlVV62TU+/Tec6/0t0+6vh2u5Zg2vgT+BMfpE9E1oDwPs5UWD7ZPe3fHD/vQamS3ixqM3T8usGMIoh+t+bRPSaJye6NbYUxZTu37L9VdDrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9zSYnFTOJjFyplreG5rMbmKjeLNFDyRB/J7qq1KH5A=;
 b=d1jyyDkXfRL2A/7k7VUdJMjV1utEFp4bwQGjaXaBBFT2+WquI1bR4o2CTzje8tM/XA9GzMQH7z7c2ZQj84gcRiJ/+b1Sun1yTS3ULqYcrO1l15NyNGlyrQ2srFlJqvvsSerXzBQ5QVv/hcQZ9w7nsuYxLpZLcw/yb8Sctn4wUZWAqpF/Ucjm5QMhDKXb9wD4hmuBjuYgfbfkXc/BRBURq15CqNnZZAXzBtIz9XgRMddjc1C+oxBle5Yr9llzzkVX/s9lPXqBrVDEQTk0PIa1IHiYdUKazT9f1bl8MOy8R0/6VrWb8mki+0+jmCJglVj/pVeWd9n8Y2cGXCTaWpsWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9zSYnFTOJjFyplreG5rMbmKjeLNFDyRB/J7qq1KH5A=;
 b=b6GKCySqgPeCFJ+9Bab2/encpTHmRD4dT2l17BRrzGisTGWpbjV8PaWPKfstjqeLoqmHS3kNj/JVskeuUY3n8NtYqBn7lSg1AmWoZ7GiqDy58FCVVrjCejCk+GJlJ3UjzOgxvGRmnXOWbRmUZ5K5zjWgOr6YUeFx+rJAG1/NMJ+Z87ZdSF7htcv9t1z0ZQThjSXAjjFMVEsKD9htOu1NTaM1/uhAnrq6Fgp7Nkuizx3MNIc8u3exF7hYKq3MTxZLjVlxtXkrsBofUBJoPtrwjcKAUddcF2PoqHL7dFmBAGg1kMdBL1AodI4fcUUDfna/fSf/Iy8i4IpqoDHbEQjZ8w==
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by DM6PR12MB3881.namprd12.prod.outlook.com (2603:10b6:5:148::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 17 Jun
 2021 20:31:27 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::df) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 20:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 20:31:27 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 20:31:26 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 20:31:26 +0000
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 20:31:24 +0000
From: Ashish Mhetre <amhetre@nvidia.com>
To: <amhetre@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
 <vdumpa@nvidia.com>
Subject: [Patch V2 2/2] iommu/arm-smmu: Fix race condition during iommu_group
 creation
Date: Fri, 18 Jun 2021 02:00:37 +0530
Message-ID: <1623961837-12540-3-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2564e868-5114-4be5-fcbb-08d931cee23f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3881:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3881EFB2E989B2E600FF334ACA0E9@DM6PR12MB3881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSDQWY2pwKSVr8P6Gz8zZLxlmBKp/OtLZGoHwEybFTdjMikMD60gAIuc/+nNivMDCbgn47i6edl3wTSOJcZlBAnHaFR3ede/jd+gPl8xF/dWxwArRY1uiRbMqzaByIjowpxE83q8lDdKd4TyPA0D4VeSSgKiKdxd/sqecIU3XRmiVY0AnQ0zM+zvohSgfUpgzqs0q7SvwZ6mSsqvCvbmUHS1ObMTLkXEJu48mRXcNzZtx/Y9ljowF9HNki2RKj3ZqD9h/TpNxzstDRN9pngpPcdvMpsRY9jwJTcxmBXKJ3zWFa63DJahfucxIIrEoZZSHjH4R9AZ9G28tHMTsOW8ax0LcHalTloXL2jTMrSnXkArxAohtjerj4iuNp/8iUUAKBueyffAY3/0uh/NOB41gvOEAeww0WGkpFY/Gjutj5VUgiiHALqyoT9S+N7BEGzXwWfnf9fgBlVP2zdMB4niUKBh2pF4Qw7pfIu2aALRxmKochkYLsUzWCJxO+Nf4zrv1puNXvlW9SNd7htRk2LpaRnNNOJPSzPrclE7bYN2utIhWt/E69ejNf+O5b6DuA25q4sB66yTPl6OgXZdUTpT/V9cjEM+AP8MX1tqsCnRbIu6tSCIzDKmT4JbW9WdgKrpbmfeq2g6SbVnbmWZtxKkPQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(46966006)(7696005)(70586007)(70206006)(7636003)(6666004)(26005)(47076005)(478600001)(36860700001)(356005)(54906003)(5660300002)(8676002)(86362001)(82310400003)(4326008)(2906002)(36756003)(82740400003)(186003)(36906005)(110136005)(83380400001)(316002)(2616005)(6636002)(426003)(336012)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 20:31:27.6755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2564e868-5114-4be5-fcbb-08d931cee23f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3881
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Krishna Reddy <vdumpa@nvidia.com>

iommu_group is getting created more than once during asynchronous multiple
display heads(devices) probe on Tegra194 SoC. All the display heads share
same SID and are expected to be in same iommu_group.
As arm_smmu_device_group() is not protecting group creation across devices,
it is leading to multiple groups creation across devices with same SID and
subsequent IOMMU faults.
During race, the iommu_probe_device() call for two display devices is
ending up in arm_smmu_device_group() twice and hence two groups are getting
created. Ideally after group creation for first display device, same group
should be used by second display device.
This race is leading to context faults when one display device is accessing
IOVA from other display device which shouldn't be the case for devices
sharing same SID.
Fix this by protecting group creation with smmu->stream_map_mutex.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
Changes since V1:
- Update the commit message per Will's suggestion

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d..21af179 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1458,6 +1458,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	struct iommu_group *group = NULL;
 	int i, idx;
 
+	mutex_lock(&smmu->stream_map_mutex);
 	for_each_cfg_sme(cfg, fwspec, i, idx) {
 		if (group && smmu->s2crs[idx].group &&
 		    group != smmu->s2crs[idx].group)
@@ -1466,8 +1467,10 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 		group = smmu->s2crs[idx].group;
 	}
 
-	if (group)
+	if (group) {
+		mutex_unlock(&smmu->stream_map_mutex);
 		return iommu_group_ref_get(group);
+	}
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
@@ -1481,6 +1484,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
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
