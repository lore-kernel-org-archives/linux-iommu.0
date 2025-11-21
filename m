Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7C340275
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716366; cv=fail; b=GXy0hGw9qudj1tFCVw2U8hO9QkDxH8gw3p4+mzzlPWwH8qUuSIt+AOGaMte498Y0KtgGjjTGy6XqwIE/RG7JgYjcLEueIMgLImnRiDc+lR6GefohjOAykvfKjFV/8/FvXRmK1nCHcos67lhxzpmd5wz+9PY1QZft9L3C2Jf2Cl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716366; c=relaxed/simple;
	bh=3tOXD1k3deZ0cvuLtkV9KBr5hgoopBgePqGm01zbV9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5BDAa1jPTDlopCyBFFf9nCCCBB4u5HWCvnfX3QaQ1s2nvWamf4HFbL9L9OUjZynRolYFzwVDUnL44G3sEpvDQomHlnur3Lx+JrD4G1gz9eoxNBvfMu+mtpY9mz0NFeb1PbpSKwvMJiCcivQqBtW39D/in55uYPwcGB8LWchvUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bryfcZSl; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bryfcZSl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+KfnYbtqLlxtZFYtCellanM5QpMkivWqM9gdvbdgt+ueq8puy6gTT2IDQpruhmVwB1VSO3Ww3WVvBBm2VthqO5iiv3hFI+nbIQ3/B9gKPdG+bbWUpxI+I+a/qKA5Wpo3SIJ2a+b0+vNV7ddcb1HYpg+RavNSjoHOi3iEWWH6sPk2anAR4PShIb28rzKVdMrxbo4rAc1cVt2jjj3otVGPQe/15jH7JlLeZ9fXICeoxt7LKoXzijzBiIHfRjZ2x4O38xP0hVYZXmKNKTqF1q60LJd9fNqB/gZmcJrfMwVtIg7wPOzWXMAmvZWcsmDCj9fTCaPA32GFkyvsFbVi2RiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODXJZwTvgzm6UjA0uCwa5nMFmhwoV5UfA9CjvlErMvY=;
 b=wOIn8nmUvgnVeEfl4TyTGxnSJ7B8TvrB5vGjlMyGm7pmoqlx17gUO8lbdY4AU/P2Wn7zBFiQuiDRXYeXdkKAEQ0EkNhhcU6cJIRjPLdTHItNPQjsUV5/eCuQEY4oN2vp1uAJNecriGSFLyOgU21BYSQ+KW3hkkz7waHoJBrnj2DUTtvy3AHAD6YpjHAzKBykI97ohon89lw77m0RCVbIncgsmmJfkX3MsoUlu4sdWUm3PWdfPD3xMtVv78OTyvdqTzs/vM1nbwGLbgbw3q9Q8XeJaYpuO5Q5j0J2puY3tm4nnFRzeXM/Z6lf9fEqZE3rXOIMlWI8w0qsZYDiZdgldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODXJZwTvgzm6UjA0uCwa5nMFmhwoV5UfA9CjvlErMvY=;
 b=bryfcZSlNHRXU85Esp7LaBKNvy7+M88HXc8qaigWu2vS/d8whjNZDiF+4fajE06EbR/xRPX8JGIb60R+OVoUb2YasyNWI7lu5krdhmQ2kyVsbwG8Gu2dkwYfCdRKIjE2E251dcXgXrDUr6Pl3vDXN81ghMWIGN+SQcgMj7wgMqI=
Received: from BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com (2603:10b6:61f:fc00::618) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 09:12:37 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::30) by BYAPR07CA0099.outlook.office365.com
 (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 09:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 09:12:37 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 01:12:32 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
	<will@kernel.org>, <jgg@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 1/2] amd/iommu: Preserve domain ids inside the kdump kernel
Date: Fri, 21 Nov 2025 14:41:15 +0530
Message-ID: <20251121091116.25663-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121091116.25663-1-sarunkod@amd.com>
References: <20251121091116.25663-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: c309e8f3-7ea7-4a7f-be2c-08de28de1d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j78isGI+a2prT5bPsv8625CrL3lSNzXj6X307oRkmqNF88sVM6us3DB/0BfK?=
 =?us-ascii?Q?8ltzzC4NjMuQ5r3OrTcPqaD1lvRA3A2V7IipyZW7mpK47ADtDPqOENcz6OhW?=
 =?us-ascii?Q?0pmY4hqI4CBnVaOm8m5TLOzL7gfMiR7BPvfjksrREqGoUoFa2ZB/AjRY6Jzc?=
 =?us-ascii?Q?P5VQWuMTjNN/F6mVAi7aoQIwfG/No/m2F+wEseANKjZS7tsrb3hTcPU9NEWD?=
 =?us-ascii?Q?JfhZaWThxo9YC59nzJ87y4tghv8LtCfst6CyQ1254fBvxZhLfJByoaiSwX2P?=
 =?us-ascii?Q?z5II1w/EUsdSLglS1T5yT0BKSWgwgd3rbPZx6qAU/l5LOmYZSJ2iv8qWCOky?=
 =?us-ascii?Q?u93O5LMWjrIkt35MGLyUa3K6FcGK4VaZT2IexQTagOriUXbd48de93q3EZtf?=
 =?us-ascii?Q?Hsg27GmEqocrJ6/yjbIdAYgRZc9W8XJJ0xS4UhNvGhI9ccS1nHg1ZW6n4dP9?=
 =?us-ascii?Q?T6n1CASE+lBncDQgMOkIWiDr4Tz3aug0iUzVdugmHcxWCfAKzv7b0PjI3KgM?=
 =?us-ascii?Q?z3jFU2xb4iCxZUHfSMKEGl+4tuYphicl9MnHjWs5YuLWANLQz3jkOf5k2Afl?=
 =?us-ascii?Q?KCbaTfy3yuVg2wXw9uyj6YW8hKfsWcNvhhCkUAopOTXDnspXR7WUhd2v72e/?=
 =?us-ascii?Q?whZ6fYPDe/DyFCIPY33yjFCMHbM8U2s4ddCFQGmpNc66IG7/vRECIXgIoasL?=
 =?us-ascii?Q?McSJ0Nd2K/qwAVNLo5r4GVa9ozm5vyCCr2lAlQ5CuOLyUZIHT8lKq+ywRXb+?=
 =?us-ascii?Q?gV+WN3zlhAkbaEKu6Ucivnb1JKZtEpQODhRdI872JmxvlHOeKivO4b8vXD/a?=
 =?us-ascii?Q?HfG5wX0WXYWdRC29DBLuads9RnQZmcJp3OyGMCZ+kx9l1m5eYWtUmiVdnDZz?=
 =?us-ascii?Q?scpw0/9+i0LLGzyGVvuQyzkwRS5+Pd3rgsuVwaqP0/kr0K/xFFIhS/lqeWyo?=
 =?us-ascii?Q?xiYXHEAb6iH1sKjh8UjmG2Qn2tkaG+wzY7AB5BReMCzvbrXCebMLlgbug6oY?=
 =?us-ascii?Q?WMVhvPBhdAURyFNFBftlJ0nxabggJEv7pxAn/M7KHxQfo9qphq4IbSLpJc+e?=
 =?us-ascii?Q?E6/mXWXBIUooXS5RCyDlqC3r43005H6SJFBh7eduXpjF7jAgLkzmSGzkj+q1?=
 =?us-ascii?Q?m70ajB2LAICl7kDCt9b1eMd/tgLHloTqox7morL3tiedPDWAPJnIMSgvu+/I?=
 =?us-ascii?Q?OhgXrtHM5g36ugmvAYNECEhBNHPwTMEtTcccrPj11BGO9XFdZHvBZBEmSjTA?=
 =?us-ascii?Q?uRxzCCqY84IZHyYlWarlhfgOkDpBIjgMlOr/z8TDGhEEDsFs4cyhTTKi+Rp1?=
 =?us-ascii?Q?W5vxsoYZDMIy+y/LFUMJr9Eth6I99fkHFe1nefTAzVgeSLk8fqN4NjCrFaqJ?=
 =?us-ascii?Q?Qdf73C77+SVh9VIjKnw5wlTw5uHpPbyUfO7f/JLa50Lx6dpzlx5LDemG4K0v?=
 =?us-ascii?Q?8TzoxVFZYcCyvG347KdZZPalKaiSL7g8LzmtMbWClo3CNsf6zO8vaacnqyVc?=
 =?us-ascii?Q?AH4JB5n8+Hlg/AdWbp0o8OY5+rK8EZHX2IeTTwy4e1XwqvcoNbFI7lV8HKUz?=
 =?us-ascii?Q?Y/KWE6tBrQPDLNGawJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 09:12:37.0798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c309e8f3-7ea7-4a7f-be2c-08de28de1d45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96

Currently AMD IOMMU driver does not reserve domain ids programmed in the
DTE while reusing the device table inside kdump kernel. This can cause
reallocation of these domain ids for newer domains that are created by
the kdump kernel, which can lead to potential IO_PAGE_FAULTs

Hence reserve these ids inside pdom_ids.

Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..14eb9de33ccb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1136,9 +1136,13 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 static bool __reuse_device_table(struct amd_iommu *iommu)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
-	u32 lo, hi, old_devtb_size;
+	struct dev_table_entry *old_dev_tbl_entry;
+	u32 lo, hi, old_devtb_size, devid;
 	phys_addr_t old_devtb_phys;
+	u16 dom_id;
+	bool dte_v;
 	u64 entry;
+	int ret;
 
 	/* Each IOMMU use separate device table with the same size */
 	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
@@ -1173,6 +1177,23 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
 		return false;
 	}
 
+	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
+		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
+		dte_v = FIELD_GET(DTE_FLAG_V, old_dev_tbl_entry->data[0]);
+		dom_id = FIELD_GET(DEV_DOMID_MASK, old_dev_tbl_entry->data[1]);
+
+		if (!dte_v || !dom_id)
+			continue;
+		/*
+		 * ID reservation can fail with -ENOSPC when there
+		 * are multiple devices present in the same domain,
+		 * hence check only for -ENOMEM.
+		 */
+		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_KERNEL);
+		if (ret == -ENOMEM)
+			return false;
+	}
+
 	return true;
 }
 
-- 
2.34.1

