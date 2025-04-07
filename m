Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD2218EB0
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047370; cv=fail; b=gQwlJar4fI2ymux1Q2QCjGQLW+6xHtIsejo6+B5DFLySh5eRKVLGvu7/YVPPWis72skkqEzujUHZA5b2/Y7lmuF94cDer85BS2IULJXoviJFhX62mFuQ7Bnujun5TiPb12J5zBOvHv2KFzD59e4gsB1zVamRYEZ026jqG/v4FJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047370; c=relaxed/simple;
	bh=LgeByRLTb8GhvL0yrEuXii+33GxMwZ6tho2fVheu+NY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMZd6lOr9izgNCHwfH08+GPHp/Qj8Lsf/204gjru96Q8oQiy9iHX/ZSv/lrElTpeOOLbKve0l+GRylS7nRVP0bI13fPR3r9UXYPag2Ss+lQDQzW+ikwTjtJ7LrgrkGaggYKQ/s7sj1FF0tYbivmMe2eahEfbG7fJ3cXdbbxSYO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EfPmbb4F; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EfPmbb4F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoCzWapZHGrQOzuF1/DoVOrsnzBP14FQI9h9/LdYFPT9DOxdN5wlQafaOS1pBXaOCYtx+AXLey5CPbh4C1wuHswE9ebVZwYzV20CWk6YDNEDa/uXumqjwORlGWfFRl+Rl+7MkqrD04mdnknn2Lp137/ZsysJ2DvhbYJU/TauufQlYBdDs7WnlfiwbMFflYdbZnkkNFjR5lhrCjmGXgvOL6uxU+8szlQ98oWABEMVPr2KRwz1BrcyGpS//sJ3HQXHG0VBwI21nK6b5iiMcv/iU+7N8dlDk4+9PpYtKd4n13wM95jIVsU78KPwIjNmPYnc06YbynDLNGRt0AlC/qajSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32IxnpKd16mrzFr3au1zbqy9IQgFdl+wg6kG1m+lRhw=;
 b=u3YglS2J107GlZoTluHOcxUbK01aI3VAm2tHv0mFPvegKGa8WTmH/VCxo4XyTxlOBnC/ULTFJgNm8gekWpuu8AIdILwJWXjgGMAD6yUifUF1p9Osv+WJffvn3AGRL5WLG5eWXCMBVjPnCAHVUHyWzdLyoSKKUoia+8l79xbhFPhIYbS1w1YR0pQLFTZlsF0Bwg2mqYXA2jjDPToi98VFl+a6Y90XC7F91DyzXqPewyWOFmAvX0+Ip62ybL/h0VS22a1FeKr3rHjzs5iPKsfl8EVwouQtCPjYBO+YQOg9w5NpIrIkgF3IvyZtryWExjLg4fBX6wSLIR3VPfhV8vtAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32IxnpKd16mrzFr3au1zbqy9IQgFdl+wg6kG1m+lRhw=;
 b=EfPmbb4FVvZXX6qOs170K+VQ4XX77vHq27UsJl6HQ+fOqbAi5P8clYR9qb1Uhf+Dxzhecim5yVI13adr175TFJRjMCUgGO2+4rkXLYt+IP8XponrN1LFHDnOkOnQJrNlKVq375IbwxEe3Ox7Tt3PApkxGhXiKjQEzZMjw26hPK8=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 17:36:03 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::94) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 17:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:36:03 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:35:58 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
Date: Mon, 7 Apr 2025 23:04:54 +0530
Message-ID: <20250407173500.1827-3-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: f06af1a9-2d14-4a11-46a1-08dd75faab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zg2ZbZkD6X6EuLvZPcVOWOAyYBelfX/kHaTRUXbyjrNCIitfgw0c9CLBS/+X?=
 =?us-ascii?Q?OSYw4ruQZOOVAbVzZvzwiC3dYlyMT0xNxHRsigGktt1oLJmTXBqeOqucOoWR?=
 =?us-ascii?Q?MQwDkBTpSsmx1dKEYClBXAGPQvX4Yl/xNbVumX2hxv0OS5KRcsFjOP4fIjae?=
 =?us-ascii?Q?T0rI0UTTBY0vh1raTSUmqFVTyX3FHQkXqOjiYMJUPzAMmL7MzzIoegW4F5im?=
 =?us-ascii?Q?E4J+okk4478slcFZcjONelwT6yR9gZHj+wqD59JWuja+OrcfRGtD7K5VFn+w?=
 =?us-ascii?Q?fchBxp1I1ZjZAoxznJcMyICCNK2ewX8DfzsZctTSyqI3mmjHnnqzElfvd7aG?=
 =?us-ascii?Q?CnOnDUAZ97YtrVnyOeIiTpof55DmrvevqzpefKoTHAbuE9nwgU2IWPFAEGo8?=
 =?us-ascii?Q?3PzIG3b5z998oTfrmYG9q9kmqSsJEDzVoMq/H3pCGuOYyvpLUisMUvNup0TC?=
 =?us-ascii?Q?7eOkBSHhtPfiRVgjt6B8TyLkqA6izYlJCa4AJENfcei2h9V4r2Dj8aIc9mWa?=
 =?us-ascii?Q?aNdVLSrGOftme/5NpiMjeE2dIh2608FRs/CYidJWUK1Oh/g6BEE+4e6gVqww?=
 =?us-ascii?Q?V3v3D0r49UaZjcCyZQG5o7LCWOlsJM+n+Z1WBz2Kvck7yqY7AGg8Aif7InRl?=
 =?us-ascii?Q?GBWvlHxFlNJw1TYKy8gO0b57Uo7K3TrsMlzVoPTR9cCGoYDqQ5bBqh/Rgrmm?=
 =?us-ascii?Q?MbTd/rY4YQHVYeIoJebGphY52MgulTme31B3eu/gGPkR+id2GnVKnoitRIky?=
 =?us-ascii?Q?uLnDWDC7qXypq5Tj3cZz1sX8JDeIFdacpHzSEfpm1WuXqis6k7zJsJ9ZrfJ0?=
 =?us-ascii?Q?kCsnxvkg0w5vDZQPnZlpZzFwTvdaYH3fpPb7C+av7eebV91Msd9AZibzKvTn?=
 =?us-ascii?Q?+GWuNjnGcyL+hfz++y1lUED5KILoIeCT6xXTQEBqQnTz2eh4u+4saUdg/5yo?=
 =?us-ascii?Q?CMkRrepaw0sozwz6NMdvO7RBZu+nvehmkb0lt9AArzep5IxsOTZ44jJSgEAc?=
 =?us-ascii?Q?5yFyPqmvxVSw0hLxm0U893DrfJ2k9LZl/MJ10J9lv6gfLcc11AUBOEEp9CiQ?=
 =?us-ascii?Q?KkciJEqOomuHPxX9tUw7iEyc+l9vT9cw1dx70NqJTNqyAUlYXoI4CHYwWxlD?=
 =?us-ascii?Q?Zccv97+J20WE7AT5M6wJRPy2IMp3qQGNdCO+dBuG3hsNDMUmZDP/miumn6hg?=
 =?us-ascii?Q?gFKRuBaPblc/ugcy/OKC15erxeQZjMZC0uq7efm6yIZz1TLhDwsMPSs4sJlX?=
 =?us-ascii?Q?DiD2lfG0Ukjj6FRSvRPDz1N1rYIoCBa0p55KG163BP8a8/OyVAaa7yV9QVT9?=
 =?us-ascii?Q?JhlhNCZ3XkiogYEahuIByJyOHA3KiVq5IThs0GPdHi3hxSaBh9BnYYefWkzi?=
 =?us-ascii?Q?3r72Nq1jdFPYfm4gSsLYl66/fCCMaBqrgup2UVrFh5T68Htihn6R5rda1kgj?=
 =?us-ascii?Q?Srb9mDZ3xsZM+KVP6fSiI4CT0e0yrfJKOH0OaoN2g18wX7AoVKK7wfDsswgA?=
 =?us-ascii?Q?kKZPjX9jvq3KDbw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:36:03.0799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f06af1a9-2d14-4a11-46a1-08dd75faab3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556

Analyzing IOMMU MMIO registers gives a view of what IOMMU is
configured with on the system and is helpful to debug issues
with IOMMU.

eg.
-> To get mmio registers value at offset 0x18 for iommu<x> (say, iommu00)
   # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
   # cat /sys/kernel/debug/iommu/amd/iommu00/mmio

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/debugfs.c         | 47 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..7cbc25eaa74a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -794,6 +794,7 @@ struct amd_iommu {
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 	/* DebugFS Info */
 	struct dentry *debugfs;
+	int mmio_offset;
 #endif
 
 	/* IOPF support */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index ff9520e002be..520377ab6731 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -15,6 +15,48 @@
 static struct dentry *amd_iommu_debugfs;
 
 #define	MAX_NAME_LEN	20
+#define	OFS_IN_SZ	8
+
+static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct amd_iommu *iommu = m->private;
+	int ret;
+
+	iommu->mmio_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->mmio_offset);
+	if (ret)
+		return ret;
+
+	if (iommu->mmio_offset > iommu->mmio_phys_end - 4) {
+		iommu->mmio_offset = -1;
+		return  -EINVAL;
+	}
+
+	return cnt;
+}
+
+static int iommu_mmio_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	u64 value;
+
+	if (iommu->mmio_offset < 0) {
+		seq_puts(m, "Please provide mmio register's offset\n");
+		return 0;
+	}
+
+	value = readq(iommu->mmio_base + iommu->mmio_offset);
+	seq_printf(m, "Offset:0x%x Value:0x%016llx\n", iommu->mmio_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
 void amd_iommu_debugfs_setup(void)
 {
@@ -24,7 +66,12 @@ void amd_iommu_debugfs_setup(void)
 	amd_iommu_debugfs = debugfs_create_dir("amd", iommu_debugfs_dir);
 
 	for_each_iommu(iommu) {
+		iommu->mmio_offset = -1;
+
 		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
 		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+
+		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
+				    &iommu_mmio_fops);
 	}
 }
-- 
2.25.1

