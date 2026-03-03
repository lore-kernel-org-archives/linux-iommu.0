Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32B3B3BEC
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 20:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568835; cv=fail; b=Fskov51bzTeKM5SgWqToL0hePC+WgrbVyENuugtohd0YGpR49fPVoQB5kcrfQhiTAIlrmjCE555Mc+fQjMm/HNkaWSyMSd7PQlBXzTF41PqjeXgVPbF+1EUVFhaEBlkB+3/A5o1dUEDEHfAEduwuHM7G5I8WJ/r+DbR+57Bs6/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568835; c=relaxed/simple;
	bh=qj4Iqrsir2WmiaHK4/EiSOkBlY4eDrKZ0MgUDYAfVOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHTp2w4AJOn+bRvU/TxYkfEvicPmEM0Hp2c1fA08dFDu1GiXBvkJBx8f0/IYBwhp1hNaEzN7JQo3RXKV6EI8XoSJ71qWYQA4DFYQbMH+3JpBjtybeQZx818YnVMPzlc84+Suie0m1Wk6gJ95OchQ3DxENFuKUCRMiOTKaJxMJ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJ1TbDGZ; arc=fail smtp.client-ip=40.107.209.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJ1TbDGZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4KrJhtoaQNviUksBZpAvFerlaXCuR7TK58gcYGpnKXWYy2CnxM/hn9uimSbS1CXKU/CdQ9RqwuClqGMvNjQ5ieQDxitdpmH1xkZqTSxpxntRoitT3i4pdKxLSJT5vybqR50AFvfwOz5jCYVR/MRlGTo2sxHK7UFMZB7aY7yA/4UJlmgERFOXc2ly8ZY4HF3TuZVD0B8Iazyq1PRQX5ELJeCDtVPLVOAklq7L2w74Fbe2zcEJwKZDzVVR2XoQaTljdX/wv7t+F3dZe9zIB5N5h9e8TzcYzObNFCsffBAFMGTat4fTEKuKi/W5NAg/QM1vs54Ut4nem1l5CzZXsc6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2lIhtbKvApOBKE2LwEEGIAsABSutCr+bRcpteD+VoA=;
 b=fWMK8Pj8CI/bVrZec8xQVrhY3QTrLipd545LPZOtnJzoWwaQCNrtDtEieVMm2LhM83ykMxIdRWlZsK2TimvlGXXQB0bHvAyIC0H34cAQtWhZGZ559YAgZdhklfeU2vaku/Uyl8CtttKvCcSkGwQsMGcOMfxsX3qGLDHWpiJT6UpmhLvZhd0h53xkQcYvPgdNI7cDH2nHf8fIjln0JTIR84U02XUVgfhXLtndBDhV8tWxq1JQ4m7G629woIw3ZClgctDZNFJ4xn+SoNVvUEDFCCQIlWkUMSsFRutIG4Ey8ZmpNQn/E1YEPJNQ3169d2i7Wz+AGcPgKYdrJdAbIzCwsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2lIhtbKvApOBKE2LwEEGIAsABSutCr+bRcpteD+VoA=;
 b=IJ1TbDGZ47Wcw7usttWCnuofFO55el6RRF/GHuhm0w6kk0BZZ6ydPRm5mCt49526z2P4eeWkk4yzAnXPsk03Co282aDTKPxmruhVa6tVGV79+6B4kre8w+mHrvibpiuqfMEALSHh8EqQKbsANOKcHhp5atKasA08JmK/yHxoQnPMIpPQ/eGmu0hwhty5FewP4FscfS9RLBYKu/qVZX6dXi6WJaOuJJxGc5JSQJdC6va/lcDDc5yyPnj8nTH6SxD6TMo8GXIroA70dLcaq8mQzJZE92bUG2zNQmvM+xW20rf2zsNNxBDnNCwdO3D4wThyqDe/9POzc6c5NF61osiS7A==
Received: from BL1PR13CA0181.namprd13.prod.outlook.com (2603:10b6:208:2be::6)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 20:13:44 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::50) by BL1PR13CA0181.outlook.office365.com
 (2603:10b6:208:2be::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 20:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 20:13:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 12:13:23 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 12:13:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 12:13:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <mmarrid@nvidia.com>,
	<kees@kernel.org>, <Alexander.Grest@microsoft.com>,
	<baolu.lu@linux.intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFTv1 2/3] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event
Date: Tue, 3 Mar 2026 12:13:06 -0800
Message-ID: <306eaea18559e090d6e5d65df673b1b245a84cdd.1772568590.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772568590.git.nicolinc@nvidia.com>
References: <cover.1772568590.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: a92ab65f-0230-4a06-df0b-08de79615eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	iiHjXl2EEX2rZE+ol8I/UZYYGf1mfXbnfAUAls16h6wRgpSivO9nv63YAeezcHJVLKDTjZiOtJ43D3SIbdQkr7VevByz596lq1oWeiyHKO44fWA0YOgvTK22DulP/hsYkl4XP+sBMmHSOzWdqrrD93+9zKJrPLp8mWFauM/92UhTACRokejnPb0wtMXKahcHZY0nG4zs4AyY/exZAm+FJx/7GQjHpQ3LTIln6q8xqG3PvHY/YEGu0xO3Qt7VVh+tl7W7i9+bRqDExL9TsNlHFmYGqw188f/SW3yaRkQAUuFe/kOd4ZQ0C+2o7VbIEPWAzFQxTc5cKloK/0bmLB205TfR528rUO2/ldNn8kfJg6ThEeKC/OJfxmriZLb6rlx9bX2isoAibUEKzWlbXM478JVRs1dTkVcWtQj/7SSSl47ndyx3CkmPB5hyfZiBiYhlwegr+Cqz0GXvPRKa9S8i+Ia6R8EVIVtzoY0K0SrgE5uz1jjfFCDEKezct10dGZjVOfXxS20R7T5dVSa8Pd0HaiEtmR1au+uqJfbm6AU1a4UVmH3wa3+KsnAykhbW2QgZKFCAubdp95oLVJk5PdQe/yy8YEjOUYXXNDC4l5A6lg1KH4wTJj3lGNyLls5MQJ/Gja+tu+t0hq46C9ty0PdGjwXHM7P7/Ds6HpALCdusb6m86IusojI3rZ5GzxnDteKVr4DE1KHopRoPxGyZrXbptSH9YZrun2ClJLfIwMmmLhPaAoTwQhupuxZZVM57XOMcRrkkuEdmdtRspfMYzaeP3hZAXZlf3ShGGXC4k/MWCLLlpPnLmAuJyOxYg/iscY44X3+ey88DKSspVvF5DTuyGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/SfAPVfOOTRBActiaA7ydbhMAYrsVOd5WwEX+pBX/B+c/N2paQjkzc5vw1fvcYvy9+iJQUnZarxU61P3TZoVsDS/eOcuUDuloku+vg++/ilpiXRK8Vh0um+dGFEyVtt4TypGWjzkT6QFKZGakvZCrqBQeubhH03gkA79G2nMf6MIPsyni4i4NoL07L9VTUKiFj2XD/SrMf8KEuRgQnykJyXZGZd/xwLXQfMbbuAHTU5JZBvHBCwcQs2MiQeHNeNDuH0Btd4sfI16mTlEB2mGg+tqW0Ya/22QIpzm+NfQz4sXf5byaiYjP1uby7LbkIBeXiWeeipDQMSgHN+SuhEzzLrBuUSs3KDhp6MCJjCwkrCxmIbhRS8925zK02rqwocaMOnEfBxtoWfbIZ1Wbi7scngTMYtzn9i5yFxYlWKc6/FCLLlaayl6d3FIc2F1XKi9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 20:13:43.8454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a92ab65f-0230-4a06-df0b-08de79615eac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

From: Malak Marrid <mmarrid@nvidia.com>

To support IOMMU_FAULT_PAGE_REQ, the arm_smmu_page_response() should issue
a corresponding CMDQ_OP_PRI_RESP for SMMU HW to response the page request.

Extract the PRI info from the iopf_fault structure and fill the command.

Also, slightly rework the function flow with the existing CMDQ_OP_RESUME.

Co-developed-by: Barak Biber <bbiber@nvidia.com>
Signed-off-by: Barak Biber <bbiber@nvidia.com>
Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 +++++++++++++++------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2176ee8bec767..055dde5367131 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -992,29 +992,56 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
-static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
+static void arm_smmu_page_response(struct device *dev, struct iopf_fault *evt,
 				   struct iommu_page_response *resp)
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	int sid = master->streams[0].id;
 
-	if (WARN_ON(!master->stall_enabled))
+	/* Handle PRI responses */
+	if (evt && evt->fault.type == IOMMU_FAULT_PAGE_REQ) {
+		cmd.opcode = CMDQ_OP_PRI_RESP;
+		cmd.pri.sid = sid;
+		cmd.pri.grpid = resp->grpid;
+		if (evt->fault.prm.flags &
+		    IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
+			cmd.substream_valid = true;
+			cmd.pri.ssid = resp->pasid;
+		}
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_SUCCESS:
+			cmd.pri.resp = PRI_RESP_SUCC;
+			break;
+		case IOMMU_PAGE_RESP_FAILURE:
+			cmd.pri.resp = PRI_RESP_FAIL;
+			break;
+		case IOMMU_PAGE_RESP_INVALID:
+			cmd.pri.resp = PRI_RESP_DENY;
+			break;
+		default:
+			WARN_ON(true);
+			return;
+		}
+	} else if (master->stall_enabled) {
+		cmd.opcode = CMDQ_OP_RESUME;
+		cmd.resume.sid = sid;
+		cmd.resume.stag = resp->grpid;
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_INVALID:
+		case IOMMU_PAGE_RESP_FAILURE:
+			cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			cmd.resume.resp = CMDQ_RESUME_0_RESP_RETRY;
+			break;
+		default:
+			WARN_ON(true);
+			return;
+		}
+	} else {
+		WARN_ON(true);
 		return;
-
-	cmd.opcode		= CMDQ_OP_RESUME;
-	cmd.resume.sid		= sid;
-	cmd.resume.stag		= resp->grpid;
-	switch (resp->code) {
-	case IOMMU_PAGE_RESP_INVALID:
-	case IOMMU_PAGE_RESP_FAILURE:
-		cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
-		break;
-	case IOMMU_PAGE_RESP_SUCCESS:
-		cmd.resume.resp = CMDQ_RESUME_0_RESP_RETRY;
-		break;
-	default:
-		break;
 	}
 
 	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
-- 
2.43.0

