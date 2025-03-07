Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219320C49E
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341578; cv=fail; b=EUx6TfQQKkTjP1OfxSdAbWPxxYFsX7j8H+rHERTI0VADJQOWBiVelSc28jPG1K7RYndls4s0BAyadbfcI5pwQKlDNBH1lsgYu5XPFQt4rVmKDfadn9qXpODYvNOzo8NFATao8bLeR9uJxjM0fzNPXTy07eBtPiOKzlmEjxoT38M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341578; c=relaxed/simple;
	bh=SSjsLorMd6NKtOr7MbG5aZN+dZ9qThegO4ewEbk6GB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIkKMmw4Ff5AyD4jZEi4rY8rO41GXn5xCaZCSs9rdbmE3bR6T7+hu1LhBJtB/WCHDdbcxoKmqU6pUOmYtysipTXzZlmaD/B3KEDk6cW5wui+ERBBNkxc3gikttoFqyq5P6LcRV2lYXTroPGAh0t5G9uz9iji9Fm0H2ywm8Kr43c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LqsDMOcc; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LqsDMOcc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAJ1oF+eGumAzcRT/LoadR0CotBRi6L/BBjn03T11/i/xd1ikxpS5cQD8UurWHH/7v1sM0HeO6Vf1XqePrJxzc3Hv0ZyqXRabU3MdhRM5citNagPdWjSk96L/lTqb/zWxDMSoViGBroegHPEzq9NGFqtiI8oIjpqcGaQb3jkVTjbqIU9TQfkZRBB/voBd9W1a6cbgTxZRnIvaRYQZP0TzTOSuEdfDJ5TKDRWXEtyLr7WiWHx0OpmPK4yBmk1X6uDnO2udnQQTj25n82Vt+LfkeJP3i/tg77QmK8hxELL3C7wI+iP4kc3RQANZPq6yVsMsgFE5QISbgEDHNueO5tU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI6c+3IH+edYXgYJqGOkzutPxOuo0ToWppbwnBWZ7XI=;
 b=a5B9xoT7Zmg5yl8EfSaUBjLX+9AGbixMl+SI8hZBlHtEF6Kmtgr6RP7qT/Uv+X28AWTUg/+RGevPR6OesygCg5jLejoPNMIZe8ImqGFJZ2YObJiNpiTm8KpgVobjXpNSeEwXhIaU2hoHHrayfGFq+2C3ENIazQX9Na/CT8PfLpLXjDt4Q03LFUD6BLVOkTnorBYPR7qBqbQvVRDeCUw0SKkkf/oJCFl0h8C+RFLWvv8x5sCGSKt3F2VAdpBr0Tx64Nwp4pisVRYNcImtjZ6fWKhyWqXJQ7LN/NsL9uyvxlFlvje4JdSPniHxFcuA1ZpRtojPl1QhSfWfyenQn7Z3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI6c+3IH+edYXgYJqGOkzutPxOuo0ToWppbwnBWZ7XI=;
 b=LqsDMOcc9M0deJinAOp/GUKaP3wu7jVpEBIOODzqOV0Aiipm891fucYpmNw31ZQ4SfmcwCeQ9tJ46WcZCKGgwZQhJN7SY1C+NQ6Ko+5ErU+XsUq9cyvp6ITrTuedsTuXFdFufmBqW3k0OVLwAGrZ1v+ETQ0kM955mgR7lWBhTjA=
Received: from SJ0PR05CA0081.namprd05.prod.outlook.com (2603:10b6:a03:332::26)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 09:59:33 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::6f) by SJ0PR05CA0081.outlook.office365.com
 (2603:10b6:a03:332::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.9 via Frontend Transport; Fri, 7
 Mar 2025 09:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 09:59:33 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 03:59:30 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH 3/4] iommu/amd: Rename DTE_INTTABLEN* and MAX_IRQS_PER_TABLE macro
Date: Fri, 7 Mar 2025 15:28:21 +0530
Message-ID: <20250307095822.2274-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307095822.2274-1-sarunkod@amd.com>
References: <20250307095822.2274-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d0ac6a-4cf7-4478-d84b-08dd5d5ec2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GNH/BrzxmgtepiNEhOL2Mz9ww4+LFFLLbowmhtQwyeV2fFSc1P6XNT+hFOAg?=
 =?us-ascii?Q?6bysxNmxnaLx5qpxKfLo4VjTokmRWEAe2oS3wSiVnNFQqyzPPQEMlzZcQw64?=
 =?us-ascii?Q?exOxfTuwp5ZH32qE64dx3aDGIb7Quz+NFx4iltf1Mtyj+7rEGI3d3W41l8aL?=
 =?us-ascii?Q?gBfjPzcT1IrstZqfiVofZQz0Z/t6gQd9f/JxkrFLp+KW70cD183T9MuZ13QR?=
 =?us-ascii?Q?gcNAaThks+qSPFmzVlKcdy4ZpslW+4XN80QW42PEMvCr38FoeNiJhnURPMfY?=
 =?us-ascii?Q?FfIFTg6Z24zHDylSB5CsEGTJFbhZ4jJ/9bQSpUoUGVsFaIQezfRXhZTySc25?=
 =?us-ascii?Q?YCwga1okGWmtRUMOhqJjLuhNXW9iVr8kHTR+M/3SLWkOo82hvOUUbB4nTFxt?=
 =?us-ascii?Q?dkMaoKlFm4FJujgLuaLsw8q5kl1HP/KzJKfD4UfckA2uJjKmM1swXCF9ocfa?=
 =?us-ascii?Q?bQAbo72cvD5zQ2riPZ9nlRT/Rzl8D9G0qiMUS9MA0SjAhpO/Tu2evwhtLDPt?=
 =?us-ascii?Q?JesNzxXSfBqvMgnawC5ZY2e+JkGwX1ob7BEuR2YEK74ri2AUf4AO0At5QFku?=
 =?us-ascii?Q?99U2AH22nqayAy47sm4mnUhfS4kZ9LZFZMnqYfjfnzKfmBmzH9sZaL3C6UYg?=
 =?us-ascii?Q?89tq2z4t2MMm5K2nl+Go925SV4xawbWGrYRjgb3DZDXTIxc/zclV4Jw4PM5D?=
 =?us-ascii?Q?PxutqNXXwJwvs0FK/RonP8uaRNg2GJWjzKva0/XTgHL82+KzCFNH98wF7Dwr?=
 =?us-ascii?Q?R/0IjoDS0+Or0ocGNHz2An5MSRGax7OVCVun8uLr1C1iGy0vbokMkHjJBnTZ?=
 =?us-ascii?Q?S08FwQwAvMgz5/YVpk6HoMCGw96sMbW/gqNVEKzxWQFbM+Umxq9/XlZIMls+?=
 =?us-ascii?Q?um4zupGwrVBL+wF7LxxvmbJT2X583dDg3npk4oJ8ASTdARH86NH27h9IWyNy?=
 =?us-ascii?Q?ge1yim+C1aYfjdyCgXQO0aTIGuZ3xTpOlgGKZhOwQy2QUPdCEu1qnZP9SGHt?=
 =?us-ascii?Q?ZZCY4zzc9onRtlgFsdy0VDdO9BhBtvUIe8YSgPpBVH/sNBxmgPl7oUIBNodw?=
 =?us-ascii?Q?NrU+y0SMz6fJ0MgiVejAQErECQiyBj+jN/ysiA+u7/sXvhSAyN9EJryBXLgA?=
 =?us-ascii?Q?gqxmgZ7BCpUcYGUBARmIawzi3VN7rr/ftxWYAAi1eFdvw7HGlKbHFA10pU3h?=
 =?us-ascii?Q?jf+tD9iEpGD0ZPSHscMjHaJmrSTSmDWtA+FJvfPKZqPQDmqXqJdHqejBUJCt?=
 =?us-ascii?Q?0nUxs48GPDGh2q0TrnsxhOPjo+cCBvBDMb/pu5fj0DAwx7gCJicmT08Fjw9H?=
 =?us-ascii?Q?bVM4JLr/P1IpmW7SFsu42kjf4UAVu3xk0xgG01zkukTRSgUH2gZ+R67htFfh?=
 =?us-ascii?Q?7BtuuNlvTisxd6dveqU2G4Zkren4pIZ59eQbc0Ul4nzqRf1rtL5MZDeYyEe1?=
 =?us-ascii?Q?Z4MLA8e/uN8rDRjxUFWA2D/cE7JmVPHVlvtx+OVlMPf+mB5fPhUBTe3mUlBt?=
 =?us-ascii?Q?aGXEaIowNg/Pjvw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:59:33.4116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d0ac6a-4cf7-4478-d84b-08dd5d5ec2f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

AMD iommu can support both 512 and 2K interrupts on newer platform. Hence
add suffix "512" to the existing macros.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 +++---
 drivers/iommu/amd/init.c            | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a1e2b8317d11..2efb47dba270 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -313,10 +313,10 @@
  * AMD IOMMU hardware only support 512 IRTEs despite
  * the architectural limitation of 2048 entries.
  */
-#define DTE_INTTABLEN_VALUE     9ULL
-#define DTE_INTTABLEN           (DTE_INTTABLEN_VALUE << 1)
 #define DTE_INTTABLEN_MASK      (0xfULL << 1)
-#define MAX_IRQS_PER_TABLE      (1 << DTE_INTTABLEN_VALUE)
+#define DTE_INTTABLEN_VALUE_512 9ULL
+#define DTE_INTTABLEN_512       (DTE_INTTABLEN_VALUE_512 << 1)
+#define MAX_IRQS_PER_TABLE_512  BIT(DTE_INTTABLEN_VALUE_512)
 
 #define PAGE_MODE_NONE    0x00
 #define PAGE_MODE_1_LEVEL 0x01
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0fbe92a0b48a..9a311c627090 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1061,7 +1061,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		int_tab_len = old_devtb[devid].data[2] & DTE_INTTABLEN_MASK;
 		if (irq_v && (int_ctl || int_tab_len)) {
 			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
-			    (int_tab_len != DTE_INTTABLEN)) {
+			    (int_tab_len != DTE_INTTABLEN_512)) {
 				pr_err("Wrong old irq remapping flag: %#x\n", devid);
 				memunmap(old_devtb);
 				return false;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0960b95656e6..1063c4988dca 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3093,7 +3093,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
 	new |= iommu_virt_to_phys(table->table);
 	new |= DTE_IRQ_REMAP_INTCTL;
-	new |= DTE_INTTABLEN;
+	new |= DTE_INTTABLEN_512;
 	new |= DTE_IRQ_REMAP_ENABLE;
 	WRITE_ONCE(dte->data[2], new);
 
-- 
2.34.1

