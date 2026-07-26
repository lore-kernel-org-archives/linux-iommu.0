Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2E1A8F7B
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053966; cv=fail; b=lln8y/D9DWDPioxNQZKHrwbBFDkgKl0VPn3uLblOJsshjI8bytID/KbCSYAoF0i9l4a9c9A6DjY7n0urp4eX+1XjWxLcR4APPYc1dz4OrEa45jHaZO93AR3kVGUIJxjjCQ28Qck7dGfbqcuRIw23Kzf9HgkFNe3IfegCz+PSSIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053966; c=relaxed/simple;
	bh=GhI6jG5jivDUBGG3tXzKr5Qi0uxnLmGcA2WWmS9Lne4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nL35+b4SjBlNRAhk5PQ64bSeuO4tzMYWeUfc2PCLU+adNFTapYi2CNPqw083PIkp4mB2QV0vZZf2gK8XxamdfdBAbzw3eK7rms514uiki5mf8WjuNl2b53ELlAXafCfI2WXVp6csOwahTBAoCQrU8K4WuDha42XaH0S18v2fEvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SVcVRSzw; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SVcVRSzw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp4jdvycEafEgv8Ks6DF7CySjWnJse521g7Jur0BTkumh2dAAcrslZZkGmJdgPkxWAVikaGMWZpbK7HO5SGNZ20WaCBpBX6Fr+gz9ERmxETsY7pdAIcLGCfNUzjF3kB0D1VCH5UMVQenXOehLKqP41L0kox8tF7heXtbOZddo/6QN1corZMOa8OylOaOnvJVay2Atmb9wAS5EFcbfS0i5HxDxSRR7jPoVT+yPR/tjeoSuaNu0ukB0cEzuIDEuKWDcYNFv51ffqAxUqtVoX7//qgLamxkQbKDJlrzLKp5zQdEXJlqVbRJfq/w3ZyCsNQBjkJgu9VvXx+ygNFttcMriA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKYC+2huWNxY7ZuAGXvWz2w711ECz0ZzF6pzzKlWutM=;
 b=oKPuhmqq+HJrrmeAw/QOSs97+Rwp5YN4z+TncQCky1cWa+MNQMZfiBxgmwP/OWgT/FotpYR62tZPzetWEuzDKwfSOUtxx+/4+QZeiAL8z8DjIjFrxqkPfz+7ufv6i3JR81fkspaTO8PpS2ppbVyayCsvML5FG/4naYDoGAwU/Nm7BmIiQpVG4es8ieCx4pYvZlTCizYe7K74Tk9eStURoccggq2JR/w8EFe41ereokwgHDO3VBvqmE29xbYPq0W0Liw5+obVJmoPebbdzThlZ6nt6r7fcGT3N0mMn1aKijFauKSIzla94zgNvTsLW0wCAem2kIls9ShPGADbuxS16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKYC+2huWNxY7ZuAGXvWz2w711ECz0ZzF6pzzKlWutM=;
 b=SVcVRSzweCtIcrf1kZIvY7+e3RUcD6PsCav2soahJbmhcSOxztDJzt/oAVTmA1EcNzezCOjUP5Bq1qr9TtIOEbKq7V3tWP+aJM2x08Ri3Lnd+JEBCxRDW3qnKYvUwGa1lVvRyZbcf5qgKoRH83U+VoZldJnz1cm8BA80bj5P4Ad3xF9LsKVGJckFdPMzm14eDYVb6px4NpspVWWBpP2wfc0H0B6pDTmc0mDoPKmI8lJAIbZvZBygfLAHiw3LFVPDND8v/7iSblsxJa4eal7EFdwo1uypcqyH++FcGLt6Q0Mmxrwom4ojwmu1vX1sqlHoMW0U6ujGzY8kbfuujXXAMQ==
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 08:19:16 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::63) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Sun,
 26 Jul 2026 08:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Sun, 26 Jul 2026 08:19:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Jul
 2026 01:19:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Jul 2026 01:19:07 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 26 Jul 2026 01:19:06 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Ashish
 Mhetre" <amhetre@nvidia.com>
Subject: [PATCH v9 1/4] iommu/arm-smmu-v3: Factor out CMDQ batch force-sync conditions
Date: Sun, 26 Jul 2026 08:19:01 +0000
Message-ID: <20260726081904.1408859-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726081904.1408859-1-amhetre@nvidia.com>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc86788-5703-4e85-d37d-08deeaee94f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	x4wEWgXERo2MeIlz8nEw+NkehslpoIEJS9cVLFWpTP+xqTwLdbV2QHwqRu8kArTvTlPhHpL3Vgt6ZHVQG6SN8ejDOrcsjYoy3eozYpp8yeFeL82//xu1xToHaJxHVNTGQ/i/Ajb905CDdZlfY6VMjSSuCM1kUdA4QaD9K3zHhZE7BwTKTBM85kad5cpuyDRWobkkOxShxYr79uFvKGOUWs1WizRk0JYnv35aSUI7H7lNzSQmknohFMKXZkjMPVtxTqR7e50pYQ1BV0nm5sNZPywm1JcI05Ai1mtLSLHNR8vUYSIgLGfWWlMxyEQx+yd9rN+WCOBB07MKBhd1dzIK9XHzn0y/Zb3Iru2ZfX5Z0i7Dyrefr1mfU2mE/CK18SjVZm+/9ybZqLAHPcqfDzm7Cv6SPRlWLL3bxI6bs0J12uLJsR/tJU3AzbO791sYtvncUS8HP7KiSxi5DL3oH9AvLPrctcM5jPn2nocm3/SS/TiKxqJ3RIv3L6wlJ4MeuRkQR30v6LIdPVt309W7e7yfQMn0QhbFF6PBwfkF0onpcTMzEPCvNj3vV+B6MI3y0a510TzLked63Nq16KOehtE/M3C2HBxS8KdeWKmpN+0MHa+hULbfIjixsRrj0ZNJzje7DyIfsYa3TRnEoSy2f/ZobAgr7L7ZENreDp+zyXdk7Iiw0TRXDQFbZ9DebaBa6SMmkf0VX+hVrKhizBCwHtbqsA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AxtlEgLK2J0UimXVXsFCkiWIkC6hagWTVXS3NoEsRXAmwPDHHEkMMOQH0eqDMeQuoMtD6Jz+fVu/9CW/fpQmiaqXqNRhVnUaPyIqq3u1oUiD6n0lWMDdNpm5N0dZG19hMIoBXM+ofPPwajH1UzyQz3hUB0PAPJnO2Qo+qkliHbBA5551VdaEiRiOkuN/YipVe4eyvOnOiiZ1wCEUysqeAoEeMwdb52YEb7GLQFrAuDay3XFwySDehbxMdnU73DlSnX/NQ7VA2Vx9wQoxTsiLw8/OCMVpnaeDNuKvqTds3YJisfwkYsu78VniafjrEpJ6isgUTHNj+ZDgHdy7nJR/K9R74nNadmK2ghNVfWk/qQysdgEFAk4GLxBClUPjboD+TWkJktLKRJWW6N3PT53ckJ9l9hl0fr6un9T+F7OSJoSuuHBJd8acV/U3nmAFXsVY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 08:19:15.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc86788-5703-4e85-d37d-08deeaee94f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

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
index f71642428df3..f278c962a7a9 100644
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

