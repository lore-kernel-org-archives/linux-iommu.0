Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512CD38757B
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022563; cv=fail; b=qhh3RHu9EdHvlUWHsYhGUN+4IVTcwXRhzIKuorCjEZRtAyRo1dZvEAkevtQDigg1rSe9I1qAOv1FxEXrgn+TC8qC02RhDMH0f7StV9CJ9D8vSgiznTAz1cqyhSALe+tRtP3o5StZW3/9lmphYWBYCMnTW/gTmBxcmGt1Po2Zslo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022563; c=relaxed/simple;
	bh=nkd5OYF/QkQBhwi3MeYWTrFetKxKFMmnZ0VJU1vR3+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAtrf3bxNkZ8cd1+5pn3A0E57vyiMIxDQrB4fHme7ynggOusLLPHxVx9KBl/BKk7ugUfpgBsVW1FCymb78GyJhK9yAmwy+B7CQ9d+7Qh+WGt0aY/FRVM5fzp3DezCSmgCm/g3H+64F1z3JheTdT4rG9LslrXOmUya/6nxISm49w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sbsa74i5; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sbsa74i5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNNdkoHm8OzVLAUUPDc0RMUxaV0qpRtwsoWrvwwSBQc5Pj8/dg/wuVFubsX6yd1zF9Ekz9RmHvyF/Uwto2Z7VAw3f6UfvN9MyQX34V1etuoxWFRavapyKetjA9WMj4SAxJoRfPaJGm2o0RaveuusUVulQfx4J2pH5v6TT7TvcSvpLM2r3d6edezWy9L4JWKIfNuTJWSMT3rkYrFIzP7yTQzYVny9wwbfE74hWOdTun4rAY4A7XYOs9lMINllT+mAV5P+aO0Y4V3WGg1Q5MHooC1H+Om0xNb+XeZ+1WtHpcMpuJyKaz6xJ2pHncvHj04RQA0AqA0wkyEIz2ZHtWAZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grtqdo6j2oEGUG6Ox9hRhExlOz9WmP8G/ErkHCBabds=;
 b=mhvYRCTXAJwJMOM7tUS2gDxbefQvrLkWnP86waEBfvmJvqV8Ptt4X2LHnPBMVGxBTxwy5pfrAiZ3AP7xtNrnxZ1qCXKNwzYyG8dmADvQaV+LjJEEFz6FEIQO+omYNhKeJJon1zyboVUDm93+8sPMEMu5pP7+iz0HGWpqavX63CJpYtFs0cJVWOgx3H+IzwwkyIWKjy33dfWugofiernDA9GOOvM9QkvzcKj66ybNRZmMmegjVborAKdzSse7lChUzAesMTWoTFpuqRf8xRC7KUE2BdUVM5OwNX//WVVhhDvrVNUVlEw1Zry6PmfAhhAwadvurVBFH2zHudYbv8HNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grtqdo6j2oEGUG6Ox9hRhExlOz9WmP8G/ErkHCBabds=;
 b=sbsa74i5udDGM3PrYpx+sEvcIa4PdIFvwCRA1N7ye6b780Fvjb8Kb1p3Y//7xY1DLBSx+84GB/JgrhV2bfFZ6QpWN7FQHrvk+paEN9+qGYSaVYVICTFLfqf1yfLuCVRNx3uOddVc4fBMzLpBvxP0TcXWo8CH8AMYZuT2frI4FDY=
Received: from CH0PR03CA0097.namprd03.prod.outlook.com (2603:10b6:610:cd::12)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:22:37 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::dd) by CH0PR03CA0097.outlook.office365.com
 (2603:10b6:610:cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Fri,
 24 Apr 2026 09:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 09:22:36 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 04:22:33 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Baoquan He <bhe@redhat.com>, Adrian Huang
	<ahuang12@lenovo.com>, Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v2 2/4] iommu/amd: Do not convert IVMD exclusion range to unity range
Date: Fri, 24 Apr 2026 09:22:11 +0000
Message-ID: <20260424092213.16976-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7c354f-38c0-437b-fa62-08dea1e30660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W3NZfA1PXMUKnLs3YhLD6KO5zj8gsSw2/BPIATVwjV7v58gDeRoIa/1M+WGdv42+zsPqmnCH6wATL4c/wrsQcalEiP3leuO3JG+ZHkdoWSRCajWGE4iWke+uhECT2JKUvKI+ntdHtGQFtxpajXQV/IfXlJW6etvJmbPANZ/QCReJIHZZ2+q8t3gnozIHmGFKLCMsThcJVWZ+Kjk6IXmrXRz58pJqBmpeKQm5oDVPf4TGW22ZRlUjbVNbwEjI23LHtoVGtKpkhtV1HaTSqU9Up7S3C95XaKZoDuPPo1AOQ+VQ7ZSxpW7Zo1yOuM/GsLQFAh74PazdiLrV/P6XHmUHJ07QzgSqQYhnXWM6RwLxaDwMJ1PCFuh9+Y2J+BIhIsSFIDsxIwfgyMi9LCBxdHFGgdj8+WxH4iLA/haYN2/giAsVFqcKQjpWpxcBGALw/WEwukctqs07+R5UaEjXhqpmlC9kW+gBbNjx+0qiJrrMcv6+02yUBO9K363ZN+p/TOIyRbgcqisypTdOsaRPyMIbm6fsKWyJtE41PV6ZI5+oD1n2dPqLISKgGpN/6wf/eeUbf02LeV70bd9kGJYdBPOl/i8nNr0vTt1qBcWloYUmSNxSNpHGll9W4wb1aEVCEx8Rn2fe1baxSvgAiTPnwoeRIQ3elFC6mkoUtWD2K/ah4lRGUGZ808WIZdAJ0nWCYPfJbZhyhnpsQA16pub506E1Msi8TnFdKVElMYH3wcVAAt0fMxoll9OnV/sQKY5zonXUjrZbmk7faM5e6e4MivvTWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6+BcF3gg8fUd/xWhXLWOKG7nYRS2zwabN0mtsI/DrEuwLp+yPSqg/MmWC1cU9o8zPsj7Fk7t7MgWcPJwr2yrkSt26iX9Wd2kRlAto9keRM7/nan7MGNjotgLB14ZCT+DB0awfVmCTYOFYIBMFnofdZWkY2ob0DUsymHsnRgZi2YHOCr5yHBCKW0LQgGD5OWvgOGhbMM2IX0HwjRfRqfa4qMP9sYLC9vqcn94S99VkDQ1YGyeCS5oPDQ0EicBYIrzROoChKySPY+hl3PVuInhtf+fYBbEYj+QxpGsCvWxkOtpGuMLyoPtFbHs75y0DonNAxOSORBRHxKS5ABtmnSfWtMeec+YzHqhT13WeqFO2pGG6QpNsnzSexOohMrQZEO7Ian9W3/DRfXDc0wGrsOen/Nx3X4WWZbCEyAmjSvHFm61HDK5kv67bSiBwbP+p1SD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:22:36.9549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7c354f-38c0-437b-fa62-08dea1e30660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894

Original problem was there could be multiple IVMD exclusion entries
conflicting over a single exclusion range supported in older Linux
kernel. The fix was first introduced in commit 387caf0b759a ("iommu/amd:
Treat per-device exclusion ranges as r/w unity-mapped regions") and in
commit 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
, where IVMD exclusions are converted to separate unity_map_entry objects
in pci_seg->unity_map so amd_iommu_get_resv_regions() treated every such
entry as IOMMU_RESV_DIRECT with R/W.

Since the AMD IOMMU driver no longer support the Exclusion Range base/limit
registers and rely on Linux kernel to exclude the specified IOVA ranges
from being mapped this logic is no longer needed.

Remove the special case that forced e->prot to RW-UNITY mapping
(i.e. IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY) whenever
IVMD_FLAG_EXCL_RANGE was set.

Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
Cc: Baoquan He <bhe@redhat.com>
Cc: Adrian Huang <ahuang12@lenovo.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 866249d3673e..2e854f4639a7 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2644,16 +2644,6 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
 	e->prot = m->flags >> 1;
 
-	/*
-	 * Treat per-device exclusion ranges as r/w unity-mapped regions
-	 * since some buggy BIOSes might lead to the overwritten exclusion
-	 * range (exclusion_start and exclusion_length members). This
-	 * happens when there are multiple exclusion ranges (IVMD entries)
-	 * defined in ACPI table.
-	 */
-	if (m->flags & IVMD_FLAG_EXCL_RANGE)
-		e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
-
 	DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
 		    "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
 		    " flags: %x\n", s, m->pci_seg,
-- 
2.34.1

