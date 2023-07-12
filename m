Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48708100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzJpN3CfRInBq3NL+FdnebXzHYv0ypdYAEXNr7yDRufxzGyeB+oJsumoRfbKs7oRGF7HtecmkeMJdt+7rbsUYNImV5JCpCA16ZhPbadXN1Cr0AAD0N6PG9yATAnqs/Ekq3u+I+RAPSeSu5IbGTxNnFgtVowOkwYiugymeNoCWHm6P6Iwmrh+ZHaDVUwfLeCWB3NqEsg6wzMo2f10LVIAqNwXiOYeRvyMYqr0VKKV8iVwkJOo5dFHB7bc3MBn/fvLxaQXMY/l6k4lJ1yZ6WwRKy/6WdF0difIQIoC+QM7vALung0BIw/UJ4/UdeSaVVdws2ZJ4+mKzsmYipyDg+XgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R74BI+Ka/xTljjdKQBcHKwsmjn11XLCz3d84bBvl1hs=;
 b=cdCV8ILNBffibTxh6dlvtun9/wSqswpbwLvOL8ru9kconvLNwYetejT1q5Zb2qkU37Z+ZpWyA6/m92KZpnUmN11KbjdvWc9RvEI5ECpUdEQYYB6BJFJ++sixp/8vrjkQsWEbk073FOqrnBed20rBAMHNeFL7EeM+3cQXn0D27R6F8XSl6OjbP2z6AI91Czr4ZWU2zbrc/HlCTgq1LMb1EfgW9+Dryv3S1V8kHSv642YUrssCijOQ1g8H82bbkjgZP9QHWyEgxjS/dp2oz49LnbZ0sFzRLZo92/8ZxcSs8XwrN5fvYmYGg8ShRIxW/2RlY4/b3mcPXOk0aJZ5NMK6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R74BI+Ka/xTljjdKQBcHKwsmjn11XLCz3d84bBvl1hs=;
 b=hapLowYX6moyStq9Bo2XZZYRR15BZo2odL8gwmDjB+j1JCVxZsLDWJPObss53wLYgKI5zDNRmZzAqXG/7hOgh4I/+9PpG9waeWixnVlub1KYdOtLDLIn2wgl3KgeX40bF1iYq2zxLGrlYEVEUBQQ5unbXeXGAWXY2gI9hw7vTNY=
Received: from DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6) by
 IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Wed, 12 Jul 2023 14:17:54 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::54) by DS7PR06CA0027.outlook.office365.com
 (2603:10b6:8:54::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 14:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:17:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:17:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 08/21] iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
Date: Wed, 12 Jul 2023 14:15:03 +0000
Message-ID: <20230712141516.154144-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: daf440ff-be59-4137-a8d9-08db82e2c8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W7boua01Mk+EQvoyG4Bruj6GA7kCToOUjaQuysCK4ZnPcoxg0SgMahmgeW2pZr3cWWiNCHByoqKx/MDNL3t0xBrtlQP9CXd2uSTx5ePDYi6OgLXpxPgucvvS5bBPmXm7/ZiHf6T2bOBEIlSDfP8bhtqro/1KjoQRuL2wgqwNJngnyw4uDJvZYuk/dZoZzAFNLkVF7SedlX2jjsuIDOUJSMlzQ36OnIr3FtVh5B8Yh+pW+PtSTdPWH6efeH9M4vVFeJdI50+mvzDL/OLWMb82fj4sYUGi2RhOzyknTo6+ThWWInKne4AdZhOFyr5LgHZamEro9mifKNnL/OOvKLj/pRGfB6Styo/jz53dMBHFktVCA/pIxM84dmbuX8s7jb/3ymA0s9IPwhy1SaNO3wAQ/GqONLlFatw15h3foLuVvH2H+oGKwJnsRhdWBF6QDJHowg5lRQDznujoHm7ZyFi17/wH0Ha4fNTuUOmQa756X9N8mjyisBpIhEdabAbatnr3OUZcnSp2gVHjiF1uYDJX4QpkmPqw6oCP7ts7M+RkUS+REJFTvKX28eNEZg52ycWXIrq9nVpWhppHLzrWB6HVmDYNomlyHtEz/HCQjfioh/vu6EiV0RK0dsQ/adsYG4GCeRJFp1DOehg5YMHY6Y4wQ+gp6IeHrcXab84x9o9yyA7YGOYh5BdAQe9twMDLvOpQwrngF0027oXdmxI5X7/9BLp4DRTD1WmtBuzavibG+CvWFi8ljbGiLr3yg0vcJEx8xsGpY5LJN2nuZDZ59EUTIA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(426003)(47076005)(4744005)(2906002)(2616005)(70206006)(36860700001)(4326008)(70586007)(316002)(6666004)(7696005)(83380400001)(110136005)(336012)(54906003)(5660300002)(8676002)(44832011)(26005)(478600001)(186003)(41300700001)(16526019)(1076003)(8936002)(82740400003)(81166007)(82310400005)(36756003)(356005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:17:54.4998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf440ff-be59-4137-a8d9-08db82e2c8c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328

Since AMD IOMMU page table is not used in passthrough mode, switching to
v1 page table is not required.

Therefore, remove redundant amd_iommu_pgtable update and misleading
warning message.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 852e40b13d20..2b01dfde6cab 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2134,9 +2134,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		    !iommu_feature(iommu, FEATURE_GT)) {
 			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
 			amd_iommu_pgtable = AMD_IOMMU_V1;
-		} else if (iommu_default_passthrough()) {
-			pr_warn("V2 page table doesn't support passthrough mode. Fallback to v1.\n");
-			amd_iommu_pgtable = AMD_IOMMU_V1;
 		}
 	}
 
-- 
2.31.1

