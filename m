Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3B12C474
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228765; cv=fail; b=bKxp7ximEJ+tEPhBApgZvPkjE6C5ZGXKkiflTgJglKpKwT9O+4RG57khth3k04gH1AqbqsdqYABnvgILmFkcA3mXB7hyeJDjzsLhtoMsH5UTO9BECPm2ZQBC1Qdy7RMCdKxW0+jmC3CblD6tJcI770AeqWvpvIyp+8TLCELcXMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228765; c=relaxed/simple;
	bh=MJkK1UK5UInpMkE+zv7fsYuYjE1sswCWk5qKBcSWoEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjpE0dxHgSFPnXej+hv9Abu5o4JQZBWUEDFnJL5Q4Mrcy33LxGL2WBLNbpsb52G4tb328QsK4wmmK453o6c9yl9h+rZfxx0tEyIUVjYT7RKdnzJVD6B1N1Yof5s1EBp10hjouaDJfgW7BHOTnlTHHO8pbZeiBIY0uXPw648i8sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WZDPAoBc; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZDPAoBc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt6hThOk7Btu4/S1t4+4hMLzNLOmL4exD/3mjlQ2bUKUkdbCUJurmoFb5B8RV4huz2SIKO58JU0GXpTFW9bq3v+qfdAWsxAApxw29SveRvF1/z44g9qWu4wv/U1bQYovKn44D5PY2SJm9v0pP8pKTOg6xTG3MSNWYiITwsfYNiM9kiQFJ6Zh3fLQD8sAR9/ripCrZeJrBs+h/FvkoMtwL3gr4wBIqcCv5a6AgQ5x2PTlrj31MvKBCSSjWip1MUvXZgZlkPVvOjIFFE7QkHxT8yJN+NRLOoMWDNGbDcPYCQdUXDHYGoWthoFuDpvitkubjETNIKx8sz03DgxTJKz4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLyCLptQSPtxghgeXB9dWIE3s4hLgYmEWpn/L3pWCOY=;
 b=V0WdR/ro7eEbazj6y8FPxXcrVsvKSY0eHIkyEUOE75CvI9TZ5GHr416k7VEU5uvw6gxfXKfG748yljhUUlxY7qAMlBVXziW4KuV8xpJWhuzAQID2ggk87zkaOqNBxnShGK0lHOrZDNEQOcJ5T1RSpfymM9H/tKD4tgJmtSu8n3Zh1ElKG0rq6iC6Fc/8c5Sz8F59K7eEZAuBPJEbLQ49mZKKACucu2F7lEI/oBIozQQiKCoWuR6DJ7bPrgaaLJt2sGJOss9QZe+neigqDxOw76nIU2JKVvSF8hOwbfyyUYfB5ycYua98nHWbWo6F/2ujpBPkAY0E/9IW2fzaGyBcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLyCLptQSPtxghgeXB9dWIE3s4hLgYmEWpn/L3pWCOY=;
 b=WZDPAoBcHmFxYiOVxVbr9BashUO2cd6aDczj64f1eiWh/C5XDKR2YLw2P4CKpDPDBhLvTCbubpwcMIwSOm4UowIT5bmqVkP8Y0KTJlfcXjEW7Pcqpy/lfEet4/oiY38R33vCxPV3BviF+LhV2Ol03Dnq4+Zi/t49yK02h3d0X4IshQSdMlif0tod89g6Po0dBluhUo9aIaMrqeAe5YTWC0i7x9e1OIguV8JUqFmKU4R1lMvON1NgS8qEtcNSyYrLzbkDs03bWiNzdkHQVsxULpmzwmLmu6FmBwcn1AJGxsy6xPYh+M0lV6cO6CgWRWkUw+O13oKv0SvATGlraZHLVw==
Received: from SA1P222CA0098.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::8)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 12 Jun
 2024 21:45:57 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::35) by SA1P222CA0098.outlook.office365.com
 (2603:10b6:806:35e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 21:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:45:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 14:45:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 14:45:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 14:45:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v9 2/6] iommu/arm-smmu-v3: Issue a batch of commands to the same cmdq
Date: Wed, 12 Jun 2024 14:45:29 -0700
Message-ID: <21c0aec2aab04b7deed18e15d543ad2a3df0f11c.1718228494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718228494.git.nicolinc@nvidia.com>
References: <cover.1718228494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae95e13-a2dd-4f02-da86-08dc8b290928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TL0HE/c3Ik7o6c8hrzCUX4vjYSAexC0ytwtVdbqSdw46vaBuFoL+wWpxOu6A?=
 =?us-ascii?Q?5H9mIgZVWG6zTs3co90ZkyucLPAfL6Jl4XFrs6DsUsElaI3NdO3fIJzbhmpD?=
 =?us-ascii?Q?FPUPESFxCNTKO9XzLhhVj+gv1cCqNmEHaNNI0M0Zm8KTnmBPa9YZDOl0qT+5?=
 =?us-ascii?Q?bhJyiYcyYP6KWdeN9aqVqjohI5nxumP3Ubytux0QYUOQ5vrz8IBuRBswWSU9?=
 =?us-ascii?Q?f3QlAy4KhoUlU7mapj/k7kNvR2TIA4hhPq3V6LG1ix6Ga9yMpZ/8ikfwm8p5?=
 =?us-ascii?Q?O2BzdRh8+ethCSyt3muucKEjZstZLNh5Ew7doiv2ugLD6mOdLPEVpm8wA47U?=
 =?us-ascii?Q?N6NkyxcfUcTrUiTqbCP+g9+E8n7R37/twMYrpheuELhoLYfOcKtui0X4/XRk?=
 =?us-ascii?Q?74u70WLf2n4w+qubAmd/1bxJUV1xj3fH4m3Lx+wihx7+M8fPxTWaMFyEDG6d?=
 =?us-ascii?Q?aVAICV2ekCOmAelMI9Y4WDQShq8F3pLtKO9cwlMf+iGKh5L02PsipYy06D/O?=
 =?us-ascii?Q?DnCGDQntcmHYd4c3ggK07TibsMVk4Uhb2uS5FzQa28+vho+5g5QrMUZ4tcHS?=
 =?us-ascii?Q?yjGGJCXC6BJbT9IPtiyRVsskE9T4KivCxekfK3uJfCN7PauMBAE7pzlYkgMJ?=
 =?us-ascii?Q?m99AespCPA/iwIFHU6fpUk7gkXvy9oNXdQKcowwrUK6BhF/RynGUTDSmgV8z?=
 =?us-ascii?Q?ludBo/Hz9DMrJUu6Z9VvJm4prj7KTCkjbJ933dIlPlDhFXPje7YkBqzQcWFb?=
 =?us-ascii?Q?0pqM3YGXKMBhnwU4JYKkJON2GRZBfu5CybA2vMQ9cMD6bDchVRaA3H/X6p0x?=
 =?us-ascii?Q?tYmE9Og19UXxMd55NCvPCfsV6e/n63TJj2LVi3Q69syzG2H+4LwU8pc4nk72?=
 =?us-ascii?Q?OBkiNaUnE0ymU7K/jFycrZB4rB71P12TFVlqbh9iKasAxv/0JQRsg1HLExx8?=
 =?us-ascii?Q?oKTzh0t5JnZ0Z4m4dGlIrLuBm12JKAm6qYAVB43ZwFIL9ltaEAXGzB5UJ0Kz?=
 =?us-ascii?Q?shZjtDG2pzxbyJJ1ZsDpf02AstHU85Setwzl8lQr0r/NG9u7sUC4MkHTI+WE?=
 =?us-ascii?Q?rqE5YMxqktsIKCEM6Esj1XsySnvF1W2KQ6ciuDuqHEncqt8QJitVJ9RNN92R?=
 =?us-ascii?Q?is0E+AgOgj524vGb8MCXCFyqeBw4AgfYclIKPLUuBkDDcu95HTPgGfbEzmEg?=
 =?us-ascii?Q?Fb5HnGu31okSJEGVQqwxdYQVVIEPDNXZZisMk5ngG5O/aAR2/K+dmfTKusmr?=
 =?us-ascii?Q?IUpo5ymzSCsmieiRtykMcRFlZJwCfdsCc1IFxBOEXiMekrYZrwFcspfcmnPQ?=
 =?us-ascii?Q?atS8G/ksb8HRCwdgY77H0dtlv1z6rZdXIQYgm0A1LN8ec55z7BChZZ5soEPW?=
 =?us-ascii?Q?01pcr64vKw9iThPhTH+Mbqj7iz8FqTfBZHilSKZxlhfctos9pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:45:54.2422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae95e13-a2dd-4f02-da86-08dc8b290928
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

The driver calls in different places the arm_smmu_get_cmdq() helper, and
it's fine to do so since the helper always returns the single SMMU CMDQ.
However, with NVIDIA CMDQV extension or SMMU ECMDQ, there can be multiple
cmdqs in the system to select one from. And either case requires a batch
of commands to be issued to the same cmdq. Thus, a cmdq has to be decided
in the higher-level callers.

Add a cmdq pointer in arm_smmu_cmdq_batch structure, and decide the cmdq
when initializing the batch. Pass its pointer down to the bottom function.
Update __arm_smmu_cmdq_issue_cmd() accordingly for single command issuers.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 44 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 21878d4467da..dc8e9a48fe62 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -588,11 +588,11 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 
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
@@ -623,11 +623,11 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
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
@@ -647,10 +647,10 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
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
 
@@ -697,12 +697,13 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
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
@@ -739,13 +740,13 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
  *   CPU will appear before any of the commands from the other CPU.
  */
 static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				       struct arm_smmu_cmdq *cmdq,
 				       u64 *cmds, int n, bool sync)
 {
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
@@ -759,7 +760,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
 		}
@@ -835,7 +836,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
 	if (sync) {
 		llq.prod = queue_inc_prod_n(&llq, n);
-		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
 		if (ret) {
 			dev_err_ratelimited(smmu->dev,
 					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
@@ -870,7 +871,8 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 		return -EINVAL;
 	}
 
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmd, 1, sync);
+	return arm_smmu_cmdq_issue_cmdlist(
+		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -885,6 +887,13 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
 }
 
+static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmdq_batch *cmds)
+{
+	cmds->num = 0;
+	cmds->cmdq = arm_smmu_get_cmdq(smmu);
+}
+
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
@@ -893,12 +902,14 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					    cmds->num, true);
 		cmds->num = 0;
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
+		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					    cmds->num, false);
 		cmds->num = 0;
 	}
 
@@ -915,7 +926,8 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 				      struct arm_smmu_cmdq_batch *cmds)
 {
-	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
+	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
+					   cmds->num, true);
 }
 
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
@@ -1158,7 +1170,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu, &cmds);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2003,7 +2015,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 
 	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2043,7 +2055,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
@@ -2120,7 +2132,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	cmds.num = 0;
+	arm_smmu_cmdq_batch_init(smmu, &cmds);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 67b0ca0b1b79..8e4fbf4f50f3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -564,6 +564,7 @@ struct arm_smmu_cmdq {
 
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
+	struct arm_smmu_cmdq		*cmdq;
 	int				num;
 };
 
-- 
2.43.0

