Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD04D8A1
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053107; cv=fail; b=fIAA9UiFAfzLHQcX10XQNnlcQVtL9UKGf1q0yqSs9oV6DgxwiS0T/zSZACZ1BrmhgsG6dq8+P3otGZI0MJAbvlfXJdukXdmRe1HVlupVytsD2IJ01+vu7P40p2TdKyMZTcpSrFgkUY9lJG60vKDoKqUm0/Askkxg1/AAKF9aByY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053107; c=relaxed/simple;
	bh=BNwheOjgK5JIDoIj4/Y/aUdr6PTA7o4059KYrjMcotU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dNS4JgCoYyqAaRLbe33mqBf732pno0bctDxDOI5nShPpr0eAS2UJhGMuQheUjWc2Ugf9jlMyBYZdFvAt2BIdxMk1XeqmHpLksMcn8GBxwgcAIJglFpgF+J5Fqn9ksv0vMK6ZKuzehgx066UCUahBOw11hPLlYxYyAW2mVN659pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TtpxL6ql; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TtpxL6ql"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHFqOzVgPEltpSU4RkiSZx1ddLoMReY8oETqqQYWXyw/dSgLu2zCUWMtUUdknU4U5IMOgnFjDpKlNJ497JWbnwAEjF+Sh0kb8VyJBlxO+XHqgY9/Zectxxj8M9vtRWCL2W8mUTi4CJnyM5lzjM4GDolJA4NVuyvdt+8ZuUKAvEeodl7e1YE1QoB49iSY1ZAgCrP3LsCCua/no1aDR1Kt5XSYkBqq0xoLoHv6FifPKwqKJBF7OtLxhoqhbijKmAAgnQ6E7useuitpaIdd8j5VwQOKA1uWcfwFcbc4UhISNdvQfJIy66AZ3ALqSxbryfYlcTTuAT6L/OIhxRbCyAE2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJgBCS+ggzmRTo/6tcDOAAPmvApPjcetsC1AHRQVEjA=;
 b=AqABBRiwvBB+EkAh9FcPA0b1SlYcNApPfEaKEGgrcUHfxswQ/rpsAeS/ZZ/KTD571BYVBN7aXr2PtYKrjO6g0Hff0C1/+1mMQSiIqp3MTve4atH7+3XMpcbSgEIjE49aD23VZAzDjadBMsAf5oaFWLrY4TKcPzKq9W4NZwUmPCdEDOjcXdvy5lVf4BGB0r4R9D4oriEpcMn1h+OxP1R+65O5ohMF2fE9AVGf/AZ8w2Z6XaBowuOMTNdztp68/mvc8x9tIgbk5jAYhtUeyZIkVusianGDr29Mejtslve1THKtHhO8AK/vFL1S3302d94LZv31kYaOgawbESCf50tLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJgBCS+ggzmRTo/6tcDOAAPmvApPjcetsC1AHRQVEjA=;
 b=TtpxL6qlVgNiDxiRjvlEbRvvkps8Yc9DoDXWUWywCrRLi++B1o2iHP+2KBa4Rq2gtIdUFF2o8j26ZxGwiXV14dx6neU7nB+qJZM/pAvJMEVlPbXQHSHSYCYW0In5rtyqNqGuxcHFscbAo5uWkMQjt+mSTEVlYM16SWffobDPqlc=
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Thu, 30 May
 2024 07:11:42 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::95) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 07:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 07:11:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 02:11:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Borislav Petkov <bp@alien8.de>, Jean-Christophe Guillain
	<jean-christophe@guillain.net>
Subject: [PATCH rc] iommu/amd: Check EFR[EPHSup] bit before enabling PPR
Date: Thu, 30 May 2024 07:11:18 +0000
Message-ID: <20240530071118.10297-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 135a73e2-335c-40b1-b63d-08dc8077c1d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F23dX0bjLs3n/4cLz5d70MlJKmLIrWjoWdg8KvtbTySWN2kVIGg7dIJpwCn3?=
 =?us-ascii?Q?T65BeziHU74LtZKhqfeu0ltQtVvf5P0bogTgaLuzsEFUF3n8JCtz5/va5NLe?=
 =?us-ascii?Q?dq+GfvnuochLAxh8nMe22JVkqVIpG+DHuQY3Z8YLSmDFPqPy+wE+qTZ39yTg?=
 =?us-ascii?Q?XztNxI/YLjgXSAa3QyKtx2OHEBwpMWPYpFCcl99FrxYg7N3GJsG/Sz207oEv?=
 =?us-ascii?Q?WQ1lnViH1YauShQY3Ddz7PjL2yWpFiTfJNjHDruKhYb/MwE9MRI2m0T4admh?=
 =?us-ascii?Q?qgQO1vPIifN6hywMP9vIBOdXa44oZdvDr4pLFuNRdniFlC35/f3Wk1jllDGN?=
 =?us-ascii?Q?gvqnz73F3E8tfOUI8lUHDxiUnt8xYJ3AuY2gj7z1ouwRLUtUxQQQor/fvuon?=
 =?us-ascii?Q?CV4CAPd3Qs6+BuFh2aglzcx8CfEwS+iBA0Rb+0Vok2JMGvoBloPXioIRCLq4?=
 =?us-ascii?Q?YnRPDAOvaDSGR4GpT/HGRo4vmaMkmJISPmXshtdRQR1IKK0bzNrs47k0us7B?=
 =?us-ascii?Q?JHczT09RzX+zVExJswllP/d0Ar4MmhqWNPbigAkXdmbdu1L//RQT7zkw9pL2?=
 =?us-ascii?Q?krJHChDRdzfmHwM33UxHbU0T9tDVnW4xTNTDdi4VZwAW1YODZ9LrvvgpNoED?=
 =?us-ascii?Q?XdfAtoqgfQjMi8AUiyNDj7J5vm7a83RQqyVZsggGRoCt+kI12j7Lnx/X1PX6?=
 =?us-ascii?Q?EDa844CeEA8gBQ+c+BdSeEiVAysR9nG5D5SDyon46qKYsGZuIl61UMBKkmJ0?=
 =?us-ascii?Q?Q6rMOIdPGyzj1+aKxp3QawhMGix0NBTrV5Xdi68nouRSPDyj6l8qJ3jCuE1i?=
 =?us-ascii?Q?ytDwiYI7Ui4DilEYPKT4w+UvoVX3MjNXSPmHIIxJ+zkLPQx0lMXv+tBBa0tj?=
 =?us-ascii?Q?z+K+jx86hFj3dQcE43Ed91PlA2T7oLjZkXxK2hPIRGZmlm5md4Hm+CKe7l7l?=
 =?us-ascii?Q?A0JglS84MIaz78GJ6Fvtz924o/52J0OyRFapj4stravn6aVcrY1E3c2NwOmC?=
 =?us-ascii?Q?wjG+kMmkhzZLCfopW1tS5v+4k7H6zOZgboTfAFdIapzTz6W5E+vwn0z4SVJQ?=
 =?us-ascii?Q?YzLEVO1D4qDgaybvuRWqmpOK8cxcILUKzcIBhOJf/gneys5Uez9EL6Dvare3?=
 =?us-ascii?Q?drr/0DHrd0LgY2Kgt1F/ZMYK4s6ox8nr0PNXkmn/hii2ALs+N10GpCfmctTp?=
 =?us-ascii?Q?tFrqF03Z/hDCVj//+ctBYxqH8y3/Zre/xMy1wZKRfupnQwJbuR9JaUFELIq6?=
 =?us-ascii?Q?d/Q6RYL/2qTca1QkxBVSw8eQhqYEe6O6t5n9xXxBQry+Rl77eRwZAW/3Qgav?=
 =?us-ascii?Q?kI5oLGojdj0LOXFOORJFK24+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 07:11:42.0261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135a73e2-335c-40b1-b63d-08dc8077c1d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

Check for EFR[EPHSup] bit before enabling PPR. This bit must be set
to enable PPR.

Reported-by: Borislav Petkov <bp@alien8.de>
Fixes: c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218900
Tested-by: Borislav Petkov <bp@alien8.de>
Tested-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2fde1302a584..2d5945c982bd 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -129,7 +129,8 @@ static inline int check_feature_gpt_level(void)
 static inline bool amd_iommu_gt_ppr_supported(void)
 {
 	return (check_feature(FEATURE_GT) &&
-		check_feature(FEATURE_PPR));
+		check_feature(FEATURE_PPR) &&
+		check_feature(FEATURE_EPHSUP));
 }
 
 static inline u64 iommu_virt_to_phys(void *vaddr)
-- 
2.31.1

