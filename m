Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B724C77B0
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 10:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715659; cv=fail; b=uIx/as7asYC7KswLiKO9uT2grmfbFjMszq3mMjKgqVFg6Nvw1sl5ZVAWmOqcC50djiweTxUcAXrA2KXRA4uMmRIc04E2UFO/iVntmktMOTcbCGrf6iCbbz7YxCUlQOlvhZrmSE1fcm6nVeiLFebjoocrL2ZYUovG5uMusJSoYok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715659; c=relaxed/simple;
	bh=I4SmvaHRP1oMJeTZ0MF+M9jFEL8X6XC0nzXyhPKHYZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDpiWO9AN1hBzi/u66fotQtpnrdNm6gPzwsU0uazih1IReLFsrxU24SmKYzg9k9SJBYroj05fidYowo2IaCgjqTMOa1UDtqWLx3P8vbmhZsN4dnwSZbtRCCNlKYv86NNpp28ktw91+1fQplN2dG6i80YoEoDiBJTvzTptyBateg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0Cvk8qm; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0Cvk8qm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVI6PB3Q1i/ZvgdyslOaL1mrnV7V036G+7+F/j279MIhfEm/iBLbnzcd4XBLH4gaf0ywdDGJGIbNX6ZKv9CoBoxJ0qmp9ZhCXPXvWY5iG6xN0MpJWh0qoO2eBNfIWz/wzSm5JGt/4qa89mv46+ajbafCAqz9hVvywDs2d4vB3D5cinizuqRRp6gVaTvrOjB08Grka7SQQPMQ/W0R0b5RO26HJSJ9eKOcD3EnqT8hmL2NR2BKLypmPMgvkTvw6ERQlhvJhcAJmhA4843Lg3oCclV16D1+9d0uKrSdXYIczhQf07sVS2tOiP6fKAQimNwTMjIcHefE8tyBMq+U2E+8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfpwYLjv5sCzPQbN+NParttoWz4IYorrAK1K8eyWAr4=;
 b=nz5+YveESIQFlK4aKGNOS5q0i2HDzAKFCK61od4+PvYkVdQTiZ2n6ojgacD3O4sH1T+DoSgtaUdqNFzduCnwjDvqf6T12rMqfTMwQAlramu/GGERuiKbeiqpIiViIwT+F1cadu5J944N7FoPnRbF7UfecwMmKo1sKKASGsoKvf/zhqEpm4EEgki081aVKCeT4K7lONtNmKek4/lbWuLJIXGeLIAtTLI1aNt7tf5o/QEbJilYhE2056uwUsAauoCgMiCP45dHqjL62/6bMbR7aBvPeSMcqYGtoS9CPV8DXt0rpOnPnyCvIKCA5MWupbo90/QTq2KX4JTEokW2H/52ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfpwYLjv5sCzPQbN+NParttoWz4IYorrAK1K8eyWAr4=;
 b=a0Cvk8qmOsbHu0tb/ZAlpLy2Qz1P3nXGnuayBaQjfcoNPnyKOoK9P8c+KUiSBLc204F/DJOp6CIIKCs/tEU+jybovd0C7s7gepocbyZD2x3bfEGC7GsAJbrnJK/ZS+469YtN/DJVSDvgbG5b9f6YX+kX2DRfVfDMzIzr24dkQqLRed5QT4tRtgcYSTd0FPAeZIS56x31itha2MdQlKfH6K+DDYr/FhUpVDhfq9rfMWyLGiSyZp+b4EVmwcYisbgrL8Zz6D9h3HiKjJkYxIf8EAE4FkOlg+DrEwQvEcG/ZDJogNi5PyDbmOC2a7ViS6k9bDufeLyq7W4+I+dxnBml6w==
Received: from CH0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:610:b1::26)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:20:49 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::85) by CH0PR13CA0021.outlook.office365.com
 (2603:10b6:610:b1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 10:20:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 03:20:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 03:20:35 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 22 Jul 2026 03:20:35 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Ashish
 Mhetre" <amhetre@nvidia.com>
Subject: [PATCH v8 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
Date: Wed, 22 Jul 2026 10:20:31 +0000
Message-ID: <20260722102033.1122277-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722102033.1122277-1-amhetre@nvidia.com>
References: <20260722102033.1122277-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a71eb1a-b47e-49c8-9630-08dee7dae6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|7416014|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gPVGtPBuCh245hkVsyFkq/wphB+yknKyEGKU+aEpEme89UKtHbMdSGss0IPKGgje1SbTZLuP2iETBl4ioVF9VMMuCV7dX0oSxQPIA16BFLrTBJFIv/waduTzFR7jxp0eHsGrqzSnyu3e6H7bAl6EVuH73mNoOBThreJ18PM5Sw4LFxus2XxRGtSZve/d9kXCpYYK7k7yggtkBQFFFQuL6d7XIgD2fBb75+1vN6k+hXOgjgqHaALCDJhj/rREC0WLH+0TfjxXsLWeCeM13rHH63THACn2l60GGmu2VvR/dRkzPS2wYySRp9Wz84fdpIBj+4zqjiQS9ZI+3OufHZGgl4BsVHw0b2v3atKP/QFN3pxSwLYYkUbRkJ8SVR2POT5gbQ6lHFqLZE5NLFeI9o4nUelnNb7c8Rl408AHRjl0OgCd6/yizxkgIWLDE0Ffbbr7X/drs+5tCJlnYbTDg53W/IcLRH9ReLPb7EgBPVY4zILSIX4aywGwzGUvI5Afulnd7iL7FuYM50/qa7YtoKfbWrkksinbka1RtQiwyxpo2JdxAbDD4ODSPtvuZrRBxm9AiOySTdt4xWA7pswYdF+ieWn3oY1kJyLHbY8HT9kIwYea0cZ7Dapr3lCEVdCCCrySeg8+xWinIRDOyne7Z1o3RWHfcG/7Iwbc2t1Wxjrp+FwUhoDqIJo5i6uUiZ7nHjlosPtqAbDpEfrMR6w9EY2wOQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RZ/El7VYyykibkgNwi08LxWQQnTau182jQrxFCDf0xTZOwfX+z1DwGxBe/t3O69BGdWmAbruTi+qmTBuw9jA3yr6oZ9R7zYNK3BDyFqa4CyY1AipXXk+iuPqrj+lxL16g2G4iGrtpS8FdOIGz01WUvY5TEBzHhnGq79vvTcZn8Ko8BqxWnmsTLHaP20qN8GIfM/c1L4nzZfUqbmaPR59fafv5YHU8kqqZzFmIWWlikZo7t+T3XeZUFUPC3HEuLDrszenlBF60X3HBMgZgurn6xU36JFY5yS4vhfPC2XNPY9TNvi4IVO/CQnxNHvRqWTTdBZmd+9EcaZ/sg/Vzt71eLIdjp9Uj5qp9gcERwApW+qmI0ynDzxbQX4zBrEPZlzccoSi93oW4i3Zr49n5tph0eKl59JVpz6En/XagZtkz8Ki7cUJdzZCt05/Re81p+vl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:20:49.3010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a71eb1a-b47e-49c8-9630-08dee7dae6d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324

From: Nicolin Chen <nicolinc@nvidia.com>

arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
flushing the current batch with a CMD_SYNC before appending the
new command:

  - The batch's pre-assigned cmdq does not support the new command.
  - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
    forces a SYNC at one entry before the batch is full.

Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
so that adding another force-sync condition becomes a one-line
addition. No functional change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 +++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 57b750ebcd3d..dd7475c50afc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -847,16 +847,27 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
 }
 
+static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
+					   struct arm_smmu_cmdq_batch *cmds,
+					   struct arm_smmu_cmd *cmd)
+{
+	/* The batch's pre-assigned cmdq doesn't support the new command */
+	if (!arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd))
+		return true;
+
+	/* Arm erratum 2812531 */
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return true;
+
+	return false;
+}
+
 static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 					  struct arm_smmu_cmdq_batch *cmds,
 					  struct arm_smmu_cmd *cmd)
 {
-	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
-			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
-	bool unsupported_cmd;
-
-	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
-	if (force_sync || unsupported_cmd) {
+	if (arm_smmu_cmdq_batch_force_sync(smmu, cmds, cmd)) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, true);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
-- 
2.50.1

