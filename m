Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B03E0C71
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091587; cv=fail; b=QrxNc7ksReXVPgg9EU752cAcTRkpy8+9fQduO7DMJYVQsDnzsUshtGvU5uK+SSWUw7OpmCpmFl8Lji/37LU4M3n82xoQLZv5qtjFrYuOXZB4+NQtXkQslsCJmsFb9ISdZvmcWZrArVkaMeVq6VPKK4LIbt/RdVy0kyD1Hy0/ToY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091587; c=relaxed/simple;
	bh=A3m04a6T3uV56T99DCBuRizmO9Fj7gFzCFTsyhq0Y6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7SO0iXojvZNL1RGNzwNP8ZOCh9J/NMX2Xv7ZY8uIVB7lkeVAZ3rXu7U7xUdIJygL8hhxgyAvOnG79Ej7cjwAh6Qh3Mi+4eAk5ooCOyZG3U+IQb+sE38/lK4y3Eh8fBhILEc7KJgOv0VyIs9ZYBQY4tH6fSJC2LXvVibRpuJeWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x3mTgitC; arc=fail smtp.client-ip=52.101.57.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x3mTgitC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SELK0EYKXh9aCApaN1T/CDAW2JzKqbFFNf+bXN1Rc58H0c1j6dOn+eDAELm67mVottaPfxvmdWVuXb6ekVaN4Rbv18n453LyTRz0EooyMEz2IFu5Scq0N6zpQyZcI4wui9fDlfvsN4igL8QuvIgoQOkgtxwGMts3Q3kZTbu38T9PnWxQ70ybmqY1g6oRPSlzm9ElJNSoNAs58z96M8N3K6gRFQuWhenUSvQwO1VSzTRlUWhmoA3vouxcvYZv8d+rHqwBTaGeoHvaZ+f0j4lQ8PSrbM8gLQ8rxzw3/9+vYjaLgK5Bnmuqowa55AXLpbMclJkWbXAJ0gh7HbJpIIVi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN2r7IGn2VCQwf1ygr0G+ZWPH3297hlzlroqsHIuo7Y=;
 b=FeaLajST07yLnrOj0Za3YEj1z7SwT9kkE9OplLtpE4F2Q1Nj8fFMfwNLVSbJXuhrrDizrqjs0k708zQ46s9FWiW4P1qD4n4+LVUlnhv3CZ9C31/2sPOOnrz5z4WUqV/m19vjFNVwuUpFuLf0POjZZZuUSDZHMx0qp1/pD7BneFSvDaltuMwwlYMTi0TwFwiMW1/J3txHRa8wNhCiHelSczIbBvUoXag2wpQRb+1DZLSAaeh40HoDgWn+IeD184lnQCxC3zcJBlL9tmYAqs53bf9V6AvL38AAGLNuu4dlCB/M2v8eQ0rHLSkw3nt09r8P46Zsk+2YUTBX1MC/DF3c+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN2r7IGn2VCQwf1ygr0G+ZWPH3297hlzlroqsHIuo7Y=;
 b=x3mTgitCrKb1V7WH6ugE9x30RqA2riuI1E72Nm3uJ1FVbbuZG6wMRzhSD+zHdawRKZXB9XPxU6UrncKbEKo+1ZeE9id6sNNi2MCGRCggMseOLrrdq3nsCJhVI9tuZzZ+KK3VIT5x910V22f1UASaA20gkLP0D8PnaCQFHMCZUmM=
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 14:46:18 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1f4:cafe::4b) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 13 Apr 2026 14:46:18 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:46:13 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>
Subject: [PATCH v5 2/4] iommu_pt: support small VA for AMDv1
Date: Mon, 13 Apr 2026 14:45:19 +0000
Message-ID: <64515b0d53c541ae52347ac3c0f90b75bcbde0c2.1776075533.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776075533.git.Ankit.Soni@amd.com>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: d11884aa-266d-401b-2432-08de996b6bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hTNBThr9YC4sKNZUb6yDX3qUe1z3wThwSuapc0xBPgk/0Cxt4euSsuen9b3Fjl2PWF7Nin4jMsg+R1N2I0aOQdDL5SQlacs+E++T8nyeXMUAYrYaDlaLaxxlt3gbzmEC/oOBi+5YwKLfGrtusuUHs44tfG54K056d/JI1s/f9gQGIr3iiMrOR8ywWYfXb3KaRufQ389bpp1ZC3A2YtAmGLMr9eVHiBaGtkNpxDk9PCYAYqdJ+NF1cSFsrpJk6rht3CULe4lEUezKN1nbdWuLMWgCXe7zTW76GtAYYmJPpNm7oWX42Xvv7QzWS2P5WUh32PcTIsiU5Z2StLiEfXTTuZP1v9mDclF4fB/1glWxc7rliukJ5VMbbwvuGWmxqoeA207XqR3tEwTiUZuO8Zx78uObYpSYN5b8BJrX0SUP3E2fbWa3C+BRz27RFoHSNOmk0R1Fgzftu7e85KEL9KpmujXzSlGxUBkwNTy5fOAexqlYMY1Oe8rFBq0nJzBLsNaXKbhN8GP1VA/yr/egpGpFAq/38bgBt9Bx2g1dJ6Bdigp3L3MWteCFzebqB/l5AKMXMAUlbA7hAzV3L1xE2nSmLNMCtHJITiLnssde5aGRpQnDneVN3LQDbzuKNUOyXWTY8cfRIaVSgf4rb4oSwSm5gWtrC8RO3u4DYJNVQ1SArMDe5AQxwDPZ60X7lFi84ufi+Gr7KW0Du+m4gdyJBBdfzQrVtQp6phdvD0qC5abafZZhXcc5aqR2eWU+M/mEp3FkvXALSlOycvnGeIlYJgh+sw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WfmqctT6q2ZaHYzoWXOvIE+YFWKBJPJ5eAdQCNs0a2xbvNbXRAipojN8x0K+NiiSa7h8Wy7MnSWg6pZa3vB6tznQNqjOBSRBUGrA7Iwlr7Iu5L+UpMXoRUMxmOiXPwgi3GFN2hPmtwN6kFWjQBNWO2ikYTn9pL2+fOSO9IqDKoR6jJ6cxc/H2JCx2izPdyLa3GFbOuRA046RKLhAgAa4PGaaoOYG/SmatfPRSG+tJy6QapHFHWpPRg1DUiG7m3Muy3rr0vIIveEVa9EOTK1eNJUHaQukRy/Uw5K7EmUZBmyP1lYM5KWuVvnf52JmMp6kBaUpks1oz1vU6RkzIMo0HHar0bxRoS+ImOSqwvEp56ZcL0ruosJTEolbZgh3JQZUFSrjhBCHnF9oD7GjaLXTFfwW7+5/8lLXbLKpW5ubKNAq/cJKU0A1nfTgZmQWFv0r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:46:18.1732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11884aa-266d-401b-2432-08de996b6bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690

When hardware/VM request a small VA limit, the generic page-table code
clears PT_FEAT_DYNAMIC_TOP. This later causes domain initialization to
fail with -EOPNOTSUPP.

Remove the clearing so init succeeds when the VA fits in the starting
level and no top-level growth is needed.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index f150e3a7f545..d91981e2128b 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -1129,10 +1129,6 @@ static int pt_init_common(struct pt_common *common)
 	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
 		return -EINVAL;
 
-	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
-	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
-		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
-
 	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
 		common->features |= BIT(PT_FEAT_FULL_VA);
 
-- 
2.43.0

