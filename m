Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7881AF0B0
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673690; cv=fail; b=gFtmpUkSNcCEjoDr8fYlFbmGQWkAPmDO/tHy+JYInWDeGM3biOC098YhMbbZmR2VsQ6gcz+gd7YcombRExcFORduZMxF1p/FVtnvzSHDVEY023PHKsmW4goY8e1GnsiGQD2KlU7pjUprKfrV0VLvYvvR8r6DvSYD8MhW4+8A4Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673690; c=relaxed/simple;
	bh=Bs5H9YOlxlREbvT60qysiZ/L5zpH3AWyry5JHkauVW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/g+BWav2zMvdM1mghuiKZR5Ubcy3kITnY0qLJ1Odcp0GeVOGQeTz9cHkwcYgYrqpS3JmGLI8D0GFGuQ1fNYLki/GRlwjozGTXyu7+4lBRermeQ7bqocfVA8w9FmBOcq5Qt04GryBVQ8Mfj7d9cfo8v5+Zois3PjhsVswO/PSWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WlZ3AHxa; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WlZ3AHxa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Muh6/4EVqiw820bVFphZ2nAsDEjQ0lSuQccpaJDisG9vEFjwoqImElQhhCAqWN7IXak9bM+Hh9NXyYnBASaxJa/mhPbe1zLjrbNwSysd+Cep9clyLaeQgGqUvcH1LNYJQcCYyQMOT0gmYzbBczhvgDJKOzVm4nfLk9EfvaGkCWW7Z5Tc5xrDj/RSCtw+8XqpX0rNDfBdALwebK32L4Ke+k/yPhh0/Gf+Fw+/qZ7cm4Dbf11+PrN/uql7ZzMVhxpd4oxhKSIez7NyU/M4kbQE5Aq2MgRehTSK8a0Ok+lM83C2gBDWBTTkqvNrRjdzybJi/W1MOvAhoXHHVt+vb26Dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27TGiWabVUjhxBxhZTYYjnghAdPUquBx7kgqUMozihI=;
 b=Vi8tYITwitu7Cf+8hD4RSNUyXQL9Y3bSHQg8+FjbLUB5K/J6pC+jU5Lx4a1mAQc2A4BLBWHEAZCA+bpeXtDIOTtllS1lsMPHyYTB9ux5ZBC9RqJKXgdhEYO9+6HsfoTBKkaSYBSAjLkFJwa4diiiffkc8ygDPr7njmOgZJPFN/RcdUTMjs6rxgV8m1xFC4ezWMq5IVb5FITpbYhrzfXdvZIeLsCIqJ968DvfyiT7aZnF5gwox1xtIKQbf6ZeOWeYqI75LoxCdol1PIsMszkOh3yfPm2Cp2h7UPm/kB8EfbvzjxJIaTrD0KZfR/pTu9kqBntrOY7LzmOfWSF+sFm+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27TGiWabVUjhxBxhZTYYjnghAdPUquBx7kgqUMozihI=;
 b=WlZ3AHxabOsVHzin7OgvZW6c6gBNjVbfwjE8yVWYokQYLsnwd8RTBwguOTq7N4vew0P+zEHos54tnb/1Qv12z6tF2hkxeP1nEl3/DTVMb8m5QUR6ZHH3aJzYzCk5cCSgNqP5pEVMiRbeRt/fAnPWO//Ls8YeH8If6b23rdPRpDQ=
Received: from BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) by IA1PR12MB8554.namprd12.prod.outlook.com
 (2603:10b6:208:450::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:28:05 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::45) by BL0PR1501CA0012.outlook.office365.com
 (2603:10b6:207:17::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.21 via Frontend Transport; Thu,
 27 Feb 2025 16:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:28:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:26:12 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 1/7] iommu/amd: Log IOMMU control register in event log path
Date: Thu, 27 Feb 2025 16:23:14 +0000
Message-ID: <20250227162320.5805-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227162320.5805-1-vasant.hegde@amd.com>
References: <20250227162320.5805-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|IA1PR12MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: a45da9e5-4b56-48b5-0a57-08dd574bb650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cIm7kgyUW25MiDZktP5vjgJotjpZFX97GKS/8wHTgsFAALhW4TwP54NGDhR5?=
 =?us-ascii?Q?i4eZRJCunORjVKteF+I1otOwiHRGF/01RoV+7RUHZQqO9w5kgmSBijceXbe6?=
 =?us-ascii?Q?+wq1B5ubpr+9GEqf8nUSPZ4uCwGMZbfQEWCrXdVpA0jDOlYiIPS5qd1zszZj?=
 =?us-ascii?Q?mn5D24nDHFmylH8YMb49dgsGBXOaUuaf5WNyWFakKunn5aYD5G6pyDW5xyFP?=
 =?us-ascii?Q?fV02SuNXtOHKgTa9jBtr9mVJNvEeIbBARt+o8ZuCcg+biT1PaciQ0FBI1Wqn?=
 =?us-ascii?Q?hKMg3C4QaNWDklSqxRev29TAldPL+7cOG4688JP4R9/jJRwyQ6clN0AqrNoE?=
 =?us-ascii?Q?DaDa754yFbYTZsqr/2akz+v8NqOoczRzO+GLoFlUsVD45JlenjQ+3ty06OyP?=
 =?us-ascii?Q?0u1t7DgK8R24lohQfBIWChwG91mSNRpUHJQTUKsJlM72n+vXS10cHCNbKhDI?=
 =?us-ascii?Q?CDmXue6Wc2ZHShDTFsRYUlsB6fb4ixQgR7gfvt/pXbKfERjAsuW0yNs8CONa?=
 =?us-ascii?Q?cCcGEH+f3vum2S6HSGkvX1eWhwUGNKN3xXeSLMRcCqR4W2UF1zP1oOzoBA4o?=
 =?us-ascii?Q?iNY+iDkxp9Qd6jx5qyRW7Mj52kJYjXrmvJmqEaLtkjCoIZE0rSNfehag/hRB?=
 =?us-ascii?Q?lBKiBXy+aDBhZ2hPkAxk7isz0thMGtIa6ASvTBXaKYaOoTauLRJ+SrPlbbdx?=
 =?us-ascii?Q?qTWry9OArTJWmRFdg01Y9ZOUv6QZzagS+PYVk4Rcx7cAVVe/mN8UhmxMvS+p?=
 =?us-ascii?Q?l3BJszLloBMXAjS7uEd9co9TcAgMcSYZ/m30tK2MF8PhynWYESk5dxfjCNHM?=
 =?us-ascii?Q?/Ef0EiAbIcJ2hH5VtkEWEdLyJSJWq69olnaA5oyDFG6Vkzxo2r/57gm/zPCV?=
 =?us-ascii?Q?JBtpAVVPlXA5QK8AJ+SSUWqUv54WhvTjR2zDnp4DAMiIAW3gq0OoWXYIgtn0?=
 =?us-ascii?Q?BFEh9vVjY9g6bjlH1VZvGemKG1eXeT+4uDMSPkj2YxK5rlmUm0YartBU3c3Q?=
 =?us-ascii?Q?Xh/Cujez7UPnbW0WeetJACgFN3QPUDfg12D4lAOJMFDyxgepTzBKj20s4ZaJ?=
 =?us-ascii?Q?AwHPvjGH/HvrU/ftSGOR2XANma+ssPVpcmy1AcEeH9ZHEmPRCZUtKwcAiPwd?=
 =?us-ascii?Q?m4v3wgnRAcxP/y8dFg7P4jzY9NCSD3HPGRvAhMtbk/7pfKDEICtzlU3zQmtL?=
 =?us-ascii?Q?swUXq9T53TqHue0+uUX+i1WVGOG91GR+r+4GuzgAXiSrMw2qkUvmwxxnYkBy?=
 =?us-ascii?Q?j20zEH3Hu0mvm20XOmlCMsltQH0O0gvt37F610i+C+ZGpvZRPoPQKajG0hbq?=
 =?us-ascii?Q?38qu0itSG2MExnsCRdS1iICMi1f2t8w5FgFKspqFvFU3iau8Pfnt36KE2Fph?=
 =?us-ascii?Q?EmhqcKa+MzjptopTB3lZnQu6ZJM0wAx+xlBaa5l4/WiCImIxSBh0LdVm6Ogp?=
 =?us-ascii?Q?muPlPYwqW8rYHlnczFiyeuYSZZG7IxHT1TZSqoQFp7myVpH+ZYHqpIfmt3Ja?=
 =?us-ascii?Q?fgA2VaeO1/XnHPE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:28:04.8872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45da9e5-4b56-48b5-0a57-08dd574bb650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8554

Useful for debugging ILLEGAL_DEV_TABLE_ENTRY events as some of the
DTE settings depends on Control register settings.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

