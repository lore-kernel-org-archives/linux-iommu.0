Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5501EC25AEB
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCAA6101C
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1FCAA6101C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0032860BAD;
	Tue, 31 Aug 2021 03:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W58NB3hnJOip; Tue, 31 Aug 2021 03:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6889360BB2;
	Tue, 31 Aug 2021 03:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B0B1C0024;
	Tue, 31 Aug 2021 03:07:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCFC2C0029
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9FF6B60BA0
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OVkSxS2R4DQA for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 03:07:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A18F560BA3
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch3+K2SKPbfhN0e2D5m45TaES2NSatir7sLM49bLvejpOMauhZvrjZI59E1cKshzxEWm9pf3ecT6xlY/6HinZg4dw4dhY9b6A+tHC72tVMZBtdAeQJYhH4XQ7xKSVz3qFUPkkPASuiP3MVs7AH5S6UqpLm2dqk9ve9SZLboRT+CfZ3pFdJZQTWUuDOc89gPg6hlrlTYxRaO2Wz5f3X30Uv9tl6KEIns80s2ScPmt0LNRTYDUNSbfcB+GPRSDZuVPuXFmHiTeD6CiQZCFYf5B0awBke/IjIbMsc3i6IXjHGW1fHHiP+8b6IBkRzolDq24Awbr2d0108G+BuwmpgQv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpjukUTieUUjed7zzEP+YhIb+Ch9mnM9hZjb/ckgsGY=;
 b=alxiWboigtim7RXbVllyIIHVCEWM3ulx5cmzspuywMIHhZ3JwDgdW2MHRxQHGJpRb6sijZlU8PPg/TXfUMhG7J9xZWupFE9bOR9s+nzun8P0fQGmbR/hoxs9qMS9OydnnPUtcmnJ7aUzIH/a08M4LkH/xQ6Jyer9mJ8Tk5zp9F1KCwa+v1bpMxAkS/YbGhH4XHYm610X+3zuODTf3gXDXNL1c+nidQObt7qbnT+y7UOMI3iCEpCtpwcSI82AFTvswslGjiwcX3yAqn3RL8F655Gls20G0QFrLGzSvdGNFngugRzdDwT4ochFsbXwAb7pJuqLhAW6ZOg4GlDe9jMJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpjukUTieUUjed7zzEP+YhIb+Ch9mnM9hZjb/ckgsGY=;
 b=qHVVyhf+BJjT+1b4k09qGJRKjjVrdWlwA8zUDonpoiBQhAgC/k+s6lW+Gg4hiYgpW/1/qlOG3TayykQJXHEASq7V1d81WW7ofov9vEU9ozZpAGI2x+iRRcu3FCNiy7y0BJgf8arUBHudKKRuppt8I3UjNj/wUzCjU0Gymb1FjfqvTsJVtZ+/BtKVTfD+rhIGGm7xEvK5a6Z1gbGLXzQK2vZG2F0/t71E4SpssuokxgfLmtu1TwiqW1ctSJF82eUeiipq5ybtm3UDcBKLORQ8gQ8i3GQaL/lYrmHsmC0sdmiXNHg6Rc3mS81wZVZyW4Tuya00ygZB+1KwrSfyM9EfPg==
Received: from BN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:405:14::26)
 by SJ0PR12MB5440.namprd12.prod.outlook.com (2603:10b6:a03:3ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 03:07:34 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::6c) by BN6PR16CA0040.outlook.office365.com
 (2603:10b6:405:14::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 31 Aug 2021 03:07:33 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 20:07:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 03:07:32 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:31 +0000
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <cohuck@redhat.com>, <corbet@lwn.net>
Subject: [RFC][PATCH v2 10/13] iommu/arm-smmu-v3: Pass cmdq pointer in
 arm_smmu_cmdq_issue_cmdlist()
Date: Mon, 30 Aug 2021 19:59:20 -0700
Message-ID: <20210831025923.15812-11-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210831025923.15812-1-nicolinc@nvidia.com>
References: <20210831025923.15812-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72bcde5a-0017-4b47-e0d6-08d96c2c7a5d
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5440:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54402774478DF6B214C1DAE8ABCC9@SJ0PR12MB5440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPFeK2n98O6QAquFBBPxaAxcGJRSzyIAw+leQthnvTgz+K9LmHI5hvE7Ffk3lCQxreQRiUNYYfMoZnYGGZ9JBqGB5kIA6FESuwZyFPWfEKNtbaHQFIfRNYsaVzLk1JKPIFwB8EUSxkGkMFPQruzTVLi/3JOyIg/M4J2r0gC8oq2jgxVhYjdiTb3V6W/h1LRJkScXnEuI8V20ZAnCNi8ZotRsXCDm+qezOMLC5naMSKwkNP8kLtPUjtD+yfIDTwvbItoItfUjacCJroeqrbSz+QRnlaO3P97ssKvwHHjc5T0Ca7/OfumoH3UAklnoieN0HBbi34vHJM5XwzVSMLD17+srunvUu+gKxgzSZG7+An+S7WfNs+ccadEkV8oWTpQ7McT0DvQdouZzbSAe3PJBKlgdKTFp+LmOAPX08YnK+WE2QDj0vX2k/GU0zt6wQA4Y/5PL9Uio7zLp8eGrmxfR8ujQtHzhvFe6vABY0xA03yXzOfxt+YqDJBDKZAMFP7ecbn0YqdIaiSFsXpQV2rrG+8eEm2ky2colpBPlgkvePGopTR2WyDr6NZAJh84TSpqzEItDCvq1pqhzcMf/xO9O9H8168GbvVLpg9eS8WxbTpn1cpar6egMuOVY0/3vFbJY2rvJ44EQ4aNNmXdhuLMtfkdQUXEzAtR1luY23hWau0Q8+JMf2hwyLdVVU0W0lJl02Vqym8+7azlP6cr29q3Nl17uocISOFYLDgFCloCVOak=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(426003)(186003)(2616005)(356005)(26005)(8676002)(36860700001)(70586007)(7696005)(8936002)(336012)(7416002)(70206006)(7636003)(1076003)(47076005)(83380400001)(82310400003)(2906002)(316002)(508600001)(4326008)(5660300002)(86362001)(110136005)(54906003)(36756003)(6666004)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 03:07:33.5390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bcde5a-0017-4b47-e0d6-08d96c2c7a5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5440
Cc: jean-philippe@linaro.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The driver currently calls arm_smmu_get_cmdq() helper internally in
different places, though they are all actually called from the same
source -- arm_smmu_cmdq_issue_cmdlist() function.

This patch changes this to pass the cmdq pointer to these functions
instead of calling arm_smmu_get_cmdq() every time.

This also helps NVIDIA implementation, which maintains its own cmdq
pointers and needs to redirect the cmdq pointer from arm_smmu->cmdq
pointer to its own, upon scanning the illegal commands by checking
the opcode of the cmdlist.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6878a83582b9..216f3442aac4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -584,11 +584,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
 /* Wait for the command queue to become non-full */
 static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq,
 					     struct arm_smmu_ll_queue *llq)
 {
 	unsigned long flags;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	int ret = 0;
 
 	/*
@@ -619,11 +619,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq *cmdq,
 					  struct arm_smmu_ll_queue *llq)
 {
 	int ret = 0;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
 
 	queue_poll_init(smmu, &qp);
@@ -643,10 +643,10 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
+					       struct arm_smmu_cmdq *cmdq,
 					       struct arm_smmu_ll_queue *llq)
 {
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 prod = llq->prod;
 	int ret = 0;
 
@@ -693,12 +693,13 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 }
 
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
+					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
 	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
-		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
+		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
-	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
+	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
 }
 
 static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
@@ -755,7 +756,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -831,7 +832,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
 		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
 		if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
