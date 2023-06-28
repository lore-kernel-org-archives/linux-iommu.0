Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB233D7
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:46:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMMJP/ArphwRRYFukqFWznm5hKLsHsXAtDRjnjDSU3B96+bVdjKr+mGog0qgRbEMENRaJYW4PEzPTMe5OpMX2uJERixuX1khfm9rEABLTonHdW/PUr97Vo1Zj/ehqpsfOb8Fq9MfZ23GDzJoYd3wMBvqV4ArnW6qp7+RLwWhwcL+uCMXKpW5FKJNbuE4wIMnnkazbrPPUJe4IrLSQU/cE+T+cghK38qSyL6RlAa9l7OzYWrLMFQehhEi/ORWKeiQelgg2tg11Q9BpjLea0HjHzFF2t5biouTx5mFGWR3JJ6POYxpeFi9TYUEqch64tMUaNXbchZtIo62f02yh0wm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywuK6XLqNNpYHOdmaN+YZdySKsi2k14rlKFoIjc5JJE=;
 b=GzJXiSscTe8nvHFT5nv8j9Ww2CEPAqKZhZFexEsfXqfmjk1srxZHMmz5ocmpBbb4mjLxFVxjh1HdiPDmia++c/GMwKTlRe5FSzorSE8WTCgq/7vIiGGi1IdMokDtDDOlkbanhrZLmrEJj14erAx+wWakkKgOoutaZqHMuX9St+ScrofULjBkpSpbQtEDmOwHWv3sDJgJk21xSV4zC8Y+Dop31C8hjviZrcAAQPMYiK64A5alMSAyyTxEMi0tapagomlWECodBbm0eTF6FEMCwi/y1Wdiyih6aE6ldTSpmip+Ot3B3tOQ0ekcSh/sHajmT04ue5q4qdWZfwvvyEQqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywuK6XLqNNpYHOdmaN+YZdySKsi2k14rlKFoIjc5JJE=;
 b=3KoHY4dQa1RSHZewRnUa1+v10M6wlBUYXmAomnsn/6D8IN7b5Sx2/8tY5bHUgPpGPM2Ti6jqAFvbBti9irmR5RHgz70JsA3zYfsS4h1KfKVPqprcOyqcgCWHOGUxn7eps+ZUs+xzV0C3QbSF4nSFkb6KcIWJyuF/8x31h5RHhPo=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:46:42 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5e) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 05:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:46:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:46:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/3] iommu/amd: Consolidate PPR log enablement
Date: Wed, 28 Jun 2023 05:45:53 +0000
Message-ID: <20230628054554.6131-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628054554.6131-1-vasant.hegde@amd.com>
References: <20230628054554.6131-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT029:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: d20a83a2-c692-438e-23a0-08db779b0ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IPOQo6xZ53LStFkv4GYtO0F69xRgJE1JydYQqX4bfIMo/bLaU/uuS5kwa71F87InmK+szJUA3FGa7sZjGeM6kjf4TZlbL08kBvO++wc8/239AXZn5Wb1OhMYf8+HLzwe0am7Y+0jWXmPocpqpEJNvQ+1ghmTP2NEnHCDdg9MHtZmvuA+uR5zvOpnKrgOLOkARnmLt3PRVbGm+LDJe07nmt0H1iQsJp3NfiAvJUUo3eijAH8kWDViaU4g7lW6204/tsecge958n1c2o8Hw71IJREbawpEQEuarAa9ddPcAOb8+G7EQZbg5e08Va8EXU47U7yS7mRVgg/SU7bn8GPFCT16qjcMMkEKA8i2qmSbxnTk7ecsht9zJRpI2M0T6p1X3ypkvPPRU5AG9jukxFEJ26iOY423q6b5M7Mr8IsBmRdkEAdIEe8Jgq7avXzGbDfNdLqs6hYWqGGYr63hw3JGPfaHz1Sl7LwHFZuFEpQJqYOoidaxqubXIU9L3+OG0MFfKQY7D9irX1ke58khs2S2vbITyZBLYXMnxUBji2b7QCApJ3rVo7H8o8zDl+3x7Zl0vX4aRMhvlSzoWSOdzLS97JazbTRuHEvWVC0+vQsYwzD8zR0guTVTl1WJK6z01SlCYDnYOg6v4909+iTGM+jtJhzQxDKM/e41fUs6zDqeqpSKwuTPKJQXv23++/VBLmsMFN8TVZttqSQ/DbBQ1OmTtpSbaKr7yvb7ohn7Ack88qDqYmQIYM+29kPFx/c3iZRgAgoRDCnuclcENIxgz/uBuw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(26005)(356005)(44832011)(5660300002)(40460700003)(70206006)(86362001)(8936002)(41300700001)(4326008)(316002)(8676002)(81166007)(82740400003)(70586007)(40480700001)(110136005)(47076005)(36756003)(16526019)(186003)(2906002)(83380400001)(1076003)(54906003)(7696005)(6666004)(426003)(336012)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:46:41.7058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d20a83a2-c692-438e-23a0-08db779b0ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943

Move PPR log interrupt bit setting to iommu_enable_ppr_log(). Also
rearrange iommu_enable_ppr_log() such that PPREn bit is enabled
before enabling PPRLog and PPRInt bits. So that when PPRLog bit is
set it will clear the PPRLogOverflow bit and sets the PPRLogRun bit
in the IOMMU Status Register [MMIO Offset 2020h].

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 94c91b6ee603..f26c077eb9ea 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -934,6 +934,8 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
 	if (iommu->ppr_log == NULL)
 		return;
 
+	iommu_feature_enable(iommu, CONTROL_PPR_EN);
+
 	entry = iommu_virt_to_phys(iommu->ppr_log) | PPR_LOG_SIZE_512;
 
 	memcpy_toio(iommu->mmio_base + MMIO_PPR_LOG_OFFSET,
@@ -944,7 +946,7 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
 	writel(0x00, iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
 	iommu_feature_enable(iommu, CONTROL_PPRLOG_EN);
-	iommu_feature_enable(iommu, CONTROL_PPR_EN);
+	iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
 }
 
 static void __init free_ppr_log(struct amd_iommu *iommu)
@@ -2526,8 +2528,6 @@ static int iommu_init_irq(struct amd_iommu *iommu)
 
 	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
 
-	if (iommu->ppr_log != NULL)
-		iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
 	return 0;
 }
 
-- 
2.31.1

