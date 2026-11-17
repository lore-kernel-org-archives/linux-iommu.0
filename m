Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899291;
	b=ZwAFToF3uGfnlssoROU3mJZLsrciXPdhjj20fc/Y3oSmFS4SuC6ZkMZ0CBqx63kpNzs+
	 5pn5Mm0ws/Jwow3+pGdjtXQNZiQiaRYq0Tirou8LOrEvJ4qVtWejOjMtZwHsPWLd8D1tH
	 //kXoqrrrRtwv2R+H30GfwyQIGSaOSQU7x2mp/JiN5xije+f28/hMdgLYaocKAOMsWUmU
	 hg5qnFpHCAfR2cv4gwU2oc2fENhKfm/NEjBv90x7/8GojvXnbnZeveK9/xrsSnsEI2iXU
	 Qkq552HMo0BW+GJoaKJo+gx4cZwiw4bySAwg1nFcqqUSWeW5SMX5z8ob16/ALxjKAfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899291;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wFUuf4lY+j4J+jtufSXb6sRQGerSY5QQgJCft+SWQWo=;
	b=B95drc8mmCKU1Q0VMxQUmbxbAfeM6Lss8RXDHUSoCBjW0QFfqhc2Q1R7W81jAReLcROt
	 5mSv8kvXHHEd8To8IhtN0G0VVu7RkQfm4UqgQkrBnQg1Q/H5FMcSCjDtXhoY01sO88/VR
	 6Y+eg7YqkJYiyy8j7IRDWtrOR/KTSRtdORqsywlytPYOGDxZA0lLZ2dc09ExbaP0MneyM
	 079/0Kzra5snGZ2+atPfm4Hlg3NFb8nDf4Z30XwdptO8Pu/kCQG8zY2Ab4PciU/kqcHBG
	 /QmPtCVJYSCnv0WlpLDFahImzYtSdT/agzmjDwUx0K8hMYORlWb5N6MYF2QroREOmVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=34o8U9qT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.5
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766DD606A323
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 07:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 766DD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=34o8U9qT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5T8yUbUNyMlQXhrg69zJ1pZTjKFGSRk8ZVlLY1mlAdACPagbHgEYEeRmSKMN4aOFNAUf+jlcQQlxRzE1YFOOKcFLqfXcFAb5z9bTKuaCQ7aoXfBpPVEzLMii8XX9D86uLP8zSLYqrQg2mOiZT/HaynXqv9xNpKWI0K+HE605jxnrOVKl3ldTdleRUmAYX3KxR+V9+fo5ligYIYffrTjVSijCzzfutQitOqt0wjhsdBAs8yM7r0ynYqsYl2gXwxFjGShrro5/IKCInzmVcBkJVfig9cppi6U1+GRSJS7l8d+Lh0WNDCcj5OSgkVQXjYbkplZ9EaLcd7AM+PvXkYhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFUuf4lY+j4J+jtufSXb6sRQGerSY5QQgJCft+SWQWo=;
 b=g8j+goyEEC8O0fRhRaLdx4v7T0F9LVwvbbb2CAlcdezfR1F2n59Ldt7kxQKxhDAPPW/sJw/tmLwRP4owl6S730XoqdGgm+VEZRxlx+fv1vlhdYO+y/9SHq3Xxk+EWm1NoOggGfjzgWsWjP5ySXTKn48QGTvjT38UnvTtRexsh1r4C3Xhd7WMMiJ09mkEm/EUhX416NyLTGyIXIGxetFxI6vHB7+GCy/7SlxNGE+e24pzY7lSj0oiQlHizHadojrcGo439TtBlQYtsMnbIMb6M/yVN+j+XMmoRZQvEz6AG+6faKWbU/OwXg7n/VPIEt5gU0qGV51GQ7vc6ZQSpanQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFUuf4lY+j4J+jtufSXb6sRQGerSY5QQgJCft+SWQWo=;
 b=34o8U9qTv2400vBJ9wMO3WCw0xjaM/qSTnSjh3uc1RVQc38sUsP9I620JzGrSQ1MK31ks68P7RjLZIQBqHFo/mp3k5TIFTv4BbEjb6avYQ6bJupn5HsEk2hKEOzhBPp71VOf00Xxu3Kv3R4tX2698Thp/vERPNukWDQzrUYPuvU=
Received: from MW4PR03CA0331.namprd03.prod.outlook.com (2603:10b6:303:dc::6)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:08:06 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::8a) by MW4PR03CA0331.outlook.office365.com
 (2603:10b6:303:dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 07:08:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:08:06 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:07:49 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Baoquan He <bhe@redhat.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v4 2/3] iommu/amd: Do not convert IVMD exclusion range to unity range
Date: Tue, 17 Nov 2026 12:36:53 +0530
Message-ID: <20261117070654.3699-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117070654.3699-1-sarunkod@amd.com>
References: <20261117070654.3699-1-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d74cb53-8258-411b-b214-08df4479875f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QaXpm6BXDublaz1hgR6hKD3CYOtd+3dNOUZioCWv5Pr8rPGYhRvsmxWrqkK8tZHIDHeWPTxg/QOd3noG/nBXYDnTvzoGJ52x7caW14AK7C1jx5aP+15ynjxF76w1uDlBYmdPHD1V5UHwyCRmksxAA5Ic+zFUAcyMO9wWcy9r5oFDAqpablYOfjM8p8jR0drFKZo/dZ/oSPWFVXPZKxU5nNdfEuKVIJ2OAbdd84wnyqAAWx/ftl3w38H+yxpTGSsyP4cn5BN6RdZ4Ip8l+pU1ZEbfX6WR9JhUxAvnaLBh3vQt+okyC//rOFSFihuqpSHSolXP9qU0F5dndStim2D7YF+ApVnZ2VFg96JRnQ7hIGnguKKOWkWuS+E6QbXSUg8WC/6QSq0v0RIi9LOQRT+cGrQERrPzNR5UUMmH70+Hj/Z21Pd0ik6JeCE6D5bZn/AmTx84sdN658aIRP16DaMKCN+jJTLRyQrSD8rFRVeYKCTZL7BE+V1oWZoQRDWrsorSKn1jeoSAXN4wZxHQ4NOqwqms4Bsob4vYlQaOgMAi4KisTp6O2n6BPLG6JtVr2Cx1okGoZc4obAF3gAp9C9DmWABqIy1J4K3/OSEMnMypyWhNXo/hM5SNnsQfs/4qVBMygt/tjIlYi6gPIvynjHTZuGCte+VUfaqzQ1xu/bsgBXfpbG8GbbP9uGpPQePkEMyQ6qQoT3CtvMLJCjMBh+Hx2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1g6SsHI+OH9867J3ysk7JxlckKhhE6q8L95y2aqRBZDPSdQhfxvnPxQVYUBhMThHFm+HRHKuzmWDaGdbyb6KaWgUtBCfJrwHNFS0cZH/7A8Kf69iBsn+ySZDHbaHq0s8zey1WUk9z6T5Mu3ejEtQOUnRVnCGeAI1QlgiAWGPgmcQy7nWmJ6Eu49jcWV9QsOX3mQD2emEiPD645HLKla5PhJd3K5/u9V5PHujMqe+DMRTUhFeG0t0jmpxzENqftAHiMr9mvvPY3vxlbpAe+joYm0DjXaOve3yf9tVT1RT4ALNVbbbOitroNi5vTAWsHVt9SerYOYnA3kTQiPB90FmYi0nVJBxPprTB3BEQ0mWibK8UsFKyZqRq4UtMqbL5uJrSvx9XW+6ChlUX/hZw/ZOQtBniNchTPSMR2ftE4n3VlvNtUZswWYzv0khwhH0CGA1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:08:06.2142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d74cb53-8258-411b-b214-08df4479875f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Original problem was there could be multiple IVMD exclusion entries
conflicting over a single exclusion range supported in older Linux
kernel. The fix was first introduced in commit 387caf0b759a ("iommu/amd:
Treat per-device exclusion ranges as r/w unity-mapped regions") and in
commit 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
, where IVMD exclusions are converted to separate unity_map_entry objects
in pci_seg->unity_map so amd_iommu_get_resv_regions() treated every such
entry as IOMMU_RESV_DIRECT with R/W.

The driver no longer programs the exclusion base/limit registers and
relies on the kernel to keep the IOVA ranges named by exclusion IVMDs
unmapped. Stop forcing exclusion entries to RW-unity. Store the raw
IVMD flags in struct unity_map_entry instead of a pre-shifted
protection value, and derive the reserved region from those flags.
Exclusion entries are now reported as IOMMU_RESV_RESERVED with no
read/write permission.

Reject unity entries that grant neither IR nor IW with a FW_BUG
message, and warn about invalid flag combinations and unknown flag bits

Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
Cc: Baoquan He <bhe@redhat.com>
Cc: Adrian Huang <ahuang12@lenovo.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ++++++-----
 drivers/iommu/amd/init.c            | 31 ++++++++++++++---------------
 drivers/iommu/amd/iommu.c           | 12 +++++++++--
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 678ceddd711c..122eac81d4e3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -368,9 +368,11 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PROT_MASK 0x03
-#define IOMMU_PROT_IR 0x01
-#define IOMMU_PROT_IW 0x02
+#define IVMD_FLAG_UNITY_MAP	BIT(0)
+#define IVMD_FLAG_IR		BIT(1)
+#define IVMD_FLAG_IW		BIT(2)
+#define IVMD_FLAG_EXCL_RANGE	BIT(3)
+#define IVMD_FLAG_MASK		GENMASK_U32(3, 0)
 
 /* IOMMU capabilities */
 #define IOMMU_CAP_IOTLB   24
@@ -880,8 +882,8 @@ struct unity_map_entry {
 	/* end address to unity map (including) */
 	u64 address_end;
 
-	/* required protection */
-	int prot;
+	/* IVMD flags for the entry */
+	u8 flags;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 13c96feed64f..de8e4ba2ccd0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -70,11 +70,6 @@
 #define IVHD_FLAG_RESPASSPW_EN_MASK     0x04
 #define IVHD_FLAG_ISOC_EN_MASK          0x08
 
-#define IVMD_FLAG_EXCL_RANGE            0x08
-#define IVMD_FLAG_IW                    0x04
-#define IVMD_FLAG_IR                    0x02
-#define IVMD_FLAG_UNITY_MAP             0x01
-
 #define ACPI_DEVFLAG_INITPASS           0x01
 #define ACPI_DEVFLAG_EXTINT             0x02
 #define ACPI_DEVFLAG_NMI                0x04
@@ -2636,6 +2631,20 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
+	if ((m->flags & IVMD_FLAG_UNITY_MAP) &&
+	    !(m->flags & (IVMD_FLAG_IR | IVMD_FLAG_IW))) {
+		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Unity set without IR/IW, ignoring\n",
+		       m->type, m->devid, m->range_start, m->range_length);
+		return -EINVAL;
+	}
+
+	if ((m->flags & IVMD_FLAG_EXCL_RANGE) &&
+	    (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_IR | IVMD_FLAG_IW))) {
+		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Invalid IOMMU flags %#x, ignoring\n",
+		       m->type, m->devid, m->range_start, m->range_length, m->flags);
+		return -EINVAL;
+	}
+
 	pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
@@ -2665,17 +2674,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	}
 	e->address_start = PAGE_ALIGN(m->range_start);
 	e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
-	e->prot = m->flags >> 1;
-
-	/*
-	 * Treat per-device exclusion ranges as r/w unity-mapped regions
-	 * since some buggy BIOSes might lead to the overwritten exclusion
-	 * range (exclusion_start and exclusion_length members). This
-	 * happens when there are multiple exclusion ranges (IVMD entries)
-	 * defined in ACPI table.
-	 */
-	if (m->flags & IVMD_FLAG_EXCL_RANGE)
-		e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
+	e->flags = m->flags;
 
 	DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
 		    "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..7edaf99a1ecb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3120,12 +3120,20 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
+		if (entry->flags & ~IVMD_FLAG_MASK)
+			pr_err("%s: Unknown flags: %#02x for sbdf=%#x\n",
+			       __func__, entry->flags & ~IVMD_FLAG_MASK, sbdf);
+
 		type   = IOMMU_RESV_DIRECT;
 		length = entry->address_end - entry->address_start;
-		if (entry->prot & IOMMU_PROT_IR)
+		if (entry->flags & IVMD_FLAG_IR)
 			prot |= IOMMU_READ;
-		if (entry->prot & IOMMU_PROT_IW)
+		if (entry->flags & IVMD_FLAG_IW)
 			prot |= IOMMU_WRITE;
+		if (entry->flags & IVMD_FLAG_EXCL_RANGE) {
+			type = IOMMU_RESV_RESERVED;
+			prot = 0;
+		}
 
 		region = iommu_alloc_resv_region(entry->address_start,
 						 length, prot, type,
-- 
2.34.1

