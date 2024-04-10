Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D51494D6
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739459; cv=fail; b=E/raBgvSmJ2u1/YAU9uwcyP6gl75GiyK4RybXai/WloBnexNY+JNbLIp60C0puk6TjBGr5rUqM/HrkLpYOeWk5ExrjgGMyQ7cYGl3v3LQhVuK67QzU+9+t3vGUGJV5ahewQJlSUFlBlAVUfAfCOtlIUM3ifBN5tDJ9TgNhMFlqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739459; c=relaxed/simple;
	bh=BJ/DEU9kenq/ZDq9OzW6lO572P1gwyD7A1gUvPvOA6M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BEzf/L6rJzugztD1+I+z0xMsaTxcHfscqdjAA+X29CqFGldEj7MhGOrpoug1tLYaUK0+5ob9YlRjU0NL3hKewGngf8Qa+YbYM5FpnqGo9mSKhw30KIWkQYZ5mrLbfyE0uS2vX4WTWpc5DW5FiotfIvgFGJJ93hAUWm9RPZOEIgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cy3G2NZt; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cy3G2NZt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGMrvhwF3fHNH07pObRevLNebgqUR8dGaa/DN423d5c5CJcBLu9vl6muRlRPkVwfZNzd3zr6MTkzOdrIzyh8mHQ7kIat3LcMlntsnbQF5U7F0lnDGyrByQLwnNtITwYQrWUyFhApLr64PsdMXZ9C3Y0C0sf6H+xdmnOtEptaKojnMsaMMeYQfoDmcB9A6yncaSszZ+TkN/mtQr2WuqedyLnk45sp15XqiLrW124ZkEaywf6yQUBCNlory778Y6aaPDHsXGsVQoJZsJoC6n9HREEWwU4K17ycaPUDJV1eZB83u6T+xJDspEufWT3Ijmdah35kzm1G4g5X9vTILFVBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVb7liGjyvtuUDV7uQnyzk1m1tLM2YsMjWV/audpzK4=;
 b=fBbe9EL1W5BQlY4TTXDy6wJQXsPL696VA9oQY+c4Dvc2H0Dm3Ubs76Gyq3w4D1rIgPgTmt+27MvXTUEyWYRVLzKnueVhP+m5uUc/m6kHXBaEJGzCPNTUm7eeKaJC+POhjj/MZkV7IatqjJ5mjBO9MRlYAYdTj91SUWsCyv386nXk0tVjkvgXncnBGjv4VkmaZGTkL+dgrZpUV5v/3SGeg5rgw4iCG3GiY+iYieNoYzXBa0IoA9Hfa+ZpdT+6U6C+eLXWg7vbBGkgoenQIJdov+Y7Sd6QXpvf6vooBQfU03mKdu3ypjxRCRnAAT8OP2gemaPXZyhx5PhrS6bNVG+X5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVb7liGjyvtuUDV7uQnyzk1m1tLM2YsMjWV/audpzK4=;
 b=cy3G2NZtuLzYAR7tULAGl2iGPqtUe62ohRzhf5wKZRrvXbh/DA3cmkcFftIXSKOpmtoUGYF7Lbkw9JxmUiC6YTRNR3trvERif8xWnfoJsy1Od8m1vyayF/tuDi2xlWAlLIfwbHzSUmIbHdIKBsgQhXAqWs3ZcHMhj3EuQyobQvc=
Received: from SA0PR11CA0145.namprd11.prod.outlook.com (2603:10b6:806:131::30)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 08:57:35 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::f0) by SA0PR11CA0145.outlook.office365.com
 (2603:10b6:806:131::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.18 via Frontend
 Transport; Wed, 10 Apr 2024 08:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 08:57:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 03:57:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <bp@alien8.de>, Vasant Hegde
	<vasant.hegde@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, Michael Roth
	<michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 rc] iommu/amd: Do not enable SNP when V2 page table is enabled
Date: Wed, 10 Apr 2024 08:57:02 +0000
Message-ID: <20240410085702.31869-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: e347d489-47ad-4c4a-59bd-08dc593c439a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UOJscauIvUFxgvwdPfsKBubExM8Y+nR51eAm+sgWmhenAshnSam+t1tvty1LW29VXJ5QM48nPXnquEmJXlBG1K4/kzCb9j5xdlVoVh2O6QqfxU0Eo/9pjO58lEk0JNqHFsY2FzfQKbx3fee9CGO17PBzJz5xA8ll4P44X83VSQEV5Taw75psCyA+uUEbcnKFjVx46eZsfq0cuApNR8I/DmoDQW/D1MAncomBybIkLDtk62RnIdrFEgBMSoo6nJoy+DTzJ06Vqsa6dFGjUrrHNbmEkHDG4zSE7H7jOdeBwblIEfLri3KtSMvym3DZuuaaUeLKIrCSxU2PKegZ9NL3hai8aBnZoPBXCogStz+4s/Ilg/kFcRBqv6PrFTdFKs4H6E4xP3y98MtiG9OZWQdgkJgmaf0rfI6kwLBnBPQBL8Ti7gN6vv+TBxV9/sKCvgbxPdT8iZu8NCK53Do7UrgyQQ3He5sgv5kiXHKo/nn1Mimz6gNc5kAVgw1AQDRVB4739GZt1dCDzWARkJEQExSCVIvG5Cq1WR4lW+XhjkbxcZVohyWzqvhnQog5C+jxIR39xTZ4cCsUXbZIabPkb3j3V33SnX8uzrEmhyPhqP8lFHweE3JQZxX0rLU4iImcfZOHkKXmYcnW140eNI+HXlT8jfYYXITaz7h+fJoASH46vmj8SKjDcIIYpZhbw9T+QZ1OfExxwAJrFvAUfgsi7zpi6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:57:34.5460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e347d489-47ad-4c4a-59bd-08dc593c439a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

DTE[Mode]=0 is not supported when SNP is enabled in the host. That means
to support SNP, IOMMU must be configured with V1 page table (See IOMMU
spec [1] for the details). If user passes kernel command line to configure
IOMMU domains with v2 page table (amd_iommu=pgtbl_v2) then disable SNP
as the user asked by not forcing the page table to v1.

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes in v3:
  - Updated description and added Reviewed-by tag.

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

