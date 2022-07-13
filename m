Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007EE15A9
	for <iommu@lists.linux.dev>; Wed, 13 Jul 2022 05:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIGCVy9fw3KNrly9UjQHPY+l0MVCxMr8C5JMHr1rQXGkOpj9XmFEE/1oxIm5ocm2C+a1Q3H+hfmZy3Q6mOLF2kFZ/r458WVo561jkg48X9FIZIKeXDjUqeJiHzU6Agu2RYuhHDezjc63vHxDzkrsH943jSCcZJn4wxOoIuhwgaA0dYpG7I+N9aIiwrDDOPJYrrqSA3+PMz+R8Nq/Ao+2vRPXP975p2OpgI/0zxttCpu1bjVVenTaD+zg3Hb7i3eTlWrMoWPSCd1HpM7f0wJfH8SiWeV0g9nE1fMpWzwiQaLSq53UaoUfbNIXcN2TFgYwXKi5IpYs8kv5iNv5o/f2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D89++7y3Qm1x0qiIzGm7GCfi2AYaG+JYRelSJI9mmn4=;
 b=AoyMBoqex/GJSoDj0GTAw8L/FNq1TFE+N486BRUMTmhCklB60NW/pDEjFsefgn+9wQsgpeIPRMTtnsmnAZNLQuFHDuFRwIb5k1LgSMWqQqXZOsXVXcIux3HiWADoHMDNJT9+eBfPKt70vFudb6Ggw2Xz5+qUlrMVWA4y9efEqi2fOybK8OTRhIyj2NFfual4I/iS0ddGzfnUZrzO230Xo21uHFq+cdJ6cprYpYu+LnIZ+R6goyPzCAlM+j72UrZb2OZNe59AuQbmUl6u4zLoMtxHr816p1ODSadzVbTrSNdHuFZu8zAXgFQVO1VMg0ENg46GNlZ846S6r9aPyafxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D89++7y3Qm1x0qiIzGm7GCfi2AYaG+JYRelSJI9mmn4=;
 b=zlQlkRaIK07RyOkmtS1lv1Q+7qOd0En1FJIf53yajp0hv7CiSbieILPfPBWX7lVxD/la2Hm0cSDNP9uSviyG80sOz0FP5XAeVWR46vLCBZKQb7LNc0QN7uusC3xNHnem1Q+bL2IUwbRKpzlGUD7AsWX1wxAo+6lOP4W/cXIPr1s=
Received: from BN6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:404:65::21)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 05:33:10 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::b0) by BN6PR17CA0011.outlook.office365.com
 (2603:10b6:404:65::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 05:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 05:33:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 00:33:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 6/6] iommu/amd: Add command-line option to enable different page table
Date: Wed, 13 Jul 2022 11:00:34 +0530
Message-ID: <20220713053034.12061-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713053034.12061-1-vasant.hegde@amd.com>
References: <20220713053034.12061-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5b90f3e-a129-463d-92e5-08da64912bf7
X-MS-TrafficTypeDiagnostic: CH2PR12MB4055:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+xvlooWfAwM6jnB3yslU8ubBe/lTt1PZCxSxVUudjGiro2gtUTaiXc4BhLTU01D5WRU8pDruOv+qhwjydC8Viy4uc+lkbrOSayrSF+8BRBjDKkGtPEgZSmqD9VbYWD7rfUHehSYAAFq+ejEwgJRxwA7ExZOqoWbTy06dxzbTzquGeeBu1dGt3Bedo6e3D9IiQWqFG1V4eai0Qgw42B2+VRMV+/IJk6IaEM84p0/0vaV8o8prSk07Ms2yTxhIAfk7sD+6UfhmddZnLqUn0+TuO1uZLDSBHz1eaNSFyZ/kMcpWFtRz0vwHHjicTtsaBHu2BQHOdObExjlIrN9jf2kmXKiGlweomOYYIfFUR/KJaaCJ8GdezlvlGssm/Bxv5vvU5vd1QnRJqGWQ3YGWtmjpMGZBaoPxJ+I6Ddf67SRf0Hc+jF3DD4eoYATiAUX89w77HEO2OyVHDwn/zvlYK1NaOpp9XcF3Swg2qew6TjOuHg9pl+Mq0HGgwNnKCsXPY3mIP7QCopAIq6AKv76H+8XSq5RgS7atfKlj3BwygXxIinJHwKpOVMQVH3PPhVf3YVO68854i32zE/Bnw4KOi/9w4NcoClEMdCmXz3alQXPQkUF/5zSvZ/rVIzsfdO2/H54lSuS3Khcqt/G4FBtlV38it/+OGmTxkuE8yPuGTxgBexVhpJxUA3R+I0AhwfhWTFXEnwDTG+0fFspnps+IK+mpw2HnZDko9G3hBsPapt8B/AXDlJzv+V4qs+KLY0L99Xy4ltu+cC9K3jACKC4wFNXR2JjXreSUbvDAiLzNo/PhFnmyk/uyZ/KcWJdK2llaLTykrjTiD+Vz9kSu+2UMOUqTIZGXlfQ8p/ok+nqnLXNbGoU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(40470700004)(46966006)(36840700001)(6666004)(36756003)(44832011)(26005)(478600001)(4326008)(54906003)(110136005)(316002)(47076005)(336012)(426003)(2616005)(41300700001)(70586007)(70206006)(8676002)(1076003)(186003)(16526019)(2906002)(356005)(86362001)(81166007)(83380400001)(82740400003)(40460700003)(8936002)(36860700001)(5660300002)(82310400005)(7696005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 05:33:09.6402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b90f3e-a129-463d-92e5-08da64912bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055

Enhance amd_iommu command line option to specify v1 or v2 page table.
By default system will boot in V1 page table mode.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Removed separate command line option and enhace amd_iommu option
  - Update document

 .../admin-guide/kernel-parameters.txt         |  2 ++
 drivers/iommu/amd/init.c                      | 23 +++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d45e58328ce6..d1919bf4f37a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -321,6 +321,8 @@
 			force_enable - Force enable the IOMMU on platforms known
 				       to be buggy with IOMMU enabled. Use this
 				       option with care.
+			pgtbl_v1     - Use v1 page table for DMA-API (Default).
+			pgtbl_v2     - Use v2 page table for DMA-API.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index a2929d8b44f4..673c263fea8d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3287,17 +3287,30 @@ static int __init parse_amd_iommu_intr(char *str)
 
 static int __init parse_amd_iommu_options(char *str)
 {
-	for (; *str; ++str) {
+	if (!str)
+		return -EINVAL;
+
+	while (*str) {
 		if (strncmp(str, "fullflush", 9) == 0) {
 			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
 			iommu_set_dma_strict();
-		}
-		if (strncmp(str, "force_enable", 12) == 0)
+		} else if (strncmp(str, "force_enable", 12) == 0) {
 			amd_iommu_force_enable = true;
-		if (strncmp(str, "off", 3) == 0)
+		} else if (strncmp(str, "off", 3) == 0) {
 			amd_iommu_disabled = true;
-		if (strncmp(str, "force_isolation", 15) == 0)
+		} else if (strncmp(str, "force_isolation", 15) == 0) {
 			amd_iommu_force_isolation = true;
+		} else if (strncmp(str, "pgtbl_v1", 8) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+		} else if (strncmp(str, "pgtbl_v2", 8) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V2;
+		} else {
+			pr_notice("Unknown option - '%s'\n", str);
+		}
+
+		str += strcspn(str, ",");
+		while (*str == ',')
+			str++;
 	}
 
 	return 1;
-- 
2.31.1

