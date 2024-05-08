Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4E17BB6
	for <iommu@lists.linux.dev>; Wed,  8 May 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715147834; cv=fail; b=EBHf8VBB/zNHJBDpn2J/Ba6O8CAvv581o3C298VYKEqHgsVxQ6Xjplteil8ma2TMoI9TlYKCJRn5c3Vf+qXkYdZb9Lse3u38MKJTJeLsAPr+NDgsdq5jDWn0DGrZgjmlg7XLi/yf1oRZCcM3jqbTWzTJs5YsbJeMzanxefJdsPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715147834; c=relaxed/simple;
	bh=TV8QN/ztLBOFxzOWYQBXTfOUMNRuS7Jr26W+GIVz/LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlA+snh2tcRzFAHw/ltnnDTrD4KxTGeYQssCchq9ZMFtosqTY8lGYEXfC5ReXrC26Jk7TTkYPo9xhGpY9p8HMCLz9PKWLArLDF8qJesJ+GHWqp7EFwz1ag8ONtLim8yOiQaSB/IizhOMgfalBNA81sA7Xz9tuumAzEIabxlnhQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LDZlqCmi; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDZlqCmi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkSzRb50T9l6h5WQzk2654GC8Wsx7lCHdat2FJI2cRt0yFCvASS8zulYnYraF8IB/Af7auTcmuC3h4naLUbP++msEvNaWXB6I2n/taUWaWWgVHfCK36f4f834N5KPOvpAMJXpF6elY1ecxee7cu/nyZ/R4jdAvoOMdQwZajpYdpJPIJVy62cHO5ZOrXqocPcfd90+eus8eDF6k2IujNtE/HR56VNYGWiRMghTdiUtt94UiQCo08+pyssbzLriMg9XB7GmhTh0Sg8/BEeeWewO9ENt9TF6/lLvTNrENkoc3jCs4nRWintNdkoNVeY9Ec0mVCfkwsBrEzzUZ+r/MZsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIjHcMmcdCGOqhevSP/rrAl0koaeFe5A1sBHXiqxyqI=;
 b=AAx1jZqDDTrkuhahGpRUhkdfRa5hF+VlcMn78RTVwZEXGUFTZwurluHjBZVMEGt3f1RB2tIS5W/3fIOTR94KeQmYNkYK82YR7ekf5TA6OH0KfnXJuRbWpEMB3riW/MTi0iAITbJho4DHRuBUgZwUa4zNeNGDsrDhG7DQnR1obgKOTAM2w4jvmrJPUWTwmd+WBreY6dJ9cIn4rWJcgId2qnNJCDD4k9/xwfg7urigw6313dkrYwDQdG6JY81tSu73xrTF6hjKDYZTNaHTt1QWWLMjrB4d1s+v86dTv4HOMVmn+rJhp/UpFwWrsSBrGSgbYi2KOAnoGKGED5mcRmMphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIjHcMmcdCGOqhevSP/rrAl0koaeFe5A1sBHXiqxyqI=;
 b=LDZlqCmiB4foG+hdBqmx/SPYgpFtqtEiLBaz3q7C8QnR+gHgGN2mIXdn1JgFl8fJYxLX9xySg8bA96HnvSTdgZfOIrnzdAX5hLOz9TtgPr7djmZKw2OJZfCM3s5E2BfdOzxk7l8ss02rNKT0EAhv60A0kiqYGjmkoYRD6EeaDZDdeQnHfWlm1nUJ2iw33gLvmUFTfb7lxhT+F7oft0N0G8Dis1c+bROGBu32F6qYLXFBtCfxbPGvPrh8+/zBn5xfdlMLfkVUv99sDeSg7oOXNCCblqk2yh8420cHCcry4OjRCTUjL+ZmRSEcmdBHx//E+ctlhdQofEOWAyy80e6Kcw==
Received: from SJ0PR05CA0184.namprd05.prod.outlook.com (2603:10b6:a03:330::9)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 05:57:10 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::15) by SJ0PR05CA0184.outlook.office365.com
 (2603:10b6:a03:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 05:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:57:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 7 May 2024
 22:57:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 May 2024 22:57:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 May 2024 22:57:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v7 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for CONFIG_TEGRA241_CMDQV
Date: Tue, 7 May 2024 22:56:52 -0700
Message-ID: <4d16c08b9d4244e1ff3836a586641ea6deb0c9cb.1715147377.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715147377.git.nicolinc@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a102a63-044f-4b28-a791-08dc6f23b38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+CGURHaGWjm9KUEHvsn7bxG6FD15On0z5uelwqXbOgkj+kNvx7AE6Rqa43h?=
 =?us-ascii?Q?wdEl0EyJpSRuoTctXqBiA4gbT1zNoSzuSo9qwZ1KjubGeigOo4JENsSB/c0E?=
 =?us-ascii?Q?W2/9eI/xQGAwgS716Z/RzWbGLIXOMsLydDgu2M3urpf7AdA6GN/qrfCktqpx?=
 =?us-ascii?Q?JyHbWB01j6YfQMf6j5r83ABhWWlhcUukie94wXYVM+A72URLbRALBRFjp5Ak?=
 =?us-ascii?Q?A/OQACaAk53LsMvPHsLxEDvtZTU2n88oJgIJgcW88LHzmFmmTC1urb3RLYXb?=
 =?us-ascii?Q?r9x1kZHCgALFLcPTtG0DYI9663cVfcat/lYVTD9Dibz0+PjrPw9QnUBmE90c?=
 =?us-ascii?Q?Rha3X4+EV6HEk4TH9yd6M/UwXJq4eaaZIIeUDjnU1c3KC6Dya2NSJoVaw3K7?=
 =?us-ascii?Q?ptOiFCmZCh1SDkV18YJdsqgWzls5XdrIhimvH3QQE6vHez4U9L39OPtPTqzE?=
 =?us-ascii?Q?Y71qZD5D2NptETjzi1hRoeSdLt52M1im7j3sfxc8V7ZxYCVRxYX5KuiUAMDT?=
 =?us-ascii?Q?nj0kKjsjz8o0WWLfDay4V8nmqjuW//RcvQ76U9GxNa7XsFHeXO+ex3rbNjKM?=
 =?us-ascii?Q?NB4At4fopKAA5AIYLDdWBZJWv1x0h6sSyCcLQoPOUhwmRoA/LHVZdQtHz3+v?=
 =?us-ascii?Q?Cdqq53MzZpsmaN55mJe/F39DjiBih09smaoNCpAxSMh99s3U0V6F4fm7Jtys?=
 =?us-ascii?Q?9Tw2Oi2jxNfyfjf/+Q2hFgoDUjuNj8E3hG947NY00HegUP9fGJrhD1ox2Mju?=
 =?us-ascii?Q?Eodo6W8jba+Fx8KInMqfAxDAyl2Uqt4LiEoWwasjYGHEMli7S8tXlIabkxXu?=
 =?us-ascii?Q?nosRR+vX5/W7+JDG34D8XXgaCwiq48LG1foUo/FaKXlTcFj4kEd51QViodGC?=
 =?us-ascii?Q?1JJf7032jgsU1EFoFgkhqyUezGharSbcJfiigtQQbotCe6F98/yZZEzyf1gQ?=
 =?us-ascii?Q?/8URq3DkTvWaXi94obdrlMLspWtr/pQBorcJnfOpcX6XOdyAUJn/XDYvGeVl?=
 =?us-ascii?Q?kXlE8wdn+Lkh1c6sG7GzgyuW3rI+Jjghtl0xaD/VSsERxlqlITUVrY0RHbf4?=
 =?us-ascii?Q?lla7lFChmb9AxLnSZphhBo0OsG2052r5Ja+/6FD6SIhj4jvkHrgavW0WOU2X?=
 =?us-ascii?Q?DeVP92sjChXxcBgea2+zO7PcmGdnHYGyvlTrs9ju+ylcGRLjpPKYT1IGsYm6?=
 =?us-ascii?Q?Oeejj+19qKSaIsoRxh0/ZuwMGU9w8uaGwQmRrV8JjMXjVUgmw6zhsNKe48f0?=
 =?us-ascii?Q?o3pilqC3Twhv3THosGg8zlTELPFLwm9QCqRPbqV/L/JxUdz/whSydvFNx1yz?=
 =?us-ascii?Q?4xCOh67bxxbtAL8eLxWoLfu90hju9BbQ5o4Jsn2khiaMygjQHx2PxhYFlzCg?=
 =?us-ascii?Q?XrWn1jG6PSzkIoe2mY1deVRni6sR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:57:10.6202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a102a63-044f-4b28-a791-08dc6f23b38a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a quirk flag to accommodate that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 569bca1a8a1f..2d8eb7c08a85 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		return;
@@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 180c0b1e0658..01227c0de290 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -543,6 +543,9 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
+	u32				quirks;
 };
 
 struct arm_smmu_queue_poll {
-- 
2.43.0

