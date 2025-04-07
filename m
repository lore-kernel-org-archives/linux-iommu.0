Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217525484A
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047409; cv=fail; b=ronafoXF1N3rI/rveo0CpzWsiIWuu2Cxau4QUZAwohD54v1hem+GkktWTKWY20uI5U7fzhLQeXMw1CsCos/9W/MohF32nNl/DZPEla9P6T+Lm8W2GRbpvurxKkpI0sKhRVeGgrBiltdyjRFBtvm5O1VGfYc+44Uy4TEOMn2oGNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047409; c=relaxed/simple;
	bh=cPiuWSxiIy3IC8otvRGDpKl5FZQag8Qb0bnt4/vpYKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csCmRy+9tm+ZFds2cgHXj26OGMwwFqZ3tW1px1XtULBwZ883AqzCWfDskXhqL1Ts+zJHXcCsaf+WNgZrHqBOpMSNy3xmoEYdrKgdJP7d8C/S6o04haiEuJSqVaaQpG0z8wY3vNg0lDvOEiwLDHhmqa9+UDtTE1M58EVtPkhGv/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mz/tTYIK; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mz/tTYIK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytXSOaaZqKfdrDfuD7Qk8nmAdZEP0He12sIftcVRo830girGhXZuVUV8ipna//sNqPu1ngYlFyZsUlZILM6yuvNDtNhQovYgGGcoCzoOLuQT2UixeTWIfMi1FB4ieAfv1PJVS1QQq4+ZXFRZ/zKyjqOrExxBVH0V5iAGw8X0Z/iQ1Oz58SdbPR795fC/VMs2E6O2iMd1Uika+t4K/j8PTtDvPDDHkRy+gYSl6Xb1CV25ZAmPrUkkE448D0bzzwttiGcUjR0YBAMSfFIqM3tC5G+M1fxdd3yKsUhpXKpwKBo2RHeppus4sMz5tNJjpwO6RvEbImEGKWT0Xjf6RhLY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LjvtqSFPkBK7b3m7aTB5eS6CJsNJ709tuy5SgtPBN8=;
 b=NHkKS4xFF9xDTvdH9A+shOBXT6Z4a0hB7DgSFP/Kj0F2oApipn79Yt9JhifoPnw9ymt0WKQoPwaBwGM1oOaIH+6MEImHkmWNjU2MfEF+DsJufEyL1wWUCRIits4dcTi6txcn8lkklp+bg//3cEVwyLyoOQCnifztgLtAtb8B0S86bL9a6NauV/bZxKv+/rC9w3EdXk2vsdp0i03e9ieMJoYqb6T1b+/QXke90SNI7zw39uDE1CZdpK2ABShJsE+3zGwSzqJ4rbfQ5lueD6Pc8dM4I1izbvR9sjs1cExmF77AFTyZxCaZzJDecJh+6C6CP/ser8vXxLyurNFJgDRsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LjvtqSFPkBK7b3m7aTB5eS6CJsNJ709tuy5SgtPBN8=;
 b=mz/tTYIKwr0ZDbqpRO5Sd9czoOX/52HV4Zn5WsAZUVMK3dDcnDqzhPjxKEKeAeHy9vvFqwA04ZwdohUT1yDYMRRIVGhCanjPt/LaGn6CYbRyFI/U4PHStfqlfgRjomoZz4sbjlGlLDKaErB0PphEd9+L41pkvEhe9x0nMexzc9k=
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Mon, 7 Apr
 2025 17:36:45 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::67) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 17:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:36:44 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:36:40 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
Date: Mon, 7 Apr 2025 23:04:56 +0530
Message-ID: <20250407173500.1827-5-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
References: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dab93de-e1c2-474e-b32b-08dd75fac429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ank0S3Tl6pngREb69qq37CvtcVRHR9dTFMTi3bwz7C2PXcf9zvwNEuHrf5NT?=
 =?us-ascii?Q?WmGsvQyG7xB8jomxrCvw7EdR9VqVO6IVSrNTuInVZvnoj+TjTpF9wsXYsqX0?=
 =?us-ascii?Q?Toz854R4Sz4YqakBLAtjthn+Ts1gHQkn8Mt1MC35cp3CmKCfQM9G/D+ddXVb?=
 =?us-ascii?Q?Ddhq8wADMmZqNuVaVM4I4Z9vEnifOOkqLVAGWljcipPjcgMmBemroEyEDcB3?=
 =?us-ascii?Q?pT+YYFwc4eQdJjQE8SH81q/XAiX4uA2GCI4af5YhwovarIicoWLk0M0zr6ay?=
 =?us-ascii?Q?+d9UwW5dtuD6jJG22ZqmeAr0RE+oJP+a5xbfZIZQSsu8D+0kHsRiBebijzOe?=
 =?us-ascii?Q?NgQoJqSjv7qVZHPaM7NBYn8UfZTXSAV7fx3QnbEyqhGGieK4DBxAxXQPQ8xW?=
 =?us-ascii?Q?+UdTqWxm3Zb8nRtFausW/Pry917eM7zPES2Uhay05h5+9rHk/2I+fSggvCPR?=
 =?us-ascii?Q?qvPPkTtOT0CWJ0CGVtnkjLpCnB3DVsLPHMvV7HcsWPUnC+jR/jyXaW+W9z05?=
 =?us-ascii?Q?Odx5f2hfbCuCilDaro8kYZ/1CNkGPvpnOKKDHthuve7KSforphmZzue1P/5m?=
 =?us-ascii?Q?QqNWS6sHXbOHamfa99MlWwLSv0DRRCbdprRwh21DZ1Odk8ne3/uHFem4/qMP?=
 =?us-ascii?Q?tEyxNy+L6hLXG+inJz5Qw0XZkagzrjMyilAoKZXVDRUe+ZZOPQXEUOFNqkSe?=
 =?us-ascii?Q?6SH1/vLVn3dmL0mvROgG3Sql30Vh8GhixK1wkl5hvYR+zK3p1CWNWCz023b/?=
 =?us-ascii?Q?XKBHWcFrnK05Z0/hhmZ01gT4VcEGB06IYQ0UeOOfUrF2r3o2H66Yx8pc8am3?=
 =?us-ascii?Q?wYnIeIwrxytmYygDcMhSvp4+l6zqSlwOUiePD+UD9c1otY4gBX/NtBn2mGkC?=
 =?us-ascii?Q?NlaFZ5CTBQfnBLD0pwNfWPmVDUBx+/u7LzM4b92bzwytPWyUZDt+ttRQ27T/?=
 =?us-ascii?Q?XGi27cIf2LZbeX0ZTX5OTz17zb61atM6ZWkxILJ8uOoK4C3SwAHtKTE3gENx?=
 =?us-ascii?Q?PvpUTaZ64Fx/VHbn8qEpe0IU6SZ69t5MEwRZ9mra9Avlq2QWtmVcEk1Ielrf?=
 =?us-ascii?Q?BV+FLQB0s4HGqC9KfVHWf/s/mSKRWPEAB1LNNW5QBR9HznnxCpacZknIunua?=
 =?us-ascii?Q?iM1k55Esu/mWT2cWVNS9kD+ggkm08VEPeQXoJQVm70t6mO1poaMaP/nRv+qJ?=
 =?us-ascii?Q?xR/i4C0VvJ2MnAhCTJWzSInXpjn0/EwYwu5r2jY3UwUKkkja4XVVWcJp1Or9?=
 =?us-ascii?Q?skbziRJGg/X2rLOiFF6KzVffpgohImQTInyPZBn4BZAbeXihAXKUaEQXvASQ?=
 =?us-ascii?Q?0SuWpYh+7m/RlQOJ3vYHBDaw1u1AaF5HxIp+qCltCulGPsglcpmPVqlKuJxt?=
 =?us-ascii?Q?z9T4Q1uxETGw/PhqyMPdXHN/Fo1euv0wP4Ua62Ba7r/gWKwfchs384CD2Tc8?=
 =?us-ascii?Q?OLUwF0pTBqjT1kjDDjuvu5fOL9HJNNcbDoOhUrIMwg/IiPTZF4b7EAcmucDA?=
 =?us-ascii?Q?kkx762ANnlg8RZnZ67OmkHICZpLO5uGMMkVs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:36:44.8881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dab93de-e1c2-474e-b32b-08dd75fac429
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

IOMMU driver sends command to IOMMU hardware via command buffer. In cases
where IOMMU hardware fails to process commands in command buffer, dumping
it is a valuable input to debug the issue.

IOMMU hardware processes command buffer entry at offset equals to the head
pointer. Dumping just the entry at the head pointer may not always be
useful. The current head may not be pointing to the entry of the command
buffer which is causing the issue. IOMMU Hardware may have processed the
entry and updated the head pointer. So dumping the entire command buffer
gives a broad understanding of what hardware was/is doing. The command
buffer dump will have all entries from start to end of the command buffer.
Along with that, it will have a head and tail command buffer pointer
register dump to facilitate where the IOMMU driver and hardware are in
the command buffer for injecting and processing the entries respectively.

Command buffer is a per IOMMU data structure. So dumping on per IOMMU
basis.
eg.
-> To get command buffer dump for iommu<x> (say, iommu00)
   #cat /sys/kernel/debug/iommu/amd/iommu00/cmdbuf

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/debugfs.c         | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           |  7 -------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1666a460d030..3f419ee49ac9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -895,6 +895,13 @@ struct dev_table_entry {
 	};
 };
 
+/*
+ * Structure defining one entry in the command buffer
+ */
+struct iommu_cmd {
+	u32 data[4];
+};
+
 /*
  * Structure to sture persistent DTE flags from IVHD
  */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 5ac12c3fe069..61fde9ebfcfa 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -106,6 +106,30 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
 
+static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	struct iommu_cmd *cmd;
+	unsigned long flag;
+	u32 head, tail;
+	int i;
+
+	raw_spin_lock_irqsave(&iommu->lock, flag);
+	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+	seq_printf(m, "CMD Buffer Head Offset:%d Tail Offset:%d\n",
+		   (head >> 4) & 0x7fff, (tail >> 4) & 0x7fff);
+	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
+		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
+		seq_printf(m, "%3d: %08x %08x %08x %08x\n", i, cmd->data[0],
+			   cmd->data[1], cmd->data[2], cmd->data[3]);
+	}
+	raw_spin_unlock_irqrestore(&iommu->lock, flag);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_cmdbuf);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -124,5 +148,7 @@ void amd_iommu_debugfs_setup(void)
 				    &iommu_mmio_fops);
 		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
 				    &iommu_capability_fops);
+		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
+				    &iommu_cmdbuf_fops);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd5116d8c3b2..5c51ffe7c956 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -62,13 +62,6 @@ static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
-/*
- * general struct to manage commands send to an IOMMU
- */
-struct iommu_cmd {
-	u32 data[4];
-};
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
-- 
2.25.1

