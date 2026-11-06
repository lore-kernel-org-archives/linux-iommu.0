Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793938684;
	b=RDT23FV3P6FFoBpc34P3YjOLcT6Lhziic02+qQKHSwFBCxz8Hr+5mv+6rIJFeYmgog08
	 3RkwkvdCnG59v9zfYGN1CguKADdvnaxDjB+nx2Sb5Z/62h2SzEtIOEE7dkuBU/5N8P/5/
	 12J7j+ovjJJIYDRot+oXF6AV3sukFkwEE7lu/jWLVoL7fXy7iq1L33rSDsK1ECy/RgG7i
	 1hBwC3RqDfL5zcfLGIUaJkvJDhARUApbG5lEizG8o0CoKQIkosKYK1aJdiEDyj6RFElQP
	 zndhd39kSFSl9rCz6d8HJKdT5+fhR/i8lDC2jjBrfZc6b57Nc7Uc/ERYUI4/3J+LWZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938684;
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
	bh=L7lpagJuqOb9KE1C/A5ROCaftQGesSWIRUfnDe8YwqE=;
	b=DOyBeeIBvb05qgolAUIYBua/1lvs+9Ur0LexsyK1HJ5BtRxp+YMAmCDkJ8VattLaDEpi
	 p3861hWW9cuPC8721uD9JkubnqMZsb0xQFpGJRkP9bVy5lFCLaP7fVc6KuUDFzjTuAbqq
	 jk4Af0n/UQX/lvIBiui7u+IV6M6ngzqLAbIeRTNwdoeVWpKiQfAGsv0ELUIUjWn7Vpe8N
	 WmnzoGZlPHJx+bRZDOy1QtIExcBNmfMuZPkHBbg94bNMhBS2kucJNCFtSL7f+OaOx2lam
	 tsA3S7RUn3bVw+QJ8JCIfxHldRE2JRlHQ6o+rV1LGOuB2IwkcwHHRGDlM3Z2pPcvaBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z0LKEulG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.63
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F4606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 04:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2F4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=z0LKEulG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfSB8yit6SLBTtv8HJL/FJDrwMYkKiYmbZ7eQ0SHBfHFrLSMdbMPUoIHvOwUgN0KobBkebZ00lGpZnlzLkh1kFCpuzBdygvcrlRsSc3cg0bXQ2CalVP8D9iYQNGhtIQ5y6XL90AZk3MYCsLUM7nKB5XoImi/mokh18mfvULEaxS/I5rLginPgO9kQ0cvZlyONcK2G47HdON4pzGyAifKYkkJyjWujNbw5dOaZySYDcAysyGKwVMw/AgtMjisuOD6d32zNNs91wcqwLqa2Qab4qylpjm+YNB03tNEnBdWISYZaF3ehQuOQbIuwphl8S9EADp+jiLLquBDAyFMn3exiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7lpagJuqOb9KE1C/A5ROCaftQGesSWIRUfnDe8YwqE=;
 b=aCHWF3bbVzNmmr2V+Q0r6+IhoLcFPqKEtrlMYYHVHPU9Hr+UYeXBWD95iSMVMoBpzhZ3ZfzaH/ARFZoQxJjPxKC+dmtw7qM8G6Bic9CsPtaE173go8BXXPcey7jDqt7I61yc8iRqwUoh8hER2OE9WFFf6EzUQWEHxUBy/mKfqxbSSIErA1NVTWqNXiShuAj1r47ctgOnN+jxMv800phK3/6vJP92Q1VIxhj0/Vv/YcSg1FoX/GgG23PNlGiNXEJCsuoMBa3POTQMm0RDFKqa4cnjgqFOs8xsop1PQ24NaJykEV9gzh0+rlGo33belTXFAbAKIYGP2f6lBDhGN5vQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7lpagJuqOb9KE1C/A5ROCaftQGesSWIRUfnDe8YwqE=;
 b=z0LKEulGLZnRbDeFLeFXAShnwHq3JNaSD6v9uY0h0ejgfMTEuDj+HqK7dmt3VdVjCaAp37EP1+TCnrXjgd5Bry3Y/2MB1bJa+DOpVn7H+xy/jto09OavVlEuhAUhlS6Frc8MPa9DlGqAunfANEQlQrI6f5f5lgeGa5ZI1Py2IZA=
Received: from CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:17:58 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::95) by CH2PR19CA0023.outlook.office365.com
 (2603:10b6:610:4d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:17:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:17:57 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 22:17:53 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Baoquan He <bhe@redhat.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Sairaj Kodilkar <sarunkod@amd.com>, Adam Pelka <adampelka26@gmail.com>
Subject: [PATCH v3 2/3] iommu/amd: Do not convert IVMD exclusion range to unity range
Date: Fri, 6 Nov 2026 09:46:49 +0530
Message-ID: <20261106041650.24076-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106041650.24076-1-sarunkod@amd.com>
References: <20261106041650.24076-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 4502a340-6a78-43eb-73a1-08df3bbcf027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|7416014|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006|261026140227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	ftd7VAu/TivtvLU98dlHkdLljMcCoaLTl+mCc+HFqZUB2L3UPeJSPSdSMncRN+IwHgWsup+Z/GCVG+/F2Dg15DOG8iACyYDmBq4Ed2N7UhzLLDaKpLxETNoU3sqUXcbXe4tgGEFmAYIrVL0jpCZyPKyAA7sWoFaD1wadIabtZ4BdpEsHM8EsTTlaxOmfHFpFoCLK4DrMX1Tpp4r735EpY1lIZVkhQofiCydPoM4tGCNpDxUkprbKTdyYjKxq/3hQuZN8D1fzVQBdxp/i/UwQH2USSTq0Y4si75PlQko4kMF7nZEeQSRWROIbHmMtUMqb0RRXTADAE9YeP5UlN4idrnxnW2jUry+GJkQvGdvO8M91aplvSugEQ+w51HsCKFmUk4UPVxYTa2mtuvDHhi2bh2wg9hmPD4maEM2jF8GEAqo7aOxtpV0EUx/5MQxwGCc+4dCYprcymYkHZBjnJy8nnDyCV/KjxAIBIQvBGKAmcWl1AgCn3MSIamWBc8iVh5d45qezprswGapwdLofD/Byawe2RqV3dt9aJEl66yC9PIyqPuIyL1rj3n8F/iX9FzQ9Vih8WvfyJjXeYEwM0jtZtR5f6KzMGTSWY2UUEKlXbNA0bwF7VQBcH3Ziv6vunFUI22EGOQVcpwc058yntUdKwWv/gdReQPdkUDpUW4CqLeGQQQCOhLXE18EAgxmOvkMQbHVdfAeJpYNL+Y94ApFipg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gpt9eSXWbWLhsa1EcpFijFdjoqW2teyMlK75cUOIvuC2f91p6TKX3LYRNtMQXZmJzP2FugGJ8JjyILuNOR9DqU2h9xE8ro5gKVWZgXrYVfsFj3lonY3QnC5XHAr4fiKkXv7bz4aoxUaQXiDd1n6ihhrEfgadoZ+E6lh5ANe4denxCusqvBBktupOYIfzBqIToHIK+2MxYB/P/nlCvTAKXk/1ZU1aVI68iK2LwePuhPoxAJqutr+nVUAY0I2sKTaabBtqB+PH4IQkItjeXC6uJc918E0C5j82WchgFSKIRS2bMtKc2l/haoD9uQ24wHdghyLsSM5A2MLNwDE+anOgYqYrw6b57I5/6T7GLdrS/+4dvJT/zivgAwnAljAH7sF/aDg7dr72jWm0eHjJjPfQcR2irrtqHzryA2clNCKnOlk/QON7/fD5TeoeZGIiykZI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:17:57.8374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4502a340-6a78-43eb-73a1-08df3bbcf027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

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
Tested-by: Adam Pelka <adampelka26@gmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 +++++++-----
 drivers/iommu/amd/init.c            | 26 +++++++++-----------------
 drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++++--
 3 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 678ceddd711c..bcb88b476167 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -368,9 +368,11 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PROT_MASK 0x03
-#define IOMMU_PROT_IR 0x01
-#define IOMMU_PROT_IW 0x02
+#define IVMD_FLAG_UNITY		BIT(0)
+#define IVMD_FLAG_IR		BIT(1)
+#define IVMD_FLAG_IW		BIT(2)
+#define IVMD_FLAG_EXCL		BIT(3)
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
index 13c96feed64f..1f0ca675df1c 100644
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
@@ -2636,6 +2631,13 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
+	if ((m->flags & IVMD_FLAG_UNITY) &&
+	    !(m->flags & (IVMD_FLAG_IR | IVMD_FLAG_IW | IVMD_FLAG_EXCL))) {
+		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Unity set without IR/IW, ignoring\n",
+		       m->type, m->devid, m->range_start, m->range_length);
+		return -EINVAL;
+	}
+
 	pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
@@ -2665,17 +2667,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
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
@@ -2702,7 +2694,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
-		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
+		if (m->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_EXCL))
 			init_unity_map_range(m, table);
 
 		p += m->length;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..699b5f530f11 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3120,12 +3120,29 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
 
+		/*
+		 * IVMD_FLAG_UNITY, IVMD_FLAG_IR, IVMD_FLAG_IW are ignored if
+		 * IVMD_FLAG_EXCL is set.
+		 */
+		if ((entry->flags & IVMD_FLAG_EXCL) &&
+		    (entry->flags & (IVMD_FLAG_UNITY | IVMD_FLAG_IR | IVMD_FLAG_IW)))
+			pr_err(FW_BUG "%s: Invalid IVMD flags combination: %#02x for sbdf=%#x. Ignore IW/IR/Unity flags\n",
+			       __func__, entry->flags, sbdf);
+
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
+		if (entry->flags & IVMD_FLAG_EXCL) {
+			type = IOMMU_RESV_RESERVED;
+			prot = 0;
+		}
 
 		region = iommu_alloc_resv_region(entry->address_start,
 						 length, prot, type,
-- 
2.34.1

