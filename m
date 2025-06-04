Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795071E6DC5
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055088; cv=fail; b=Cc2gx9iJIUVXPQZLC4UUZxOch1Nl4eejD+dh6xIdDorGi9eaYgt7BhL5aWX7PSHLVk/vBXriZ5/M7bMkJXp5HkZYYKmjJhbX3/NCgguwQsOizqVRbTqcCYoun4h/3f122QA5dmG8f2siyYDLn5ey1LKyKRh2rLlMvnUdEm7K/Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055088; c=relaxed/simple;
	bh=VmpqOBYvfyyu8PG+/jbvj0tq3TkSFEqPkU4KxvHoWpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL145vzcBAMl/Xc0zdMZjGWSYTaRjQQ78HNyN4P0cUQELMbMp5KXByKoIC4m9sb5FV225LBfHTj7h1Ml2D7XjzN0jsMaqIEbm6pTxS5tFPpisojgDbt6dQQEkwHFya250PyrPzqUyFFvsfxHbAV1o43oiXHzzD4Of3YODBucDyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qff5nev/; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qff5nev/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGYWQNdpRQU06HOk8P9IADn7+Wd1qaDjyrzKTKUhZCDaV762DwD4NkLeVmR6CX9pfiIvZzdm3vNzFuVxay9SjAUn+f57XYlK1J+W6qVTU0fNVFvmK67CaC3+mSQgTjC+Uklce/BVNOTVEodEazvKcl7++zdTpg6MJ1IqFmB2W4KAgjyOTxJo4yU/Ef0vhWzVDVvobNonroKULoWWHK1ztQvYvrrQLycStHVOncWuPkGgmuW2dOeR8X+tZIMi1IRk1wppjeyGHlHl344VnuOFmTkyMRY7ZAPdqxKpIztJ2Tl/gNjTeVdXIFxE+keDJVfkl8SMGN3/uUprrHgQzGjVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/Xn1LSFfluE4CEwT5l5JsDcdxU1GNKDIqy2Eapn8Zg=;
 b=vMxJWBaOLK9YBycY5LSXng0q9roGIiHmWX/CpzvfT+WLPdQjt3OnYxwHHn/1tjtUiL8otBFbDXS6T/e+EHaB+SkLOyqSVAhQYyCCfMLfUHueFAstQBMmrz/PjTXm/+rMyKNhs92iaj7FwCLGt3JvPGacxyni3fp6HhMRHw5LF54yYfEo8E5BovjpXVROjYQOcjVF+WbB6XccSxCYDMzXPgVinFj4itjORgzguFQkDcnJa3TBe+nAJAToRNtg0d2rc3qdg/oEBMaRV0ILruXetL45b1FmA3TRNNW5FwHIWlRc+TNpxhS9kLYe5X+O6tDI8PjK/6eVra7tzMdtd88nLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Xn1LSFfluE4CEwT5l5JsDcdxU1GNKDIqy2Eapn8Zg=;
 b=Qff5nev/4cP1+4UzMXBLkDq8466DIMwmY3Iv8V/ppQpuW91+shOqUpioMXK2lORM6GiFzl1qMhdueut1tI6AhuDw6KoET8tZcxPxBFFYLmyEr1LVmyEvnfNCOgJmSJgHaDOKo2DXVCYBxkhKfc7QkO54XdMVFZElknTPj4SsfXE=
Received: from BY5PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:180::16)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 16:38:01 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::6f) by BY5PR13CA0003.outlook.office365.com
 (2603:10b6:a03:180::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 16:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:38:01 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:37:57 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 3/8] iommu/amd: Add debugfs support to dump IOMMU Capability registers
Date: Wed, 4 Jun 2025 22:06:42 +0530
Message-ID: <20250604163647.1439-4-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: b9234d04-6a51-4a7f-0f7d-08dda3862be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/3WFWKr8JyX03uViQhw9F38oNwfFUg1xm6g2n9fSQIZt8gQZxqIk98rUgur?=
 =?us-ascii?Q?a3pnH3vEmF0C3AE7Ut5/MqdShDhXx/Gwmc2RvKkattAkvLC9QbWa5JQmjrVJ?=
 =?us-ascii?Q?yHqH72GW6e3igiZxHVXk6SX2bqGiXSwOHFEWxsl+JIVRUMN3tLm/cU5LIOAd?=
 =?us-ascii?Q?UNFmH4Jyqzo1tymsx1XZekSeGjisJo0gn4reYBynRQCiq5blEriflh6nGsEl?=
 =?us-ascii?Q?ZCyG7Sd6TJdSpYtC5qOj1NbZA4ME5/NP51KGykAnu4EK/43TDEVfdQBMZw4Y?=
 =?us-ascii?Q?FQuW1vIBVQab4v0HWleLspL3kJUxtzYoL6n+hL7JAvO7Fj6myr8lwYZRZl4U?=
 =?us-ascii?Q?P3HAc+Z1OP6+Lo5cdQDwbto7rZr30CVadgJsUFssC6ajqUrmhAsI/gJYFx+3?=
 =?us-ascii?Q?8bXp7iRSQHbmXrVuhubkkTHsiPx/1+T1mA5tzg/3PxEMK51NycU58DFPIU5a?=
 =?us-ascii?Q?wMM1+/Ebc/x6/WNgGOOWPYSDiK0HoizgXmqHwGNh8sP/Gm9V8uW0ztii4Kmk?=
 =?us-ascii?Q?2aGBQERMdGQJHFLmclst+cpLQ4ck9fP4Wf8ly6CdwL4gttJkYjlZz4aLyn9h?=
 =?us-ascii?Q?wRS3g8UUHhynRa3YY6o0XfVzW+6FMt4IfPe3+qXHfaYaAil1+nEPkEkGWYqh?=
 =?us-ascii?Q?RIT/PzYSFHjrF7b5iBcY97NYkxXUxO4BZhmMHRTAsxZS7EDIT4LBFR42Brvk?=
 =?us-ascii?Q?DXnII0pyeTnOIRoMZ+6W5VU9iybSMLNNkLfacsft7tQ4axdLcFZSgwFzPc8W?=
 =?us-ascii?Q?ycBB1pbInbRxa4BQrxsUQvPE/fkaQZhMKcFPIUxU/jdqGR2VzJfqiAb0VRtv?=
 =?us-ascii?Q?C9fQ3QqJSfVzwlSgxFPkUbkajiTAP4Ez23Ji3C82OgZmyW7Oq5HQH+OZd6/K?=
 =?us-ascii?Q?FkYNsQAjlRZnQozxcidcnQ7/793LNUS7XApDOK4OOSSYsXqLNAD6C/wu9xYp?=
 =?us-ascii?Q?XGyseCnDZKvYOQ37lvtBqpTkoGRKMsWVnedyPzDXQGddAqJsRbzjnIl/eF7H?=
 =?us-ascii?Q?f9uG5NFscpcKyvlfBOOImGX1DHIqZH6Sd7SST0BXv5713RbcbGybxMEOk+fm?=
 =?us-ascii?Q?30vethWIyJ5Uz7C6ICA9Uvww6o8xkLokYUnAnlWqA0maGbfPR1vqG+DR44hk?=
 =?us-ascii?Q?YGVPMbAPqEyzPCOP0vmAU3McO9CTxd0xOF68rzfINnH1e6INk7wxQs/wOwx6?=
 =?us-ascii?Q?s9E/f42RSF50MGxDnPLCTpkGK9bntdpNjXS2F0sgLzVCW4Qxeq1koHCkqntE?=
 =?us-ascii?Q?uUqG2b/wuXc/crGTVyYrgmWgkirSLIhXH7Oar9NjJZL/cWZ0QtK26syQP9p1?=
 =?us-ascii?Q?GmU+s88kkf1y6CXt/mQpMCyJwIggDploZ2D8rGB8Kv4LaQ2O5+tSPqk9NPkS?=
 =?us-ascii?Q?EcSpBl17W9h9W9oCAI/7oF7rYUxzBU00EJj0VZJZQMpntl/5VKQO1Y+ny89C?=
 =?us-ascii?Q?G8/TflAqpc7LJEPcI3o68SEOvDmxIT+cO5o5gUurZvnMU9cBih+YoBBDiU0w?=
 =?us-ascii?Q?ZTAqnuhSW/u+RntSUS0WGP5c3almouHJMdEy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:38:01.2123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9234d04-6a51-4a7f-0f7d-08dda3862be1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

IOMMU Capability registers defines capabilities of IOMMU and information
needed for initialising MMIO registers and device table. This is useful
to dump these registers for debugging IOMMU related issues.

e.g.
-> To get capability registers value at offset 0x10 for iommu<x> (say,
   iommu00)
   # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
   # cat /sys/kernel/debug/iommu/amd/iommu00/capability

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/debugfs.c         | 51 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 38eca75f6ef1..22679ca0bc26 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -797,6 +797,7 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 	int mmio_offset;
+	int cap_offset;
 #endif
 
 	/* IOPF support */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 520377ab6731..5ac12c3fe069 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -58,6 +58,54 @@ static int iommu_mmio_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
+static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf,
+				      size_t cnt, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct amd_iommu *iommu = m->private;
+	int ret;
+
+	iommu->cap_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->cap_offset);
+	if (ret)
+		return ret;
+
+	/* Capability register at offset 0x14 is the last IOMMU capability register. */
+	if (iommu->cap_offset > 0x14) {
+		iommu->cap_offset = -1;
+		return -EINVAL;
+	}
+
+	return cnt;
+}
+
+static int iommu_capability_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	u32 value;
+	int err;
+
+	if (iommu->cap_offset < 0) {
+		seq_puts(m, "Please provide capability register's offset in the range [0x00 - 0x14]\n");
+		return 0;
+	}
+
+	err = pci_read_config_dword(iommu->dev, iommu->cap_ptr + iommu->cap_offset, &value);
+	if (err) {
+		seq_printf(m, "Not able to read capability register at 0x%x\n", iommu->cap_offset);
+		return 0;
+	}
+
+	seq_printf(m, "Offset:0x%x Value:0x%08x\n", iommu->cap_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -67,11 +115,14 @@ void amd_iommu_debugfs_setup(void)
 
 	for_each_iommu(iommu) {
 		iommu->mmio_offset = -1;
+		iommu->cap_offset = -1;
 
 		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
 		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
 
 		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
 				    &iommu_mmio_fops);
+		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
+				    &iommu_capability_fops);
 	}
 }
-- 
2.25.1

