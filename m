Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C6B19C54F
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480865; cv=fail; b=cNL/ZMkpeySYD9+QjKdBDcWsMQXq1cpGzY6LXtOTTWUiAlQGA7ND1x+sqNLVLePLbx70Hp3Yy/O24yFzNWeluqo+1oJ76r2SqkiNSRA+Q8WcJydf2DCckImTtzV9Luhc7jo4j7CfbsPI5b0mBpaW9V6mPGEOxVII9tCUlFmyOhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480865; c=relaxed/simple;
	bh=iuzGqmY6iJcQcEkpwBJV2OG4JD/GfabbFDHvyg2YT68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps4SmyXVXzN82o76DbJD+WZczsJfnJ3Vo0Sz4Uypmn1s7yVDiaDUDyHe2XboAQU8BxgonfVuyaBAdk14vvimgpihSLWEP8QWXfKTTPq+NSCBAqz4ENzvegDXCIeZzkg56uh0c8UXztn8zqUkXCkcxN2kv5vXZiC66+s3TonkWvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CLoZ5LBA; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CLoZ5LBA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAaPt3/v0eD7OpW7FRFoBSQ18tacCCrbkTeTahLmNAUotR46VA9y5Qk9vyRpgin+hcmz7hZF1sXXHcVAeuKgBQxMnoP/3m4CSBSHlvGEtmC2DOs4JCaJGjVI2+PRk+8/mWG1bGNNddXzjhY3qVlUm2XM+wZbiZTiT3s7wtqcMoxPQmDClEIlNRvyoYtcIUkuRTsEH1LrrYWZUfbfeRDFC9I/dfZLXMe6PGq3CcQKDKcfaiv/a9ZJ5+AMp1YQXN3QjJxmLiRKBL5qUumJfRbm/PFr1ntXTTxWjcxLea8sClex+6aRIbWXuVz5vUehzu63auO9yWP5WJ088iQ/fDmypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MABrEs/RwOxD4f/5BmIz9TNzcUQzh+hxPfd4u2NB4tQ=;
 b=rF1EUYnFQoAP4n4OpOS7Pyra1F/shHLI4ItvPi022moMmkh3YtOPjV5aE0N2zdLqN5AIFRNGRYtA3Ixof06PL6d4MH5khuF/2feq//Noljoj4AliPIwa+hNlzrDnYWkCvjxxn1i5dUMe5s4kIbplwGJ2IBfO8gnOhC1gZmed0/saloyLmNjtBhBGgltg5+NNCJKfpbGe1OSndZsilCYTLYRT3A8eB++TeiTp8YR+mzrtBFBwxolL1LPcvwzZs5uU7Tj6o5FBhSSCe/7p6cMB6jgPT6qPPNeOdWIak4GGZy95HMDjZUKVLso/0fVhpXOxpJ4xw0BosdjjRxR+dUbeqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MABrEs/RwOxD4f/5BmIz9TNzcUQzh+hxPfd4u2NB4tQ=;
 b=CLoZ5LBAeVikEukZmLzDepkCypgKHUM8jwiym+UbBB/evwgc/xA/NS64OmpXVmx01wpi+LYvdr1EstMMBmGlV3Jvgp74A/bhyebriQ2vvmur1XAbv+w+4S4oYGVQCuQz/uniR+JhzxrB5Epm3iiqXfpVEVZMklCaKSVrmwi/Ww4=
Received: from PH8PR02CA0037.namprd02.prod.outlook.com (2603:10b6:510:2da::35)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 10:54:21 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::ff) by PH8PR02CA0037.outlook.office365.com
 (2603:10b6:510:2da::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 10:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:54:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:54:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/7] iommu/amd: Log IOMMU control register in event log path
Date: Tue, 25 Feb 2025 10:53:39 +0000
Message-ID: <20250225105345.52143-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225105345.52143-1-vasant.hegde@amd.com>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: c6013666-bfc6-4c37-b08f-08dd558ac1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZX385mNywo6KBi1P9gCn+4V82KlWlQY/H72W4sfYZCbb+oCjpe6isG6UjgSc?=
 =?us-ascii?Q?w3guOj2ASclOPV6Xg6mC69Ou7/Pb6A4hGJBpWCG116wj27kszOqi5MR5FXoE?=
 =?us-ascii?Q?gHfwvNFrUZ6eYggmBm+esGW2dwMcgZHqIkTMBT4p7AFMqsFxV0jyZfZPg2g2?=
 =?us-ascii?Q?DRoP5a0+Mpj3mT5ix1I2yY+hxDRj3T2228vqTQsP/+3wEi0jQQHke4EkqyDj?=
 =?us-ascii?Q?KAPgxKzb/rKY6nvV0LEQXU+Zwdug33lT7vZ5PLURx8Ho5wISxjLw6CvtYPjB?=
 =?us-ascii?Q?Ph2YQXf3r5p7p7TWM3G7b/6ub1lj0HuiZHD37AcbV+Y1ld4oA+pu/SniN+Uo?=
 =?us-ascii?Q?+RAjUGnkYQne0i5/lHvVI4NJqfS+izcYWtDK/THMojuX0kkcuIE0x/kJfJg4?=
 =?us-ascii?Q?YvJ1jt/L78BcO5gQwTI2mUK6Xfh2TOXNP/cKgmEZFao14/zEmlwT8ja2rRBF?=
 =?us-ascii?Q?kQGG4zZ8bTDY4Yx5ftzt9iv/GEtBgeRZ1eu2uvSn0pTQNp9P+f//YZLnd5+0?=
 =?us-ascii?Q?o81hIFkxwHQhIkQcawDm+JDaCoLQ9VBAYeFNOuYsbVt33dLQIEs/7PzFXE9n?=
 =?us-ascii?Q?vQg4b6cEeRcBmdgSl1b4UJ2+6opzDmnzqJCMb3rnzHnsY2vfUq6FGubWJ05n?=
 =?us-ascii?Q?T2V44baBO9mK6TzXfcUodhDTp0q12ncdEaLmruq8rNzH403q+ShrdYV0O72G?=
 =?us-ascii?Q?k1VJ5bUNQBAKpRMYJR3DfXyTK5gAJbUdKfk9YabdYESxSH3Owi0Bza3Gt3+8?=
 =?us-ascii?Q?ZHErbQ6lH/yuDZSPmJVhlLFa/tPLD7rvyfzax8wkO2ObyreR6uXYd/nf2oEC?=
 =?us-ascii?Q?/OBWQd+fj/S5By8+INk2fjHmIl4d2FXalzWDZVDeCc5VZVADgeg+b6/5iHC2?=
 =?us-ascii?Q?Std5+XyT3+PCmNrG1gyeApQNad9bl778fA40IMVp2yiyohX6qv2GjL4278jQ?=
 =?us-ascii?Q?t9x8odrUxfLx4ENHRrV+xtmNSLMT+j8kiamBzgczjREgIBQSoqL9hxrBWZlu?=
 =?us-ascii?Q?Lg88SuDP+Ui2D6ym8m3I2ZZTfhCPmHrJ/5BFBJH76oO7o2nboroMidyve612?=
 =?us-ascii?Q?smdB6U5IbbG6lAGa9uB6YJKWhejLju7cQAhb43wfh/UcNogqDg/N4SEcKMDW?=
 =?us-ascii?Q?cMLIz+Sf69fA79sj/P9guRaDpesCYtpxsQJlnK3Qt5zK94e+X9Wipj8cwPN8?=
 =?us-ascii?Q?AqJkmXnWfC+kQNrCNPH36O3GL0g3sSRDVEhtqnfxDSAiNqYoqxp1nBnUAjNF?=
 =?us-ascii?Q?w+z94++1lvO1HSQ/lFHZbP4WOInIVsd87B5P1ceuEuke0ONl7VZrp0KYYulX?=
 =?us-ascii?Q?E+CGBDA0YewDsLE0jPd/KMLRIT6raxzjTeajGvACD9Cu3JsM6cZwYqyG6Bl8?=
 =?us-ascii?Q?h92ODAepj9jxcPEAodsh6fhvoBl4xqAahEYrd4Sjri+ES8jy4upWGb2gLOAt?=
 =?us-ascii?Q?gzf1QH28kZDjQ9Q0CAlfF3imtUtbn1xE6UEQe2l3q5mbAwcq9s7MykS3PueU?=
 =?us-ascii?Q?gRI5lYmD7VFdLDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:54:20.2903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6013666-bfc6-4c37-b08f-08dd558ac1ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166

Useful for debugging ILLEGAL_DEV_TABLE_ENTRY events as some of the
DTE settings depends on Control register settings.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b48a72bd7b23..797c8612966a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -868,7 +868,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	int type, devid, flags, tag;
 	volatile u32 *event = __evt;
 	int count = 0;
-	u64 address;
+	u64 address, ctrl;
 	u32 pasid;
 
 retry:
@@ -878,6 +878,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		  (event[1] & EVENT_DOMID_MASK_LO);
 	flags   = (event[1] >> EVENT_FLAGS_SHIFT) & EVENT_FLAGS_MASK;
 	address = (u64)(((u64)event[3]) << 32) | event[2];
+	ctrl    = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
 
 	if (type == 0) {
 		/* Did we hit the erratum? */
@@ -899,6 +900,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
+		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
 		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-- 
2.31.1

