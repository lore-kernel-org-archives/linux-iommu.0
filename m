Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE288194C94
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722996749; cv=fail; b=QBui+K+4YpoZfewJW5N2hDczJ0unZHijytdsCrcFQ/PuWEY8q7foPUxkXTF/38GE3wM8YlyDBhT6K83bcXyg0VFxERvXQhyzSj1R/neLaloEHsby7qawgPN2Fb825Bz70YHN3WgJoq28BzjirY0hoC3GlzSNQduNnNxCOqg4kzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722996749; c=relaxed/simple;
	bh=56pj4qWImdgyu9ACzYuTpl1/p2q1AfXhbxaKbb6CRpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnirqR896pzUYnhiAc0cu7hwS/FSm9/+YdB10muxgnwbwzIMZebUZyguQ4YBS2veMlbC8mcAPnCaTnLZyO6Y66qCc1VJG3aZhUSU/C/rbdRQb3M0XbeFFT5PnS9qoVaoBMwsWogp6rdAbAI1XvLrYLKBDrN1nkl04k9SJYDw6pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HP1lSA8c; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HP1lSA8c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvx2IFQUhXttH9TZarvgjQmYs1BIrgMYfaior+yMiHxNVJ1rhpWIzSGzlTX+syBNw8BlhxE0/9PD2p9sO/ZSSYc/GN9izMoxJYaLlaP0DzSOgkkV380buvhjp4GlnKYp5J3e9LNmeW84/AqHe08SS7/wu6l1lffQgdpHi8GcaZJlgJ8TpHevgCsdbPc5xCEftOMaQKWXyK6SkGAeN2J8AkNN58vFTYKvIn1wjnbHIvVOnbz+moloX9Rv7D1wJYwviFPRkQixdXC02e1OipYVLFrSSxqV6HS9RgHoDZvWu61QI7BW/4dQ5jNc0B7NVsmyTBZtmLa6hc330eUu+F0GGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phgPaY+yO+XDIG18DAq7MBrwAMSq1PcYMMpWjeM4jiI=;
 b=WF8rqV5I3QHrlpCDahoJbVDQb4tDIfMONbfkWu0udizRjeDTkTZn2VYiAJKouU0MhvbuFOtBiGrGuIXK2ff7lsXZQbncRKYbc9p0t0kc8J95jKM9Tu6G/p226emd1VdMWJX36rK6H+WVmGayJhbPxpC3D38MUvBKNvEL9CHHRDaku1pQdZrhxwVT8jhet+l9sAwYzZtT0Ny/+ima06QGxH00iGqKR42J8tGtAXYCyRpGuWEDrsH91y2OxgSoYw+1QBovn3/jdJckrsC1LCSgTVRta3E7XaBe/3x20WF8265SPx2Wc2NILXklvFY8rhFRRIDuovKqbfnXevIHaSA1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phgPaY+yO+XDIG18DAq7MBrwAMSq1PcYMMpWjeM4jiI=;
 b=HP1lSA8c9zXX5+9+4xA9IQm6aCeQU69n64uFw9OmbuSYMBzEVxcTGcTVXb3yVXrJ0amjJ2PsDGqW7jtpMTQxx+qFF2JQkCiZudJdLHAB3wDRakvRk1t4qxblvHzz2aMpSoiB4OHMzlKa80C0lq6fVpV1ypPnt/H6xyA8hjUyTf/MN0eI7MHlXsTGyd/p8L3j87ACTpgwTd3zFFehK9iy7fKFa5vTCKWy9x8Jcc5VyoUMYHeE3xMNO30xSYuV1QjZha+uXNeBrHF/rHuBmnRxO2LRHeaB07TreB3SsPLRgPU2LMmukcsWfTZKSMrgfXe8WzkFzsKOTAvISiRE12+nmA==
Received: from PH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:510:5::10)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 02:12:23 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::6f) by PH0PR07CA0005.outlook.office365.com
 (2603:10b6:510:5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 02:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 02:12:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 19:12:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 19:12:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v11 6/9] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY
Date: Tue, 6 Aug 2024 19:11:51 -0700
Message-ID: <716ac3e9d2564bbc47390160286a9ce1a1d85704.1722993435.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722993435.git.nicolinc@nvidia.com>
References: <cover.1722993435.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e8a8bb-ec72-4e7e-7617-08dcb6865f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JHlJxQqZbGr4uVaLs4EdWIbR9nc6/T0XQI46J9VvbumSqo98xDKCNileH/pT?=
 =?us-ascii?Q?Pay/2LP3kOeWvHlUm0Xri+o5DskWhJDTOwv0JKiNFUV7/zltHfF0a0192I8n?=
 =?us-ascii?Q?K1XPUhpTHzYT0v/cZr1txHNuKdMrlcquJJ7/ua6jav5BKqHjI90eZafKZuLm?=
 =?us-ascii?Q?XZb9hIbxFfSlV6rho3PyAyjYTA0wyUI6lN/qEckGhecGYhSBK2c3la9deqM1?=
 =?us-ascii?Q?rYRZ7//fSjLokLPFbC4l9AmAhETlx18++6O4Pdss4RQtige/Hm6B16nySSxg?=
 =?us-ascii?Q?BP7v2Eb6YBZzlTexnFDJo/lNnRMBNHgW4p3q8kfv1f5xwxiSjOWOtpEVKl3f?=
 =?us-ascii?Q?fXwQwba+xL9+J1theTh3GFK0ozTg/VxvSkI8X5Xz5xuNo2tsf8tRxCkOo6dQ?=
 =?us-ascii?Q?w/pRqjapxgmtnFUEVPWJ/Aqqdpy1XhhLCoiLmRaFUCy1mpsyS0ktGBxtouvE?=
 =?us-ascii?Q?cS1BB371EpqcUFj7k2+xkzr3Q3jM8v1fQwJWuoUUcsoy8sSORXcmW4CjXGWa?=
 =?us-ascii?Q?Sa8eBrLZklu1grso+RFyD6VnXkVnChSS6BGMbgBLbv9lr5oBlakbgseSvKph?=
 =?us-ascii?Q?PoTLx3BTsbJk6oPJ8hdNHiXWw2kS/vLelV6EDyqReYC3XUc3ojOjpXoZSrld?=
 =?us-ascii?Q?CNNsCva9KQ/n+aQzeimmsHvjyeGyHD41+7MmZDL3zby79gS8ktieFLV0Ud7k?=
 =?us-ascii?Q?DHASgaKJ2NhlgbvNYuAOlagt5Bu0YVeE84U8400Jwb2QGo1WdGO+9CXQTl1H?=
 =?us-ascii?Q?IKKk7HSc5u2Q/tflECj6ABQ1OpxWVY+6KjG0vmGoDTXbzMyJhAf+KsCb+nnF?=
 =?us-ascii?Q?XRtqwrVvIyACKQnu+r36VgUUObti5qtyKiCKq5SRnuAi1vBuNJzEUpFKsALN?=
 =?us-ascii?Q?59UYtAjrpb55lz2e0l3Ru3KcEdncLwqRmRvsi8ItGmHlf5FeYZQn/E+3pejJ?=
 =?us-ascii?Q?w5U5RUF3ouAX0jnEXgSBOadsOCeNQTGq3iP+9PccUqegJ7Oyf7FvntQT8WEs?=
 =?us-ascii?Q?tj8boTVVq64Zpt3ippNVuqslSMzUlvGdG3V6JjWpiQvsvZiBK26at41nUndM?=
 =?us-ascii?Q?YlPunBaFtiKqlmJr8dq25uq/81BDSAibN27WtUhGC9W0CVgiyKk2192I/fp+?=
 =?us-ascii?Q?tl5z3vdsW1+0sPFRSxUJwHckwehfXSnasnmTBbSpirkr4OzFcAnJVVOJNcYG?=
 =?us-ascii?Q?YPH5eJehZqPy5/GMffoJMXNkQu96fn7XnSOee++aOMYKQLLQuBAOBMhr6wmg?=
 =?us-ascii?Q?tfe8FBVq8/UvvZ04iEmW9WGvm+Jqp+QfJgRw/SNEFFaK83fOdl2UhB5h8095?=
 =?us-ascii?Q?PL4RftzrcrTdGafROaPbjarm/snIkEpre3BDGrduCC+sa2nFAOb8lLXbCgZ/?=
 =?us-ascii?Q?2VhmE2HFbNiF78tOodFoQWNpXjr98p5LCwBWKqh37+iEa5zDG13CFkOVUZcr?=
 =?us-ascii?Q?oiQcmIYc5YZTA6iA/Kv+1+LllNsjv+VC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 02:12:22.2750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8a8bb-ec72-4e7e-7617-08dcb6865f84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a new SMMU option to accommodate that.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index df1149095860..e764236a9216 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -341,6 +341,15 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 	return &smmu->cmdq;
 }
 
+static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq)
+{
+	if (cmdq == &smmu->cmdq)
+		return false;
+
+	return smmu->options & ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY;
+}
+
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq, u32 prod)
 {
@@ -351,6 +360,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
+	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq)) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		return;
@@ -697,7 +711,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6c5dc2f10a33..71818f586036 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -658,10 +658,11 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 	u32				features;
 
-#define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-#define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
-#define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
-#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
+#define ARM_SMMU_OPT_SKIP_PREFETCH			(1 << 0)
+#define ARM_SMMU_OPT_PAGE0_REGS_ONLY			(1 << 1)
+#define ARM_SMMU_OPT_MSIPOLL				(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC			(1 << 3)
+#define ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY	(1 << 4)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.43.0

