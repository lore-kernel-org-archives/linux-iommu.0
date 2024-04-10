Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B2158210
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744232; cv=fail; b=dWMqpwVeoVJfkjBTdYw9qP2efmgR1rNRqDlGNYixPjnfU3oET53UOCdXgLRO49rYeCk/T6dPd7vWlTkxcyZszjqaXhzHmKf3x5Y1ljXF3lr2WuhdqA2QTNUHhRRw1FFMBZsNHHsvxTnQcfYDnSjUvsxWVWhO38Cnm3kF75CoBCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744232; c=relaxed/simple;
	bh=wwfLDv9C2ZFoMifEA8cI0VSoeo/srwFUG5+OuBvfYRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3FlJR6R1NvN2c4I3846sCsdpizE3IErjuRV0e8LDkmlc8ZzOnAprltKsGHWxdZggZx6TOdowVWCM1Lxg6jk1mCCGgpWEAvMcFcUTBzMj6drPsAIx9Yt3DS0oOEQtJC41TmZuMcYtGs0NGxf1MwLtIMkxuUrZyJqID0I+ZKeYVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T+lmp7xe; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+lmp7xe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWC+vUpAfCRIqVydwx0HSW9kzh8UO/zTJAVJs7PC4P4kuDoihzVdNpyDCunm7dAJ91ZLEjubIz8XtqKTedKboANal9iko4vjRYZKHMq1yNuz9RD34ZZxAjDyyr2UkaXM4RV8OREju2xdihbnMAyPrqnehZW9ClWLtW5lYuP6sCOI7QLzsBbVl+hgj1e9rZOgdy7c2jlrw2Y7KhWu0kYkASLxQA/Y1CgkXX3R7Kil7U+0TJ+b4jDV2AG/Dn8qORkRg+2vRiPeYVOWJUsGmPXv7WNZjCyZIepC59Ve6qQrcSs6LbHtIQQJYaeDYJGk6F92EBOA63XUYWDRRlpsoprVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqcl+qqshbe6nrH8O9x7tQ9dtbjigXJW00eO87rpK8c=;
 b=Is/NYJlnv60m2Oo1b7+H+6d6Cqlsnwq75D+hsvGfF37xXZSVOSQHl45ND7dZ7vbMHITRE6H/qC2VgpWNqZIBEnRV3o5H2ITZvpHx9CL2yeqjegsXBTTPCGUYCKoeuoRSj4fjGj9aDj9bGSXiUftogEcDfx/AQTWnmERQvZQRYHQy9ff7HI43hg9sxeMo8TrRW3S6sCh1uUym+PlnOgkLaAyw7Gt7QonKd3CVYWk91XlhNeiWgZTuJTS2xYYfINtCLKRywGVb/rDklfrtkqicjh1mVj16suUKPtJJK8EOvnxeOtU2BnRRH9t6nqzjhYmnhsqHCG66s2udeH0NhmjQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqcl+qqshbe6nrH8O9x7tQ9dtbjigXJW00eO87rpK8c=;
 b=T+lmp7xeNWY1lSTA+KqrzxKJvEME1886S/H0A1RxpRcSp2HOYrgJ0WiBgW3zXR+gshl7dwqNCUbyWF59l7MJ8XNJHDSSjLoQ0lr6Y1VHZCDnSTWMGxBjMVkQC2HtEYjD0Ryt2eIwcBW2xthXlAmfhdXl6AUByPTmQYNnC+wIwyI=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 10:17:07 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::7c) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Wed, 10 Apr 2024 10:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 10:17:07 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 05:17:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>
Subject: [PATCH] iommu/amd: Change log message severity
Date: Wed, 10 Apr 2024 10:16:43 +0000
Message-ID: <20240410101643.32309-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: cfeb7be0-d88a-4ab2-d6e6-08dc59476032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kht/znC3h+9x5aIYpWfLfZYwuXSkwO8rQVKdKe6MTKmRSo2CK7ltDWY5oslDyrMkeMMPGznRJd58IvvC+M8G7ZBXKTrqBNL9prUGXTTap3e/ZIFItHa5g9ce0GeIGCJyXmXQzxD5oziPkM9DC212xc97VTQk7yeJh94JFj1s+3fZW+yxd+mImPYZ7JmFcMLr3MebFvhQ+ZR12yEGuLvHUO3JC/UTZojRQl5KvXHQuGdDfB/wR77mG9jT4GOaeX90BeL7ImsQqjnvJupb1cY+2yCytjZNP7SdJ+2z7Ninb5V4/+nTuLfA+KcuyE5i4LFqxlO4/3C54DmL0AQ75WXAEEua+Rgrxzdia00Jqzq7xTccMUydf3oeYgT4LmDbt+b9Nx7elcoDDc+fa0URWq82vYllpVMPFYYY0ydgvjJ0Sch+i82pBOE2AarppmCqlEfSGhawcR9tlI2OVTWUxz/SdGTcgCq9XmO5wRa7W8fpxwGeEXTbKIgajtgBDc3zAXR2pteMJbezRIngCY7LtK0K6b1ofRMoZQ6mbL8WP7+7yhCRe2F3vA7AbBMcTs8cVIhWVrHnHyoBCwhpbgLeJtBhdTIxYUn5BMOE99mSP1LIHY2mFqDo/hRTYz4T3aWNY2hzNraL2cwcSPTJXPr56T6O4PV/y6/85IKg4o0FEBgBMK9L8WuJuKYQr8o46knbusrH7PN90XVfevHLNoHBSfxomjuKtAn0pFEwyrfN2iLj0ltBEsI+t+qLgs6tOjLZwjxx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:17:07.0012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfeb7be0-d88a-4ab2-d6e6-08dc59476032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829

Use consistent log severity (pr_warn) to log all messages in SNP
enable path.

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0d9b69765099..19fd1049a585 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3218,7 +3218,7 @@ static void iommu_snp_enable(void)
 	 * configured with V1 page table (DTE[Mode] = 0 is not supported).
 	 */
 	if (no_iommu || iommu_default_passthrough()) {
-		pr_err("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
+		pr_warn("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
 		goto disable_snp;
 	}
 
@@ -3229,7 +3229,7 @@ static void iommu_snp_enable(void)
 
 	amd_iommu_snp_en = check_feature(FEATURE_SNP);
 	if (!amd_iommu_snp_en) {
-		pr_err("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
+		pr_warn("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
 		goto disable_snp;
 	}
 
-- 
2.31.1

