Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5372BB04
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458282; cv=fail; b=A5h6ehrhtosNt1s9gZ6cqy+I/DJk4WGOiDSAfKqdp1nA7KljLTmrbBB13ECnC8M6Rc9zvUf+DjazCt2O8HXTKC20lFEGmfWYoznhFxVCvJgM9GKisefhkKBkK1vFxCKDqapZo7x1sK5hBhgoNuBnfwdopzIi8PfwoXTbEHmxOys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458282; c=relaxed/simple;
	bh=tcEeygpvS158io8kHbz3zhoBOzIGFN2BgcmEELp2QdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CySWsKRnhxTuk/4Ik806BtSYZQK1eoFjOOmZTCvPkpfIkLy4kwBihxe5+4fuSZNl4iM2UHD7ClpeO+3DOCJlroPCaITYt3iiWU8pdB9+JvgLcV+fpGrOQKtg5xN/DBt6TRLNlL6VIHQDRhfXQcgh1GPp5OmRMZxfypqigHs8ceA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dpB13oiv; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dpB13oiv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHTrRBFGjdz4itCHtau3D/ni1+vyryqmpaXixGedIo1z3LQ9adW1fogVgxkr7HxJRCRBXvITKKnJignplBsi7kPxAg3TPRQPvPoi91T+iBlAXzX/IGDGpgxLU5wdrYBwhXY3wGi6JJXTF7NFt417UvMHxsiYQ6sTg8dCOt+DWUK6qdRmHhlLKLxLuqa2hrrQlQgw3UIME/nAsyDhSL7pebqdsvY21gHZfT4uCE15km1aVfR6BS4JDCkg4zXxY96RAQj0238IVGU5YqfOffXhxF5KOLM6JfSWu1cqXYzdcSX57xUE/SIqGnQsJ+5MEW/UEDkiMxhPt3QLaUVEhjkmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgjAaKrc9hz0B54nKQ0zwOPPpQnmeqESwuEvGcVlrSg=;
 b=StkHEZblSpy8Who79vK7ZsTNGPR3apVacQQVahYqsgJBb6FZYa4KXVNqdUs3iWLGwP8lWnjFxZ24AzmWtEwppYGumDHw3GB1HKEB2EGBPr+SI4HCECfpCM5t/awKev3br1H5JlSgxl/mEEAER5w1Iwq5KBLyZAhVRFRRSmMY2n8baU3RaJV1BaTgpA+kyEyQSVprsGNmrrBOoDY3UmwdDB0ZvwZZWwkxlmy9RrlTJS3aob5P4jmnhz059xwpyzvHugrYA5RKM+2DMCd5GdY+Nfqt7Q5s6Wgs1ET9K1yyd+oGW+F4fGPeRUssXWrsSP6Ur2HGsEtE6M4971q2I9hwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgjAaKrc9hz0B54nKQ0zwOPPpQnmeqESwuEvGcVlrSg=;
 b=dpB13oivjQ45YG5OTddTmgXYKJ/aubcIFSNd9g1LqOnabOY5kDXAuGjdkAMRk+CSXVi0PhxP6M8RJX36+jjsFFH4H5TqMuN0xiihAWUpQ+I8U4gv9xUIoI88tgBG/qOSlsulw4mHKjKjj53n8gxZY9KHc791uUSvSuBT4WPMwCcUPinPCL3hX/s7mJNBQqkTYujrhEQv2guBd1b8cbPySUcOW29qAw31jgCH/tQi+Iv1Gc4Rc9nwnlMFU+QJX/rMQNNra3Z/XdGh7AVI3f8wLwpa+v1z1dhs/x4hEgMaDVt63xKUOmkTc/vYBVd+ixh3Rg4twZm0SQB6Yl6MTDM/6g==
Received: from CH2PR14CA0024.namprd14.prod.outlook.com (2603:10b6:610:60::34)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Sat, 24 Aug
 2024 00:11:15 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::ad) by CH2PR14CA0024.outlook.office365.com
 (2603:10b6:610:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:58 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:57 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 09/10] iommu/arm-smmu-v3: Start a new batch if new command is not supported
Date: Fri, 23 Aug 2024 17:10:43 -0700
Message-ID: <e6f45e0136ca9252554e800b9bbb623c577b0cc1.1724453781.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724453781.git.nicolinc@nvidia.com>
References: <cover.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1c0ccd-a61f-4fa0-9631-08dcc3d14539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zlXAlrw/ivcEr1GPJX+DNMyb8jYJaug8XBgnVx4AUkCU7jxfWBjzXP1G1uf7?=
 =?us-ascii?Q?i2+SqdGJS8uPzm62DrvK+zXts66eq2g2dVMIGZn1dha7Y+uO0bjRBeXR396R?=
 =?us-ascii?Q?Q+0bsYHsnfPBxTXXlz/yCdjAYzBo+fYiF4z0aa3WfOBr3/lTx32rsH4uG9j9?=
 =?us-ascii?Q?ZeIuq8lATeE1a54pxhPvrd45YKcIRH95sxt4tSDb+Log7Wnvc0GyRyl0wP1j?=
 =?us-ascii?Q?/yM4m0DGNUKJGf6649zVhkylGCFcSWsd3QlbXmS7nTbQEj9kNjIdensKzGE5?=
 =?us-ascii?Q?T2Dp9iZkk20wW8VNCVqTyiD0bmboHEJwxtKUIj3UtfAikG1PEO3Zylt1FOXP?=
 =?us-ascii?Q?apUwco/GaEivNdLbR4W4KA6gZ6vxfyLr2cW/lRjLOlNXrxqvfYjm3HpB6Z8E?=
 =?us-ascii?Q?iZ4WuTCc2Vp2wEID4wNgC7VwfWP/nThKUn5hQ1SSVYpHZh4uNgtbnrBva1yd?=
 =?us-ascii?Q?8UTDW8jvdDsnSUwSdhHteO2tESdrBvoFpHG5dn8ThHj4LThqWdfFPYbDAKwC?=
 =?us-ascii?Q?Y6WoV71VTiUkeYKW5NHoGRZ2mAzE/ukPhL/YRtn9iuYISe6zUpULD5E+2+mf?=
 =?us-ascii?Q?lL7lcWsF6Ll5vNEAmPoC9NZJq9hQfc98uYCgRKI/4+YSiQvuW1kGGlg/zxDv?=
 =?us-ascii?Q?Xuy6Ibs+ZqRCSMpmkgOzpgJWfkz6/CEZH6B156E/Km+1iM/s3DqgO3z3EuRM?=
 =?us-ascii?Q?dqGIdxJ7GiZJNmp1o7EZkpD13js+QH0sVSzsEAeTJW31ad6YTlhZsRaoNHk8?=
 =?us-ascii?Q?0Q8+cHACL21DSh7ZnkipmOyRuRDfncTGfGV3AACjOBlWbYO6alX879Kfde0U?=
 =?us-ascii?Q?Kr55IaDC8Fn64EMM7ib9CxtTyUuAuBf24DD6WUhShYlNTssAe08Guf00ghNm?=
 =?us-ascii?Q?KKmfi5YVE3ZWVCi/Z43BizNUcUJtlaSYcoaaKcwmYd4eSM9wXAKxNqIbM608?=
 =?us-ascii?Q?LXw14CACGGNGdu2nvBZrBOXbSo6jdpXB6nhaq2YtmFV1hfVrT5RXILH9Ukpg?=
 =?us-ascii?Q?xXTSShE2zhkDNtkStnPXWh4CwjgIdKdFmhC4Uk7GGSkkdBuOsZxi1P8X/oEC?=
 =?us-ascii?Q?0daImxGXCkEHz9wUXI25SZmIgvcH1sIW6aMVjZKC+eppq+zqgw/hRFQJ+Zaf?=
 =?us-ascii?Q?i+OvhvHRgTtS/ML21O1uFAFqpYx3GnSYxf4wnMeuO/99bEeQv3Fax/MtA8H2?=
 =?us-ascii?Q?l2D6OEQssEx9lSkUjZ+4UsIMO99vtq5O4HuIr2WY/T/xonorkG6POheXivCQ?=
 =?us-ascii?Q?iGmy/BKz3U+chOl6F9VkGdQKl3f+CUIs1tpeICkVnnAtp1T63vfR2kS30Y9R?=
 =?us-ascii?Q?jt8YIfRZPEKkZOfbKaFwJPiG87My1Hl63I3Uth0CZ2T5HMrBCppt3Qk19kX9?=
 =?us-ascii?Q?GQ++LSU62kHaEjGgVjq06ZNc7jEKTtHM7QLHIdqdmx4pUQaX7jB29VwXvlb4?=
 =?us-ascii?Q?DnF9a2HGBHlEZ9dZnlnfC6b2vGMLogRO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:15.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1c0ccd-a61f-4fa0-9631-08dcc3d14539
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227

The VCMDQ in the tegra241-cmdqv driver has a guest mode that supports only
a few invalidation commands. A batch is initialized with a cmdq, so it has
to confirm whether a new command is supported or not.

Add a supports_cmd function pointer to the cmdq structure, where the vcmdq
driver should hook a command scan function. Add an inline helper too so it
can be used by both sides.

If a new command is not supported, simply issue the existing batch and re-
init it as a new batch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fb7a1d7fcdd6..40dc5b9afa00 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -923,10 +923,12 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
 {
+	bool unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
+	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
+			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
 	int index;
 
-	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
-	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
+	if (force_sync || unsupported_cmd) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, true);
 		arm_smmu_cmdq_batch_init(smmu, cmds);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d820da90a09a..d4e5a22408e3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -568,8 +568,15 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	bool				(*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
 };
 
+static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
+					      struct arm_smmu_cmdq_ent *ent)
+{
+	return cmdq->supports_cmd ? cmdq->supports_cmd(ent) : true;
+}
+
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_cmdq		*cmdq;
-- 
2.43.0

