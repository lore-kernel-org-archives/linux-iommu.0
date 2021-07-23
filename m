Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD9EC4338F
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 19:32:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE2D60EAF
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 19:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FE2D60EAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEF638385D;
	Fri, 23 Jul 2021 19:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_cRBr0ifjmA; Fri, 23 Jul 2021 19:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BA7DB834C7;
	Fri, 23 Jul 2021 19:32:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD2AC001F;
	Fri, 23 Jul 2021 19:32:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB76C001F
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 19:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F5FA4011A
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 19:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TBNqm49zpBfj for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 19:32:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B71B0400D4
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 19:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH/eHAUipegepkCVbT0ZMsJJ4TR1loWzHTOdhfy4p1/aGlj0yY96paMjNUJIbxzn0Kn287fXHF4Rtu7jg5Unzm6cKY6DK6/Fg2o64GqTeDxzDClkgaRJ5AmAl80StEbm+jBSBgFcVm2l7oj4080c6AP4bDAIw+d6IueDbt4KaYDfiGuPz/ITjF+sW5cYD83p8eJeSni4aMxcGV9v/qar0HTlh7QGMXWW9oBL/WDcrCSMcUunu9ShYL9btje1zYC6bRv6sv2cGTou+G6HR1nnGTuc3MiA/7xuqhh631rGOh9G37C0Wg++T5ESDBj5wPGyIMu4dkYGioNc/0baVHQGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD4m3q5CinF7gB4LBlWhoEjtqe4XNgEghSisQ6ryaD8=;
 b=IrPlot2sa5k88S+Tl2/O/pfyvM5jokhVtmIEFDgTmIQZGJNJ7jpiprDBRno/ZYibqvUdt7I5TW33s+yR3n5cgk8528ONN+yt+qE94Pg8W0IjEGdCJSn0Ro6HuKecZJOsecSukq+zEluEcW0v0Zh+VwX38l5zzEEMEcl1J+5yHJft13fDDWT+rum59wi9dKZFo20FrodIXRvUKpfUVvLI4O/UfrT3zMiOt1NysKYP16zKXWYlzXC59OIeLwVs9yVF//sUEK1xzWoGdCre2Rh3kb3S64YXXQkihtRPhxQfnjbAJEfQ/ldEt+Pk1YW9v6YstNA8K/Eq1z4rVvbyg1gokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD4m3q5CinF7gB4LBlWhoEjtqe4XNgEghSisQ6ryaD8=;
 b=HvR9PSWdhV9cu2U+uQF2jenz527BJhl1+2Nc/b1NhNz1f1z6MQ8tL4brf9Bm0raGnoNdVNM/4pLDu6MRz8hD9C1/FmCMT34B8sec/IhG8/07dJ9kKnwjsX2pFu6/PIpYr6y6I5RPGAydpNFXKX4ykC9Bz1RFLNLIrVTdQRl+dHytpWGmQYFqd+BCoFSEXTu085UroSmZwQ9TaKe3vsCj2cTCrhBUykNXWEQLxJ7Qs56DON0995qCF7rR9GT0DMRj9uXg2LkOr0wkPqeL/x9Wo+6QTUrMCAU7/PErOpqmc+m2QTvRtmZrHNr8DD2BWzaRCMXcWXRudBB+MJGAoKVxPg==
Received: from DM5PR17CA0058.namprd17.prod.outlook.com (2603:10b6:3:13f::20)
 by BYAPR12MB3254.namprd12.prod.outlook.com (2603:10b6:a03:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 23 Jul
 2021 19:32:25 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::f0) by DM5PR17CA0058.outlook.office365.com
 (2603:10b6:3:13f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Fri, 23 Jul 2021 19:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 19:32:25 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 19:32:24 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Jul 2021 12:32:24 -0700
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
Subject: [RFC][Patch v1 2/2] iommu/arm-smmu-v3: Add support for NVIDIA
 CMDQ-Virtualization hw
Date: Fri, 23 Jul 2021 12:31:40 -0700
Message-ID: <20210723193140.9690-3-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723193140.9690-1-nicolinc@nvidia.com>
References: <20210723193140.9690-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 532a7848-3f7e-4a39-5b97-08d94e109988
X-MS-TrafficTypeDiagnostic: BYAPR12MB3254:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3254EAE325DA4289792A421DABE59@BYAPR12MB3254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waJBIohn9/yMTf48ZyI9e4sTBT80SVRn5TsvQpA90KQbAtSwPHSPhdVjmswjbto+QCxjJmmnkK93oppf7hFQYXb3I7hAT8lVBGUUdG427/iSW2IVosJApKoYgJRmsJHQz0tXdkln6n4o9eRGg/ZBhATcRVjP8isj8vLZHnv9N15+HAKCeu4gpy3DMci0QVg59gFLIH+f+d7kA86zvazdWtKODmQBTxqrM1TPEcWTfm1iq5bwOz74GH9Bc7UGntI0CJZfwTJqGvW6du1dEcyZB2OzTlM2G4PXwbB1xKVc/l6uTNVteaO8O4rewr1xY8yuVQUqqPfurnxVRa2/IFuep7HRiNlVwsyhYb4JXNyYn3aNJtam06H9s4YwRJA7ie/69rrBdpqzQWFcTUGUeODTpQqOdcKRgg5H4I81HpLCc3q/9v6J09sPwbTB+jN3A91qOQ7B0k1ysPC/JlZwWg3Q/USJEyIBxqF0OCcGx/snrk+BhTDdLuxd5PDJOoXWtlNQG5k4J0LNXDPF5tX7ewwNjMhx6ENChAiLj/0MlMIf7rkKy7ERDPNWKYXkRkWxjVdVjmHbdwL0/QM79tqn4H/R2R1LHEMJUu5dYW4aMlHS6Yya25TSMZLwjbwf9gFJUuGwQwpxOmhjlg9CDbRydG58gYG+D9Nm8gCFXD0cY/kc0HoGhgSZV9S8MPEiwuSlnXmpdPCkKPpvBe+m6xz83JanRA==
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7636003)(47076005)(110136005)(82310400003)(4326008)(70586007)(2906002)(36860700001)(83380400001)(7696005)(356005)(26005)(186003)(336012)(6666004)(426003)(5660300002)(8936002)(7416002)(508600001)(36756003)(2616005)(8676002)(70206006)(30864003)(86362001)(1076003)(316002)(54906003)(36906005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 19:32:25.0800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 532a7848-3f7e-4a39-5b97-08d94e109988
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3254
Cc: jean-philippe@linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

From: Nate Watterson <nwatterson@nvidia.com>

NVIDIA's Grace SoC includes custom CMDQ-Virtualization (CMDQV)
hardware, which adds multiple VCMDQ interfaces to supplement
the architected SMMU_CMDQ in an effort to reduce contention.

To make use of these supplemental CMDQs in arm-smmu-v3 driver,
we borrow the "implementation infrastructure" design from the
arm-smmu driver, and add support for implementation defined
issue_cmdlist methods.

Signed-off-by: Nate Watterson <nwatterson@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 MAINTAINERS                                   |   2 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c  |   7 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  67 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  11 +
 .../iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c    | 425 ++++++++++++++++++
 6 files changed, 487 insertions(+), 27 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d69b2d4646be..e72e3459c9be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18240,8 +18240,10 @@ F:	drivers/i2c/busses/i2c-tegra.c
 TEGRA IOMMU DRIVERS
 M:	Thierry Reding <thierry.reding@gmail.com>
 R:	Krishna Reddy <vdumpa@nvidia.com>
+R:	Nicolin Chen <nicoleotsuka@gmail.com>
 L:	linux-tegra@vger.kernel.org
 S:	Supported
+F:	drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c
 F:	drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
 F:	drivers/iommu/tegra*
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 1f5838d3351b..0aa84c0a50ea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
-arm_smmu_v3-objs-y += arm-smmu-v3.o arm-smmu-v3-impl.o
+arm_smmu_v3-objs-y += arm-smmu-v3.o arm-smmu-v3-impl.o nvidia-smmu-v3.o
 arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
index 6947d28067a8..37d062e40eb5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
@@ -4,5 +4,12 @@
 
 struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu)
 {
+	/*
+	 * Nvidia implementation supports ACPI only, so calling its init()
+	 * unconditionally to walk through ACPI tables to probe the device.
+	 * It will keep the smmu pointer intact, if it fails.
+	 */
+	smmu = nvidia_smmu_v3_impl_init(smmu);
+
 	return smmu;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b2d23de2b207..439809e1acd4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -336,9 +336,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 }
 
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
-					 u32 prod)
+					 u32 prod, struct arm_smmu_cmdq *cmdq)
 {
-	struct arm_smmu_queue *q = &smmu->cmdq.q;
+	struct arm_smmu_queue *q = &cmdq->q;
 	struct arm_smmu_cmdq_ent ent = {
 		.opcode = CMDQ_OP_CMD_SYNC,
 	};
@@ -575,11 +575,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
 /* Wait for the command queue to become non-full */
 static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
-					     struct arm_smmu_ll_queue *llq)
+					     struct arm_smmu_ll_queue *llq,
+					     struct arm_smmu_cmdq *cmdq)
 {
 	unsigned long flags;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	int ret = 0;
 
 	/*
@@ -595,7 +595,7 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 
 	queue_poll_init(smmu, &qp);
 	do {
-		llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+		llq->val = READ_ONCE(cmdq->q.llq.val);
 		if (!queue_full(llq))
 			break;
 
@@ -610,11 +610,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
-					  struct arm_smmu_ll_queue *llq)
+					  struct arm_smmu_ll_queue *llq,
+					  struct arm_smmu_cmdq *cmdq)
 {
 	int ret = 0;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
 
 	queue_poll_init(smmu, &qp);
@@ -634,15 +634,15 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
  * Must be called with the cmdq lock held in some capacity.
  */
 static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
-					       struct arm_smmu_ll_queue *llq)
+					       struct arm_smmu_ll_queue *llq,
+					       struct arm_smmu_cmdq *cmdq)
 {
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	u32 prod = llq->prod;
 	int ret = 0;
 
 	queue_poll_init(smmu, &qp);
-	llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+	llq->val = READ_ONCE(cmdq->q.llq.val);
 	do {
 		if (queue_consumed(llq, prod))
 			break;
@@ -684,12 +684,13 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 }
 
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
-					 struct arm_smmu_ll_queue *llq)
+					 struct arm_smmu_ll_queue *llq,
+					 struct arm_smmu_cmdq *cmdq)
 {
 	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
-		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
+		return __arm_smmu_cmdq_poll_until_msi(smmu, llq, cmdq);
 
-	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
+	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq, cmdq);
 }
 
 static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
@@ -709,6 +710,14 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
 	}
 }
 
+static int arm_smmu_issue_cmdlist(struct arm_smmu_device *smmu, u64 *cmds, int n, bool sync)
+{
+	if (smmu->impl && smmu->impl->issue_cmdlist)
+		return smmu->impl->issue_cmdlist(smmu, cmds, n, sync);
+
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds, n, sync, &smmu->cmdq);
+}
+
 /*
  * This is the actual insertion function, and provides the following
  * ordering guarantees to callers:
@@ -725,14 +734,13 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  */
-static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				       u64 *cmds, int n, bool sync)
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu, u64 *cmds, int n, bool sync,
+				struct arm_smmu_cmdq *cmdq)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
 	}, head = llq;
@@ -746,7 +754,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq, cmdq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -772,7 +780,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 	if (sync) {
 		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod, cmdq);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
 		/*
@@ -822,7 +830,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
 		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq, cmdq);
 		if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
@@ -856,12 +864,12 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, false);
+	return arm_smmu_issue_cmdlist(smmu, cmd, 1, false);
 }
 
 static int arm_smmu_cmdq_issue_sync(struct arm_smmu_device *smmu)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, NULL, 0, true);
+	return arm_smmu_issue_cmdlist(smmu, NULL, 0, true);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -869,7 +877,7 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_ent *cmd)
 {
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		arm_smmu_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
 	}
 	arm_smmu_cmdq_build_cmd(&cmds->cmds[cmds->num * CMDQ_ENT_DWORDS], cmd);
@@ -879,7 +887,7 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+	return arm_smmu_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
 }
 
 static int arm_smmu_page_response(struct device *dev,
@@ -2899,10 +2907,9 @@ static void arm_smmu_cmdq_free_bitmap(void *data)
 	bitmap_free(bitmap);
 }
 
-static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
+static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu, struct arm_smmu_cmdq *cmdq)
 {
 	int ret = 0;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 	atomic_long_t *bitmap;
 
@@ -2932,7 +2939,7 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
-	ret = arm_smmu_cmdq_init(smmu);
+	ret = arm_smmu_cmdq_init(smmu, &smmu->cmdq);
 	if (ret)
 		return ret;
 
@@ -3416,6 +3423,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		return ret;
 	}
 
+	if (smmu->impl && smmu->impl->device_reset) {
+		ret = smmu->impl->device_reset(smmu);
+		if (ret) {
+			dev_err(smmu->dev, "failed at implementation specific device_reset\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4c60ba14221b..baec2d3a46f9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -647,6 +647,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 	u32				options;
 
+	const struct arm_smmu_impl	*impl;
+
 	struct arm_smmu_cmdq		cmdq;
 	struct arm_smmu_evtq		evtq;
 	struct arm_smmu_priq		priq;
@@ -807,7 +809,16 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu, u64 *cmds, int n, bool sync,
+				struct arm_smmu_cmdq *cmdq);
+
 /* Implementation details */
+struct arm_smmu_impl {
+	int (*device_reset)(struct arm_smmu_device *smmu);
+	int (*issue_cmdlist)(struct arm_smmu_device *smmu, u64 *cmds, int n, bool sync);
+};
+
 struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu);
+struct arm_smmu_device *nvidia_smmu_v3_impl_init(struct arm_smmu_device *smmu);
 
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c
new file mode 100644
index 000000000000..ceec2a24057f
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/nvidia-smmu-v3.c
@@ -0,0 +1,425 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define dev_fmt(fmt) "nvidia_smmu_cmdqv: " fmt
+
+#include <linux/acpi.h>
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+
+#include <acpi/acpixf.h>
+
+#include "arm-smmu-v3.h"
+
+#define NVIDIA_SMMU_CMDQV_HID		"NVDA0600"
+
+/* CMDQV global config regs */
+#define NVIDIA_CMDQV_CONFIG		0x0000
+#define  CMDQV_EN			BIT(0)
+
+#define NVIDIA_CMDQV_PARAM		0x0004
+#define  CMDQV_NUM_VINTF_LOG2		GENMASK(11, 8)
+#define  CMDQV_NUM_VCMDQ_LOG2		GENMASK(7, 4)
+
+#define NVIDIA_CMDQV_STATUS		0x0008
+#define  CMDQV_STATUS			GENMASK(2, 1)
+#define  CMDQV_ENABLED			BIT(0)
+
+#define NVIDIA_CMDQV_VINTF_ERR_MAP	0x000C
+#define NVIDIA_CMDQV_VINTF_INT_MASK	0x0014
+#define NVIDIA_CMDQV_VCMDQ_ERR_MAP	0x001C
+
+#define NVIDIA_CMDQV_CMDQ_ALLOC(q)	(0x0200 + 0x4*(q))
+#define  CMDQV_CMDQ_ALLOC_VINTF		GENMASK(20, 15)
+#define  CMDQV_CMDQ_ALLOC_LVCMDQ	GENMASK(7, 1)
+#define  CMDQV_CMDQ_ALLOCATED		BIT(0)
+
+/* VINTF config regs */
+#define NVIDIA_CMDQV_VINTF(v)		(0x1000 + 0x100*(v))
+
+#define NVIDIA_VINTF_CONFIG		0x0000
+#define  VINTF_HYP_OWN			BIT(17)
+#define  VINTF_VMID			GENMASK(16, 1)
+#define  VINTF_EN			BIT(0)
+
+#define NVIDIA_VINTF_STATUS		0x0004
+#define  VINTF_STATUS			GENMASK(3, 1)
+#define  VINTF_ENABLED			BIT(0)
+
+/* VCMDQ config regs */
+#define NVIDIA_CMDQV_VCMDQ(q)		(0x10000 + 0x80*(q))
+
+#define NVIDIA_VCMDQ_CONS		0x00000
+#define  VCMDQ_CONS_ERR			GENMASK(30, 24)
+
+#define NVIDIA_VCMDQ_PROD		0x00004
+
+#define NVIDIA_VCMDQ_CONFIG		0x00008
+#define  VCMDQ_EN			BIT(0)
+
+#define NVIDIA_VCMDQ_STATUS		0x0000C
+#define  VCMDQ_ENABLED			BIT(0)
+
+#define NVIDIA_VCMDQ_GERROR		0x00010
+#define NVIDIA_VCMDQ_GERRORN		0x00014
+
+#define NVIDIA_VCMDQ_BASE		0x10000
+#define  VCMDQ_ADDR			GENMASK(63, 5)
+#define  VCMDQ_LOG2SIZE			GENMASK(4, 0)
+
+struct nvidia_smmu_vintf {
+	u16			idx;
+	u32			cfg;
+	u32			status;
+
+	void __iomem		*base;
+	struct arm_smmu_cmdq	*vcmdqs;
+};
+
+struct nvidia_smmu {
+	struct arm_smmu_device	smmu;
+
+	struct device		*cmdqv_dev;
+	void __iomem		*cmdqv_base;
+	int			cmdqv_irq;
+
+	/* CMDQV Hardware Params */
+	u16			num_total_vintfs;
+	u16			num_total_vcmdqs;
+	u16			num_vcmdqs_per_vintf;
+
+	/* CMDQV_VINTF(0) reserved for host kernel use */
+	struct nvidia_smmu_vintf vintf0;
+};
+
+static irqreturn_t nvidia_smmu_cmdqv_isr(int irq, void *devid)
+{
+	struct nvidia_smmu *nsmmu = (struct nvidia_smmu *)devid;
+	struct nvidia_smmu_vintf *vintf0 = &nsmmu->vintf0;
+	u32 vintf_err_map[2];
+	u32 vcmdq_err_map[4];
+
+	vintf_err_map[0] = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_VINTF_ERR_MAP);
+	vintf_err_map[1] = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_VINTF_ERR_MAP + 0x4);
+
+	vcmdq_err_map[0] = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_VCMDQ_ERR_MAP);
+	vcmdq_err_map[1] = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_VCMDQ_ERR_MAP + 0x4);
+	vcmdq_err_map[2] = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_VCMDQ_ERR_MAP + 0x8);
+	vcmdq_err_map[3] = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_VCMDQ_ERR_MAP + 0xC);
+
+	dev_warn(nsmmu->cmdqv_dev,
+		 "Unexpected cmdqv error reported: vintf_map %08X %08X, vcmdq_map %08X %08X %08X %08X\n",
+		 vintf_err_map[0], vintf_err_map[1], vcmdq_err_map[0], vcmdq_err_map[1],
+		 vcmdq_err_map[2], vcmdq_err_map[3]);
+
+	/* If the error was reported by vintf0, avoid using any of its VCMDQs */
+	if (vintf_err_map[vintf0->idx / 32] & (1 << (vintf0->idx % 32))) {
+		vintf0->status = readl_relaxed(vintf0->base + NVIDIA_VINTF_STATUS);
+
+		dev_warn(nsmmu->cmdqv_dev, "error (0x%lX) reported by host vintf0 - disabling its vcmdqs\n",
+			 FIELD_GET(VINTF_STATUS, vintf0->status));
+	} else if (vintf_err_map[0] || vintf_err_map[1]) {
+		dev_err(nsmmu->cmdqv_dev, "cmdqv error interrupt triggered by unassigned vintf!\n");
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* Adapt struct arm_smmu_cmdq init sequences from arm-smmu-v3.c for VCMDQs */
+static int nvidia_smmu_init_one_arm_smmu_cmdq(struct nvidia_smmu *nsmmu,
+					      struct arm_smmu_cmdq *cmdq,
+					      void __iomem *vcmdq_base,
+					      u16 idx)
+{
+	struct arm_smmu_queue *q = &cmdq->q;
+	size_t qsz;
+
+	/* struct arm_smmu_cmdq config normally done in arm_smmu_device_hw_probe() */
+	q->llq.max_n_shift = ilog2(SZ_64K >> CMDQ_ENT_SZ_SHIFT);
+
+	/* struct arm_smmu_cmdq config normally done in arm_smmu_init_one_queue() */
+	qsz = (1 << q->llq.max_n_shift) << CMDQ_ENT_SZ_SHIFT;
+	q->base = dmam_alloc_coherent(nsmmu->cmdqv_dev, qsz, &q->base_dma, GFP_KERNEL);
+	if (!q->base) {
+		dev_err(nsmmu->cmdqv_dev, "failed to allocate 0x%zX bytes for VCMDQ%u\n",
+			qsz, idx);
+		return -ENOMEM;
+	}
+	dev_dbg(nsmmu->cmdqv_dev, "allocated %u entries for VCMDQ%u @ 0x%llX [%pad] ++ %zX",
+		1 << q->llq.max_n_shift, idx, (u64)q->base, &q->base_dma, qsz);
+
+	q->prod_reg = vcmdq_base + NVIDIA_VCMDQ_PROD;
+	q->cons_reg = vcmdq_base + NVIDIA_VCMDQ_CONS;
+	q->ent_dwords = CMDQ_ENT_DWORDS;
+
+	q->q_base  = q->base_dma & VCMDQ_ADDR;
+	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
+
+	q->llq.prod = q->llq.cons = 0;
+
+	/* struct arm_smmu_cmdq config normally done in arm_smmu_cmdq_init() */
+	atomic_set(&cmdq->owner_prod, 0);
+	atomic_set(&cmdq->lock, 0);
+
+	cmdq->valid_map = (atomic_long_t *)bitmap_zalloc(1 << q->llq.max_n_shift, GFP_KERNEL);
+	if (!cmdq->valid_map) {
+		dev_err(nsmmu->cmdqv_dev, "failed to allocate valid_map for VCMDQ%u\n", idx);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int nvidia_smmu_cmdqv_init(struct nvidia_smmu *nsmmu)
+{
+	struct nvidia_smmu_vintf *vintf0 = &nsmmu->vintf0;
+	u32 regval;
+	u16 idx;
+	int ret;
+
+	/* Setup vintf0 for host kernel */
+	vintf0->idx = 0;
+	vintf0->base = nsmmu->cmdqv_base + NVIDIA_CMDQV_VINTF(0);
+
+	regval = FIELD_PREP(VINTF_HYP_OWN, nsmmu->num_total_vintfs > 1);
+	writel_relaxed(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
+
+	regval |= FIELD_PREP(VINTF_EN, 1);
+	writel_relaxed(regval, vintf0->base + NVIDIA_VINTF_CONFIG);
+
+	vintf0->cfg = regval;
+
+	ret = readl_relaxed_poll_timeout(vintf0->base + NVIDIA_VINTF_STATUS,
+					 regval, regval == VINTF_ENABLED,
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+	vintf0->status = regval;
+	if (ret) {
+		dev_err(nsmmu->cmdqv_dev, "failed to enable VINTF[%u]: STATUS = 0x%08X\n",
+			vintf0->idx, regval);
+		return ret;
+	}
+
+	/* Allocate vcmdqs to vintf0 */
+	for (idx = 0; idx < nsmmu->num_vcmdqs_per_vintf; idx++) {
+		regval  = FIELD_PREP(CMDQV_CMDQ_ALLOC_VINTF, vintf0->idx);
+		regval |= FIELD_PREP(CMDQV_CMDQ_ALLOC_LVCMDQ, idx);
+		regval |= CMDQV_CMDQ_ALLOCATED;
+		writel_relaxed(regval, nsmmu->cmdqv_base + NVIDIA_CMDQV_CMDQ_ALLOC(idx));
+	}
+
+	/* Build an arm_smmu_cmdq for each vcmdq allocated to vintf0 */
+	vintf0->vcmdqs = devm_kcalloc(nsmmu->cmdqv_dev, nsmmu->num_vcmdqs_per_vintf,
+				      sizeof(*vintf0->vcmdqs), GFP_KERNEL);
+	if (!vintf0->vcmdqs)
+		return -ENOMEM;
+
+	for (idx = 0; idx < nsmmu->num_vcmdqs_per_vintf; idx++) {
+		void __iomem *vcmdq_base = nsmmu->cmdqv_base + NVIDIA_CMDQV_VCMDQ(idx);
+		struct arm_smmu_cmdq *cmdq = &vintf0->vcmdqs[idx];
+
+		/* Setup struct arm_smmu_cmdq data members */
+		nvidia_smmu_init_one_arm_smmu_cmdq(nsmmu, cmdq, vcmdq_base, idx);
+
+		/* Configure and enable the vcmdq */
+		writel_relaxed(0, vcmdq_base + NVIDIA_VCMDQ_PROD);
+		writel_relaxed(0, vcmdq_base + NVIDIA_VCMDQ_CONS);
+
+		writeq_relaxed(cmdq->q.q_base, vcmdq_base + NVIDIA_VCMDQ_BASE);
+
+		writel_relaxed(VCMDQ_EN, vcmdq_base + NVIDIA_VCMDQ_CONFIG);
+		ret = readl_poll_timeout(vcmdq_base + NVIDIA_VCMDQ_STATUS,
+					 regval, regval == VCMDQ_ENABLED,
+					 1, ARM_SMMU_POLL_TIMEOUT_US);
+		if (ret) {
+			u32 gerror = readl_relaxed(vcmdq_base + NVIDIA_VCMDQ_GERROR);
+			u32 gerrorn = readl_relaxed(vcmdq_base + NVIDIA_VCMDQ_GERRORN);
+			u32 cons = readl_relaxed(vcmdq_base + NVIDIA_VCMDQ_CONS);
+
+			dev_err(nsmmu->cmdqv_dev,
+				"failed to enable VCMDQ[%u]: GERROR=0x%X, GERRORN=0x%X, CONS=0x%X\n",
+				idx, gerror, gerrorn, cons);
+			return ret;
+		}
+
+		dev_info(nsmmu->cmdqv_dev, "VCMDQ%u allocated to VINTF%u as CMDQ%u\n",
+			 idx, vintf0->idx, idx);
+	}
+
+	return 0;
+}
+
+static int nvidia_smmu_probe(struct nvidia_smmu *nsmmu)
+{
+	struct platform_device *cmdqv_pdev = to_platform_device(nsmmu->cmdqv_dev);
+	struct resource *res;
+	u32 regval;
+
+	/* Base address */
+	res = platform_get_resource(cmdqv_pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	nsmmu->cmdqv_base = devm_ioremap_resource(nsmmu->cmdqv_dev, res);
+	if (IS_ERR(nsmmu->cmdqv_base))
+		return PTR_ERR(nsmmu->cmdqv_base);
+
+	/* Interrupt */
+	nsmmu->cmdqv_irq = platform_get_irq(cmdqv_pdev, 0);
+	if (nsmmu->cmdqv_irq < 0) {
+		dev_warn(nsmmu->cmdqv_dev, "no cmdqv interrupt - errors will not be reported\n");
+		nsmmu->cmdqv_irq = 0;
+	}
+
+	/* Probe the h/w */
+	regval = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_CONFIG);
+	if (!FIELD_GET(CMDQV_EN, regval)) {
+		dev_err(nsmmu->cmdqv_dev, "CMDQV h/w is disabled: CMDQV_CONFIG=0x%08X\n", regval);
+		return -ENODEV;
+	}
+
+	regval = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_STATUS);
+	if (!FIELD_GET(CMDQV_ENABLED, regval) || FIELD_GET(CMDQV_STATUS, regval)) {
+		dev_err(nsmmu->cmdqv_dev, "CMDQV h/w not ready: CMDQV_STATUS=0x%08X\n", regval);
+		return -ENODEV;
+	}
+
+	regval = readl_relaxed(nsmmu->cmdqv_base + NVIDIA_CMDQV_PARAM);
+	nsmmu->num_total_vintfs = 1 << FIELD_GET(CMDQV_NUM_VINTF_LOG2, regval);
+	nsmmu->num_total_vcmdqs = 1 << FIELD_GET(CMDQV_NUM_VCMDQ_LOG2, regval);
+	nsmmu->num_vcmdqs_per_vintf = nsmmu->num_total_vcmdqs / nsmmu->num_total_vintfs;
+
+	return 0;
+}
+
+static int nvidia_smmu_issue_cmdlist(struct arm_smmu_device *smmu, u64 *cmds, int n, bool sync)
+{
+	struct nvidia_smmu *nsmmu = (struct nvidia_smmu *)smmu;
+	struct nvidia_smmu_vintf *vintf0 = &nsmmu->vintf0;
+	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	u16 idx;
+
+	/* Make sure vintf0 is enabled and healthy */
+	if (vintf0->status != VINTF_ENABLED)
+		goto issue_cmdlist;
+
+	/* Check for illegal CMDs */
+	if (!FIELD_GET(VINTF_HYP_OWN, vintf0->cfg)) {
+		u64 opcode = (n) ? FIELD_GET(CMDQ_0_OP, cmds[0]) : CMDQ_OP_CMD_SYNC;
+
+		switch (opcode) {
+		case CMDQ_OP_TLBI_NH_ASID:
+		case CMDQ_OP_TLBI_NH_VA:
+		case CMDQ_OP_TLBI_S12_VMALL:
+		case CMDQ_OP_TLBI_S2_IPA:
+		case CMDQ_OP_ATC_INV:
+			break;
+		default:
+			goto issue_cmdlist;
+		}
+	}
+
+	/*
+	 * Select a vcmdq to use. Here we use a temporal solution to
+	 * balance out traffic on cmdq issuing: each cmdq has its own
+	 * lock, if all cpus issue cmdlist using the same cmdq, only
+	 * one CPU at a time can enter the process, while the others
+	 * will be spinning at the same lock.
+	 */
+	idx = smp_processor_id() % nsmmu->num_vcmdqs_per_vintf;
+	cmdq = &vintf0->vcmdqs[idx];
+
+issue_cmdlist:
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds, n, sync, cmdq);
+}
+
+static int nvidia_smmu_device_reset(struct arm_smmu_device *smmu)
+{
+	struct nvidia_smmu *nsmmu = (struct nvidia_smmu *)smmu;
+	int ret;
+
+	ret = nvidia_smmu_cmdqv_init(nsmmu);
+	if (ret)
+		return ret;
+
+	if (nsmmu->cmdqv_irq) {
+		ret = devm_request_irq(nsmmu->cmdqv_dev, nsmmu->cmdqv_irq, nvidia_smmu_cmdqv_isr,
+				       IRQF_SHARED, "nvidia-smmu-cmdqv", nsmmu);
+		if (ret) {
+			dev_err(nsmmu->cmdqv_dev, "failed to claim irq (%d): %d\n",
+				nsmmu->cmdqv_irq, ret);
+			return ret;
+		}
+	}
+
+	/* Disable FEAT_MSI and OPT_MSIPOLL since VCMDQs only support CMD_SYNC w/CS_NONE */
+	smmu->features &= ~ARM_SMMU_FEAT_MSI;
+	smmu->options &= ~ARM_SMMU_OPT_MSIPOLL;
+
+	return 0;
+}
+
+const struct arm_smmu_impl nvidia_smmu_impl = {
+	.device_reset = nvidia_smmu_device_reset,
+	.issue_cmdlist = nvidia_smmu_issue_cmdlist,
+};
+
+#ifdef CONFIG_ACPI
+struct nvidia_smmu *nvidia_smmu_create(struct arm_smmu_device *smmu)
+{
+	struct nvidia_smmu *nsmmu = NULL;
+	struct acpi_iort_node *node;
+	struct acpi_device *adev;
+	struct device *cmdqv_dev;
+	const char *match_uid;
+
+	if (acpi_disabled)
+		return NULL;
+
+	/* Look for a device in the DSDT whose _UID matches the SMMU's iort_node identifier */
+	node = *(struct acpi_iort_node **)dev_get_platdata(smmu->dev);
+	match_uid = kasprintf(GFP_KERNEL, "%u", node->identifier);
+	adev = acpi_dev_get_first_match_dev(NVIDIA_SMMU_CMDQV_HID, match_uid, -1);
+	kfree(match_uid);
+
+	if (!adev)
+		return NULL;
+
+	cmdqv_dev = bus_find_device_by_acpi_dev(&platform_bus_type, adev);
+	if (!cmdqv_dev)
+		return NULL;
+
+	dev_info(smmu->dev, "found companion CMDQV device, %s", dev_name(cmdqv_dev));
+
+	nsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*nsmmu), GFP_KERNEL);
+	if (!nsmmu)
+		return ERR_PTR(-ENOMEM);
+
+	nsmmu->cmdqv_dev = cmdqv_dev;
+
+	return nsmmu;
+}
+#else
+struct nvidia_smmu *nvidia_smmu_create(struct arm_smmu_device *smmu)
+{
+	return NULL;
+}
+#endif
+
+struct arm_smmu_device *nvidia_smmu_v3_impl_init(struct arm_smmu_device *smmu)
+{
+	struct nvidia_smmu *nsmmu;
+	int ret;
+
+	nsmmu = nvidia_smmu_create(smmu);
+	if (!nsmmu)
+		return smmu;
+
+	ret = nvidia_smmu_probe(nsmmu);
+	if (ret)
+		return ERR_PTR(ret);
+
+	nsmmu->smmu.impl = &nvidia_smmu_impl;
+
+	return &nsmmu->smmu;
+}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
