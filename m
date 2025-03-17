Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715879D2
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742190648; cv=fail; b=D0NFGbfHnW1zaGNN5Mhb+A7E6L6GPogUHWydUqmwyRcV7mwcawOamN61/go2XIiREqULUkGTYxobwcXSP+fMu1602842+GoTFBicRZ/yyWbByZyqpGQ3a4It7QjWUCyR8m9fZMpeW2oYdT3bujdCTOtvWZWrvSK5PgzDFx9tumw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742190648; c=relaxed/simple;
	bh=jYWFaVwdJLuiwoiM0/3YQQ/3tvnPsSf3fv1aU51v9EY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7qF21nmxMWF7OR2wzLrMOuoKq/MPeX6E0/uyhFlzdc3S/XTXMbUoudfX35mjZv3p0nwnpEFgheTfghO7m2EL9ynJclu9gIYByxzkVV9HnCqQnjon6aIxnx5F8KStvQU7wtHm0BC+FUIcnqYdpd5OaSjFh5p8shKLN+oyYEq3bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UaN7Vi0i; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UaN7Vi0i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k67sKkXihT6qsjwh02tNjp2SwOb4cOspXlh3d+4fTsqChFVwCHHRPFpdV5g47AtLf0q5PeP/lG3OeA6zEcGylFi5Zx7XlpUgAEzfglBwPFq6ce3ufIF6CEqM/esCXAfA8j/VYnJkXqhOZAVTAqYh58PnRnrrwA2vNtQaJEL2FELAgazlPUoepyFtNtTookOdXzfovOspy8nAwLg39xnDjFFXiMDq75myhWdGIf1gDEY6B++GfUo8+ECkUOoqI4RCMX8HYvHQQUuvrvN0OwIa3aRZSmv8w+62+NxPpmTD8LTT4DQaAtBCCx6raILZJmEbiW8LOSg6kY5w4ry7MygwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjvxiGWbsx5NrovU2qPgNIp0MRVnZU8nuonUhNGrbgI=;
 b=jiBi4AHB1+ZesUpNBUTd4x4Nmyfv+4HAKygoxtnrTkarFr7mY48/wAOOvwq4Xr4JhSmSjYKlkRrSlb3kOXKdu4AoOesjh2Y/rRnVeA+zAmNFV1whgO0YxpDzPyPEhZyzpGhreJuDJD4PAsgkBEb9WIuSPyJE/YBCVS4g6ek6QzqDCRFJyEHVOKWnT8Xj2Ldo1t6wV47BJQdhOoh/EV2hCoGRYaAhGPnA0rqmerSFhRHkpF3UAJuy5YNibmn1MFmqvsksEdozBCbq3QhUb2d49vnxY96vz8DL8kW2ARLqRz0f5NwoiuoRF28lZKiccn1vTRfyMfmnDj181gKMNRvAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjvxiGWbsx5NrovU2qPgNIp0MRVnZU8nuonUhNGrbgI=;
 b=UaN7Vi0i5L0/IiqfpU6BK7LwMEZ9C2NFfRjgaxrc9dTyd5eGjTwXxplLPEkeyFeiIp+5VOh+FbuoID6pAM8QejWsEeloVT9K25JAZupndaLJdl4dtnf2HvfHevt508EMGaGt7EzwLPExP0fG2SszuKzrhIdi28y6fg4xiUSlzZw=
Received: from PH8PR02CA0043.namprd02.prod.outlook.com (2603:10b6:510:2da::12)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 05:50:40 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:2da:cafe::35) by PH8PR02CA0043.outlook.office365.com
 (2603:10b6:510:2da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Mon,
 17 Mar 2025 05:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 05:50:39 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 00:50:34 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH] iommu/amd: Add support for HTRangeIgnore feature
Date: Mon, 17 Mar 2025 11:20:20 +0530
Message-ID: <20250317055020.25214-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: d1db9cfc-6876-43b7-aaef-08dd6517a5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dl+VD50/BhGqzYnsQQOaHwkhnwYSiYe6MkJ4x1ZO1jZ4MgY9gUdz5LWK07l1?=
 =?us-ascii?Q?Gnfuu7rAOfd3l3bMXnM05DzbBAtzlPiBCvYnDwM3bUfOD2B6vyiq2uML3QAx?=
 =?us-ascii?Q?7wh8CUpRugtUfJKCJKoFr3DvaJsKPTffOfhmKA6jIHWvu1JGT6wPCug+1atD?=
 =?us-ascii?Q?qJNgXBSuWwJ4QFlz1sADuFNeSgufVWz7BYCqeNd8nsc9r1qH4ZPfTmJ52WE0?=
 =?us-ascii?Q?0HT5mhgo+mvNkxBj/qnn8JFy69pepYO5+7G2ujZg9FttJpPNspt+mJ/EgfVu?=
 =?us-ascii?Q?VvctqUBN/uMKBhjxGwpHF2N7JliXZD9NWkab3Xi3oaRG+Zd7yDTIBOk9LDJK?=
 =?us-ascii?Q?WTdE7UOP905hwM2PlB4I8LyJwK8xaf9ypFhdgUB+lwI/nXK+y848uN93BSRM?=
 =?us-ascii?Q?rZJnFsi2biRzgIiGmF9V6UpMi6JVJhBn9mjD/AIY8MseIUiSLxwA0UFI+HjD?=
 =?us-ascii?Q?BhJzWig2gZD7crSosFn1p9/GPBLddzs+sNAxly41IBiiGKcbLld/XxmvtsLI?=
 =?us-ascii?Q?odknxx5bTKVJVSfLfqWi4S7W3DWJxwwS0q1fiOnbG/yutIG+3S57uSC+D+Rn?=
 =?us-ascii?Q?d5oF0yuXAaLYX4WbwEWTMsgKFCfAoKLUCdWKGh3SJPHQVJRSulSux58hmLlj?=
 =?us-ascii?Q?A2TvwOHOI1ZKVodf7MI6OZrqhv4gEImL6Ipvaliz+kkOVBvwOA66t2O28jc5?=
 =?us-ascii?Q?A7holmNChByRHhxVOGBDi8CsDIWqJmazrwOc4v5vl1w7ONpAwEfQoaXS2vhy?=
 =?us-ascii?Q?O1L7SnXSEwoU/9iIKcuvVeHK5wLCY8W5ckN4708XdsJUn8hBDAmC022kqDTY?=
 =?us-ascii?Q?mLhutxulVlRILoHFBttnxoPZdpf+T2yQKMem/hvj1ajI5ZeoA2GDF4Frlt9d?=
 =?us-ascii?Q?ZbdppZBmoxVJVPdpiYDIkFt7EgfbmnL0gF16xs0+0ZwOxGiVu5id/A5lvq8e?=
 =?us-ascii?Q?undwCVF7otoynsgzqM1/sw8JEsXEoS4N4cC/Dz989qs1ilJt0g0AWpnVlsxd?=
 =?us-ascii?Q?Upvow/ycXZha7uaIWIWYJWAlpfJ5OmoYcH6aHgtVoA+ro85t8GTxq3B5AMrh?=
 =?us-ascii?Q?FS0ntTHTodHRbzAQcJJ7qQqtvyOqdZWlahlgsKCdj1Aosa63UrlMVfN6YY/E?=
 =?us-ascii?Q?LXqdLcKNQJfmWyK73nkaZY8fC57p9Xh/cfFUh+YeTUfa2jbXdB/WTHYCH1md?=
 =?us-ascii?Q?rPn1aSO5CIjLNYI51guQ08GBFsRmUI/fErU0nsFIvmeJBk2Utjf6aEbZZx6l?=
 =?us-ascii?Q?TIvJzYtuVLCDYdZK9eEcHdbEEmL2QYZPVMXKeQiMkqZv1vKQ8pgF4XDhk7qj?=
 =?us-ascii?Q?FNrKKoFyA9OALi968sOOtT772O8Y3XJPiRWjY+VFmKEtbF5XuvUUpPeCNsyV?=
 =?us-ascii?Q?YfpNBnwAtMnrD2ZNwfU7WEBlJsrmzt+bUCeT0Ackf/ljWKO06Gqmw+IIozna?=
 =?us-ascii?Q?MdPskNelMZTIH2FMXWb1fvvr8/XIcFBbdDv74gNW6xiVOTeW2clwi4jHtTrR?=
 =?us-ascii?Q?7qBOMwvMsIr0BGA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 05:50:39.7123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1db9cfc-6876-43b7-aaef-08dd6517a5e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

AMD IOMMU reserves the address range 0xfd00000000-0xffffffffff for
the hypertransport protocol (HT) and has special meaning. Hence devices
cannot use this address range for the DMA. However on some AMD platforms
this HT range is shifted to the very top of the address space and new
feature bit `HTRangeIgnore` is introduced. When this feature bit is on,
IOMMU treats the GPA access to the legacy HT range as regular GPA access.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 2 ++
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/init.c            | 5 +++++
 drivers/iommu/amd/iommu.c           | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 68debf5ee2d7..156eb66caca1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -148,6 +148,8 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
 	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
 }
 
+bool amd_iommu_ht_range_ignore(void);
+
 /*
  * This must be called after device probe completes. During probe
  * use rlookup_amd_iommu() get the iommu.
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..1b3fc25bcdbf 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -111,6 +111,7 @@
 #define FEATURE_SNPAVICSUP	GENMASK_ULL(7, 5)
 #define FEATURE_SNPAVICSUP_GAM(x) \
 	(FIELD_GET(FEATURE_SNPAVICSUP, x) == 0x1)
+#define FEATURE_HT_RANGE_IGNORE		BIT_ULL(11)
 
 /* Note:
  * The current driver only support 16-bit PASID.
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..538af5a7418f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -258,6 +258,11 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
+bool amd_iommu_ht_range_ignore(void)
+{
+	return check_feature2(FEATURE_HT_RANGE_IGNORE);
+}
+
 /*
  * Iterate through all the IOMMUs to get common EFR
  * masks among all IOMMUs and warn if found inconsistency.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd5116d8c3b2..4985855914a3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2907,6 +2907,9 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 	list_add_tail(&region->list, head);
 
+	if (amd_iommu_ht_range_ignore())
+		return;
+
 	region = iommu_alloc_resv_region(HT_RANGE_START,
 					 HT_RANGE_END - HT_RANGE_START + 1,
 					 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
-- 
2.34.1

