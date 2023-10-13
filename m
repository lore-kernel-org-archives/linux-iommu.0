Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8601B272
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LqMXHBDt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oduM3Reo9FvtPk+hHh+hC6NbNhDMiLZ/FXdYS+HcGBeerVyIR8drDsYct57vZJ3ldA5x67RML2ckg+Nc6rB/KaBQbB7JTy4J1ns5a+NdA7JyvbiWay1ggSeP1/6Y6XAjwkPd5lwlkHrKFNkTWl4NdPsOCDSMsi+vVF3h6BvEX/oy3ZBZYf39U/E87wCHv9K5nU9IXh9rZB6a1u4kdNNNxKa/NhY28tF/kuIexJ7BrbSSnjw4LL/gwIQaSjkZL1OKtkTwCCOUFGMxcFX64t4GslAbPRN4C9C4LMaQLs8sTCYvGeEVhtLHNbTYRbTs+cdSL4CziLpZt2IxaXeKUPqgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQjDcOqj6sgu8tj+Tjij7DYilbJFtGtnzA1DtbJJsQA=;
 b=V6PFHPG5JR/ltwZ+OUE/cbBYyf/rs3grjF6sLe+3xhtN3HxUoGpDW0d+CM9R89lA+llLlV9beHEq2SxqcJwNW2uJKDx2cQ2o8MVH4/N2AnwnikF+gKa2AKgTPL2IIEgO089iATN+7TWHPlJKAS0m/Ee0HzSK170DV5+gCHV5WwNhbTeX1BaqLb7YS5EUA9FlI1BkTdoAtbKgcE/rA+2DNXVOG5c+0s0Dy4fgkoA2rzhuT0QRkg2vv5LMBWCLFWVHed2NzJlcS84Wzh2fstaEcAkmi8K1QPhfBaH9ODdj2mCiXlMyPhWd+9O2sFwQAQ+0ACqqw7Qh/HgO98X/XQKq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQjDcOqj6sgu8tj+Tjij7DYilbJFtGtnzA1DtbJJsQA=;
 b=LqMXHBDt5G5iEN+7rm7vdNQAYXgJ5S19ZlPnJJaUNo56Wt5/lBXOZqrl1IM4+60kDUmzym0zmbL5B9Zf0K7mOnDZlxsLRmfUZ7PfseBYMKSjq2FCowxWcYAxWAWOthzlXzn1jraOXy0W1XEJaMcyS+3okqlVOL0LEkx0qqY1vCM=
Received: from SN6PR16CA0066.namprd16.prod.outlook.com (2603:10b6:805:ca::43)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:21:11 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::99) by SN6PR16CA0066.outlook.office365.com
 (2603:10b6:805:ca::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Fri, 13 Oct 2023 15:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:21:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:21:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 11/13] iommu/amd: Refactor protection_domain helper functions
Date: Fri, 13 Oct 2023 15:16:50 +0000
Message-ID: <20231013151652.6008-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2890b8ca-866b-471a-c79d-08dbcc0007ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SQS+YFG9XBx5HeMKCcIwJPph5OWT0+cjeMfK4+rA0hCoaFEODokLNnO6EkepKXv5KWE90lBsuOKCfAo4ldoHtNv+t1VL77a2dQb3cINaEE0ODu9Br9Z/IsYESeJgyU0lPDSNUhCjqqxU7sEuJdpkSGpPzjrbNHJ7dONvFdyfn6cnv2+Ua7v7b0c+hIS2PKI3cdJCcyB9cz4llumjPWfZGiZSRn0FopCAVayWxc+axvNJTZr3ncAUoAzeg/QjzBMCkgnybTIn4puiANmhlfWJYeflfmurXb84dzAETtz++S9JAsQbSkdp+akygfPjlL5dG0KvFfo7R+eJLghiqyNQPktvuMLVHcLcZVFWYaDaBRQfu9fqaQbYGn0fwmYQOvHhZE3+Uia/6yLRhw96iESvyMvwrnFa+VoMZ9WPzTLA+pSujbSXb8a29fH8XLMUPFQsbMXia1NzmOIu4MtV9qPr2kaHy03He2GDpwTxcuA6lb4XRAbUfsrtL/VOTTf6r9u97FPBYWtrv2AfREB23HLfrHtOXlQEqvT2KQmdL0O7nWidbw5xJ+I2XwvRNraKuWp+ryJZoCdZUNcAiF+NnJfax9GhM4342fbGuppSZd2eUtIyAZCV3oiOAvZF+fAzULPvwIPaYoqlypCzMm23Vr4LpUe0fcVeHe6ocDttu0rONQXi1ExluRqSvzsI4vvtVDS8Dl9uxM2npFQFZzOEwyn+ejpbB5IWd9/ZdkD7gFDeIfrOIYFoufRKMq/raUoYYYpLZ3SajW4wxQm5PJmo6y8oaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(2616005)(1076003)(336012)(26005)(6666004)(16526019)(7696005)(47076005)(36860700001)(83380400001)(4326008)(5660300002)(44832011)(8676002)(2906002)(8936002)(478600001)(41300700001)(70206006)(316002)(110136005)(54906003)(70586007)(356005)(82740400003)(81166007)(36756003)(86362001)(40480700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:21:10.7365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2890b8ca-866b-471a-c79d-08dbcc0007ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To removes the code to setup GCR3 table, and only handle domain
create / destroy, since GCR3 is no longer part of a domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cb24bfaa9dd0..302ae7ed6d7c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2335,9 +2335,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
-
 	if (domain->iop.root)
 		free_page((unsigned long)domain->iop.root);
 
@@ -2365,15 +2362,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static int protection_domain_init_v2(struct protection_domain *domain)
+static int protection_domain_init_v2(struct protection_domain *pdom)
 {
-	domain->flags |= PD_GIOV_MASK;
-	domain->pd_mode = PD_MODE_V2;
-
-	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	if (setup_gcr3_table(domain, 1))
-		return -ENOMEM;
+	pdom->pd_mode = PD_MODE_V2;
+	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
 	return 0;
 }
-- 
2.31.1

