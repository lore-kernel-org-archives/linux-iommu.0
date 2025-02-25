Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F8266EFA
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480925; cv=fail; b=oMXCo8hB4O/jaEgVy57odgJacYMJqVqJgbQB3KgycaXNTilN9ZjrmTOG/yyTD4vEk+xfm/4D7gILB+0o37pjmjfHzrO+EcX5TM8xvyv15bdNPK3OeX8b+P1/0YWIcIGHDRPq+y6EXs2LaycYr9w7+KhDROOJc5QJ4jQG2y98mN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480925; c=relaxed/simple;
	bh=ZTNUPMLVSTk7B3I4Q36trbMCJ26EbnKGNQSwUqk10Ys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNIucE6bAdBFqZuxi182beV839UlGSIaKv7jAc6b3sqfrCe9dg2GxaR3OCXXiZAM8WXcnT8RotvOmFxGJI/zmFehyF4+D0N9beVphMkRb+7G0ZB9Yec0BIobG02hCCv3u7Uw4HZk3gSJGbYmWgNH1TzxCtwDxQtD4KB52oOaFx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B1fbh588; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B1fbh588"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ML68M81etpBL4yuRtPpxR9Kps9s0/EQABjnV+VwF4yJ7V4B2NYFqwg/ZL0bMXvvgVnOatxmiPxwfwKCVIVS8p+bzTz2ewTGLJTxpYF75mtPEkv17E6/4Mtr598y/6xkxradZokQwBo6aLVZ19U/k/SNnTblLQA8Kx4k3mQfwzJQWYzJ2KreUML5YgEBo5v1SBnz6/5AL6YGymSykChQATuDDjo7LngA6fdMJamfigN0ODA7MowrWDbvbLVRodRuSfZO/gNAcG/IN3s2Dek+2xAI0AtEIpZYJe1p5KrbfXTaED3HFWsOj4elCNoc9BH5GSFYR2Y4nyTHqdg3KsRvjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0Y0sRqI33LRyj2hAH7FU/6Q9KVbjdK/NvGLuq7j+dU=;
 b=VdJ0Uw7Kyg81h6Lwa7CNLY0p7rrYBKk1yR0Nn/NtJ35SCGmE0hnEkhwoXwt9upgog5QIAqg4p8hDZIfYAPsvwuMDUWKPKAVDFDPXtFtiwUsrTLQnYcGSclmYmKFKDPCs36BspRQ8zDuo9umbOaj45QbmupwYVyWXyZ3hPDi6SlWp05MMf/Rtf/rS6DzpV+m/UPdsUndS7SQK7QGAM3g+9h5H7GSO+C+FfOGs90ZF6Ip6iiXCj3fbP7QTS06q5tWfsaQLk1fuU4nOJhkLaGXFBuulM+dUJimTwICSSi98Q0vDdNC2IdB/2rEtmKAp1zV/Q/DI/L51bOaalN8sI62maQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0Y0sRqI33LRyj2hAH7FU/6Q9KVbjdK/NvGLuq7j+dU=;
 b=B1fbh588pNyGWhy7M2RRPWFg4oSK/WZGn2Hux7I68tZUYS7eJOo65ZGemjir8odJodqedC75pGLqyQOOCRYuun9v7r/prZrNcVsLPAbsqk0/zKka3dv6BM+DfE/64G35EyP3LqYqL2amlMfX+CtDpzfFd1DUT4fa0RVe43jTyzU=
Received: from SN7PR04CA0068.namprd04.prod.outlook.com (2603:10b6:806:121::13)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 10:55:20 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::87) by SN7PR04CA0068.outlook.office365.com
 (2603:10b6:806:121::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 10:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:55:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:55:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 5/7] iommu/amd: Fix header file
Date: Tue, 25 Feb 2025 10:53:43 +0000
Message-ID: <20250225105345.52143-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b8976f-c0bd-4879-f2eb-08dd558ae589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kzSn67sACF3qqClxjy8rz4f/qiiVvGmZEbu7Nl2iwNWA/9ZJZMpZfRrO/DF3?=
 =?us-ascii?Q?ZX3qQ35h/g+TEOTa45jLxlbK2Ib88G43+sH0WpfFHHYECRTaqOd3L01xWATX?=
 =?us-ascii?Q?4Et2qx5OG/2m1gi5+S72+wItd+RNvGvsCJOEj8NOts6nmdHrEH14kHEfxiUA?=
 =?us-ascii?Q?aUsjn07h19BMZ3Xkkc5qF7bpVxxDD8leJwPCuR3XF4j4f+ZPHMz72C8oM1Jm?=
 =?us-ascii?Q?NCHGtYLXTKwJ7FGeEw20lBQwY4+L2EIoH7Cu6jccLhjOxEzS6iZLFv2Lcqel?=
 =?us-ascii?Q?yvek+6sw2gl2BfGNZEgkzcL1RboApeqOFdwPvX0HFeBfFpH1cVHT9ToV43wD?=
 =?us-ascii?Q?TdAZnnXhH4+yJf7IvdpWlrTB6e1P1gQWb/0lMrTtf5cpwLT+ojJaZNw3xY7G?=
 =?us-ascii?Q?b40BD8lWgwbclxEmN7G3DD3UHa6+5I9k8WBYgSfrD+AxbSngVHBCUmUA9wnt?=
 =?us-ascii?Q?BInTb32dq4DM+ORx1Qdy2gbqj8nzNL8nOCthR4cs1kvrOWbGgopbwCbhksMY?=
 =?us-ascii?Q?9ph1Yk9TFgQHbMikHorNtke19xMuaecI9y6lAKBV7hrxEo1eqGv5TyxJqMb1?=
 =?us-ascii?Q?RTzlTjUXwgSmu/E8hEU5A+XOQHBX1AODeC2HiDZ7VttT6EKxZNLVwbDlg2/7?=
 =?us-ascii?Q?7R8DcSCZ2/N+i5e9FwuWjG3HOBy+8DY31eAgcWvvQwCCXS9ZMJ4wxSSGMi5E?=
 =?us-ascii?Q?XMUX2apcSBKiHpsHrnro3l1P3srFeeDF/kwzy8TSEw0bmz8uKWAue0Tg4B98?=
 =?us-ascii?Q?qn4c2sRGXBimI6Vlrfothex7usY/VL/tW+9vDx/GMAvo6cgE4kqUiIBFbDYD?=
 =?us-ascii?Q?6mTYE31pAnziD47DUog/yZUnXgnGRDe+bBYa2Uz0qWJ669z3gbvoxutPU19x?=
 =?us-ascii?Q?iY9FbSJRgINBFhPMWxMiwlj9s0J6sdL+HlknJmgVKkANeHejz0TuvSe/IA9Y?=
 =?us-ascii?Q?LgI4VchCoOp51gpaeOMvhtXzMjKOfzhZpCe6fulJFTAuJmy4X2q07IBDqgpJ?=
 =?us-ascii?Q?BApbVHXkgWwvpgLHXEX+ZXMmuixUEdjGS16TV2oQJcBs0L317tUEH0iJAM9F?=
 =?us-ascii?Q?H9+7kLpw8dvaO2EBQ0xU8I9dGUM1RRi5wwkspOo/ZHUGdsV4DRiXKOUl5QuA?=
 =?us-ascii?Q?AFkGzWOayv2OhDLTtsi3XdywsTUCxJUtpvkSZsEmTOmRGvqbfGaTQD7oiwgv?=
 =?us-ascii?Q?z+FG/Bp4zZKVBClh/Qa1uhJkb3sVb8mDrPX8+XnCgogmWh2iOTQxmyKFQBBb?=
 =?us-ascii?Q?Nbe07HWL5mdo5LzMvJJPk7+t14xoSAHRDXt6DQ3Ya3BKuI3n+WAUGseyk3VF?=
 =?us-ascii?Q?1ZsaL8IfkA+b206S58OlxNE7u0iZMmEQtrFGGJK6cj+rGbht0WriRQa2+/jd?=
 =?us-ascii?Q?8XLdFReniKqy26CXIG7pfad+5YeSj95xLiZoXVGiOteHYzkI5kDsiBHahbkg?=
 =?us-ascii?Q?WlC3L5TO/a22MmPHdjhs6afC4ku5j3mlZlug0uGNRloAmxyELf8MqNdyJ2El?=
 =?us-ascii?Q?0Nwhp7vN3S5CSrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:55:20.0411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b8976f-c0bd-4879-f2eb-08dd558ae589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

Move function declaration inside AMD_IOMMU_H defination.

Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers")
Fixes: 457da5764668 ("iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()")
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 68debf5ee2d7..e3bf27da1339 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -176,12 +176,11 @@ void amd_iommu_apply_ivrs_quirks(void);
 #else
 static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
 
 void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 				  u64 *root, int mode);
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
-
-#endif
-
-struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
+
+#endif /* AMD_IOMMU_H */
-- 
2.31.1

