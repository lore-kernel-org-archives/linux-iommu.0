Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C5313521
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117127; cv=fail; b=bXuevE6KNi6oATFYQJf2YwrXmTFWdkKVgKYTHNXKp5WBSwZ01GskffC99/9iMhSO41eE8LMFKwVNACn08g+YNRDPiOIjt+2zxV8efVXuMmu60kUu1jVc+ByP4tsJ4hYy/SD6DblRFJ6YNhgrsGwCMw88+B4RmfAOm0MiSfkLQM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117127; c=relaxed/simple;
	bh=MLgS/BQcJVTHK8Wju+W2BLcmpedaPg6akcA5paNf3jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggADphEtV4HEfIjPGYPcrv+t7fUw1gU56ceY52i9s3LvDj46X3oJq8j4p5np9A/LZ1cxyWeaWFPZu9tEzfjYjSDTdn87u/dN01Y+nYut8WYKe/IL8o39o+Jc+Le8jkjCwDTWJIFsmoazeMljEhXEL3dQezKlG2CGysAGuGt5Xk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tYSDtDBN; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tYSDtDBN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEJ91PMRHtica3qPf6KbknAZOz/wjPTtlpC1jBplEanUPxBw6E1u8gU5vszdHiMZG1t3RnZDpU3nBLmEzLt/pEPvLv671KbB7OI9D/x5BCLPuxr/UsbiO22C38Y6GdewwfOnc8g7sgKZMxsud5GyoAbPWhCJ80lJCtdhr9BvPkFsKqI/IGE60aYxCnpjvGgrF6HGQqZP6HBp5SVVgCjNNsr/H+NoBUPKVgT8cH1o/qYk+1p7ho/n+DmXGtixqTgvguMSRT2RJ9cvdm7URmKHAj5Y9LpJNxh9jm8fmlzTK+dTLz7q7kPprp6Qhl+aIcNNRbFjH65kagEWEhQ2srpeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0Ep94gpB4Q3RKviMYWsKf5IRkU3iLF+ACi0Pro9Kl4=;
 b=Gtr49NGFgMmvgPKgSndP2oZNpFpaZRY2TwU0mkfWdqHeL+IhpgimlS0mVRDefsUYd4rOkAgJnLqYAF8V53UZNKnb1zZWisyCceiFACE7ZLCU41KWu9qLgjrLX7czFJHDlpTIlQQeJmazDNsloBtQk9XD4wvXCjXyUX+i9k3bUrTqjlySu/6Opoip0SAFR31cq1/JSKnT6k7k6WdhQoaG8nq0amx9pT1mf3WjBs1rcyqaEXrqn4NhOnkngYerV11JXVgsUWnA1nM/sNwi5C04P6Zb0FvYJZ/72uvMqw+aHdskG3gFph3Wadlbqpo/duJoLebwtGYRTnLETcBXiMJCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0Ep94gpB4Q3RKviMYWsKf5IRkU3iLF+ACi0Pro9Kl4=;
 b=tYSDtDBN4I+ysgklbRO5rXK3QNdTAiKMEMs3Lj7oDcDnNxIfz7/gxjBfwtIIG36KXYPnjXJrHFFum8x6ecmCiXrvfNRFvX/GDZCn9c3uXCkpEqJIrVTHx0X5LZocOuqjraZ3MD5NcZABlp9FHO+B257JEtrzjI4Wjut5QrT4dSA=
Received: from DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8) by
 CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 10:45:22 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::f1) by DS7PR06CA0024.outlook.office365.com
 (2603:10b6:8:2a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 10:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 10:45:22 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 02:45:19 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <ashish.kalra@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump kernel
Date: Fri, 14 Nov 2025 16:14:41 +0530
Message-ID: <20251114104442.23296-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114104442.23296-1-sarunkod@amd.com>
References: <20251114104442.23296-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b0efab-0dd8-4a60-60ae-08de236ae94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSX2m678c+WD4frehYeylNF8BDGbFHI9Hf4PPQm2/lu1uJZiEckpYelVM199?=
 =?us-ascii?Q?CP9XxigadrAOMIWS8dTeUi3F3A42l3R55FuoWUikafApX5U+1mEbLTEGtwtT?=
 =?us-ascii?Q?40xukNCoPKedgFveHV2DzRoN52ArTwBv6wI+KHkokjfrnYWzW5y//6YwKYZo?=
 =?us-ascii?Q?xhxOOImtWr6iNVqThxDxVVKc5Dt2QIp7hAyBN5Cs6lAo8TXVth39Y9eLrYJC?=
 =?us-ascii?Q?peLNqQARZvUFlVHK0ZFgp6yBAinZkpBNxfy6W2D2feCIjm3RMSG7B15OPaua?=
 =?us-ascii?Q?kKQP0l6P/tFY/DL77hBz2lrk2h5IKaRvjIQaFAuhBgDDF75jCPO0OwWOxMKU?=
 =?us-ascii?Q?QvgrKozwfgfADcp6Ocxn6Y8BaJLqNp+UX2iejWP9tit4KfTNwWTf8EnUYLDR?=
 =?us-ascii?Q?eqewclGJoUJSErdnv+LeN5W3WEdl7xMkaPPeUrQ+LL+2Xm7C/6exStCv5imS?=
 =?us-ascii?Q?Zgu06wjuNDsruu+xUvzkYdqatHR/d7DvSZ3GIezpAO+vNCnQUAzpiDRPnZdF?=
 =?us-ascii?Q?VfovYF51EsSZwqoBs0xihbIv6G/4sZxXZmBw3BIjVTWXKWXOAyFvmhm4G0lR?=
 =?us-ascii?Q?7vt52+iyy4JTavKCJrg7KNLxN5p7QD3EgRJATkZkRLQBK9valJxGQb7gPZGF?=
 =?us-ascii?Q?eaDeq+fhFZkhabGKTmQz7JihmnNJ52HDZA/a0G0OLt55K6fpCKmnKPBpAMOa?=
 =?us-ascii?Q?ZVvzOWczqa5Wm3XS8aRwDD7EOrphOI9Lu0DfVwd2uxurN84VT1LDbqfXPgPv?=
 =?us-ascii?Q?OOItf8giYH2XViSb/tCZIzTJaFlXb7VNR+Ip941PkR80szjJ7xSF0tSzxMDi?=
 =?us-ascii?Q?+8hcLsa+VZQXQEW5NNV8EARD20xFUR02FQp/uyTIwge20SlQzOgUhp8inu/V?=
 =?us-ascii?Q?xSJajagO52cj2sHgcRxMGOfTTldpdRHhufJd4LS54OMujDWR0cekb2gGJN/M?=
 =?us-ascii?Q?ly7jFTka3mBjLLKuiVi9dTkNnnEAUEy2cvwTs3KaTC5OrhdMpvEz0em5UbNz?=
 =?us-ascii?Q?TjpqWlYWVi6h5M+VbG6yFWWqKaDFStyaRv4t3mIbM+ySWoqg0xaBA1usaEQl?=
 =?us-ascii?Q?9jxQ4Q63E5VyVo2xTJqF3IBPkIxVVswNRhYaFWw8RTLTu7p7d4lSTLCoJQbO?=
 =?us-ascii?Q?G43WlNnR2grVioEm0umDCvvmjis8W/WJf6UN0XVm10ckHhgxqgFVbr9fP+ft?=
 =?us-ascii?Q?Jg8Cu9TrmqDtetVFSy6i6hAMXZgfccjDmwj4ZPeTbFMUrvq8OD9hZ5J1OL2T?=
 =?us-ascii?Q?OMasB6hGkQEpvVPnUF97dJWHOdXr3O8rA575chHxCifbqjvYzWhMQIAjC2WI?=
 =?us-ascii?Q?lHun/qAp+AhIZH9pHg7c3jMsLUQR0BGedQ5P1qKMNQcjHmSTZ6nxwv1MEo32?=
 =?us-ascii?Q?jJ0d5lfCsD7ly23cgwF2ToE5f/5ux0NiI4AWnvYoOMdpvjzkZMV7/BaHhOw8?=
 =?us-ascii?Q?cWB9SQdZxp3m04mvPQGk6bDYDYKl8OWcW9KHa9jEreK1hVGCPtjnXGtq3kD7?=
 =?us-ascii?Q?pk5r2S1M+EijxMt3LIXdJIaFEN8UaSfQiAA8ASH1BNvaiWQNrvvio8sDJryZ?=
 =?us-ascii?Q?ZZFxBDAofSyicTsCOnY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:45:22.0112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b0efab-0dd8-4a60-60ae-08de236ae94f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551

Currently AMD IOMMU driver does not reserve domain ids programmed in the
DTE while reusing the device table inside kdump kernel. This can cause
reallocation of these domain ids for newer domains that are created by
the kdump kernel, which can lead to potential IO_PAGE_FAULTs

Hence reserve these ids inside pdom_ids.

Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/init.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..9375fba1071c 100644
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
@@ -1173,6 +1177,25 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
 		return false;
 	}
 
+	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
+		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
+		dte_v = old_dev_tbl_entry->data[0] & DTE_FLAG_V;
+		dom_id = old_dev_tbl_entry->data[1] & DEV_DOMID_MASK;
+
+		if (!dte_v || !dom_id)
+			continue;
+		/*
+		 * ID reseveration can fail with -ENOSPC when there
+		 * are multiple devices present in the same domain,
+		 * hence check only for -ENOMEM.
+		 */
+		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);
+		if (ret == -ENOMEM) {
+			pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
+			return false;
+		}
+	}
+
 	return true;
 }
 
-- 
2.34.1

