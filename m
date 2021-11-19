Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F14C433F5
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8705061B04
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8705061B04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49D2261BDC;
	Fri, 19 Nov 2021 07:27:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHe96vcIO_DC; Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 397AF61BDB;
	Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCABC002E;
	Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA61C0012
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2D99400DF
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dtHu-jRA6ywc for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 07:27:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A860E400D9
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1Drrr/r9QwuLizYUsAa7BgOQygkJcvjHDo2Dy5uzOu9HTs8lKe1fedVNFlJRaH/6hsfypipVD2Qfzjh3KJqBv+C30yiDh+44wKQqiQX94JVva7ObScpM/lEqIHGJtcyfyAxBGE5qeVzLZH0K3Uqh8Su0GHQoBwMdnp8E+M5cpOpvO+DE8XmziRi6v7WEk+lD4bZmHpqglg+NcioJuNr6tkli9JFeOh4+EJ54X9lCD7jq+PM5ZqLlEvWxtYJEebyfzK3mbNw1XohPSXUafUveXZljFRzrU6/Z3VBwhf9uArf/hIvLb8OeEIxV9EwQm6kdHvV2lb84nzXGTUjPut4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkagOCbFUsmRyTNFeaYX6wFbNPq2tFycC7QRLHnpPfU=;
 b=l2Kv/D0GGzLDIt/Q6PDds4m4laCo8kjiOqTAEaqBMw5wK3JVXqb31EKY+JOC1GYv2ULoPSnkzJBVUxOgjJ32PlYXTcgaO+fmr/MKdeH5AO5zsNsxnpJLqFI143MuMFaY3LTeQbrlSflt0Iu8D3Wo7nmolCZEnVSt3dgm+YdsVmSw/ixgDcf9/f5LxFZ9mcpsPEiXXPg28QCyxgEPaB+HAxIX8x2qqKyyex7njEtKSiR6WwuN3txGrLrw1kro1Esa7Phhza5NySL6sSf+yAigM6NBH0wZ3RHcZUTx1XPfhr57lg/Sjny7J+qSruPEI7pQ/DcM/N7qkfXmjPgNjJguzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkagOCbFUsmRyTNFeaYX6wFbNPq2tFycC7QRLHnpPfU=;
 b=VwCqdfP4iHx7z4NgOuYe+ZxWBhoM00LKaPXYgc1SgYWClW+smzq0oG9NT2yqOi6eT4YIMkecoQkud6aonqUz0FLusF0gWtAtEC+HVFyaLgTVfrohW+i7V4Q4Df/R7lS+jAEogb8PFEtYH36paOtYG3nD1KOLgy2VG7EOWwWLSQF4K9OMI0RdgX0hJS82nBYxhrbHOeKNnwOU683P7oiBjfacwjq6JMEMy2kdJQ9DJwv+DrbBbwviPpTt/WW6+RyrKU43KGUlNpGqJpN5tsFKL4PTIe2IuuqAiD7qmgZaE7RBEMKiMAOmGWBqGz+RYhVNpP2iP//LK5nGIQWopXY0jA==
Received: from DM6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:5:1e0::25)
 by BL0PR12MB2450.namprd12.prod.outlook.com (2603:10b6:207:4d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 07:27:37 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::5d) by DM6PR08CA0051.outlook.office365.com
 (2603:10b6:5:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 07:27:36 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 19 Nov
 2021 07:27:36 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:36 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 1/5] iommu/arm-smmu-v3: Add CS_NONE quirk
Date: Thu, 18 Nov 2021 23:19:55 -0800
Message-ID: <20211119071959.16706-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119071959.16706-1-nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc09f842-8823-4e78-ac62-08d9ab2e0fb4
X-MS-TrafficTypeDiagnostic: BL0PR12MB2450:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2450AB9F29A91BF67B82D25BAB9C9@BL0PR12MB2450.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MaY2CJG+mef8qOHNSig8NQs+ssfbhTdlbyeCrYFAp/b1U91T4PssDRtvbT+9AzZaaXnjwWoG8R6ci9JlNqQ1kdJ8t0yNS5rLskAyf+FOcm6AvmgSxJpVelH7/3JwfUScXNx0Sh1LLDSQRbHFU0KajCX0I2mm5CLGRlKdiFrm1va/51qLU/6SSTkHwvEcwfheyuXfO1NcDUbp8OlUzAt+gFE1Cr/7UpM6okZvJHMKJe9idsf+aJiHlazbokeJeZQSnWMBwp5y/5WQ1ieMKJnbLFSOn3xCZy0l/MJBsyKWIyNaGp4yX4KnC1J6Ib/Tf0CJxeemxfSTC0D1WISapjoOuYRc+dAW8iyIbz6nJEtPmekWWeZG11glnnrW60uu0CMvuCFGH4jjsk2/JoRWZt707dIuBCoCd+JlFwkOO7TG1GgIpy7y1KdmShx/kgfWzJ4O5Fk3osx1P9S3vMUAD2Vp3Zt/xUBaBi23+sT46oYkiDbGjkKrkJUXeeaXAp0IMchlOhBx9zEEipv8PfhyvGISJbGZLqR70r3hxIz1/HD42kW60GpNTWn1cEofxoc+G21naUg7TA+kPwXseGsWMfS8/iBilj4QGrnE7J8w4C43Vns5gp23FscUICO6LYqGxiyoUni7YpuuZDrBQnEc29avsGVvrsLAN+VWk0x++M1LeKUJQMMCSS2AM5xF0xEhb8NNrnqQlIFczc1cWac+r1m3pA==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(26005)(47076005)(4326008)(508600001)(6666004)(356005)(5660300002)(7636003)(82310400003)(426003)(7416002)(70206006)(1076003)(70586007)(8936002)(2906002)(2616005)(336012)(186003)(110136005)(54906003)(36756003)(36906005)(8676002)(7696005)(107886003)(83380400001)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 07:27:36.8400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc09f842-8823-4e78-ac62-08d9ab2e0fb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2450
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 thierry.reding@gmail.com, jgg@nvidia.com, linux-arm-kernel@lists.infradead.org
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

The CMDQV extension in NVIDIA Grace SoC only supports CS_NONE in the
CS field of CMD_SYNC. So this patch adds a quirk flag to accommodate
that.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f5848b351b19..e6fee69dd79c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -319,7 +319,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
 		break;
 	case CMDQ_OP_CMD_SYNC:
-		if (ent->sync.msiaddr) {
+		if (ent->sync.cs_none) {
+			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		} else if (ent->sync.msiaddr) {
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
 			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		} else {
@@ -356,6 +358,9 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 				   q->ent_dwords * 8;
 	}
 
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY)
+		ent.sync.cs_none = true;
+
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4cb136f07914..7a6a6045700d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -499,6 +499,7 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_CMD_SYNC	0x46
 		struct {
 			u64			msiaddr;
+			bool			cs_none;
 		} sync;
 	};
 };
@@ -531,6 +532,9 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
+	u32				quirks;
 };
 
 struct arm_smmu_queue_poll {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
