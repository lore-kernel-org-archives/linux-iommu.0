Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795773934;
	b=oTq84fk+odCGNlC2ScBl5MjEKDhvasiZ/SrVmiO7x4/Y0i2paLchdOYUbFgGnnT1EM4Q
	 pqLeVdWVh9hhWj7gs64lGMHA4nf9GAJeBrQCQwVLzZb2XjBGmIEOITxt6hErx+q9nhFiN
	 RGk/nEnllR3M4Z3CDBVgWL5dx387PfCT4Kvt8iaOZPxnqGUe9nu+H/SUyM/3fY+BQztqB
	 18PvI5XtobUS6SdG1tKm02eq21k5pRNDqknK9N8q3i+7EwyYq1wF05FHMtkIgUWa9gmZp
	 BQO2JPD3N/uSk9RA4+VAUfgX/lEbd4JgPoNIYBssPcr0zVc9KKv89qUe/bRscBIrPmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773934;
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
	bh=zvW7OCQGIqyeLzx6aVF7reSQMfXe/cHVr2GmaeecJts=;
	b=QAK0eHwux/h3Gf7S0Ug4OHn3pbOka1OlrsnZdH79sRjvZrjRlOsqnr0cSU2pCGQSSWFK
	 pzOojnWACSgrtyA34x+wpyMTB0lzl6m0RQtEMvngBjVIsXo4/qQpaoJzb+gco75FWSrU6
	 CdwhmdnQRI3Oz7DMsFrBGBD2tOYfs9qu3C3hENWZJPDk4jwQX6X3+HM7myF0Peu05bR4b
	 UVAWXTJfLF0UHut+EJWhYbB5dX9yqX7r4xjKW0EGr5ArbELgrqHyCUUXZ3f2mcHFbe+se
	 wRQ52JlfO8sfqZUiHcqU5lRA5UCczSkb70cY33bPZqa7/q0NpKswZbVTZ6Ol0SofD1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="Tr2o/0+8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.70
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A4606A323
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 10:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A12A4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Tr2o/0+8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrtREPLLK0DuFgMri5NvL2ZUYFE102S+VXmH8ZD/lmwRWQV+R3o7//AB/K3b0C7znwG41GZa79FXGcePbX1Di53i2YFypwr0eWsbjscx+03ik7am09cbIPLmW9r2O4/By7JZd8IJqAPVxa9z5l8mNIXjfnrvOuo7sgGIr/pv7nATKDHGlIXGlSyygRUlas1TDRxo/v/7HTjErKNJZQj7Cg69LaJjlO3AiqJAx2luUo9xFwKRxlMDj5zC4PZv9k1kDHPHwuT3m3/6rQVsvfuzGL77OTGQdGppuq6T9VG38y+5XpwEDk/5bKC6z1gm1FIB6+1NAq4kCM4PLj9gVQcDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvW7OCQGIqyeLzx6aVF7reSQMfXe/cHVr2GmaeecJts=;
 b=XLndI0RILMLVXsCJwplb+jgO4N+QKtkP+h0EKJefB/IEt8gh3Hkqkewdi2YrJJtdHn6lGE8StUWf83YE0lP+iqEDx4ubb+B4Yqsr6UhVUGbIG30WeqfEmuNIgy51In+sOHWjYUOU1Nl7XfZ+bLzV022hls3QbiovNxz3F5PUlJIIHGlDqGNWjKpSJYVfLdG48I7HJXJ0EWUohRz5J9EqwK08kcL5S74t4M0XACygQhKzHY9lojEq3P85ylNJDXWGdPaxkxELreRvoVwrWklI/MpgNBU7ICjpp/slgCwHmsGa+aoqnPecmrMy2PErceIEzRor+GJwj94LyDHBkExPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvW7OCQGIqyeLzx6aVF7reSQMfXe/cHVr2GmaeecJts=;
 b=Tr2o/0+8hqEF/zl53prRzRsUA7Xw5EqPxss2DZ7Hphb3+vhg1OoNrTlAwy0LKPYW261YKsRG0atkgpoIeQGIAbyGWpprIkgWg8HP67zk5MTQCiDgP62WIWALfK//603AdTlIT+mvN/1T+GjBVvnYKCrMvYPYsVzc+A3iamxXQ30=
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 10:05:26 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:610:cc:cafe::83) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:05:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 27 Nov 2026 10:05:25 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:05:21 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, <Suravee.Suthikulpanit@amd.com>, Baoquan He
	<bhe@redhat.com>, Jerry Snitselaar <jsnitsel@redhat.com>, Sairaj Kodilkar
	<sarunkod@amd.com>
Subject: [PATCH v5 2/3] iommu/amd: Do not convert IVMD exclusion range to unity range
Date: Fri, 27 Nov 2026 15:34:13 +0530
Message-ID: <20261127100414.6980-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127100414.6980-1-sarunkod@amd.com>
References: <20261127100414.6980-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|DS5PPF5C5D42165:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbc9bd5-1780-4c5e-0e3a-08df4c6df540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	g4MlJzWcS6ItMIcHMI/5pWEee4ezX3gDMuHw2qW/dZRqycVrMvdbYxfkUk3j2s4MnAY5pXhhkgNCpVnUcRjlcqfKLq9pxHeNBoIdQuZKN0pk1xjtkbxuLjPhflj59Le/7wxFSadph3AuM4n17+iDnPjAJaSVn/NbxC6TKQJkFiPbF3jXd0n5P4ok2hwkZyeM6kl6NjJhM8h+HfrtyEGpMRSkvgSr1kN264Hyl1k3jlu4fMIub+yFnIrDE8/eqzJUIh+xx2F752xWtUJ15A2oTL5O2zu5JI2wx0sYDINyCJOPoHboF4BlEr9V0QcDWM0ANu1gJuHareBZIWYhHihdaezjabu1xUFHozJPIt0Jz5mURKqI3OiKH+V+haVxY0pvlwYJ7GZBfNpm42UKYNUMgBJlQTQPMJFg5/3e+fNVIckl3eVmTkPyBV3UpdS0qAQPqodzAGJDkJPOPMQeB1UFtx8VqKc/79bwxXAqmN5HyPOy+dahEPUcpEfrYlUsb7aBf/lvbJdPJdzM8Ruqe8cMgfPDAMhs85t0aJEgbH42gVgziE1+SN0jpYgSQk/VChX5ZsCN0jAvsddtmTRcpUNMk+80E7pvgvhgt73MRUPKRkMACNXj421Ve6GDp7LYwNIUz+mfLgGze77nHg5LrNJtV0BcSKMBJjZgIsTVliy1/cXGt9OLyCUHNOaz9G3a2vfKbP/k/uvGBBfW0fnY3WwMWw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tZy2JGFRPCnyscAUX1T6pvqSbspaktgMWIm36uNmdv+WLEuyldSWbWm/Md3GJj4fXryFnsnkTRvFBNbOjRH0mesKC6WgPEG4Bn8Z45HzOohoi4d+9T5BE8W5D2oiYKfMhtAW58g1gmeE+2hbI7BsCLfTOLh7vtQgdnP46SXidF6NKxaws8JGkPUWgHUAtXpsqQh3261iAIMjQJswLFoUcKXf3leU3sTOzKMmmiX8+/TlLqRRDnBKLivhQ7RKH1ffvjg8IN2d42W+ltuup3tCpRef3AIg49rtedNZahNzDYv3z7YX6Wdkv/HrII+u8gTyvFPXGE7tGdGfqn3iTY/cv0epuqZBIz20eUfLyGrWH+CuXuGfGM3on+CDTRCyxuE1pVunfn3XyiGyK+vo6DQVYFVOjrrM0v3A0lVmlrZjMjuvvp3spxtUn2DVRSQo1qtq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:05:25.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbc9bd5-1780-4c5e-0e3a-08df4c6df540
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165

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
message, and entries with unknown flag bits. Warn about invalid flag
combinations.

Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
Cc: Baoquan He <bhe@redhat.com>
Cc: Adrian Huang <ahuang12@lenovo.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ++++++----
 drivers/iommu/amd/init.c            | 36 ++++++++++++++++-------------
 drivers/iommu/amd/iommu.c           | 24 +++++++++++++++++--
 3 files changed, 49 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d1602144c160..0f4c3c65188c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -371,9 +371,11 @@
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
@@ -890,8 +892,8 @@ struct unity_map_entry {
 	/* end address to unity map (including) */
 	u64 address_end;
 
-	/* required protection */
-	int prot;
+	/* IVMD flags for the entry */
+	u8 flags;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f8cf37a471f8..6d92fb5c81a7 100644
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
@@ -2742,6 +2737,25 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
+	if (m->flags & ~IVMD_FLAG_MASK) {
+		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Unknown flags\n",
+		       m->type, m->devid, m->range_start, m->range_length);
+		return -EINVAL;
+	}
+
+	if ((m->flags & IVMD_FLAG_UNITY_MAP) &&
+	    !(m->flags & (IVMD_FLAG_IR | IVMD_FLAG_IW))) {
+		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Unity set without IR/IW, ignoring\n",
+		       m->type, m->devid, m->range_start, m->range_length);
+		return -EINVAL;
+	}
+
+	if ((m->flags & IVMD_FLAG_EXCL_RANGE) &&
+	    (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_IR | IVMD_FLAG_IW))) {
+		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Invalid IVMD flag combination %#x\n",
+		       m->type, m->devid, m->range_start, m->range_length, m->flags);
+	}
+
 	pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
@@ -2771,17 +2785,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
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
index 41ee4ad1dcf8..a417bfce0c89 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3153,10 +3153,30 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 		type   = IOMMU_RESV_DIRECT;
 		length = entry->address_end - entry->address_start;
-		if (entry->prot & IOMMU_PROT_IR)
+		if (entry->flags & IVMD_FLAG_IR)
 			prot |= IOMMU_READ;
-		if (entry->prot & IOMMU_PROT_IW)
+		if (entry->flags & IVMD_FLAG_IW)
 			prot |= IOMMU_WRITE;
+		if (entry->flags & IVMD_FLAG_EXCL_RANGE) {
+			/*
+			 * Each IOMMU has only one exclusion base/limit
+			 * register pair (MMIO 0x0020/0x0028). Older kernels
+			 * programmed that pair with the exclusion range,
+			 * which assumed at most one range per IOMMU. Some
+			 * buggy BIOSes list several exclusion IVMD entries for
+			 * the same IOMMU. Writing them all to the single
+			 * register overwrites the earlier ranges, so they
+			 * were lost.
+			 *
+			 * Reporting each range as a reserved region removes
+			 * the one-range limit. The IOMMU core keeps these
+			 * IOVAs out of allocation and never maps them, so any
+			 * number of exclusion ranges is supported without
+			 * touching the register.
+			 */
+			type = IOMMU_RESV_RESERVED;
+			prot = 0;
+		}
 
 		region = iommu_alloc_resv_region(entry->address_start,
 						 length, prot, type,
-- 
2.34.1

