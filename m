Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F3433C8
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712639674; cv=fail; b=uK6x7Esw4TH3YHCDUaIRB8ZFPhPtVjjLk2MRy9C18E8X/7DNGadnV39D6nvA022ByxAdCGaG1tCxMKLA6+sIY7/e2+B98nADVX2KcKwsvhGocRpG5ZY7aruylqWO6SBc3YC9M4IX+Fy5RL0GbfsKOgCDqGAHyLoJCpmOLr1HPn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712639674; c=relaxed/simple;
	bh=8PNapSFzbYEz9uf3cCxTYYa39cHDWoZmoWzQ7GuBaD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ruHFR5uJwfdYsJ83zU7W+XbOO5YpTbxuhx+mfsRAa7rIrDmnPxk6VK7JjOyZHvpm9uOd2m4ffQkNuIAcWWJWn8lT2073wiQdMGJYQkkz/nSWnoaSMKY+zS181g8ObQEP/Bpow8X34kHn9mj2ujh7LUcRxVx3lzsSnmKMK5k+tWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WnHWLEhi; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WnHWLEhi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0VwkYJ9Mu1ZK/hRnAXzEqjjctmagWZOOJzQ8HinjfObZTbfaU/+hiNH3gJjy8EzSS4RAdhQxR/aNAUvmF5WhgHJKVlb8zYaHccd3sRvKXf5oC8JP10XaefzxHQz73gCHvZKDoGk8/pYHjFFRC/T/9XsxX5NXDLHHuixQcuvA7nsT4v3ZQKT7srvBXXoJEfEZPMT2u2lkqyxCR3R/wYhbkW7jPgYWkHdro97/8a2XBmZtSjljjivFOXj/2PXrZoIooKDzC7spnaKp3mkn74ar9BGk/+D8je9FWg7Y2g9A4GdZQdVt6ZE1CVvaYU/4OuC/2dMvgUXA0uL0kBo2oJgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUrSmRO5rLpun/y92gCI4c19bpzFkLgyu3or9GnDBGM=;
 b=eWOB0tO6YT4oUX78Uznw/k8cHI9MWwS1NejipIwjI8FcIm0jbTq8x7gT/7+GdJ7p2bXNLQ61Bx+WNAILnWm4DyM9bjvkK7dj2x6vNFvufBPllB6Cw2llh/KolReshZWRlgK6TPmh84GVblt9p8biqGa1KaN2OWvtzgeeflpMgkKbHrFE+x2a69qqq09Rdyt+sYpYzxiVAbeGWt40td5UPUhq3k4ev6us85OZjYpGxINAeOtW2KCApS2CSvcg+zT6qKiptPuOtHBLnLBP1X+V/JBkOOVVcdjjS3E3xZf1kB0ihGKfU7Jqn4nK9mmsf7sKjlo1Pc4k51uJszgttK2Gsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUrSmRO5rLpun/y92gCI4c19bpzFkLgyu3or9GnDBGM=;
 b=WnHWLEhihY7q7W5hmz2LWAah2+kw7ZZl8VPa8og63yf+lGVDUigoF8CFD6jLIHvC7UUUyxKmCvLOSByDkJHWcJRJ9jpfklIsh8A3OLcPrRsKxzR08P3Pjl2lK96NMog06omZejQ107SWCDtEWZYaNpPIun44NQn2uK0avmAv6yc=
Received: from CH2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610::31) by
 SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 9 Apr 2024 05:14:28 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::42) by CH2PR05CA0018.outlook.office365.com
 (2603:10b6:610::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 05:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 05:14:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 00:14:24 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <bp@alien8.de>, Vasant Hegde
	<vasant.hegde@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Michael Roth
	<michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 rc] iommu/amd: Do not enable SNP when V2 page table is enabled
Date: Tue, 9 Apr 2024 05:13:54 +0000
Message-ID: <20240409051354.26429-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 54da2458-af10-4ffb-cb49-08dc5853ee1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J1NMTf++HuXVlii0SxViGW+mY7bm5m5N1eV7AJL2nb/yetTG4Emz8OQMGtUJt9Q396D2o9dFlgjsKKGy08x/mnD6G21qr5uIZvq0B3mbR2Yzb7xevaj1r/Gvg2dNtpmm6OAVNC7syfORw2L1EhnxwFjnO1x3e8kA0KVn3zhFvWawh3PBr5oxgg/Ehate980G1u6fmW6SOIlqT4/lUwbPxHLtKQ7HabL6RCKP4HWtZigfknH2RajvssMNDvNlCCCQJQetQhkP4Ygkbb0rQeal4/xSMVzxifw89dQY0wU5isZ5QXhU+3URrBf8n2i4dSFwV6xLWnCoXmUalaziuErhrfKJ2p1VgjinvykAaD9mTZn4d50NpyOzX5nIBioJwxljqaZUm2ALAG2eeEc/vSkmpjVAuGA3FDWAo8ROcJh4JPVvMbiHGyXaAgaA0pdoO5HonGXAnHTw1noLIAA+noQ2fU0yOf87VooLnLGJtX8+JV1VK+AD2MqqUkhc5zgh7n/N6vTiU7fx98JurAoflYx/5dSosByF74YubyeSNThhHreV4kVXs9/gCrvOdjbajKFfXbrhSSdWStNOJGS8gwX2gMQUKD8GPSDBVHA97rAVsbAGnOzxwMgW3Vt4TULETLfPZLeZXsGpYM9muhjPIkWN23d+ThldF9LHAQ7SBpFGP0f1/xImMSWVD+Fjc5JZ8zf1V5pVbpMtlh/JfDKk0ebSJUDKvsFhm5/WO3Z4LknIu2Gqd7DfcS8nyeV4OV6a7V1K
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 05:14:27.9602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54da2458-af10-4ffb-cb49-08dc5853ee1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034

DTE[Mode]=0 is not supported when SNP is enabled in the host. That means
to support SNP, IOMMU must be configured with V1 page table (See IOMMU
spec [1] for the details). If user passes kernel command line to configure
IOMMU domains with v2 page table (amd_iommu=pgtbl_v2) then disable SNP.

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Rebased on top of v6.9-rc3 and resolved the conflict.

-Vasant

 drivers/iommu/amd/init.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 005981c2f96a..0d9b69765099 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3215,28 +3215,29 @@ static void iommu_snp_enable(void)
 		return;
 	/*
 	 * The SNP support requires that IOMMU must be enabled, and is
-	 * not configured in the passthrough mode.
+	 * configured with V1 page table (DTE[Mode] = 0 is not supported).
 	 */
 	if (no_iommu || iommu_default_passthrough()) {
 		pr_err("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
-		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
-		return;
+		goto disable_snp;
+	}
+
+	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
+		pr_warn("SNP: IOMMU is configured with V2 page table mode, SNP cannot be supported.\n");
+		goto disable_snp;
 	}
 
 	amd_iommu_snp_en = check_feature(FEATURE_SNP);
 	if (!amd_iommu_snp_en) {
 		pr_err("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
-		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
-		return;
+		goto disable_snp;
 	}
 
 	pr_info("IOMMU SNP support enabled.\n");
+	return;
 
-	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
-	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
-		pr_warn("Forcing use of AMD IOMMU v1 page table due to SNP.\n");
-		amd_iommu_pgtable = AMD_IOMMU_V1;
-	}
+disable_snp:
+	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
 #endif
 }
 
-- 
2.31.1

