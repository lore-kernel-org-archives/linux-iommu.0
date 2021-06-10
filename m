Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6111FC48BE5
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 04:45:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254AD613C8
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 04:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254AD613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17F8383C8D;
	Thu, 10 Jun 2021 04:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCgnJ1keMINH; Thu, 10 Jun 2021 04:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2C3483CA1;
	Thu, 10 Jun 2021 04:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22665C0023;
	Thu, 10 Jun 2021 04:45:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAD24C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 04:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C693F40380
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 04:17:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtMRU6u959aM for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 04:17:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E6CC401CC
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 04:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7MyKdCxEvY1yaeCMR+a0s52J8k0EVIqfJfAbnx0fPrq+JqDH9eS8Bufv5DQFe0kyVz9mYuet89GiArjIqpTMiVopC4fK2k7yRG4quqr05bmNz9s6KICVVOiXbS3kq5kVZwUL/1OHsxMnS7Is+29pWNikhsjaOlnw/L5Enhf5CnE60DktBN1v1yQFiV6rSg0GeMuT88Z1iLp6TUX39eUOhHNo5l8prTyhazcr0XCLmjUx3pDQUFxMfFZ+SXEHlDHBk4s3lDYlFi8BT2xM90X3+qBox0JG4Tkn+EzTTkNWKkt5WMtzX3gmNxWfYZ1TDZKimgrgHRq9eZBxnr3KM3ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b1sK68wbBCTbQjyOI2dbd+1bwA3LBeLoZHiGhjP2Rs=;
 b=iBmFW4eh7FOphqmePGOzuUWO2jCw8QVd6S+hxACo3HM+xx2F1qPVK5YdZBv4d90kwUUcaUFDeSDRbXYSBUHHIcapHbhUX4i97OmcU/GzLA1BGsIdRVq9+RdkEto11fjb7itVjAolGNWNX/xsAUT6n6Hgc83wKKY47YTBfq5x/p6A/uZ7VAfyPO3iy57qz3+7GBPm10GYJ+lPlOdxBQ5T8l0nozUpUXVM0ym7ggOtbybACKmOSuUFZ3zzb3VT6kBJ2rlkrhhnFCkp6DwfJYpqyUJ2ekLBtxcAcQLGTu3ZTtfgIbFL9hvwVW5osS3/qec2AAg2/ATSGnHQg/NAFQUV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b1sK68wbBCTbQjyOI2dbd+1bwA3LBeLoZHiGhjP2Rs=;
 b=BfMxMtRYovkuk5W7eBHekwfKgHaa8Ew6aDH+MVYg5OeJGGI0KFPak0lh1nAyxh34hYW647WGjGeLvoG9HqliS5d3803Tcc3/2HjJi0xTtpC0J3JndrqxpcLKYfKOfqX53TEEKg5oeQd6PI2pe2buitcGYZperIGmiaHSWT6ZSYB2vvjn3Wn27sBOcSRyea0NDUQwlcOkCkHz7GXQrhAUgqQY9KaV2S/qhtgsknQQARV4v5LRgqBO6zB4NCY1L9LZksmZ/q+mdmzlXykUwew7D4cKXRtgMzF/dexoJxMJ4jyL0gdlYphyrygmIZMNXHzE99JdBbjuQFuyCZtP+GEAlA==
Received: from DM5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:3:7b::17) by
 DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.23; Thu, 10 Jun 2021 04:17:40 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::4d) by DM5PR13CA0031.outlook.office365.com
 (2603:10b6:3:7b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Thu, 10 Jun 2021 04:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 04:17:39 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 04:17:39 +0000
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 21:17:36 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <amhetre@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <vdumpa@nvidia.com>
Subject: [PATCH 2/2] iommu/arm-smmu: Fix race condition during iommu_group
 creation
Date: Thu, 10 Jun 2021 09:46:54 +0530
Message-ID: <1623298614-31755-3-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1974845e-8d18-4046-3329-08d92bc6af7a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5039439F70BB57AD5F43859DCA359@DM4PR12MB5039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxwA1oMzqw3QUgSXmLC/CNwarktwdvFP8LrAlb70zDfs13MRvVSyWSWOG/gPqb7r5UJUjfA8ck5tgc2QRidfl4F50SDz4SmaZd7ZNUeDOuta8duD2s6aePbZ+CdafZAbCY9ymMKhlvpalfyJPf6zol28Z4phklvwziglLAgRTJqojpEhspGLCq2F06nGlAQS6NgNeR4CEKwZfpHEBQbnNsUiGglXz27mQkRI9XND1HbgC++t2JVY1vIw0dFyfEQjOGDjTsgofrORe5XNzg7Ga3Eyi4f8/nZFu4AsWpjRdwDxHTDe9PYZ5aQTaiTOsygoVXckEr7YpzZgDiAxZjGHXUJhJhIQg2zUGPIcl0Oy/MqZjyYZwHw+s8GsqtlAa8NVRO7T2p8A7yMabAKQmPgvXP6o5py5HMbpdGacl614yU5TrKuLoVk7mLKu4VuKMnupB1fONCJ/cKdjW7JuGfPhrUvp8rv7dB7VmrZA9Vh/rCutEKyuDsvDiYExNRuXTDU85vKYy8+UZ87io50UTiJ6ESzZhppU8ZOhXqsyhV2/yPVO7MY6McrQmqOI/h6/5kmzHB1wSj25VemYYrX8O05vIIVwBCTExO4ktJPBgWfZL3GfLg8A0tO3gaPEKcZSTTZgCq45YE4K0Luq5jIIqTGmWQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(8936002)(8676002)(6636002)(478600001)(426003)(2616005)(47076005)(83380400001)(2906002)(82740400003)(7636003)(36906005)(356005)(70206006)(86362001)(36756003)(186003)(7696005)(54906003)(82310400003)(110136005)(70586007)(6666004)(5660300002)(336012)(26005)(4326008)(36860700001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 04:17:39.6076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1974845e-8d18-4046-3329-08d92bc6af7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
X-Mailman-Approved-At: Thu, 10 Jun 2021 04:45:06 +0000
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
Fix this by protecting group creation with smmu->stream_map_mutex.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
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
