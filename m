Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8394F1D27A5
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270764; cv=fail; b=fgcvIj6Kh+DYSqSlYMRbhOb2GoFKQpt928ZcXiJGCzZDgtyqgQvnMIGWmyUHeEhvkGn6KFsbJE5rZrKR24v7wGeYjaAjLzkyUHkXAr6ojDLXsG3eGehenLMKigz4AJufYndPKZu8dNUOjhLxaskCp/9Ywtp9JahvoMSuuesNUQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270764; c=relaxed/simple;
	bh=7CXmC+kLo82HaH/QqhgkNC7cVRbicGOnywczgNXqTNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NV9fiD6sev9ecZOvJDUd0cSGVNBjkt+bGwf/+65XI2ZW6Ob9GFdAc6L3IU1qiPh+vgu9XwJZ/T7vAaWVTrtDDzambEQlLFLaJVZ2iKaBXbQFY+ejfeJoj8bAVafiOa8hL/lgU/tUH/id1Y6KwQ1E2n18cwpA5EX4nHpgiHN9oPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a5BDXWDY; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a5BDXWDY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISuZCqXE2qgeZZc9WxX9B8A1LJHPtLkmIm8bP8cG7kkUXxiiFY6klFEYqvfjWuM98GmZurpBpdqJYuB1wjyccv3FZoWAFrZFv47QLF9tkjomBME5HTC/QF74ip1jZxMAdvCOyn+K8t5dAL1P1esPpfUmZ3vmG8gquqrqAfJrWCC/KiwCr5oIqh9WaBZiBFWItA3N+KCY8csn45J8NmzDPRq+o4fJlID7yFxDpLXhQCNatr2+JZDbM8YJ5Qol/Ece3fSd/7GD0+twv4kJsXmEtQfMbF9ezIoKRdPV0iiWJl8N+EcALMhaIQbdjApgzgrB/5ZBN7l3q6LAC/Xty01iVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsHGjmrAjuI3BP+DfqT8160pPvzNQMtwu7ofxqu9bh8=;
 b=Kl7qBy5NG6e2sYQ5H2cT3+Wop1/O3f3MkLIpmub0euCsaXVV7WZhzhuytNfNthO488dXyGxMRRjvrgVwNaMMKThSZwHfW2ieF8o3SvMCgRArwCqfjxdWOYRWRio5zre6XVWBQ5Gv3CI1sY02pTuHhrbXYYeZhM+5jEnF4RLPUPV6vQ9M/+XToTSMcbYuQoD6JlLzpjNCWULY7siXBLLUeTZduRiASA87mhziSvjkQCDZZsRFLWpTe5COonEI/bubRHlEGS5WCNVlbpbu/VEACW4MtcNqFrdjOSSetTBB83ul2FXr/vlJAh6RHEOsKBOXTXI0QsckomH8Gz/afpNVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsHGjmrAjuI3BP+DfqT8160pPvzNQMtwu7ofxqu9bh8=;
 b=a5BDXWDYWUsIee0KTo9SWRFbJAn9MqgkvMTZj4tUvnqaSXJCSQms7FA1QfMQLsSdAwcg2AFxafNpZFaem63msG+wbVYzUo7QqouHoGetasWbWKAvnPCvC0AsDosjU+8tDHaCuvk1KTe47G0k6GSXI5Vs0XdxOGKlNZLvIbJKUlo=
Received: from BN6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:405:75::25)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:45:55 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::3f) by BN6PR17CA0036.outlook.office365.com
 (2603:10b6:405:75::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:45:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:44:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v5 05/12] iommu/amd: Remove unused amd_iommus variable
Date: Wed, 30 Oct 2024 06:35:49 +0000
Message-ID: <20241030063556.6104-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd7b1fc-e731-43e7-c00a-08dcf8ae80e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGu3OV7FtNqjAgPjWJiqc5NzAtS2Q7pSVvLk3qp+aeI3PUbM/2w+puFj9/Fc?=
 =?us-ascii?Q?JW3pwtBi38BwMs4J6ufQWi5YbiPFkamsqFGOpQlTWzu630qRmp6ZPbVdumGv?=
 =?us-ascii?Q?MmT97geY0bOoVpa3UuNlC8YVbmfCq4JI29eobAtIRXnPKVpSstpt8Gx++xFe?=
 =?us-ascii?Q?nAmDI/kZcCHMj4du+ONLNGBywYR5uT1ANPFmLZnDCWzGoSRXM6cjfCRji6wQ?=
 =?us-ascii?Q?M5P7j/ZOAHYYzrid3BOugym2RxAg4r/ZNICxeZOovz4BiJZwEegO5YLEj9Km?=
 =?us-ascii?Q?eKmQwdHswZzTEGfmP2BLDqb2lXNi4burVyi3qWMxM2mVEVA1pGQZi7DlB093?=
 =?us-ascii?Q?iqSKNJvfFhFsRCeQmy2WLB034HzfjuvSOirsElBCgcBXU4TaUj9wLdyJPlvg?=
 =?us-ascii?Q?Y9bbHcjXrcI3qWZFgaCFUJvDEiLnmA9ZM3mb9rc8fmTZz05u5gi5Cez75Pry?=
 =?us-ascii?Q?F8OnHl8Ejoyt9fQsmQfomf4JdLARXZdhobpGqxyYGY03OmaGbwc8cjc3wE/2?=
 =?us-ascii?Q?VjDbCqDrMBeKELpB9D0z0PqdXU6CGA73o7Od/WysJFLmxKZNg+70jUWAxZr4?=
 =?us-ascii?Q?NBwg8Md7tD1uzD8d6vNlAKYTskqEM4BIsx7X22O0fpCPNqOjOrrsI8nns0/8?=
 =?us-ascii?Q?jfIuJzrMxcJ4jbYyAHUSIw9WlX6QiOrW5O9yvmswTM/YC8MT/f+YHEpJWM5+?=
 =?us-ascii?Q?IMO6+z9hpBrWRm+OaqHsTSEgOD21Yw19oF0BQCX/IQQgYTPMAjlgo+VxcQkt?=
 =?us-ascii?Q?AUQzajI7K/Owjns/+ZMa32oxblbNNbqik8Knk5UWfTJIw8wBNtmWkLHLuDMp?=
 =?us-ascii?Q?DIfOvywwcmElPQDqPvhGA+/HYkiqpi+7Q9oAFumfkB5BqEFqO6apkGzmiU5A?=
 =?us-ascii?Q?nq9GGFdn8B0kMQFmFM5zGqrN4XxBABlBRJsNVKZHdd0wTAyqHV3DcVfSbrKZ?=
 =?us-ascii?Q?KsezpS82gMRrjPjjzGXGNVqrc2D/gJVgVegbjWbUzRhPeul74Sy0UGOHX0ZV?=
 =?us-ascii?Q?qO6gjVmda/YxyUUgiYf6oZZsDMvjt8C7CmHDrUWzKe3OLySOuOLEbFpeo/sI?=
 =?us-ascii?Q?MUDRhvqvSJuJf2MbAlt+yfPTJ2Q7Nzttdnn1w5hHL3KxdrWOgIRJHxhXb719?=
 =?us-ascii?Q?pP0whXTY4y8aj5nwdw7NEi0p5bnS0t5AQuGSSitXZwC0PIfAwLb+G6WVxgjx?=
 =?us-ascii?Q?moJjY09+qWA83P16jDizonHEgzYrScqAWhc1DBA/wrwy4LW0rIGhY/ZWtJ6M?=
 =?us-ascii?Q?rXh83rJIxBNbbSfCTGO1kMKHyBJ+PafMz0UQx6HiS3NVTZ0Ie92DwydYvyrw?=
 =?us-ascii?Q?Gq20Eurr5qrLYeRej3TLycNkl1PsmBJ6xzpHOedhpSh5Z8cmEXm9C5wKSfjL?=
 =?us-ascii?Q?AuaCGEgV+IPV2o6vceH5JdezSEKMRRO6TjoEhSrGUEz8Avb6yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:45:54.9550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd7b1fc-e731-43e7-c00a-08dcf8ae80e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788

protection_domain structure is updated to use xarray to track the IOMMUs
attached to the domain. Now domain flush code is not using amd_iommus.
Hence remove this unused variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ------
 drivers/iommu/amd/init.c            | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f88f6e4e910f..f44de5f31625 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -877,12 +877,6 @@ extern struct list_head amd_iommu_pci_seg_list;
  */
 extern struct list_head amd_iommu_list;
 
-/*
- * Array with pointers to each IOMMU struct
- * The indices are referenced in the protection domains
- */
-extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
-
 /*
  * Structure defining one entry in the device table
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f01edc7a8d46..faf6b8fd8c4a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -177,9 +177,6 @@ LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
 
-/* Array to assign indices to IOMMUs*/
-struct amd_iommu *amd_iommus[MAX_IOMMUS];
-
 /* Number of IOMMUs present in the system */
 static int amd_iommus_present;
 
@@ -1743,9 +1740,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		return -ENOSYS;
 	}
 
-	/* Index is fine - add IOMMU to the array */
-	amd_iommus[iommu->index] = iommu;
-
 	/*
 	 * Copy data from ACPI table entry to the iommu struct
 	 */
-- 
2.31.1

