Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20345C433F5
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1DD61AFB
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 07:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA1DD61AFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5EB081CE7;
	Fri, 19 Nov 2021 07:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03ZmrtdZyWUI; Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EDBA81D11;
	Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3355DC0033;
	Fri, 19 Nov 2021 07:27:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86634C0039
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 596CD61BDE
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RePDqwyOnbTN for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 07:27:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::617])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6AD4B605FF
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 07:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hq3oUPvisnNfl7MRWzOHG7ym314y/z3HHvL/988Q9G//5rnyEBcfAXdr4CnkKVGKdbr10QyykbQu4LhU53s5772EA8NKJUlhYDpz5mDHKdZtLHwsECFJhKX2oUn9LvhWyWfHo/sab3RDXBoRkSICJamFTDNooiMz0x5DPDw4HzLf072f001mrzONb1urgohrEy7TWkhSkJvX5i0w72e5rNdDTlT+pBPeeWzuTCkcO4DzFUcpr0aktpFjk/0d0BPT4fMgnXe9B0nOI4QfiFPNJcJ9tm+G/SIjtx5PdBkdJJCcUokG1v43CnAyOFMlx5qrCO2xmG4cppSbZ2Kn3z77Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsRK1Q74hiK7MaCRZch1f4+qyyM7SfVCtHJX4+aYgS8=;
 b=D/8MkN0Z0ByM2dy3roEaMRXQKecNuPE5wu8W/Fi9FDXX/nDvSKa0rg6OFtr2T1pTIckbWzGxuR1YZN3QVXK29/v2RoiAdz98QcFG5qmuyA0At1ubOJ5nPvAZtpQN78FGZPP9SzQJ83rOgQzPFlNIdXNbMl2iepmLjG5Of674SJ14N2tJ66cZaZpmnpKUwPyQqCSN7plvQwwZ1rbjpltIFx+bzOtOCnDLNeKVjvCAA8ZGMYRGX03u7K8A8jFB+29bbOlacZpCdFdtznLQfu7f5cLQ0xDb5iF1IL1AlnAXM8bhslyjwZsyePdc2p6kEolwV77DxrtAz8omvFcQFmwerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsRK1Q74hiK7MaCRZch1f4+qyyM7SfVCtHJX4+aYgS8=;
 b=oYeqCkCAoozFh+CjaEjq01hmLHQ8t6pH5GrdUpyMg9PWwGA/FVTP66RGCvoiPnwNhgR9CWRgY9RndBZopbGWO2wx53t6kBDaWsR+gm6i9uO3X7xmzx+rVSbr0+25/ScAvs4k3+9UCeNAAtqQRu+UCgRG02HKAT7ys8KduQ7+pEoLZkIdivxa/ncwmNtptagIFvsLQiV122iHB3i0iXH7RYnt/ZFLLfzpQAMUrOPkS8+F7m/vm9xYkGbzBB+0fQEs7YFM4TwgVP8HiV8xZ3oJ/+4CHiihhtbQ8f17jUZwPh64RScTSTcJNgON90SYZeLYBsdMAUHG88fF1u5IZ9Lg3g==
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 07:27:38 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::b6) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 07:27:37 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 19 Nov
 2021 07:27:36 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 19 Nov 2021 07:27:36 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 3/5] iommu/arm-smmu-v3: Pass cmdq pointer in
 arm_smmu_cmdq_issue_cmdlist()
Date: Thu, 18 Nov 2021 23:19:57 -0800
Message-ID: <20211119071959.16706-4-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119071959.16706-1-nicolinc@nvidia.com>
References: <20211119071959.16706-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5de930be-b995-436c-5edc-08d9ab2e0fcc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-Microsoft-Antispam-PRVS: <BL0PR12MB46759FEA6F65C1EF7A8F8794AB9C9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfP51KMxUm23Yz7qg4t8XDnDaWkwTSFm1vY7JQu3Nq4IcB7P3+mLuCGvM4/q+zNm5Ess3sWes+aPw2ctv5QoK1ProX6PZAa4N4LkrifgWYq3oj/xhUlHmuwHqrAeOrrAYhZ5md5X1IHOTX6CIFD4nynYtu338Lcj+mEwPZOKO44XbysLk/+ZUGfpnme1AtPP6ShcYU0O2EeIpoKBmUe14+8rXjRix/GRG4WDIxSRv+8A0/HYfiX6AWE/gW084Wt7jXhwkOmVP+UPmoUUC6XBAfi5v+wjthZDJs9GUqVwFCkJrgMWbZZqi7zbSobf3+ZPlbk7iotjicElkwrOoL83OFU6cXVMV7v/HScTb/o9e/pJULEL351sO3WBCJwKsPER2r7pPHgA1Yd1L8dqdbe0BhZPmzlqH6NQ75X4XmOwBS+6BY7jMeN61MhN6butpjIqyCIAcJ++coAPQApbnc4IbGKDZ/c3demZGIltLHrNvYpRMRiwmUGAM+dDACoIR+PmtGENp6oj4zon5A3derjiDsFZOmgmmEi44fS1qIyp2k9UM3uUlV/1SToF7oU83tKF+epb8EvaAkiFT/Nwekw5jUUb6sZE/cJrz18k6HSCX8ukIWuKyjYiAsdkoLZZtjif033CvEazF9hWdEoLntON3yzyc9rSjUwoikp0/oFI4gvpLJz4393ScdRO9P+HJmuJB7pNs1sC8e3MRolqrVPpuw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(54906003)(7636003)(7416002)(4326008)(8936002)(36906005)(70586007)(26005)(5660300002)(508600001)(316002)(356005)(82310400003)(8676002)(110136005)(70206006)(7696005)(426003)(2906002)(83380400001)(107886003)(36860700001)(1076003)(336012)(47076005)(86362001)(36756003)(2616005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 07:27:37.0503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de930be-b995-436c-5edc-08d9ab2e0fcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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

The driver currently calls arm_smmu_get_cmdq() helper internally in
different places, though they are all actually called from the same
source -- arm_smmu_cmdq_issue_cmdlist() function.

This patch changes this to pass the cmdq pointer to these functions
instead of calling arm_smmu_get_cmdq() every time.

This also helps CMDQV extension in NVIDIA Grace SoC, whose driver'd
maintain its own cmdq pointers and needs to redirect arm_smmu->cmdq
to that upon seeing a supported command by checking its opcode.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6be20e926f63..188865ec9a33 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -586,11 +586,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
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
@@ -621,11 +621,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
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
@@ -645,10 +645,10 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
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
 
@@ -695,12 +695,13 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
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
@@ -757,7 +758,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -833,7 +834,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
