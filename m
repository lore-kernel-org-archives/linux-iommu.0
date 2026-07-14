Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8C36654F
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025745; cv=fail; b=opvi8xF/jQo0lq6COZ6My3JT20lq6CRI8ktmwXjf+UajVRVzO6Su+MAKhtDMAiwYZWYXNhy9IWGbSBTcnGH6rqov4io2qOYtaFtClaW/kLV/98o8iXfIMxklZTHEHoDUdas6U5hRy0GbgxSqcwktqZn5YiSts273L5W1LDxOaWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025745; c=relaxed/simple;
	bh=k5aH3ICaAWytql2QwkIHrmweb9UPUhz04ODfNyO3Z7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfmIMUzlvdAZaLq7XSAIy8JIaDjbLR5vX/y3SGpamGIPyTLhSOxvMdDySq1650mXoo+TlHlzFRfThYANZVf4srhk6CqoVBsRsHYi6+KLZWHGOmw6UPhu07/ccAigqCgzSxMBAeApZ8/OxcGlB4Dvb86EQ6Z4BGnSLvpwdZBve24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o62ptlmm; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o62ptlmm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANUmy86FV6eh0nyyF2U3SqOmU2j4LRI8M2mRL+pCibt0uMFPjD0HEeMNctu3HrMZcfrFnaPiOdY6qtCoPQYPPeLmFp2m3Ng6RCYDI3xc+kvP7EKAzHUwScaR1/8DKZ5/D76Ec5GZk1D9Q5M0+KNe/rv2JeeeAzeBMl6/I0BCbh9Dr4uwntGH3dO7KdqKCaG/EPEgWtoE8A/xDlruT+bsQBaCBszG/5OgDKkkjfuwwK9OnzIQ0ZZgqPHjjX34PE7Z/BhXj5AWkE3HwanK9HHCzZ+VodMigO+LHBtSHb2QpoQbEdt2VE3gNK7VoLiOqnMsfDAHZ024vkFKeE4ZigJoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1HjK7/VpxvpKPOyTKw+TQ15mT5aGjfcm/clObjEwDA=;
 b=jINdj6kGLUfpgUREXrAd/5IL3CjE63jSusAlsm/lMO742aYhUqkTRlqMnQw3oEiiWamnid4zFTGjpx1Fd+2tD0ZLX1lxTc7iFbg9E8eJuQMaeFi7rJEmfP8JJdLrXTY6JozpYK7NPQFjZ5Cp+X1vO1efJ7aj4xtslzP+G0JhBTf78aQWR7N4MU2Qe2Oc+HSDmMhEJNBEW9OXimImEisZwG6lSwNLdtKL7DOWd6wsNM3Dq7aAa0kRU0SEHuk/tZ6fZn4TdRm03uGdNFBlmDH9i1PKY9DviskfGYeWb6yoDaTDS+MyZou0fh5amZ2qu9w33rUBfM6HUeLrQXUtQWcLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1HjK7/VpxvpKPOyTKw+TQ15mT5aGjfcm/clObjEwDA=;
 b=o62ptlmm+JjcbCw/RIyZM9UGd0P4a7fRHwunu7Gs2AQC7Qxv/CLunAMbJChSx7zWYm1+/sLL6mw21jGBkHU4qx2Jc+cYAneAa9IpsNEztSC1E3T1wCagLgaF4WdOps9PRZoNE7QECEaGaV13XhJ+uL2f1pY6y2kTeBvDKS0dGtBsQgK4AT+oAjkirkOvBbhhfENgr4lC6AxZhUS1U/+zwi1ZJvsWTvsWhAhmxmS8+mrFGQj3K01qzyQPBwMTBRe/NDWLiSHajgV4Yr3zOVALauhBxSHGL2UTOi9HaYvx9xbsqGsdQCHAtSO3GxMZalFDsoZISuE5f9KiJ5g/Y57vpw==
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 10:42:17 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::12) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.8 via Frontend Transport; Tue, 14
 Jul 2026 10:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 10:42:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 03:42:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 03:42:04 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 14 Jul 2026 03:42:04 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v7 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
Date: Tue, 14 Jul 2026 10:42:00 +0000
Message-ID: <20260714104202.1664187-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714104202.1664187-1-amhetre@nvidia.com>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: ed933bb7-5e20-4c64-cbaa-08dee194935f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|7416014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	hJGAvOfJVeenfgWV9pNMxIWbc3HXFCbY5G72Su93gH1AWMzoVJe8nPp2ZLBb5mGGCB9SJYumGFIaGjrtK+37sYb/qzYnwS3jBmslPBz5nAdTh3FIEl3+6z7XGofA+3qUIlGaSbNeW5pGFsSxilOipDPTWFaV+Jaa0hdvlRAs+BwHnvdnnUPJkoDWCZh7Vz7YreOqtxqL6DuSPkqvldiLtVaFta556KK3zbBXNegd0fo44RcsUIvgRRgZ79t2OBZbwE++iywdIsUDfZyXuE0iYED5XAKl8lnz6bqJ8/TsGT1HGQ6VeMOKC/r/xJINSWdgtb/fAvgt+mVY/syyhfT6LNjZaQLpUtwZQs0IkoMuceRexhXsAtQ3dCJeLzrvKnTsy26y9+fSdiWM1j6mM/O49JU6bxGlJTjVNGzkEMv/sGwPK+jCc0vEXPTEbHD9dIm+yHijESElRww9cicU+bq7JLO8L0fG4tZfFY2wGMA0LfjFOMKONFlcUYdl5LbXLETHbETrLJPnLr5oZ3+LIu/WLVV3aKTpihfvrskT+jM2jl/IdWzRgFjD+5lp1gs8u4BJ/1SyJHTWOO/+IhhmvhFzu1DVFpabAUMUeo8eGvkCAFf+dTffMugpF2QSvr4TZaX71oAwT5z5m60qsm/3RzUDV4i7CMP6Lpv6Xt1be1BYp3yzlceGMaM2o3zYbLfvt0yxqtLNrBEuffRGZtwjKp8iBQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1d9PCTTCzqMhVaj/akUjg9YnRWXMkAuIUg2s0baTXgsB+srLEpZAY4kcKXADeAykxO9E5JzYwmi1xWCLVQgmKqRLJRhzy9/WVu1/tMuE2WFpKrBUbMZ4/UpTMWLfP95XrAHlcUmRWfZznsL5KuTqmXb11ad+EiwHNsKgFeCSV8aMg0lx3/ulkVEhSA5NTfP7GvE6S3npu3jmhWimFGMvnOoZVD31kvGe4t21GwkqKuePoKxA5Jay59FwyTzNkvCBCzOJzCm+qMjNdZY6Aa+Xf6Cy2Y28IVT9hF+Zi1ayYy12YR/fXxU/rAD2S6piyWhAkHiy8sYSfjrfOB2MxRTJFv0h+OqrSuI33sm3JwIJsuBVhnV6xknuV/y7ue1RUUujxv5PZTSqLDH+tLIvCeHSzeWIFivOEehHC1UFsDaIiz22TMD1DttDpLos/abqtnXC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:42:17.6870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed933bb7-5e20-4c64-cbaa-08dee194935f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079

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

