Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6833439D
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627319; cv=fail; b=NWWYAu/sXJO9/9XMxLAg9gmPgoYYVqpp1Ud1ecYibUAaSAzhb/liA46sQb+CYZkblwlMW5kPX5QSSzRhycR9JRwRr1r4H69fpI+xcqtKi7Qxja4GsRVwt+iemYSaV6n6O8bxKHGCMkCan3dMSU9P0/4wCwUJ2/rX4BebO/SC868=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627319; c=relaxed/simple;
	bh=9B1S0e1hx06lrq8n7aV9cWbs7NUDI89ZCGr0GS0MZZg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DIDTHIqdS5KfDb3GJYLdhBFvmgwZvMCvoOWmbONCR2tYx1NvTdF2Ow+CapwCrkfCAbj8UxcqLpMIm7zzFTzVVx72Wc5xfLA8RhTBXgzFD4y8CIVyKnU7JJwgTUNCe/A5mV3sDre+nK5/ZmM1I8HEeXj6KQRGx0/r6mVtRW1JSb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a4TgdJj1; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a4TgdJj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx8dmYqe++3dSsWKLzIfKNiJ70s8Rv1aM1kAaOWHlJTAy+MxajxNZBsZPXhq8HP6/5CpLb7N8xg8oojr3RqMVf0OAmLW38LYZyHoxTci6AqtKcY1phVPf4yO1JGTQyJllk+r+eMrsjwzTKDpg7Vjuqss/G1uPVPWFAcOF0cRFyrPljcyO6wh9ohphJioO8ZTEzRH1Yh7afvBSfXToZbM8MSeEMoB6z3kwl3sw9sNRRrtnklT6H9N2wCIhAZYyVTXsXDKT3os+uPmL5h/KDxMFFhRbp+mUSYEtsbSICtpwOKcdEeb6lUiV2UW4GhyR3+K35h7DoRd76nOI9uhio1qSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWcBNcks2TmtVkG6XiPH4D6S0Ub1Uh+pjXL0gfwY9tk=;
 b=wcekD3vEPka2/wWW8cWDfoocU+2gE4EdYyjQhRJYHI6UjJKtlW4QEGehqsKq/HMYfGa1MVT0HY0Con+zofF//RZZ8+TiZv1xJXp/1qU5PtXs46PqQRwjFUZZSt4ye3c/nYWg3NuT7LN/jPPXsDg0Ve0+9IFvq4Fz70FezSiKzAazyBNOmVtpkxzgy2tl08GENxSATLd3yEDCHlOTUY6Vn8tuhjideyEeiHItKugDN0fqOGiw9Iq5KEZKVGGSPQwlJGi1Wx8mMURZJLG5OoYBzBTzdq4JW5EO4ZMEyRgzOp0mSYyt4JuTnAicLulQrsi+YrNEQ8rfB4HZjFwkITcNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWcBNcks2TmtVkG6XiPH4D6S0Ub1Uh+pjXL0gfwY9tk=;
 b=a4TgdJj1ay0UOCXnnjbozPB6Lgy5MsLYKMFQI75XxbmWKKqnfEAyhb1H6QZO0nV2rRNvvjieR2k0KzTP/ACrNn7qEG61e3R8fx2X+AXCxsM1sEi+dFfuCK6Y2mEJkiKUiXHvjr5zLPBYOffTi3z6DwNjzzfqk2Rg3GDHAD/71Uc=
Received: from BL0PR0102CA0043.prod.exchangelabs.com (2603:10b6:208:25::20) by
 DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 15:08:32 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::23) by BL0PR0102CA0043.outlook.office365.com
 (2603:10b6:208:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Thu,
 16 Oct 2025 15:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 15:08:32 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 08:08:29 -0700
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>,
	<Santosh.Shukla@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH] iommu/amd: Enhance "Completion-wait Time-out" error message
Date: Thu, 16 Oct 2025 20:38:09 +0530
Message-ID: <20251016150809.5465-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 30858188-2362-4737-eccf-08de0cc5df3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gas6x4jkizx66RM76is5O+cCsIESQcmhKNrRTgGekvXwR2UI73/YOyB3z2Ry?=
 =?us-ascii?Q?SUJzsjmbFIOAlUEszwnIl1jpJzbpeIV6BbM9isgKukNMhcWdvoW3j0LR+vog?=
 =?us-ascii?Q?ysmsoHM1LuLQdlOP9RTTeTbtKKV2Fw167HZGrdvMLWk26NaZ+N+kuZzor9Wj?=
 =?us-ascii?Q?ayKvsGudluVFt/oGshwnJEaTfjdrtOU6CAPzYAR8patyqdQiOoGdrMN9HvJp?=
 =?us-ascii?Q?IdgzWslw98+zq8rN1AFq0HnX+12YONdKP70c01byA6zi8+4ftIRLPyVzKaDA?=
 =?us-ascii?Q?hSOhTxrlEKGhQh9kPhe6KPFpN53/jBgxci6GNTygrC/Lxs2E65WRwdDbbYN8?=
 =?us-ascii?Q?1/bP/ggEd1v18+lU0ZXCfz9aOpsrgmRfDwK90IA74m6LUQnnMK8ckl7OFg4u?=
 =?us-ascii?Q?lxMtLxeMEcikLjc5UBycghqO2MWgzHiApCtak4F6GfYNv55PYZyvEeSd5UP/?=
 =?us-ascii?Q?tU0qAfH5x37M0T91gYeFiUATdxhkBOjAHffoVAiyaUQFsNcynNl4bMH0AXMv?=
 =?us-ascii?Q?nbFP31knDJZx/47Qe0J0ZU39iAeDkrDQNHwxdWODgiVW5XZFwqkk6x/dVKn/?=
 =?us-ascii?Q?9xpfwyqhD1eVijEEcFYdcFcBcbzVP3OLaxRUmI++Zso4JKcPCS1bSX8iaqmV?=
 =?us-ascii?Q?NJaGMU0HxvsyDalLkBSxInRIYE3hDTOF3aBijoMR2n2kx20BtuHA4QO5HGfc?=
 =?us-ascii?Q?nwKaqGx5zjLuM2MsEPdBSNX87IyNuVYSCv+m5hKlPgmPDRMmy8pvBu1zn4jg?=
 =?us-ascii?Q?QI4u0vKlzJzkLqAa6OSBgkslosBXhQ3wPJEGY2KUGFURI21lkyCBgG+WP0an?=
 =?us-ascii?Q?JB/fyN8c3OZxGgWQZG317wgo4lj8h4dRfWqnRf8e5scGfv1616ekMyc+is8Z?=
 =?us-ascii?Q?YIDAEBvWKS0ccxrF9ATXvDx/Ri9hWF/L2Pj4pVXDN9++rv8eX2XBvr2NXNZ9?=
 =?us-ascii?Q?yfht7vNWiNvFXh4Kxua+EIZFILEA+ISyV/COgLyd7epyaVzoKRtBYz2bxnFE?=
 =?us-ascii?Q?WORUiZtKP6mPUI5bGUF5tLyQD/NLVTS/PduE4rLx5jzTDnP05WtX0b30TtpH?=
 =?us-ascii?Q?JtTJoYo/A68Pb1Rw4zpzaSz4w0uKsoII8uTmkivmPcNK8vnJYCCuZxXw8xOM?=
 =?us-ascii?Q?WueC0JNSx8EJjcjEg+toVS32y62TI/lAL8EYniTFjkRdmJ+Fv9cPl7HGy43+?=
 =?us-ascii?Q?R+7QBAEEopyUBaM/Gy8PQUcq0C/wiFCExx/2VxAFlz0Jesrvuej4M6I1MWAE?=
 =?us-ascii?Q?M7IPqMkMAUtbo+oxZKLRaIQLqLFq+M3gksS3kNpYsO5e/LemsbEVJEaiJ264?=
 =?us-ascii?Q?Byxx3HAIunixvpiNYDpuXLomGM3DIfLFTWq3Qkd5NV2WEx/1nOkCbSUQI8vT?=
 =?us-ascii?Q?StoG8lh7/xhJGmU8xtd4EGrEvET6HtEgDXoCiaksZFFyc/z/5nO0UDerBI9p?=
 =?us-ascii?Q?3d8vsLwtEMNfuCu0pUzQq7uDr9DoiUxDczzarZ7qZqZV1pFT9TrupZmeWsby?=
 =?us-ascii?Q?E8ZCw1A0i3vydRoZSUhF7dRg1Pk9Z4is37Agc/yRgNGevAJCeg2XgTpgs7ns?=
 =?us-ascii?Q?FWpLPOnCgU68Fw5kiyE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:08:32.6156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30858188-2362-4737-eccf-08de0cc5df3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192

Current IOMMU driver prints "Completion-wait Time-out" error message with
insufficient information to further debug the issue.

Enhancing the error message as following:
1. Log IOMMU PCI device ID in the error message.
2. Also dump the command and offset of the command prior to the
   COMPLETION_WAIT command to figure out for what IOMMU is waiting.
3. With "amd_iommu_dump=1" kernel command line option, dump entire
   command buffer entries including Head and Tail offset.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/iommu.c           | 31 +++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 95f63c5f6159..7576814f944d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -247,6 +247,10 @@
 #define CMD_BUFFER_ENTRIES 512
 #define MMIO_CMD_SIZE_SHIFT 56
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
+#define MMIO_CMD_HEAD_MASK	GENMASK_ULL(18, 4)
+#define MMIO_CMD_BUFFER_HEAD(x) FIELD_GET(MMIO_CMD_HEAD_MASK, (x))
+#define MMIO_CMD_TAIL_MASK	GENMASK_ULL(18, 4)
+#define MMIO_CMD_BUFFER_TAIL(x) FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
 
 /* constants for event buffer handling */
 #define EVT_BUFFER_SIZE		8192 /* 512 entries */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..e1b4b0ea0990 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1158,7 +1158,8 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
 
 static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
-	int i = 0;
+	struct iommu_cmd *cmd;
+	int i = 0, j;
 
 	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
 		udelay(1);
@@ -1166,7 +1167,33 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 	}
 
 	if (i == LOOP_TIMEOUT) {
-		pr_alert("Completion-Wait loop timed out\n");
+		int head, tail;
+
+		head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+		tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+
+		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
+			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
+		if (!amd_iommu_dump) {
+			/*
+			 * On command buffer completion timeout, step back by 2 commands
+			 * to locate the actual command that is causing the issue.
+			 */
+			tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
+			cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
+			dump_command(iommu_virt_to_phys(cmd));
+		} else {
+			/* Dump entire command buffer along with head and tail indices */
+			pr_alert("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
+				 (int)(MMIO_CMD_BUFFER_TAIL(tail)));
+			for (j = 0; j < CMD_BUFFER_ENTRIES; j++) {
+				cmd = (struct iommu_cmd *)(iommu->cmd_buf + j * sizeof(*cmd));
+				pr_err("%3d: %08x %08x %08x %08x\n", j, cmd->data[0], cmd->data[1],
+				       cmd->data[2], cmd->data[3]);
+			}
+		}
+
 		return -EIO;
 	}
 
-- 
2.25.1

